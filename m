From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH 3/4] gitweb: git_tree displays blame based on repository config
Date: Fri, 4 Aug 2006 15:14:27 -0700 (PDT)
Message-ID: <20060804221427.38373.qmail@web31807.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1393858777-1154729667=:35101"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sat Aug 05 00:14:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G97w7-0002HP-2C
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 00:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161529AbWHDWO2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 18:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161530AbWHDWO2
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 18:14:28 -0400
Received: from web31807.mail.mud.yahoo.com ([68.142.207.70]:39856 "HELO
	web31807.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161529AbWHDWO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 18:14:27 -0400
Received: (qmail 38375 invoked by uid 60001); 4 Aug 2006 22:14:27 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=c8YlzjfAO00ZTvY1+w0LI1DqhDTfSrJToDdyWnyLjrRt8qGu09YYYo3dbzeCb8+3+kmXmVDM+NQF7oUnS2k8F1tH4IQwpIGcTlXQGNLKnq4czayyjXrWXslX7JF3fTP9ZDHlLFXf4z+Wl6KnTcj57hPPizurarVketMChfj/lLs=  ;
Received: from [64.215.88.90] by web31807.mail.mud.yahoo.com via HTTP; Fri, 04 Aug 2006 15:14:27 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24852>

--0-1393858777-1154729667=:35101
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

git_tree() will now conditionally display "blame"
depending on how "gitweb.blame" variable is configured
using "git-repo-config".

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)
--0-1393858777-1154729667=:35101
Content-Type: application/octet-stream; name="p3.patch"
Content-Transfer-Encoding: base64
Content-Description: 963471848-p3.patch
Content-Disposition: attachment; filename="p3.patch"

ZGlmZiAtLWdpdCBhL2dpdHdlYi9naXR3ZWIucGVybCBiL2dpdHdlYi9naXR3
ZWIucGVybAppbmRleCA2OWI3ODdmLi43MjM4MjNhIDEwMDc1NQotLS0gYS9n
aXR3ZWIvZ2l0d2ViLnBlcmwKKysrIGIvZ2l0d2ViL2dpdHdlYi5wZXJsCkBA
IC0xNzU3LDYgKzE3NTcsNyBAQCBzdWIgZ2l0X3RyZWUgewogCWdpdF9oZWFk
ZXJfaHRtbCgpOwogCW15ICRiYXNlX2tleSA9ICIiOwogCW15ICRiYXNlID0g
IiI7CisJbXkgJGhhdmVfYmxhbWUgPSBnaXRfZ2V0X3Byb2plY3RfY29uZmln
X2Jvb2wgKCdibGFtZScpOwogCWlmIChkZWZpbmVkICRoYXNoX2Jhc2UgJiYg
KG15ICVjbyA9IGdpdF9yZWFkX2NvbW1pdCgkaGFzaF9iYXNlKSkpIHsKIAkJ
JGJhc2Vfa2V5ID0gIjtoYj0kaGFzaF9iYXNlIjsKIAkJZ2l0X3BhZ2VfbmF2
KCd0cmVlJywnJywgJGhhc2hfYmFzZSk7CkBAIC0xNzkyLDkgKzE3OTMsMTEg
QEAgc3ViIGdpdF90cmVlIHsKIAkJCSAgICAgICRjZ2ktPmEoey1ocmVmID0+
ICIkbXlfdXJpPyIgLiBlc2NfcGFyYW0oInA9JHByb2plY3Q7YT1ibG9iO2g9
JHRfaGFzaCRiYXNlX2tleTtmPSRiYXNlJHRfbmFtZSIpLCAtY2xhc3MgPT4g
Imxpc3QifSwgZXNjX2h0bWwoJHRfbmFtZSkpIC4KIAkJCSAgICAgICI8L3Rk
PlxuIiAuCiAJCQkgICAgICAiPHRkIGNsYXNzPVwibGlua1wiPiIgLgotCQkJ
ICAgICAgJGNnaS0+YSh7LWhyZWYgPT4gIiRteV91cmk/IiAuIGVzY19wYXJh
bSgicD0kcHJvamVjdDthPWJsb2I7aD0kdF9oYXNoJGJhc2Vfa2V5O2Y9JGJh
c2UkdF9uYW1lIil9LCAiYmxvYiIpIC4KLSMJCQkgICAgICAiIHwgIiAuICRj
Z2ktPmEoey1ocmVmID0+ICIkbXlfdXJpPyIgLiBlc2NfcGFyYW0oInA9JHBy
b2plY3Q7YT1ibGFtZTtoPSR0X2hhc2gkYmFzZV9rZXk7Zj0kYmFzZSR0X25h
bWUiKX0sICJibGFtZSIpIC4KLQkJCSAgICAgICIgfCAiIC4gJGNnaS0+YSh7
LWhyZWYgPT4gIiRteV91cmk/IiAuIGVzY19wYXJhbSgicD0kcHJvamVjdDth
PWhpc3Rvcnk7aD0kdF9oYXNoO2hiPSRoYXNoX2Jhc2U7Zj0kYmFzZSR0X25h
bWUiKX0sICJoaXN0b3J5IikgLgorCQkJICAgICAgJGNnaS0+YSh7LWhyZWYg
PT4gIiRteV91cmk/IiAuIGVzY19wYXJhbSgicD0kcHJvamVjdDthPWJsb2I7
aD0kdF9oYXNoJGJhc2Vfa2V5O2Y9JGJhc2UkdF9uYW1lIil9LCAiYmxvYiIp
OworCQkJaWYgKCRoYXZlX2JsYW1lKSB7CisJCQkJcHJpbnQgIiB8ICIgLiAk
Y2dpLT5hKHstaHJlZiA9PiAiJG15X3VyaT8iIC4gZXNjX3BhcmFtKCJwPSRw
cm9qZWN0O2E9YmxhbWU7aD0kdF9oYXNoJGJhc2Vfa2V5O2Y9JGJhc2UkdF9u
YW1lIil9LCAiYmxhbWUiKTsKKwkJCX0KKwkJCXByaW50ICIgfCAiIC4gJGNn
aS0+YSh7LWhyZWYgPT4gIiRteV91cmk/IiAuIGVzY19wYXJhbSgicD0kcHJv
amVjdDthPWhpc3Rvcnk7aD0kdF9oYXNoO2hiPSRoYXNoX2Jhc2U7Zj0kYmFz
ZSR0X25hbWUiKX0sICJoaXN0b3J5IikgLgogCQkJICAgICAgIiB8ICIgLiAk
Y2dpLT5hKHstaHJlZiA9PiAiJG15X3VyaT8iIC4gZXNjX3BhcmFtKCJwPSRw
cm9qZWN0O2E9YmxvYl9wbGFpbjtoPSR0X2hhc2g7Zj0kYmFzZSR0X25hbWUi
KX0sICJyYXciKSAuCiAJCQkgICAgICAiPC90ZD5cbiI7CiAJCX0gZWxzaWYg
KCR0X3R5cGUgZXEgInRyZWUiKSB7Ci0tIAoxLjQuMi5yYzMuZzZkZjMKCg==


--0-1393858777-1154729667=:35101--
