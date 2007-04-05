From: "Dana How" <danahow@gmail.com>
Subject: [PATCH 03/13] make close optional (like checksum) in csum-file.c:sha1close
Date: Thu, 5 Apr 2007 15:26:52 -0700
Message-ID: <56b7f5510704051526o4067ed4al948ba0767adc458b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_58987_23082705.1175812012053"
Cc: git@vger.kernel.org, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 00:27:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZaPw-0004Qq-7h
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 00:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767224AbXDEW0x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 18:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767367AbXDEW0x
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 18:26:53 -0400
Received: from nz-out-0506.google.com ([64.233.162.238]:10930 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767224AbXDEW0x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 18:26:53 -0400
Received: by nz-out-0506.google.com with SMTP id s1so401959nze
        for <git@vger.kernel.org>; Thu, 05 Apr 2007 15:26:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=aQg2YLGPaxVN+npiYPAywGaAycVE/mz/3C4hKw2q5XMIkrksoFmj6i/4xHa6BFFEll991vxshZFV0PkJyhiIz1M42QxhP3bLmIrGWmt74hzcBsVN/MdQ9dNk+0LHjipqppk26Pr13q70bOvkpue4uy+dajgJUbJLVaWR+PJanCE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=i7bbjkkimUnzCc/0i7fGI9CfOYZHUTR4M8++R6opB8KHDThDtVzRlhO7PgnDAbkpFrptiEyuIljlMeSWzzlCvXLoLmZiJ1nnHxHLKc6sUQETXHuGdPM8pXuEDiEvw4T35ImIDTrsbp1j+sYCvKojFx/4AFkoL2KVCo2snKiGw8c=
Received: by 10.115.61.1 with SMTP id o1mr948748wak.1175812012096;
        Thu, 05 Apr 2007 15:26:52 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Thu, 5 Apr 2007 15:26:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43866>

------=_Part_58987_23082705.1175812012053
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

---
 csum-file.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell

------=_Part_58987_23082705.1175812012053
Content-Type: text/plain; name="0003-make-close-optional-like-checksum-in-csum-file.c-s.patch.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0003-make-close-optional-like-checksum-in-csum-file.c-s.patch.txt"
X-Attachment-Id: f_f05s3s7c

RnJvbSBlZTViNmM4OGMzODk1MGVhYjRhNzgxNTEyMGQ3MmNmMzRlZDBmMTAwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5hIEhvdyA8aG93QGRlYXRodmFsbGV5LmNzd2l0Y2guY29t
PgpEYXRlOiBUaHUsIDUgQXByIDIwMDcgMTI6MjE6NTggLTA3MDAKU3ViamVjdDogW1BBVENIIDAz
LzEzXSBtYWtlIGNsb3NlIG9wdGlvbmFsIChsaWtlIGNoZWNrc3VtKSBpbiBjc3VtLWZpbGUuYzpz
aGExY2xvc2UKCi0tLQogY3N1bS1maWxlLmMgfCAgICAzICsrKwogMSBmaWxlcyBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvY3N1bS1maWxlLmMg
Yi9jc3VtLWZpbGUuYwppbmRleCBiNzE3NGM2Li5lMWZmNzY5IDEwMDY0NAotLS0gYS9jc3VtLWZp
bGUuYworKysgYi9jc3VtLWZpbGUuYwpAQCAtMzUsNyArMzUsMTAgQEAgaW50IHNoYTFjbG9zZShz
dHJ1Y3Qgc2hhMWZpbGUgKmYsIHVuc2lnbmVkIGNoYXIgKnJlc3VsdCwgaW50IHVwZGF0ZSkKIAlp
ZiAob2Zmc2V0KSB7CiAJCVNIQTFfVXBkYXRlKCZmLT5jdHgsIGYtPmJ1ZmZlciwgb2Zmc2V0KTsK
IAkJc2hhMWZsdXNoKGYsIG9mZnNldCk7CisJCWYtPm9mZnNldCA9IDA7CiAJfQorCWlmICh1cGRh
dGUgPCAwKQorCQlyZXR1cm4gMDsJLyogb25seSB3YW50IHRvIGZsdXNoIChubyBjaGVja3N1bSB3
cml0ZSwgbm8gY2xvc2UpICovCiAJU0hBMV9GaW5hbChmLT5idWZmZXIsICZmLT5jdHgpOwogCWlm
IChyZXN1bHQpCiAJCWhhc2hjcHkocmVzdWx0LCBmLT5idWZmZXIpOwotLSAKMS41LjEucmMyLjE4
Lmc5Yzg4LWRpcnR5Cgo=
------=_Part_58987_23082705.1175812012053--
