From: Alex Riesen <raa.lkml@gmail.com>
Subject: trivial: check, if t/trash directory was successfully created
Date: Thu, 5 Jan 2006 12:57:36 +0100
Message-ID: <81b0412b0601050357s2446b103we3e9beff5de50be9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_11369_29646553.1136462256702"
X-From: git-owner@vger.kernel.org Thu Jan 05 12:58:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuTlS-0002uT-IS
	for gcvg-git@gmane.org; Thu, 05 Jan 2006 12:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbWAEL6j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jan 2006 06:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752168AbWAEL6j
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jan 2006 06:58:39 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:6551 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932956AbWAEL6i (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jan 2006 06:58:38 -0500
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.193])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k05Bwbvo018447
	for <git@vger.kernel.org>; Thu, 5 Jan 2006 03:58:38 -0800
Received: by nproxy.gmail.com with SMTP id x37so104280nfc
        for <git@vger.kernel.org>; Thu, 05 Jan 2006 03:57:37 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=iSKWE2AoNyZoI60EzS1bkIhCcicL/7vFwfDdaa5OeDm1CpMWmrUDuV0Xgedx4ZJ68hgZNje26PlCDjGu7l4FpSmozYL5kOkFogWYdokqzulEimk18/vtgQdtmO1WORAHi/6QN1PRl4KfuriG/TxNDBwmFP28oZeObOO9Fn2rlKU=
Received: by 10.49.2.9 with SMTP id e9mr682821nfi;
        Thu, 05 Jan 2006 03:57:36 -0800 (PST)
Received: by 10.48.248.4 with HTTP; Thu, 5 Jan 2006 03:57:36 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on zeus1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14197>

------=_Part_11369_29646553.1136462256702
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

and was successfully entered. Otherwise git-init-db will create it directly
in the working directory (t/) which can be dangerous.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

------=_Part_11369_29646553.1136462256702
Content-Type: text/plain; name="0010-Check-if-trash-directory-was-successfully-created.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0010-Check-if-trash-directory-was-successfully-created.txt"

U3ViamVjdDogW1BBVENIXSBDaGVjaywgaWYgdHJhc2ggZGlyZWN0b3J5IHdhcyBzdWNjZXNzZnVs
bHkgY3JlYXRlZAoKYW5kIHdhcyBlbnRlcmVkLiBPdGhlcndpc2UgZ2l0LWluaXQtZGIgd2lsbCBj
cmVhdGUgaXQgZGlyZWN0bHkgaW4gdGhlCndvcmtpbmcgZGlyZWN0b3J5IHdoaWNoIGNhbiBiZSBk
YW5nZXJvdXMgd2l0aCBhbGwgdGhlc2UgbmFzdHkgcm0ncwppbiB0aGUgdGVzdHMKClNpZ25lZC1v
ZmYtYnk6IEFsZXggUmllc2VuIDxyYWEubGttbEBnbWFpbC5jb20+CgoKLS0tCgogdC90ZXN0LWxp
Yi5zaCB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9ucygtKQoKMDFkM2Y4ZmM3NDk5YTJkZDVlMjE1MTMxODdkZTdkNzNhZjA4MDUzMwpkaWZmIC0t
Z2l0IGEvdC90ZXN0LWxpYi5zaCBiL3QvdGVzdC1saWIuc2gKaW5kZXggYTk3ZDI1OS4uNzUzNGE3
NiAxMDA3NTUKLS0tIGEvdC90ZXN0LWxpYi5zaAorKysgYi90L3Rlc3QtbGliLnNoCkBAIC0xOTUs
NyArMTk1LDcgQEAgdGVzdCAtZCAuLi90ZW1wbGF0ZXMvYmx0IHx8IHsKIHRlc3Q9dHJhc2gKIHJt
IC1mciAiJHRlc3QiCiBta2RpciAiJHRlc3QiCi1jZCAiJHRlc3QiCitjZCAiJHRlc3QiIHx8IGVy
cm9yICJDYW5ub3Qgc2V0dXAgdGVzdCBlbnZpcm9ubWVudCIKICIkR0lUX0VYRUNfUEFUSC9naXQi
IGluaXQtZGIgLS10ZW1wbGF0ZT0uLi8uLi90ZW1wbGF0ZXMvYmx0LyAyPi9kZXYvbnVsbCB8fAog
ZXJyb3IgImNhbm5vdCBydW4gZ2l0IGluaXQtZGIgLS0gaGF2ZSB5b3UgYnVpbHQgdGhpbmdzIHll
dD8iCiAKLS0gCjEuMC5HSVQK
------=_Part_11369_29646553.1136462256702--
