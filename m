From: Peter TB Brett <peter@peter-b.co.uk>
Subject: [stgit PATCH] stgit.el: Stop "Summary:" being added to all commit msgs.
Date: Mon, 13 Jun 2011 09:37:26 +0100
Organization: Surrey Space Centre
Message-ID: <077cac32c74edaff2f20c84897bfc171@mail.theimps.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_4b1497c062cbd3c743027c7195ae4ebb"
Cc: <git@vger.kernel.org>
To: =?UTF-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Mon Jun 13 10:47:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW2ne-0002k5-K3
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 10:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325Ab1FMIrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 04:47:05 -0400
Received: from mail.theimps.com ([81.91.110.43]:32844 "EHLO mail.theimps.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753722Ab1FMIrD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 04:47:03 -0400
X-Greylist: delayed 344 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Jun 2011 04:47:03 EDT
Received: from mail.theimps.com (mail.theimps.com [127.0.0.1])
	by mail.theimps.com (Postfix) with ESMTP id 0E0CF143D6;
	Mon, 13 Jun 2011 09:37:27 +0100 (BST)
Received: from mail.theimps.com (apache [172.16.1.101])
	(Authenticated sender: peter@peter-b.co.uk)
	by mail.theimps.com (Postfix) with ESMTPSA id 0804F1425D;
	Mon, 13 Jun 2011 09:37:27 +0100 (BST)
X-Sender: peter@peter-b.co.uk
User-Agent: RoundCube Webmail/0.2.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175692>

--=_4b1497c062cbd3c743027c7195ae4ebb
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="UTF-8"

In Emacs 23.3.1, if `log-edit' is called with a non-nil `setup' argument,
it unconditionally appends "Summary:" to the log buffer.  It causes great
annoyance to have to remember to find and delete this string on every patch
commit message edit with stgit-mode.  This patch makes `stgit-edit' call
`log-edit' with a nil `setup' argument.

Did I mention that this is *incredibly annoying*?

See also https://gna.org/bugs/?18206

Peter

-- 
Peter Brett <peter@peter-b.co.uk>
Remote Sensing Research Group
Surrey Space Centre

--=_4b1497c062cbd3c743027c7195ae4ebb
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8";
 name="0001-stgit.el-Stop-Summary-being-added-to-all-commit-msgs.patch"; 
Content-Disposition: attachment;
 filename="0001-stgit.el-Stop-Summary-being-added-to-all-commit-msgs.patch"; 

RnJvbSA0Y2RmOTc3MDE0NDkzM2M1Y2QyYjAzOTljYzA4NDg0MWMxZDVjNDZkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQZXRlciBUQiBCcmV0dCA8cGV0ZXJAcGV0ZXItYi5jby51az4K
RGF0ZTogTW9uLCAxMyBKdW4gMjAxMSAwOTozMzoxMiArMDEwMApTdWJqZWN0OiBbUEFUQ0hdIHN0
Z2l0LmVsOiBTdG9wICJTdW1tYXJ5OiIgYmVpbmcgYWRkZWQgdG8gYWxsIGNvbW1pdCBtc2dzLgoK
SW4gRW1hY3MgMjMuMy4xLCBpZiBgbG9nLWVkaXQnIGlzIGNhbGxlZCB3aXRoIGEgbm9uLW5pbCBg
c2V0dXAnCmFyZ3VtZW50LCBpdCB1bmNvbmRpdGlvbmFsbHkgYXBwZW5kcyAiU3VtbWFyeToiIHRv
IHRoZSBsb2cgYnVmZmVyLiAgSXQKY2F1c2VzIGdyZWF0IGFubm95YW5jZSB0byBoYXZlIHRvIHJl
bWVtYmVyIHRvIGZpbmQgYW5kIGRlbGV0ZSB0aGlzCnN0cmluZyBvbiBldmVyeSBwYXRjaCBjb21t
aXQgbWVzc2FnZSBlZGl0IHdpdGggc3RnaXQtbW9kZS4gIFRoaXMgcGF0Y2gKbWFrZXMgYHN0Z2l0
LWVkaXQnIGNhbGwgYGxvZy1lZGl0JyB3aXRoIGEgbmlsIGBzZXR1cCcgYXJndW1lbnQuCgpTaWdu
ZWQtb2ZmLWJ5OiBQZXRlciBUQiBCcmV0dCA8cGV0ZXJAcGV0ZXItYi5jby51az4KLS0tCiBjb250
cmliL3N0Z2l0LmVsIHwgICAgMiArLQogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvY29udHJpYi9zdGdpdC5lbCBiL2NvbnRyaWIv
c3RnaXQuZWwKaW5kZXggYzcxZGY0Yi4uZjY0MGU1ZSAxMDA2NDQKLS0tIGEvY29udHJpYi9zdGdp
dC5lbAorKysgYi9jb250cmliL3N0Z2l0LmVsCkBAIC0yMjk4LDcgKzIyOTgsNyBAQCBmaWxlIGVu
ZGVkIHVwLiBZb3UgY2FuIHRoZW4ganVtcCB0byB0aGUgZmlsZSB3aXRoIFwKICAgKGxldCAoKHBh
dGNoc3ltIChzdGdpdC1wYXRjaC1uYW1lLWF0LXBvaW50IHQgdCkpCiAgICAgICAgIChlZGl0LWJ1
ZiAoZ2V0LWJ1ZmZlci1jcmVhdGUgIipTdEdpdCBlZGl0KiIpKQogICAgICAgICAoZGlyIGRlZmF1
bHQtZGlyZWN0b3J5KSkKLSAgICAobG9nLWVkaXQgJ3N0Z2l0LWNvbmZpcm0tZWRpdCB0IG5pbCBl
ZGl0LWJ1ZikKKyAgICAobG9nLWVkaXQgJ3N0Z2l0LWNvbmZpcm0tZWRpdCBuaWwgbmlsIGVkaXQt
YnVmKQogICAgIChzZXQgKG1ha2UtbG9jYWwtdmFyaWFibGUgJ3N0Z2l0LWVkaXQtcGF0Y2hzeW0p
IHBhdGNoc3ltKQogICAgIChzZXRxIGRlZmF1bHQtZGlyZWN0b3J5IGRpcikKICAgICAobGV0ICgo
c3RhbmRhcmQtb3V0cHV0IGVkaXQtYnVmKSkKLS0gCjEuNy42LnJjMQoK
--=_4b1497c062cbd3c743027c7195ae4ebb--
