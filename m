From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] Revert "gitweb: extend blame to show links to diff and previous"
Date: Wed, 27 Sep 2006 17:18:47 -0700 (PDT)
Message-ID: <20060928001847.41690.qmail@web31801.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1575605340-1159402727=:41128"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Sep 28 02:19:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSjc4-0003B4-3Z
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 02:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031279AbWI1ASt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 20:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031281AbWI1ASt
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 20:18:49 -0400
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:28552 "HELO
	web31801.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1031279AbWI1ASs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 20:18:48 -0400
Received: (qmail 41692 invoked by uid 60001); 28 Sep 2006 00:18:48 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=D0PnFhEY/ytV8bMPqcNXp9/+GjPsXpkaqQ07hztEJATRrly0Jpyb1nxuymCilYZCmcyGlKIzWMpPEeB+FpBgXtPIJWkchOvcu8ebCKrpM8/XqLVnq+ac7Ngib6wJF0MOBPUR5xYZQ7SHQf2Gn7YW7Mt4qktKeOtbGvT/CctzBUU=  ;
Received: from [64.215.88.90] by web31801.mail.mud.yahoo.com via HTTP; Wed, 27 Sep 2006 17:18:47 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27951>

--0-1575605340-1159402727=:41128
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

This concept is very fine, but it makes blame slow
across renames and across branches, so revert it.
There is a better way to do this.

This reverts commit 03d06a8e26f4fbd37800d1e1125c6ecf4c104466.
---
 gitweb/gitweb.perl |   18 +-----------------
 1 files changed, 1 insertions(+), 17 deletions(-)

--0-1575605340-1159402727=:41128
Content-Type: application/octet-stream; name="p1.patch"
Content-Transfer-Encoding: base64
Content-Description: 2795696785-p1.patch
Content-Disposition: attachment; filename="p1.patch"

ZGlmZiAtLWdpdCBhL2dpdHdlYi9naXR3ZWIucGVybCBiL2dpdHdlYi9naXR3
ZWIucGVybAppbmRleCBkMjUxOWYwLi41NjYzOGYyIDEwMDc1NQotLS0gYS9n
aXR3ZWIvZ2l0d2ViLnBlcmwKKysrIGIvZ2l0d2ViL2dpdHdlYi5wZXJsCkBA
IC0yNDM5LDcgKzI0MzksNyBAQCBzdWIgZ2l0X2JsYW1lMiB7CiAJcHJpbnQg
PDxIVE1MOwogPGRpdiBjbGFzcz0icGFnZV9ib2R5Ij4KIDx0YWJsZSBjbGFz
cz0iYmxhbWUiPgotPHRyPjx0aD5QcmV2PC90aD48dGg+RGlmZjwvdGg+PHRo
PkNvbW1pdDwvdGg+PHRoPkxpbmU8L3RoPjx0aD5EYXRhPC90aD48L3RyPgor
PHRyPjx0aD5Db21taXQ8L3RoPjx0aD5MaW5lPC90aD48dGg+RGF0YTwvdGg+
PC90cj4KIEhUTUwKIAl3aGlsZSAoPCRmZD4pIHsKIAkJL14oWzAtOWEtZkEt
Rl17NDB9KS4qPyhcZCspXClcc3sxfShccyouKikvOwpAQCAtMjQ0Nyw4ICsy
NDQ3LDYgQEAgSFRNTAogCQlteSAkcmV2ID0gc3Vic3RyKCRmdWxsX3Jldiwg
MCwgOCk7CiAJCW15ICRsaW5lbm8gPSAkMjsKIAkJbXkgJGRhdGEgPSAkMzsK
LQkJbXkgJXBjbyA9IHBhcnNlX2NvbW1pdCgkZnVsbF9yZXYpOwotCQlteSAk
cGFyZW50ID0gJHBjb3sncGFyZW50J307CiAKIAkJaWYgKCFkZWZpbmVkICRs
YXN0X3JldikgewogCQkJJGxhc3RfcmV2ID0gJGZ1bGxfcmV2OwpAQCAtMjQ1
NywyNiArMjQ1NSwxMSBAQCBIVE1MCiAJCQkkY3VycmVudF9jb2xvciA9ICsr
JGN1cnJlbnRfY29sb3IgJSAkbnVtX2NvbG9yczsKIAkJfQogCQlwcmludCAi
PHRyIGNsYXNzPVwiJHJldl9jb2xvclskY3VycmVudF9jb2xvcl1cIj5cbiI7
Ci0JCSMgUHJpbnQgdGhlIFByZXYgbGluawotCQlwcmludCAiPHRkIGNsYXNz
PVwic2hhMVwiPiI7Ci0JCXByaW50ICRjZ2ktPmEoey1ocmVmID0+IGhyZWYo
YWN0aW9uPT4iYmxhbWUiLCBoYXNoX2Jhc2U9PiRwYXJlbnQsIGZpbGVfbmFt
ZT0+JGZpbGVfbmFtZSl9LAotCQkJICAgICAgZXNjX2h0bWwoc3Vic3RyKCRw
YXJlbnQsIDAsIDgpKSk7Ci0JCXByaW50ICI8L3RkPlxuIjsKLQkJIyBQcmlu
dCB0aGUgRGlmZiAoYmxvYmRpZmYpIGxpbmsKLQkJcHJpbnQgIjx0ZD4iOwot
CQlwcmludCAkY2dpLT5hKHstaHJlZiA9PiBocmVmKGFjdGlvbj0+ImJsb2Jk
aWZmIiwgZmlsZV9uYW1lPT4kZmlsZV9uYW1lLCBoYXNoX3BhcmVudF9iYXNl
PT4kcGFyZW50LAotCQkJCQkgICAgIGhhc2hfYmFzZT0+JGZ1bGxfcmV2KX0s
Ci0JCQkgICAgICBlc2NfaHRtbCgiRGlmZiIpKTsKLQkJcHJpbnQgIjwvdGQ+
XG4iOwotCQkjIFByaW50IHRoZSBDb21taXQgbGluawogCQlwcmludCAiPHRk
IGNsYXNzPVwic2hhMVwiPiIgLgogCQkJJGNnaS0+YSh7LWhyZWYgPT4gaHJl
ZihhY3Rpb249PiJjb21taXQiLCBoYXNoPT4kZnVsbF9yZXYsIGZpbGVfbmFt
ZT0+JGZpbGVfbmFtZSl9LAogCQkJICAgICAgICBlc2NfaHRtbCgkcmV2KSkg
LiAiPC90ZD5cbiI7Ci0JCSMgUHJpbnQgdGhlIExpbmUgbnVtYmVyCiAJCXBy
aW50ICI8dGQgY2xhc3M9XCJsaW5lbnJcIj48YSBpZD1cImwkbGluZW5vXCIg
aHJlZj1cIiNsJGxpbmVub1wiIGNsYXNzPVwibGluZW5yXCI+IiAuCiAJCSAg
ICAgIGVzY19odG1sKCRsaW5lbm8pIC4gIjwvYT48L3RkPlxuIjsKLQkJIyBQ
cmludCB0aGUgRGF0YQogCQlwcmludCAiPHRkIGNsYXNzPVwicHJlXCI+IiAu
IGVzY19odG1sKCRkYXRhKSAuICI8L3RkPlxuIjsKIAkJcHJpbnQgIjwvdHI+
XG4iOwogCX0KLS0gCjEuNC4yLjEuZzI3MWUKCg==

--0-1575605340-1159402727=:41128--
