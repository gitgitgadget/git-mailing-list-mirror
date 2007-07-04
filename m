From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Handle format.subjectprefix for every command which accepts --pretty
Date: Wed, 4 Jul 2007 12:42:10 +0200
Message-ID: <81b0412b0707040342m22d3979cte99601bc1117f065@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_93479_557982.1183545730013"
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Adam Roben" <aroben@apple.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 12:42:19 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I62JL-0005jv-8K
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 12:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758545AbXGDKmN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 06:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758402AbXGDKmN
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 06:42:13 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:14930 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754911AbXGDKmM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 06:42:12 -0400
Received: by wr-out-0506.google.com with SMTP id i30so64704wra
        for <git@vger.kernel.org>; Wed, 04 Jul 2007 03:42:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=Nf2GQN4qpxpJ7lU7wnxKbWD5nBTCg6yXWuHwZQZSy6Zza4cGxvv1+/amEmKNGuxFX3mUn61aUdksGfeOxkSRSWtGlZyj3v9CFGaUns40TG9JBkNWNooyK2CdS18Lahc/ipCeut/1rsbSlbMaBuYizcrGRT2/XxDK1S0m/Trutug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=qKvPsW9i7cWfjC+WH0hT3KSBO8KnfBnFDE9WlrsZwPfugQg0+1T3ienfNcHTDinB4R8lqz7MBrWtPTuU6RajWQXMm1cT8KoxZ/f+F+x+b00yoh/G2ZH3QEMMI29MQqh6giuhiJvIAhATgjdjJ0YZ+ZbBIpmx8ZgaNu7wGYW8NAI=
Received: by 10.78.168.1 with SMTP id q1mr4019681hue.1183545730044;
        Wed, 04 Jul 2007 03:42:10 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Wed, 4 Jul 2007 03:42:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51590>

------=_Part_93479_557982.1183545730013
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Because the --pretty can be given as --pretty=email which historically produced
mails with patches. IOW, exactly what git-format-patch does.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 builtin-log.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

------=_Part_93479_557982.1183545730013
Content-Type: text/plain; 
	name=0002-Handle-format.subjectprefix-for-every-command-which.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f3polz8p
Content-Disposition: attachment; filename="0002-Handle-format.subjectprefix-for-every-command-which.txt"

RnJvbSAzYzhiNTI0Yzc3NWE5NmViMGU5YjYzOGUzYzBiMTk0ZDg3NDM1OTRhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhQGxpbWJvLmxvY2FsZG9tYWluPgpE
YXRlOiBXZWQsIDQgSnVsIDIwMDcgMTI6Mzc6MjcgKzAyMDAKU3ViamVjdDogW1BBVENIXSBIYW5k
bGUgZm9ybWF0LnN1YmplY3RwcmVmaXggZm9yIGV2ZXJ5IGNvbW1hbmQgd2hpY2ggYWNjZXB0cyAt
LXByZXR0eQoKQmVjYXVzZSB0aGUgLS1wcmV0dHkgY2FuIGJlIGdpdmVuIGFzIC0tcHJldHR5PWVt
YWlsIHdoaWNoIGhpc3RvcmljYWxseSBwcm9kdWNlZAptYWlscyB3aXRoIHBhdGNoZXMuIElPVywg
ZXhhY3RseSB3aGF0IGdpdC1mb3JtYXQtcGF0Y2ggZG9lcy4KLS0tCiBidWlsdGluLWxvZy5jIHwg
ICAxNSArKysrKysrKy0tLS0tLS0KIDEgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA3
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2J1aWx0aW4tbG9nLmMgYi9idWlsdGluLWxvZy5j
CmluZGV4IDVkYzJjMWMuLjEzYmFlMzEgMTAwNjQ0Ci0tLSBhL2J1aWx0aW4tbG9nLmMKKysrIGIv
YnVpbHRpbi1sb2cuYwpAQCAtMTYsNiArMTYsNyBAQAogI2luY2x1ZGUgInJlZnMuaCIKIAogc3Rh
dGljIGludCBkZWZhdWx0X3Nob3dfcm9vdCA9IDE7CitzdGF0aWMgY29uc3QgY2hhciAqZm10X3Bh
dGNoX3N1YmplY3RfcHJlZml4ID0gIlBBVENIIjsKIAogLyogdGhpcyBpcyBpbiBidWlsdGluLWRp
ZmYuYyAqLwogdm9pZCBhZGRfaGVhZChzdHJ1Y3QgcmV2X2luZm8gKnJldnMpOwpAQCAtNTUsNiAr
NTYsNyBAQCBzdGF0aWMgdm9pZCBjbWRfbG9nX2luaXQoaW50IGFyZ2MsIGNvbnN0IGNoYXIgKiph
cmd2LCBjb25zdCBjaGFyICpwcmVmaXgsCiAJcmV2LT5jb21taXRfZm9ybWF0ID0gQ01JVF9GTVRf
REVGQVVMVDsKIAlyZXYtPnZlcmJvc2VfaGVhZGVyID0gMTsKIAlyZXYtPnNob3dfcm9vdF9kaWZm
ID0gZGVmYXVsdF9zaG93X3Jvb3Q7CisJcmV2LT5zdWJqZWN0X3ByZWZpeCA9IGZtdF9wYXRjaF9z
dWJqZWN0X3ByZWZpeDsKIAlhcmdjID0gc2V0dXBfcmV2aXNpb25zKGFyZ2MsIGFyZ3YsIHJldiwg
IkhFQUQiKTsKIAlpZiAocmV2LT5kaWZmb3B0LnBpY2theGUgfHwgcmV2LT5kaWZmb3B0LmZpbHRl
cikKIAkJcmV2LT5hbHdheXNfc2hvd19oZWFkZXIgPSAwOwpAQCAtOTQsNiArOTYsMTIgQEAgc3Rh
dGljIGludCBjbWRfbG9nX3dhbGsoc3RydWN0IHJldl9pbmZvICpyZXYpCiAKIHN0YXRpYyBpbnQg
Z2l0X2xvZ19jb25maWcoY29uc3QgY2hhciAqdmFyLCBjb25zdCBjaGFyICp2YWx1ZSkKIHsKKwlp
ZiAoIXN0cmNtcCh2YXIsICJmb3JtYXQuc3ViamVjdHByZWZpeCIpKSB7CisJCWlmICghdmFsdWUp
CisJCQlkaWUoImZvcm1hdC5zdWJqZWN0cHJlZml4IHdpdGhvdXQgdmFsdWUiKTsKKwkJZm10X3Bh
dGNoX3N1YmplY3RfcHJlZml4ID0geHN0cmR1cCh2YWx1ZSk7CisJCXJldHVybiAwOworCX0KIAlp
ZiAoIXN0cmNtcCh2YXIsICJsb2cuc2hvd3Jvb3QiKSkgewogCQlkZWZhdWx0X3Nob3dfcm9vdCA9
IGdpdF9jb25maWdfYm9vbCh2YXIsIHZhbHVlKTsKIAkJcmV0dXJuIDA7CkBAIC0yNjUsNyArMjcz
LDYgQEAgc3RhdGljIGludCBpc3RpdGxlY2hhcihjaGFyIGMpCiAKIHN0YXRpYyBjaGFyICpleHRy
YV9oZWFkZXJzID0gTlVMTDsKIHN0YXRpYyBpbnQgZXh0cmFfaGVhZGVyc19zaXplID0gMDsKLXN0
YXRpYyBjb25zdCBjaGFyICpmbXRfcGF0Y2hfc3ViamVjdF9wcmVmaXggPSAiUEFUQ0giOwogc3Rh
dGljIGNvbnN0IGNoYXIgKmZtdF9wYXRjaF9zdWZmaXggPSAiLnBhdGNoIjsKIAogc3RhdGljIGlu
dCBnaXRfZm9ybWF0X2NvbmZpZyhjb25zdCBjaGFyICp2YXIsIGNvbnN0IGNoYXIgKnZhbHVlKQpA
QCAtMjkxLDEyICsyOTgsNiBAQCBzdGF0aWMgaW50IGdpdF9mb3JtYXRfY29uZmlnKGNvbnN0IGNo
YXIgKnZhciwgY29uc3QgY2hhciAqdmFsdWUpCiAJaWYgKCFzdHJjbXAodmFyLCAiZGlmZi5jb2xv
ciIpIHx8ICFzdHJjbXAodmFyLCAiY29sb3IuZGlmZiIpKSB7CiAJCXJldHVybiAwOwogCX0KLQlp
ZiAoIXN0cmNtcCh2YXIsICJmb3JtYXQuc3ViamVjdHByZWZpeCIpKSB7Ci0JCWlmICghdmFsdWUp
Ci0JCQlkaWUoImZvcm1hdC5zdWJqZWN0cHJlZml4IHdpdGhvdXQgdmFsdWUiKTsKLQkJZm10X3Bh
dGNoX3N1YmplY3RfcHJlZml4ID0geHN0cmR1cCh2YWx1ZSk7Ci0JCXJldHVybiAwOwotCX0KIAog
CXJldHVybiBnaXRfbG9nX2NvbmZpZyh2YXIsIHZhbHVlKTsKIH0KLS0gCjEuNS4yLjIuNjY5Lmdh
ZDMxNgoK
------=_Part_93479_557982.1183545730013--
