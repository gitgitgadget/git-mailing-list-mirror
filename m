From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] disable merge summaries if they are disabled
Date: Wed, 23 May 2007 17:28:07 +0200
Message-ID: <81b0412b0705230828s7fcdd836gf3bb92000d8ebd79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_63776_29206939.1179934087605"
Cc: "Junio C Hamano" <junkio@cox.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 23 17:28:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hqsl8-00026j-BA
	for gcvg-git@gmane.org; Wed, 23 May 2007 17:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759368AbXEWP2O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 11:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934708AbXEWP2O
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 11:28:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:36100 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934969AbXEWP2M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 11:28:12 -0400
Received: by ug-out-1314.google.com with SMTP id j3so561608ugf
        for <git@vger.kernel.org>; Wed, 23 May 2007 08:28:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=DDBgtbrYnHVj8vMXwqrNwQ2wPaX6YTO9KxDfMV58T5+4Bpte9Ea2UOV6pCG2YeIfmRGLPYxXBu1aDv/ilGPuk1/rPzycMa//O3AV7lPGImKhtaSvQvhMGMn8La4T43p4hDk/Pyw+uUZWrA9+WwT9PuPVW4eEoG/3OtPzbW4bRTw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=hddhoIaCB751MlEG60lAhNUkMQWQBWrCRlmXslM2p+pljsJC2mPIQ/TSeQZexyFQ1p3pqxhx49JTe/3gRFPXQKJfl3XJkWoX5s0qwoWnfkeCXmBdT9zl3IytfsZKy0mCLxvA2ud5sw3kEHd5OXNT4fkj3z+HQS3PMuBqsvJKT0M=
Received: by 10.78.120.6 with SMTP id s6mr147490huc.1179934087631;
        Wed, 23 May 2007 08:28:07 -0700 (PDT)
Received: by 10.78.97.16 with HTTP; Wed, 23 May 2007 08:28:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48160>

------=_Part_63776_29206939.1179934087605
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Otherwise the merge.summary option has no visible effect.

---
 git-merge.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

------=_Part_63776_29206939.1179934087605
Content-Type: text/plain; name="0001-disable-merge-summaries-if-the-are-disabled.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-disable-merge-summaries-if-the-are-disabled.txt"
X-Attachment-Id: f_f21ybbfc

RnJvbSAyMGVmODFjYTNiMzBhNGM5NjkwNmIzNTEyY2ExYjUyZDJiZWMzNjk4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBXZWQsIDIzIE1heSAyMDA3IDE1OjUyOjE2ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gZGlzYWJs
ZSBtZXJnZSBzdW1tYXJpZXMgaWYgdGhleSBhcmUgZGlzYWJsZWQKCi0tLQogZ2l0LW1lcmdlLnNo
IHwgICAgMSArCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9naXQtbWVyZ2Uuc2ggYi9naXQtbWVyZ2Uuc2gKaW5kZXggMzUxNjc2
Zi4uN2ZiZTAzYSAxMDA3NTUKLS0tIGEvZ2l0LW1lcmdlLnNoCisrKyBiL2dpdC1tZXJnZS5zaApA
QCAtMTIxLDYgKzEyMSw3IEBAIG1lcmdlX25hbWUgKCkgewogY2FzZSAiJCMiIGluIDApIHVzYWdl
IDs7IGVzYWMKIAogaGF2ZV9tZXNzYWdlPQordGVzdCAkKGdpdC1jb25maWcgbWVyZ2Uuc3VtbWFy
eSkgPSBmYWxzZSAmJiBub19zdW1tYXJ5PXQKIHdoaWxlIGNhc2UgIiQjIiBpbiAwKSBicmVhayA7
OyBlc2FjCiBkbwogCWNhc2UgIiQxIiBpbgotLSAKMS41LjIuNzg0LmdiMThjCgo=
------=_Part_63776_29206939.1179934087605--
