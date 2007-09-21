From: "Jakub Narebski" <jnareb@gmail.com>
Subject: [PATCH 1/5] gitweb: Remove parse_from_to_diffinfo code from git_patchset_body
Date: Fri, 21 Sep 2007 23:35:04 +0200
Message-ID: <8fe92b430709211435x4ac974bg9e938e26310ce9ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_12844_8089279.1190410504205"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 21 23:35:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYq9x-0005Xf-3D
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 23:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764364AbXIUVfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 17:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763037AbXIUVfJ
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 17:35:09 -0400
Received: from nz-out-0506.google.com ([64.233.162.233]:48138 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763007AbXIUVfF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 17:35:05 -0400
Received: by nz-out-0506.google.com with SMTP id s18so785827nze
        for <git@vger.kernel.org>; Fri, 21 Sep 2007 14:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=mDG+Z2JI0gRPxoun8Lymu0y1jN5lf6jbSjbPpUwMrR8=;
        b=HM2U8BA7Z34frqrpG+RIEay5vak0mLgOj335oVHMV3lwV64LUR8jNwcU+r2G6mPjFYhXRcriE5FPnjQR2jfR3bfVH4Vfm1hgWjjBcg8TDyRp1TqUbLTXckcbNLnbc/wD9C3pncMQWSjpioZZ4ckXbK5BEkBCBIjG+KzdGCM4fKs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=muO+siUwQjymE4Jt2mLccT73RBzaTVETnsG8iQavd3i/s9WdGk0xAoZESrbR9T6sEG8gTscb9nFUshuhJsJnWBzXx+ieuuDS0CBQfpibhR7DFyisaX32jPLxixSgVYIK5WM5C/RJ+wlOymNltTgQLN+4l0ZmQDOLF+8jMZURGxU=
Received: by 10.115.49.16 with SMTP id b16mr4033612wak.1190410504209;
        Fri, 21 Sep 2007 14:35:04 -0700 (PDT)
Received: by 10.114.202.19 with HTTP; Fri, 21 Sep 2007 14:35:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58884>

------=_Part_12844_8089279.1190410504205
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

In commit 90921740bd00029708370673fdc537522aa48e6f
  "gitweb: Split git_patchset_body into separate subroutines"
a part of git_patchset_body code was separated into parse_from_to_diffinfo
subroutine.  But instead of replacing the separated code by the call to
mentioned subroutine, the call to subroutine was placed before the separated
code.  This patch removes parse_from_to_diffinfo code from git_patchset_body
subroutine.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
My bad...

I hope the explanation is clean enough. It does make reading
git_patchset_body code much easier.

 gitweb/gitweb.perl |   36 +-----------------------------------
 1 files changed, 1 insertions(+), 35 deletions(-)

------=_Part_12844_8089279.1190410504205
Content-Type: application/octet-stream;
 name="0001-gitweb-Remove-parse_from_to_diffinfo-code-from-git_.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-gitweb-Remove-parse_from_to_diffinfo-code-from-git_.patch"
X-Attachment-Id: f_f6v7na9t

RnJvbSA1MDE2YTE5NjhiNjUxY2E5NzE5NjhmOTE3ZTIyZGQ3Y2U5ODhlMjNkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYWt1YiBOYXJlYnNraSA8am5hcmViQGdtYWlsLmNvbT4KRGF0
ZTogU2F0LCA4IFNlcCAyMDA3IDIxOjQ5OjExICswMjAwClN1YmplY3Q6IFtQQVRDSCAxLzVdIGdp
dHdlYjogUmVtb3ZlIHBhcnNlX2Zyb21fdG9fZGlmZmluZm8gY29kZSBmcm9tIGdpdF9wYXRjaHNl
dF9ib2R5CgpJbiBjb21taXQgOTA5MjE3NDBiZDAwMDI5NzA4MzcwNjczZmRjNTM3NTIyYWE0OGU2
ZgogICJnaXR3ZWI6IFNwbGl0IGdpdF9wYXRjaHNldF9ib2R5IGludG8gc2VwYXJhdGUgc3Vicm91
dGluZXMiCmEgcGFydCBvZiBnaXRfcGF0Y2hzZXRfYm9keSBjb2RlIHdhcyBzZXBhcmF0ZWQgaW50
byBwYXJzZV9mcm9tX3RvX2RpZmZpbmZvCnN1YnJvdXRpbmUuICBCdXQgaW5zdGVhZCBvZiByZXBs
YWNpbmcgdGhlIHNlcGFyYXRlZCBjb2RlIGJ5IHRoZSBjYWxsIHRvCm1lbnRpb25lZCBzdWJyb3V0
aW5lLCB0aGUgY2FsbCB0byBzdWJyb3V0aW5lIHdhcyBwbGFjZWQgYmVmb3JlIHRoZSBzZXBhcmF0
ZWQKY29kZS4gIFRoaXMgcGF0Y2ggcmVtb3ZlcyBwYXJzZV9mcm9tX3RvX2RpZmZpbmZvIGNvZGUg
ZnJvbSBnaXRfcGF0Y2hzZXRfYm9keQpzdWJyb3V0aW5lLgoKU2lnbmVkLW9mZi1ieTogSmFrdWIg
TmFyZWJza2kgPGpuYXJlYkBnbWFpbC5jb20+Ci0tLQpNeSBiYWQuLi4KCkkgaG9wZSB0aGUgZXhw
bGFuYXRpb24gaXMgY2xlYW4gZW5vdWdoLiBJdCBkb2VzIG1ha2UgcmVhZGluZwpnaXRfcGF0Y2hz
ZXRfYm9keSBjb2RlIG11Y2ggZWFzaWVyLgoKIGdpdHdlYi9naXR3ZWIucGVybCB8ICAgMzYgKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9ucygrKSwgMzUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZ2l0d2ViL2dpdHdlYi5w
ZXJsIGIvZ2l0d2ViL2dpdHdlYi5wZXJsCmluZGV4IGIyYmFlMWIuLmMxODMzOWYgMTAwNzU1Ci0t
LSBhL2dpdHdlYi9naXR3ZWIucGVybAorKysgYi9naXR3ZWIvZ2l0d2ViLnBlcmwKQEAgLTMxOTEs
NDQgKzMxOTEsMTAgQEAgc3ViIGdpdF9wYXRjaHNldF9ib2R5IHsKIAkJCQl9CiAJCQl9IHVudGls
ICghZGVmaW5lZCAkdG9fbmFtZSB8fCAkdG9fbmFtZSBlcSAkZGlmZmluZm8tPnsndG9fZmlsZSd9
IHx8CiAJCQkgICAgICAgICAkcGF0Y2hfaWR4ID4gJCMkZGlmZnRyZWUpOworCiAJCQkjIG1vZGlm
aWVzICVmcm9tLCAldG8gaGFzaGVzCiAJCQlwYXJzZV9mcm9tX3RvX2RpZmZpbmZvKCRkaWZmaW5m
bywgXCVmcm9tLCBcJXRvLCBAaGFzaF9wYXJlbnRzKTsKLQkJCWlmICgkZGlmZmluZm8tPnsnbnBh
cmVudHMnfSkgewotCQkJCSMgY29tYmluZWQgZGlmZgotCQkJCSRmcm9teydmaWxlJ30gPSBbXTsK
LQkJCQkkZnJvbXsnaHJlZid9ID0gW107Ci0JCQkJZmlsbF9mcm9tX2ZpbGVfaW5mbygkZGlmZmlu
Zm8sIEBoYXNoX3BhcmVudHMpCi0JCQkJCXVubGVzcyBleGlzdHMgJGRpZmZpbmZvLT57J2Zyb21f
ZmlsZSd9OwotCQkJCWZvciAobXkgJGkgPSAwOyAkaSA8ICRkaWZmaW5mby0+eyducGFyZW50cyd9
OyAkaSsrKSB7Ci0JCQkJCSRmcm9teydmaWxlJ31bJGldID0gJGRpZmZpbmZvLT57J2Zyb21fZmls
ZSd9WyRpXSB8fCAkZGlmZmluZm8tPnsndG9fZmlsZSd9OwotCQkJCQlpZiAoJGRpZmZpbmZvLT57
J3N0YXR1cyd9WyRpXSBuZSAiQSIpIHsgIyBub3QgbmV3IChhZGRlZCkgZmlsZQotCQkJCQkJJGZy
b217J2hyZWYnfVskaV0gPSBocmVmKGFjdGlvbj0+ImJsb2IiLAotCQkJCQkJICAgICAgICAgICAg
ICAgICAgICAgICAgIGhhc2hfYmFzZT0+JGhhc2hfcGFyZW50c1skaV0sCi0JCQkJCQkgICAgICAg
ICAgICAgICAgICAgICAgICAgaGFzaD0+JGRpZmZpbmZvLT57J2Zyb21faWQnfVskaV0sCi0JCQkJ
CQkgICAgICAgICAgICAgICAgICAgICAgICAgZmlsZV9uYW1lPT4kZnJvbXsnZmlsZSd9WyRpXSk7
Ci0JCQkJCX0gZWxzZSB7Ci0JCQkJCQkkZnJvbXsnaHJlZid9WyRpXSA9IHVuZGVmOwotCQkJCQl9
Ci0JCQkJfQotCQkJfSBlbHNlIHsKLQkJCQkkZnJvbXsnZmlsZSd9ID0gJGRpZmZpbmZvLT57J2Zy
b21fZmlsZSd9IHx8ICRkaWZmaW5mby0+eydmaWxlJ307Ci0JCQkJaWYgKCRkaWZmaW5mby0+eydz
dGF0dXMnfSBuZSAiQSIpIHsgIyBub3QgbmV3IChhZGRlZCkgZmlsZQotCQkJCQkkZnJvbXsnaHJl
Zid9ID0gaHJlZihhY3Rpb249PiJibG9iIiwgaGFzaF9iYXNlPT4kaGFzaF9wYXJlbnQsCi0JCQkJ
CSAgICAgICAgICAgICAgICAgICAgIGhhc2g9PiRkaWZmaW5mby0+eydmcm9tX2lkJ30sCi0JCQkJ
CSAgICAgICAgICAgICAgICAgICAgIGZpbGVfbmFtZT0+JGZyb217J2ZpbGUnfSk7Ci0JCQkJfSBl
bHNlIHsKLQkJCQkJZGVsZXRlICRmcm9teydocmVmJ307Ci0JCQkJfQotCQkJfQogCi0JCQkkdG97
J2ZpbGUnfSA9ICRkaWZmaW5mby0+eyd0b19maWxlJ30gfHwgJGRpZmZpbmZvLT57J2ZpbGUnfTsK
LQkJCWlmICghaXNfZGVsZXRlZCgkZGlmZmluZm8pKSB7ICMgZmlsZSBleGlzdHMgaW4gcmVzdWx0
Ci0JCQkJJHRveydocmVmJ30gPSBocmVmKGFjdGlvbj0+ImJsb2IiLCBoYXNoX2Jhc2U9PiRoYXNo
LAotCQkJCSAgICAgICAgICAgICAgICAgICBoYXNoPT4kZGlmZmluZm8tPnsndG9faWQnfSwKLQkJ
CQkgICAgICAgICAgICAgICAgICAgZmlsZV9uYW1lPT4kdG97J2ZpbGUnfSk7Ci0JCQl9IGVsc2Ug
ewotCQkJCWRlbGV0ZSAkdG97J2hyZWYnfTsKLQkJCX0KIAkJCSMgdGhpcyBpcyBmaXJzdCBwYXRj
aCBmb3IgcmF3IGRpZmZ0cmVlIGxpbmUgd2l0aCAkcGF0Y2hfaWR4IGluZGV4CiAJCQkjIHdlIGlu
ZGV4IEAkZGlmZnRyZWUgYXJyYXkgZnJvbSAwLCBidXQgbnVtYmVyIHBhdGNoZXMgZnJvbSAxCiAJ
CQlwcmludCAiPGRpdiBjbGFzcz1cInBhdGNoXCIgaWQ9XCJwYXRjaCIuICgkcGF0Y2hfaWR4KzEp
IC4iXCI+XG4iOwotLSAKMS41LjMKCg==
------=_Part_12844_8089279.1190410504205--
