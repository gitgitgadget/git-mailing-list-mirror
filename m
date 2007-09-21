From: "Jakub Narebski" <jnareb@gmail.com>
Subject: [PATCH 5/5] gitweb: Add 'status_str' to parse_difftree_raw_line output
Date: Fri, 21 Sep 2007 23:41:12 +0200
Message-ID: <8fe92b430709211441x59489fc7u5b784ad70e8e903f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_12881_11685102.1190410872939"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 21 23:41:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYqFT-0008Uu-Ro
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 23:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757272AbXIUVlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 17:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758035AbXIUVlP
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 17:41:15 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:6942 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753957AbXIUVlO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 17:41:14 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1117688wah
        for <git@vger.kernel.org>; Fri, 21 Sep 2007 14:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=K9OZCZbcFwf5a7xXxMXL108WXjU9wMjPwqUPzAgEU5Y=;
        b=Y+OxsYoDMgSHvQvx4yf0o+U7FKiXCImBgB5HwBkbnyuuPD4zUkiaqBBH4hQHCHf26Csxi4W6WuQ8MMhwydgs6T7o+vQApsTmkiHCKr8rdK3ms/uoRSK/Jp2z0/9K2ylok7PBLrswardq1usG+qH3n9+szRbhKNU/5TMWkbnlTBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=MwER70U/uKx1ZXWChqPtnKYNq4pnZTZJtNZya1Q9c7fdKU1NFGzDnfTl+hOQ+jy6X282MIwNmxmvvnGozKOuwJxLWEqwEqkRPWHktBlgWD8ZtJww5nre/Hw3rxRXwxShUfcfplKTlAmlPkRtqEEovPNsa/1nQ6+/6cS09kku9oI=
Received: by 10.114.179.1 with SMTP id b1mr100179waf.1190410872956;
        Fri, 21 Sep 2007 14:41:12 -0700 (PDT)
Received: by 10.114.202.19 with HTTP; Fri, 21 Sep 2007 14:41:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58888>

------=_Part_12881_11685102.1190410872939
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Add 'status_str' to diffinfo output, which stores status (also for
merge commit) as a string.  This allows for easy checking if there is
given status among all for merge commit, e.g.
  $diffinfo->{'status_str'} =~ /D/

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is to simplify _future_ code, so I won't cry if it is not
accepted without some code that needs it.

 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

------=_Part_12881_11685102.1190410872939
Content-Type: application/octet-stream;
 name="0005-gitweb-Add-status_str-to-parse_difftree_raw_line.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0005-gitweb-Add-status_str-to-parse_difftree_raw_line.patch"
X-Attachment-Id: f_f6v7uzg3

RnJvbSBkNWQwODg2MTExZTk4ZGMyODFkODUwM2RhYTFjZTY1NWVhNzcyOWJmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYWt1YiBOYXJlYnNraSA8am5hcmViQGdtYWlsLmNvbT4KRGF0
ZTogVGh1LCAxMyBTZXAgMjAwNyAyMTo1NzoyMCArMDIwMApTdWJqZWN0OiBbUEFUQ0ggNS81XSBn
aXR3ZWI6IEFkZCAnc3RhdHVzX3N0cicgdG8gcGFyc2VfZGlmZnRyZWVfcmF3X2xpbmUgb3V0cHV0
CgpBZGQgJ3N0YXR1c19zdHInIHRvIGRpZmZpbmZvIG91dHB1dCwgd2hpY2ggc3RvcmVzIHN0YXR1
cyAoYWxzbyBmb3IKbWVyZ2UgY29tbWl0KSBhcyBhIHN0cmluZy4gIFRoaXMgYWxsb3dzIGZvciBl
YXN5IGNoZWNraW5nIGlmIHRoZXJlIGlzCmdpdmVuIHN0YXR1cyBhbW9uZyBhbGwgZm9yIG1lcmdl
IGNvbW1pdCwgZS5nLgogICRkaWZmaW5mby0+eydzdGF0dXNfc3RyJ30gPX4gL0QvCgpTaWduZWQt
b2ZmLWJ5OiBKYWt1YiBOYXJlYnNraSA8am5hcmViQGdtYWlsLmNvbT4KLS0tClRoaXMgaXMgdG8g
c2ltcGxpZnkgX2Z1dHVyZV8gY29kZSwgc28gSSB3b24ndCBjcnkgaWYgaXQgaXMgbm90CmFjY2Vw
dGVkIHdpdGhvdXQgc29tZSBjb2RlIHRoYXQgbmVlZHMgaXQuCgogZ2l0d2ViL2dpdHdlYi5wZXJs
IHwgICAgMyArKy0KIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2dpdHdlYi9naXR3ZWIucGVybCBiL2dpdHdlYi9naXR3ZWIucGVy
bAppbmRleCA2Yzc5YTk1Li5hZGMxYjMyIDEwMDc1NQotLS0gYS9naXR3ZWIvZ2l0d2ViLnBlcmwK
KysrIGIvZ2l0d2ViL2dpdHdlYi5wZXJsCkBAIC0xOTYzLDcgKzE5NjMsNyBAQCBzdWIgcGFyc2Vf
ZGlmZnRyZWVfcmF3X2xpbmUgewogCQkkcmVzeyd0b19tb2RlJ30gPSAkMjsKIAkJJHJlc3snZnJv
bV9pZCd9ID0gJDM7CiAJCSRyZXN7J3RvX2lkJ30gPSAkNDsKLQkJJHJlc3snc3RhdHVzJ30gPSAk
NTsKKwkJJHJlc3snc3RhdHVzJ30gPSAkcmVzeydzdGF0dXNfc3RyJ30gPSAkNTsKIAkJJHJlc3sn
c2ltaWxhcml0eSd9ID0gJDY7CiAJCWlmICgkcmVzeydzdGF0dXMnfSBlcSAnUicgfHwgJHJlc3sn
c3RhdHVzJ30gZXEgJ0MnKSB7ICMgcmVuYW1lZCBvciBjb3BpZWQKIAkJCSgkcmVzeydmcm9tX2Zp
bGUnfSwgJHJlc3sndG9fZmlsZSd9KSA9IG1hcCB7IHVucXVvdGUoJF8pIH0gc3BsaXQoIlx0Iiwg
JDcpOwpAQCAtMTk3OSw2ICsxOTc5LDcgQEAgc3ViIHBhcnNlX2RpZmZ0cmVlX3Jhd19saW5lIHsK
IAkJJHJlc3sndG9fbW9kZSd9ID0gcG9wIEB7JHJlc3snZnJvbV9tb2RlJ319OwogCQkkcmVzeydm
cm9tX2lkJ30gPSBbIHNwbGl0KCcgJywgJDMpIF07CiAJCSRyZXN7J3RvX2lkJ30gPSBwb3AgQHsk
cmVzeydmcm9tX2lkJ319OworCQkkcmVzeydzdGF0dXNfc3RyJ30gPSAkNDsKIAkJJHJlc3snc3Rh
dHVzJ30gPSBbIHNwbGl0KCcnLCAkNCkgXTsKIAkJJHJlc3sndG9fZmlsZSd9ID0gdW5xdW90ZSgk
NSk7CiAJfQotLSAKMS41LjMKCg==
------=_Part_12881_11685102.1190410872939--
