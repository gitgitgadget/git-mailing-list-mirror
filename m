From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH 1/3] Insert ACTIVESTATE_STRING in Git.pm
Date: Mon, 22 Jan 2007 17:23:47 +0100
Message-ID: <81b0412b0701220823r327cee48idea1dfe5aaaf1f7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_156837_30693759.1169483027459"
Cc: "Junio C Hamano" <junkio@cox.net>, "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jan 22 17:23:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H91xY-0004kY-CV
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 17:23:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbXAVQXt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 11:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbXAVQXt
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 11:23:49 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:7466 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945AbXAVQXt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 11:23:49 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1094652uga
        for <git@vger.kernel.org>; Mon, 22 Jan 2007 08:23:47 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=DF91ltKWqezWXzLKaIXS901TWyvAWAXImOUafZ6VMojDfGgx4Ygz/+HXub+GcsGoWrqf4SrSqMNZVCnhLzkGgs9iGuLyeTLCfC0dsNT1BPrq3sFBKJox2W23/rmMcZEBUjl5yGidXeJOhM0F79TlHatSmImOSehl5u6oeAVOPs0=
Received: by 10.82.138.6 with SMTP id l6mr5275553bud.1169483027485;
        Mon, 22 Jan 2007 08:23:47 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Mon, 22 Jan 2007 08:23:47 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37423>

------=_Part_156837_30693759.1169483027459
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Also add "git" to the pipe parameters, otherwise it does not work at all, as
no git commands are usable out of git context.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 perl/Git.pm |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

------=_Part_156837_30693759.1169483027459
Content-Type: application/xxxxx; 
	name=0001-Insert-ACTIVESTATE_STRING-in-Git.pm.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ex940sfn
Content-Disposition: attachment; filename="0001-Insert-ACTIVESTATE_STRING-in-Git.pm.patch"

RnJvbSAxMmQ1ZDMxOWFjODY0M2Q0M2RiNGE3MjczODMyZjY3ZmE1NWVmNzUwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBNb24sIDIyIEphbiAyMDA3IDE3OjE0OjU2ICswMTAwClN1YmplY3Q6IFtQQVRDSCAxLzNdIElu
c2VydCBBQ1RJVkVTVEFURV9TVFJJTkcgaW4gR2l0LnBtCgpBbHNvIGFkZCAiZ2l0IiB0byB0aGUg
cGlwZSBwYXJhbWV0ZXJzLCBvdGhlcndpc2UgaXQgZG9lcyBub3Qgd29yayBhdCBhbGwsIGFzCm5v
IGdpdCBjb21tYW5kcyBhcmUgdXNhYmxlIG91dCBvZiBnaXQgY29udGV4dC4KClNpZ25lZC1vZmYt
Ynk6IEFsZXggUmllc2VuIDxyYWEubGttbEBnbWFpbC5jb20+Ci0tLQogcGVybC9HaXQucG0gfCAg
ICA3ICsrKystLS0KIDEgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL3BlcmwvR2l0LnBtIGIvcGVybC9HaXQucG0KaW5kZXggMzQ3NGFk
My4uNTg0MTRlMyAxMDA2NDQKLS0tIGEvcGVybC9HaXQucG0KKysrIGIvcGVybC9HaXQucG0KQEAg
LTczNiw3ICs3MzYsNyBAQCBzdWIgX2NvbW1hbmRfY29tbW9uX3BpcGUgewogCV9jaGVja192YWxp
ZF9jbWQoJGNtZCk7CiAKIAlteSAkZmg7Ci0JaWYgKCReTyBlcSAnIyNJTlNFUlRfQUNUSVZFU1RB
VEVfU1RSSU5HX0hFUkUjIycpIHsKKwlpZiAoJF5PIGVxICdNU1dpbjMyJykgewogCQkjIEFjdGl2
ZVN0YXRlIFBlcmwKIAkJI2RlZmluZWQgJG9wdHN7U1RERVJSfSBhbmQKIAkJIwl3YXJuICdpZ25v
cmluZyBTVERFUlIgb3B0aW9uIC0gcnVubmluZyB3LyBBY3RpdmVTdGF0ZSc7CkBAIC04MDksOCAr
ODA5LDkgQEAgc3ViIFRJRUhBTkRMRSB7CiAJIyBGSVhNRTogVGhpcyBpcyBwcm9iYWJseSBob3Jy
aWJsZSBpZGVhIGFuZCB0aGUgdGhpbmcgd2lsbCBleHBsb2RlCiAJIyBhdCB0aGUgbW9tZW50IHlv
dSBnaXZlIGl0IGFyZ3VtZW50cyB0aGF0IHJlcXVpcmUgc29tZSBxdW90aW5nLAogCSMgYnV0IEkg
aGF2ZSBubyBBY3RpdmVTdGF0ZSBjbHVlLi4uIC0tcGFza3kKLQlteSAkY21kbGluZSA9IGpvaW4g
IiAiLCBAcGFyYW1zOwotCW15IEBkYXRhID0gcXh7JGNtZGxpbmV9OworCSMgTGV0J3MganVzdCBo
b3BlIEFjdGl2ZVN0YXRlIFBlcmwgZG9lcyBhdCBsZWFzdCB0aGUgcXVvdGluZworCSMgY29ycmVj
dGx5LgorCW15IEBkYXRhID0gcXh7Z2l0IEBwYXJhbXN9OwogCWJsZXNzIHsgaSA9PiAwLCBkYXRh
ID0+IFxAZGF0YSB9LCAkY2xhc3M7CiB9CiAKLS0gCjEuNS4wLnJjMi5nM2YxYQoK
------=_Part_156837_30693759.1169483027459--
