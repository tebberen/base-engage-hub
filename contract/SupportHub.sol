// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SupportHub {
    struct Supporter {
        address supporter;
        uint256 amount;
    }

    Supporter[] public supporters;
    address public owner;

    event NewSupport(address indexed supporter, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    function sendSupport() public payable {
        require(msg.value > 0, "Support amount must be greater than 0");
        supporters.push(Supporter(msg.sender, msg.value));
        emit NewSupport(msg.sender, msg.value);
    }

    function getTotalSupport() public view returns (uint256) {
        uint256 total = 0;
        for (uint256 i = 0; i < supporters.length; i++) {
            total += supporters[i].amount;
        }
        return total;
    }

    function withdraw() public {
        require(msg.sender == owner, "Only owner can withdraw");
        payable(owner).transfer(address(this).balance);
    }

    function getSupporterCount() public view returns (uint256) {
        return supporters.length;
    }
}
