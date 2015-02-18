From: Guenther Demetz <guenther.demetz@wuerth-phoenix.com>
Subject: Memeory retention problem
Date: Wed, 18 Feb 2015 09:30:38 +0000 (UTC)
Message-ID: <loom.20150218T102920-988@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 10:35:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO12R-0004QF-VJ
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 10:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbbBRJfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 04:35:09 -0500
Received: from plane.gmane.org ([80.91.229.3]:59690 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752109AbbBRJfF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 04:35:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YO126-0004LZ-Dn
	for git@vger.kernel.org; Wed, 18 Feb 2015 10:35:02 +0100
Received: from host-82-193-25-94-z1.infracom.it ([host-82-193-25-94-z1.infracom.it])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Feb 2015 10:35:02 +0100
Received: from guenther.demetz by host-82-193-25-94-z1.infracom.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Feb 2015 10:35:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 82.193.25.94 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:35.0) Gecko/20100101 Firefox/35.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264010>

SGksCgp3ZSBvd24gYSBnaXQtcmVwb3NpdG9yeSB3aGljaCBzaXplIGlzIGFyb3VuZCAzLjQgR2lCLgoKV2luZG93czoKZ2l0IGNsb25lIGdpdDovL3BiemN2czAxL2Npcy9kZXYKQ2xvbmluZyBpbnRvICdkZXYnLi4uCnJlbW90ZTogQ291bnRpbmcgb2JqZWN0czogMzczNjY3LCBkb25lLgpyZW1vdGU6IENvbXByZXNzaW5nIG9iamVjdHM6IDEwMCUgKDU2MDcyLzU2MDcyKSwgZG9uZS4KUmVjZWl2aW5nIG9iamVjdHM6IDEwMCUgKDM3MzY2Ny8zNzM2NjcpLCAzLjQ2IEdpQiB8IDYzLjE1IE1pQi9zLCBkb25lLgoKTm93IHdoaWxlIHRoZSBjbGllbnQgaXMgcmVjZWl2aW5nIHRoZSBvYmplY3RzIGZyb20gdGhlIHJlbW90ZSwKd2UgZXhwZXJpZW5jZSB0aGF0IG9uIHRoZSByZW1vdGUgKGEgbGludXggc3lzdGVtKSB0aGUgYWxsb2NhdGVkIG1lbW9yeSBpcwpsaW5lYXIgaW5jcmVhc2luZyB3aXRoIHRoZSBhbW91bnQgb2YgdHJhbnNmZXJyZWQgZGF0YS4KV2hpbGUgdGhlIHRyYW5zZmVyIGlzIGF0IDk5JSB3ZSBzZWUgZm9sbG93aW5nIG9uIHRoZSByZW1vdGU6CgpMaW51eDoKICBQSUQgVVNFUiAgICAgIFBSICBOSSAgVklSVCAgUkVTICBTSFIgUyAlQ1BVICVN
 RU0gICAgVElNRSsgIENPTU1BTkQKMTAxOTcgcm9vdCAgICAgIDIwICAgMCA0MzE4bSAzLjRnIDMuM2cgUiA0MC4yIDkxLjYgICAwOjI2Ljk3IGdpdAoxMDE5NiByb290ICAgICAgMjAgICAwIDExOTFtICA1MW0gIDEwbSBTIDE5LjAgIDEuMyAgIDA6MDcuMjQgZ2l0LXVwbG9hZC1wYWNrCgpBZnRlciB0aGUgdHJhbnNtaXNzaW9uIGhhcyBjb21wbGV0ZWQsIHRoZSBtZW1vcnkgZ2V0IGZyZWVkIGlzdGFudGx5LgpNeSBxdWVzdGlvbiBpczoKCklzIGl04oCZcyByZWFsbHkgbmVjZXNzYXJ5IHRvIGFsbG9jYXRlIGFsbCBjb21wcmVzc2VkIG9iamVjdHMgaW4gbWVtb3J5IGFuZApyZWxlYXNlIHRoZW0gbm90IGJlZm9yZSB0cmFuc21pc3Npb24gaGFzIGNvbXBsZXRlZD8KCkkgYXNrLCBiZWNhdXNlIHdoZW4gdGhlcmUgYXJlIG1vcmUgY2xpZW50cyBkb2luZyBhIGNsb25lIGNvbnRlbXBvcmFuZW91c2x5CndlIGZhY2Ugb3V0IG9mIG1lbW9yeSBlcnJvcnMuCgpXaW5kb3dzOgpXaW5kb3dzIDcgRW50ZXJwcmlzZSwgU1AxLCA2NCBiaXQKZ2l0IHZlcnNpb24gMS45LjUubXN5c2dpdC4wCgpMaW51eDoKUmVkIEhhdCBFbnRlcnByaXNlIExpbnV4IFNlcnZlciByZW
 xlYXNlIDYuMyAoU2FudGlhZ28pLAoyLjYuMzItMjc5LjUuMS5lbDYueDg2XzY0CmdpdCB2ZXJzaW9uIDIuMy4wIChjb21waWxlZCBsb2NhbGx5KQoKUC5TLjogUGxlYXNlIGZvcmdpdmUgbWUsIGlmIHNpbWlsYXIgbWFpbCB3YXMgYWxyZWFkeSBwb3N0ZWQgb24gdGhlIG1haWxpbmctbGlzdC4KCmJlc3QgcmVnYXJkcwpHw7xudGhlciBEZW1ldHoKV8O8cnRoIFBob2VuaXggUy5yLmwuClByb2R1Y3QgRGV2ZWxvcG1lbnQgKENJUykKVmlhIEtyYXZvZ2wgNApJLTM5MTAwIEJvbHphbm8gCkRpcmVjdDogICAgICszOSAwNDcxIDU2NCAwNjEKRmF4OiAgICAgICAgKzM5IDA0NzEgNTY0IDEyMgpFLU1haWw6ICAgICBndWVudGhlci5kZW1ldHpAd3VlcnRoLXBob2VuaXguY29tCldlYnNpdGU6ICB3d3cud3VlcnRoLXBob2VuaXguY29tCg==
