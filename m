From: Alex Riesen <raa.lkml@gmail.com>
Subject: trivial: use git-repo-config to detect if the test can be run on the repository
Date: Thu, 5 Jan 2006 12:55:03 +0100
Message-ID: <81b0412b0601050355v7fcecaeem7e04c6ccb062bc3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_11345_15752674.1136462103333"
X-From: git-owner@vger.kernel.org Thu Jan 05 12:55:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuTi2-0001xc-JD
	for gcvg-git@gmane.org; Thu, 05 Jan 2006 12:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbWAELzG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jan 2006 06:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752074AbWAELzG
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jan 2006 06:55:06 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:2712 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752071AbWAELzF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jan 2006 06:55:05 -0500
Received: by nproxy.gmail.com with SMTP id x37so103985nfc
        for <git@vger.kernel.org>; Thu, 05 Jan 2006 03:55:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=NXekSXlx9gbWmiYX8IvY9xJyYW1sps8smkqOpHs0wBb2S6xkSXjtd5YmQ8WaTiQB/cnHCLtrgaIvJ6jIXsRf2mokxm5YkGEgnHjwfat93R2/He22gXVhsuTKr42LF1VHrnl5HawtiqwMQLa293x+ryRYNhQm6m93xtVqsaAXJNM=
Received: by 10.48.209.20 with SMTP id h20mr683306nfg;
        Thu, 05 Jan 2006 03:55:03 -0800 (PST)
Received: by 10.48.248.4 with HTTP; Thu, 5 Jan 2006 03:55:03 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14194>

------=_Part_11345_15752674.1136462103333
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

------=_Part_11345_15752674.1136462103333
Content-Type: text/plain; name="0008-use-git-repo-config-to-detect-if-the-test-can-be-run-on-the-repository.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0008-use-git-repo-config-to-detect-if-the-test-can-be-run-on-the-repository.txt"

U3ViamVjdDogW1BBVENIXSB1c2UgZ2l0LXJlcG8tY29uZmlnCgp0byBkZXRlY3QgaWYgdGhlIHRl
c3QgY2FuIGJlIHJ1biBvbiB0aGUgcmVwb3NpdG9yeQoKU2lnbmVkLW9mZi1ieTogQWxleCBSaWVz
ZW4gPHJhYS5sa21sQGdtYWlsLmNvbT4KCgotLS0KCiB0L3Q0MDAwLWRpZmYtZm9ybWF0LnNoIHwg
ICAgOCArKysrKysrKwogMSBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDAgZGVsZXRp
b25zKC0pCgphMDM4MzY1ODVhMWJjMzEwMWMyMTlhMzFmNDM2ZDA0NmYzNzc4MmYyCmRpZmYgLS1n
aXQgYS90L3Q0MDAwLWRpZmYtZm9ybWF0LnNoIGIvdC90NDAwMC1kaWZmLWZvcm1hdC5zaAppbmRl
eCBiZWI2ZDhmLi42N2I5NjgxIDEwMDc1NQotLS0gYS90L3Q0MDAwLWRpZmYtZm9ybWF0LnNoCisr
KyBiL3QvdDQwMDAtZGlmZi1mb3JtYXQuc2gKQEAgLTI2LDYgKzI2LDE0IEBAIHJtIC1mIHBhdGgx
CiB0ZXN0X2V4cGVjdF9zdWNjZXNzIFwKICAgICAnZ2l0LWRpZmYtZmlsZXMgLXAgYWZ0ZXIgZWRp
dGluZyB3b3JrIHRyZWUuJyBcCiAgICAgJ2dpdC1kaWZmLWZpbGVzIC1wID5jdXJyZW50JworCisj
IHRoYXQncyBhcyBmYXIgYXMgaXQgY29tZXMKK2lmIFsgIiQoZ2l0IHJlcG8tY29uZmlnIC0tZ2V0
IGNvcmUuZmlsZW1vZGUpIiA9IGZhbHNlIF0KK3RoZW4KKwlzYXkgJ2ZpbGVtb2RlIGRpc2FibGVk
IG9uIHRoZSBmaWxlc3lzdGVtJworCXRlc3RfZG9uZQorZmkKKwogY2F0ID5leHBlY3RlZCA8PFxF
T0YKIGRpZmYgLS1naXQgYS9wYXRoMCBiL3BhdGgwCiBvbGQgbW9kZSAxMDA2NDQKLS0gCjEuMC5H
SVQK
------=_Part_11345_15752674.1136462103333--
