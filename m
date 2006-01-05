From: Alex Riesen <raa.lkml@gmail.com>
Subject: trivial: use git-repo-config to detect how to run tests in the test repository
Date: Thu, 5 Jan 2006 12:55:58 +0100
Message-ID: <81b0412b0601050355i78a7a71dm852bfdad5ad3648b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_11361_15679517.1136462158252"
X-From: git-owner@vger.kernel.org Thu Jan 05 12:56:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuTiu-0002DS-Lu
	for gcvg-git@gmane.org; Thu, 05 Jan 2006 12:56:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbWAEL4B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jan 2006 06:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752091AbWAEL4B
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jan 2006 06:56:01 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:53696 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752074AbWAEL4A (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jan 2006 06:56:00 -0500
Received: by nproxy.gmail.com with SMTP id x37so104122nfc
        for <git@vger.kernel.org>; Thu, 05 Jan 2006 03:55:59 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=XY80hCv16g+5zjrTp1XE7ECJn/C9SPzv1gyISrriKrkeWfrDt3Nzv6J6BaKTrqAdDm6XKH7SG7n5DM3p3I102YvGCNFy3unMF1Q1gN0GonKFSzEuMqn/hjc24RREAPyqHTqthrPiZjZ1JRIKqv1ExmbeoECCdFygToRRBZLO8CY=
Received: by 10.48.30.17 with SMTP id d17mr682769nfd;
        Thu, 05 Jan 2006 03:55:58 -0800 (PST)
Received: by 10.48.248.4 with HTTP; Thu, 5 Jan 2006 03:55:58 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14195>

------=_Part_11361_15679517.1136462158252
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

------=_Part_11361_15679517.1136462158252
Content-Type: text/plain; name="0009-use-git-repo-config-to-detect-how-to-run-the-test-in-the-test-repository.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0009-use-git-repo-config-to-detect-how-to-run-the-test-in-the-test-repository.txt"

U3ViamVjdDogW1BBVENIXSB1c2UgZ2l0LXJlcG8tY29uZmlnCgp0byBkZXRlY3QgaG93IHRvIHJ1
biB0aGUgdGVzdCBpbiB0aGUgdGVzdCByZXBvc2l0b3J5CgpTaWduZWQtb2ZmLWJ5OiBBbGV4IFJp
ZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgoKCi0tLQoKIHQvdDQwMDYtZGlmZi1tb2RlLnNoICAg
IHwgICAyMCArKysrKysrKysrKysrKystLS0tLQogdC90NDEwMi1hcHBseS1yZW5hbWUuc2ggfCAg
ICA5ICsrKysrKystLQogMiBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCA3IGRlbGV0
aW9ucygtKQoKMzA2YTA1OGYzZjNkMmE4YTQyMGVjNGRlNzg2Mzk4ZWM3N2IwZmM4MwpkaWZmIC0t
Z2l0IGEvdC90NDAwNi1kaWZmLW1vZGUuc2ggYi90L3Q0MDA2LWRpZmYtbW9kZS5zaAppbmRleCBl
MmE2N2U5Li44YWQ2OWQxIDEwMDc1NQotLS0gYS90L3Q0MDA2LWRpZmYtbW9kZS5zaAorKysgYi90
L3Q0MDA2LWRpZmYtbW9kZS5zaApAQCAtMTUsMTEgKzE1LDIxIEBAIHRlc3RfZXhwZWN0X3N1Y2Nl
c3MgXAogICAgICB0cmVlPWBnaXQtd3JpdGUtdHJlZWAgJiYKICAgICAgZWNobyAkdHJlZScKIAot
dGVzdF9leHBlY3Rfc3VjY2VzcyBcCi0gICAgJ2NobW9kJyBcCi0gICAgJ2NobW9kICt4IHJlenJv
diAmJgotICAgICBnaXQtdXBkYXRlLWluZGV4IHJlenJvdiAmJgotICAgICBnaXQtZGlmZi1pbmRl
eCAkdHJlZSA+Y3VycmVudCcKK2lmIFsgIiQoZ2l0IHJlcG8tY29uZmlnIC0tZ2V0IGNvcmUuZmls
ZW1vZGUpIiA9IGZhbHNlIF0KK3RoZW4KKwlzYXkgJ2ZpbGVtb2RlIGRpc2FibGVkIG9uIHRoZSBm
aWxlc3lzdGVtLCB1c2luZyB1cGRhdGUtaW5kZXggLS1jaG1vZD0reCcKKwl0ZXN0X2V4cGVjdF9z
dWNjZXNzIFwKKwkgICAgJ2dpdC11cGRhdGUtaW5kZXggLS1jaG1vZD0reCcgXAorCSAgICAnZ2l0
LXVwZGF0ZS1pbmRleCByZXpyb3YgJiYKKwkgICAgIGdpdC11cGRhdGUtaW5kZXggLS1jaG1vZD0r
eCByZXpyb3YgJiYKKwkgICAgIGdpdC1kaWZmLWluZGV4ICR0cmVlID5jdXJyZW50JworZWxzZQor
CXRlc3RfZXhwZWN0X3N1Y2Nlc3MgXAorCSAgICAnY2htb2QnIFwKKwkgICAgJ2NobW9kICt4IHJl
enJvdiAmJgorCSAgICAgZ2l0LXVwZGF0ZS1pbmRleCByZXpyb3YgJiYKKwkgICAgIGdpdC1kaWZm
LWluZGV4ICR0cmVlID5jdXJyZW50JworZmkKIAogX3g0MD0nWzAtOWEtZl1bMC05YS1mXVswLTlh
LWZdWzAtOWEtZl1bMC05YS1mXScKIF94NDA9IiRfeDQwJF94NDAkX3g0MCRfeDQwJF94NDAkX3g0
MCRfeDQwJF94NDAiCmRpZmYgLS1naXQgYS90L3Q0MTAyLWFwcGx5LXJlbmFtZS5zaCBiL3QvdDQx
MDItYXBwbHktcmVuYW1lLnNoCmluZGV4IDA0MDFkN2IuLmZiYjUwOGQgMTAwNzU1Ci0tLSBhL3Qv
dDQxMDItYXBwbHktcmVuYW1lLnNoCisrKyBiL3QvdDQxMDItYXBwbHktcmVuYW1lLnNoCkBAIC0z
MSw3ICszMSwxMiBAQCB0ZXN0X2V4cGVjdF9zdWNjZXNzIHNldHVwIFwKIHRlc3RfZXhwZWN0X3N1
Y2Nlc3MgYXBwbHkgXAogICAgICdnaXQtYXBwbHkgLS1pbmRleCAtLXN0YXQgLS1zdW1tYXJ5IC0t
YXBwbHkgdGVzdC1wYXRjaCcKIAotdGVzdF9leHBlY3Rfc3VjY2VzcyB2YWxpZGF0ZSBcCi0gICAg
J3Rlc3QgLWYgYmFyICYmIGxzIC1sIGJhciB8IGdyZXAgIl4tLi54Li4uLi4uIicKK2lmIFsgIiQo
Z2l0IHJlcG8tY29uZmlnIC0tZ2V0IGNvcmUuZmlsZW1vZGUpIiA9IGZhbHNlIF0KK3RoZW4KKwlz
YXkgJ2ZpbGVtb2RlIGRpc2FibGVkIG9uIHRoZSBmaWxlc3lzdGVtJworZWxzZQorCXRlc3RfZXhw
ZWN0X3N1Y2Nlc3MgdmFsaWRhdGUgXAorCSAgICAndGVzdCAtZiBiYXIgJiYgbHMgLWwgYmFyIHwg
Z3JlcCAiXi0uLnguLi4uLi4iJworZmkKIAogdGVzdF9kb25lCi0tIAoxLjAuR0lUCg==
------=_Part_11361_15679517.1136462158252--
