From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Fix t7606 on Cygwin: for some reasont it does not recognize a "." in PATH
Date: Fri, 12 Dec 2008 13:29:00 +0100
Message-ID: <81b0412b0812120428mc85ae84r260b722022dc3449@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_76231_1144079.1229084940053"
Cc: "Junio C Hamano" <junkio@cox.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 12 13:30:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LB7AB-0000VL-MI
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 13:30:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756229AbYLLM3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 07:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756110AbYLLM3E
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 07:29:04 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:43103 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755601AbYLLM3C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 07:29:02 -0500
Received: by wa-out-1112.google.com with SMTP id v27so684888wah.21
        for <git@vger.kernel.org>; Fri, 12 Dec 2008 04:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type;
        bh=S1pP/KKjTsj7orKRIJsFQl/HfhSrbTFUG+7g3ACW7gI=;
        b=SHSb2F3ki1tVlnRGXs1Ey+cAL/uScXVboE4qCDEEWMZZMp2QWam9Q77JAoR41Ym+7U
         25Dsvu1rRnTnqfFvpOxHbx2oZ7cMJI4JU2yXyzgX1RpGRLaDk6M2zq75zQ8a3tPFbCvi
         DWxl2Lm4fsBH8qWFkeJ4pGfEa+yrBoKYYz1Vs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type;
        b=XxSYE6RteWEsK5lXEWVbzRu9gzmVhqfltPUAUwJwL/BKgvPWKIGN8rFN9dm8dIGZvJ
         eWZrxK3n1P6X/ovNGUIVpG6hnv8CE2GXe3ZdexTw0+B82CBKXrqt2rFA0NZQT52q5e1I
         9cXFhO8lOpgun0bvzR6Su4Z6t2VGkS5kQNc5U=
Received: by 10.114.157.1 with SMTP id f1mr2679087wae.43.1229084940070;
        Fri, 12 Dec 2008 04:29:00 -0800 (PST)
Received: by 10.114.74.15 with HTTP; Fri, 12 Dec 2008 04:29:00 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102895>

------=_Part_76231_1144079.1229084940053
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The test uses the dot to add custom merge strategies
---
 t/t7606-merge-custom.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

------=_Part_76231_1144079.1229084940053
Content-Type: application/octet-stream;
 name=0001-Fix-t7606-on-Cygwin-it-does-not-recognize-a-.-in.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fomtds9x0
Content-Disposition: attachment;
 filename=0001-Fix-t7606-on-Cygwin-it-does-not-recognize-a-.-in.patch

RnJvbSA5MjhiMmI5NTViZDJlZjBlNDAwZGU2OThjMGMwYmNkZTVlNjQ2MzhiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBNb24sIDI5IFNlcCAyMDA4IDE3OjA3OjAwICswMjAwClN1YmplY3Q6IFtQQVRDSF0gRml4IHQ3
NjA2IG9uIEN5Z3dpbjogZm9yIHNvbWUgcmVhc29udCBpdCBkb2VzIG5vdCByZWNvZ25pemUgYSAi
LiIgaW4gUEFUSAoKVGhlIHRlc3QgdXNlcyB0aGUgZG90IHRvIGFkZCBjdXN0b20gbWVyZ2Ugc3Ry
YXRlZ2llcwotLS0KIHQvdDc2MDYtbWVyZ2UtY3VzdG9tLnNoIHwgICAgMiArLQogMSBmaWxlcyBj
aGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdC90
NzYwNi1tZXJnZS1jdXN0b20uc2ggYi90L3Q3NjA2LW1lcmdlLWN1c3RvbS5zaAppbmRleCA1MmE0
NTFkLi4yMGMwOTA3IDEwMDc1NQotLS0gYS90L3Q3NjA2LW1lcmdlLWN1c3RvbS5zaAorKysgYi90
L3Q3NjA2LW1lcmdlLWN1c3RvbS5zaApAQCAtMTEsNyArMTEsNyBAQCBjYXQgPmdpdC1tZXJnZS10
aGVpcnMgPDxFT0YKIGV2YWwgZ2l0IHJlYWQtdHJlZSAtLXJlc2V0IC11IFxcXCRcJCMKIEVPRgog
Y2htb2QgK3ggZ2l0LW1lcmdlLXRoZWlycwotUEFUSD0uOiRQQVRICitQQVRIPSQocHdkKToiJFBB
VEgiCiBleHBvcnQgUEFUSAogCiB0ZXN0X2V4cGVjdF9zdWNjZXNzICdzZXR1cCcgJwotLSAKMS42
LjEucmMyLjQ4LmczYzdkZgoK
------=_Part_76231_1144079.1229084940053--
