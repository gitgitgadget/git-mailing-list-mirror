From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] disable merge summaries if they are disabled
Date: Wed, 23 May 2007 18:03:54 +0200
Message-ID: <81b0412b0705230903j197c2b8ewfbf81002c0e6b5be@mail.gmail.com>
References: <81b0412b0705230828s7fcdd836gf3bb92000d8ebd79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_64016_29094956.1179936234107"
Cc: "Junio C Hamano" <junkio@cox.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 23 18:04:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqtJt-0003Ow-SZ
	for gcvg-git@gmane.org; Wed, 23 May 2007 18:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756156AbXEWQD5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 12:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759412AbXEWQD5
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 12:03:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:47835 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756156AbXEWQD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 12:03:56 -0400
Received: by ug-out-1314.google.com with SMTP id j3so575402ugf
        for <git@vger.kernel.org>; Wed, 23 May 2007 09:03:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=YnJTw9x7+PdXC335dW/yy2bCxXeOOsAx/h1eiykPICllXbF2J2TPqnLQTWSAq0AH+gvSKw1jJ3ly1545EUAWDNi/k1i83FgTfHysIZztzpV0PAvuRTKHxPdtS57Qavtm4t5oQVId1SxZvIuQtgsVpUFXMOkbqkalovzH5Zbr9eg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=Ltur0ZoRyZ3jvBj6A0LoVp53T22rtRdCS8EVIr5OtVhQnqW2FCikuUXg5Pwcn0PPD43jyOz/U7r5cqDlteKD40b4ZsJQc1ejn1ErJ18BqncNudaHYmc1qLhdAI5NPwpN0DI0POBmb2Le7dYPh/vb0Ak144QP1rGIJ40pG3LaeJg=
Received: by 10.78.186.9 with SMTP id j9mr159568huf.1179936234143;
        Wed, 23 May 2007 09:03:54 -0700 (PDT)
Received: by 10.78.97.16 with HTTP; Wed, 23 May 2007 09:03:54 -0700 (PDT)
In-Reply-To: <81b0412b0705230828s7fcdd836gf3bb92000d8ebd79@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48161>

------=_Part_64016_29094956.1179936234107
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Otherwise the merge.summary option has no visible effect.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

---

Forgot the sign-off.

 git-merge.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

------=_Part_64016_29094956.1179936234107
Content-Type: text/plain; 
	name=0001-disable-merge-summaries-if-the-are-disabled.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f21zjvu1
Content-Disposition: attachment; filename="0001-disable-merge-summaries-if-the-are-disabled.txt"

RnJvbSAyMGVmODFjYTNiMzBhNGM5NjkwNmIzNTEyY2ExYjUyZDJiZWMzNjk4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBXZWQsIDIzIE1heSAyMDA3IDE1OjUyOjE2ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gZGlzYWJs
ZSBtZXJnZSBzdW1tYXJpZXMgaWYgdGhleSBhcmUgZGlzYWJsZWQKClNpZ25lZC1vZmYtYnk6IEFs
ZXggUmllc2VuIDxyYWEubGttbEBnbWFpbC5jb20+Ci0tLQogZ2l0LW1lcmdlLnNoIHwgICAgMSAr
CiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9naXQtbWVyZ2Uuc2ggYi9naXQtbWVyZ2Uuc2gKaW5kZXggMzUxNjc2Zi4uN2ZiZTAz
YSAxMDA3NTUKLS0tIGEvZ2l0LW1lcmdlLnNoCisrKyBiL2dpdC1tZXJnZS5zaApAQCAtMTIxLDYg
KzEyMSw3IEBAIG1lcmdlX25hbWUgKCkgewogY2FzZSAiJCMiIGluIDApIHVzYWdlIDs7IGVzYWMK
IAogaGF2ZV9tZXNzYWdlPQordGVzdCAkKGdpdC1jb25maWcgbWVyZ2Uuc3VtbWFyeSkgPSBmYWxz
ZSAmJiBub19zdW1tYXJ5PXQKIHdoaWxlIGNhc2UgIiQjIiBpbiAwKSBicmVhayA7OyBlc2FjCiBk
bwogCWNhc2UgIiQxIiBpbgotLSAKMS41LjIuNzg3Lmc1Njc3MAoK
------=_Part_64016_29094956.1179936234107--
