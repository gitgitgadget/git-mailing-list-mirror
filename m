From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Fix t4030-diff-textconv.sh
Date: Wed, 19 Nov 2008 12:14:50 +0100
Message-ID: <81b0412b0811190314m44f4ac92me747aaad4b542d84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_34617_9225641.1227093290529"
To: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 19 12:16:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2l2U-0002n4-RS
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 12:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbYKSLOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 06:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752098AbYKSLOw
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 06:14:52 -0500
Received: from rv-out-0506.google.com ([209.85.198.225]:52758 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbYKSLOv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 06:14:51 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3359173rvb.1
        for <git@vger.kernel.org>; Wed, 19 Nov 2008 03:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type;
        bh=668ObBRsR2ZFDxKI08HwkoTEtiiGfY16ToOGfKjBq7M=;
        b=BGsnysIfjg5Dag0ZF3vnUqt1RPpa2KnHygYBWyu9+mpwL7YwRFLQN1PQWDUmdclgo8
         ULdUaBSAxJnTeIhhmD9i6bMfU644CKyVhPi4Sebvdss6ThMasPxY7ifPf8YRzlvNVa5R
         AuF3/wN8/EtuUqt6j+IaDZ4Odn4uzPIHWgTuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=FStxx7EEgfR4/mVltSRTh1yaYwbNnK5H9UtXn9aoo5MoSBf+UP5+jNf8cj4rPW5A0/
         8+83Knai4Ci1J4nx9kIIMZdOujM/PI7Rn+K3qKizYriuwkuV/Ju64yjEvksZ5fFs0T+n
         H6W8u0wK4KBQTFwWFygqetVHHgO5rnNE261p8=
Received: by 10.114.24.1 with SMTP id 1mr585452wax.179.1227093290548;
        Wed, 19 Nov 2008 03:14:50 -0800 (PST)
Received: by 10.114.157.9 with HTTP; Wed, 19 Nov 2008 03:14:50 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101324>

------=_Part_34617_9225641.1227093290529
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Avoid passing cygwin pathnames to Perl. Some Perls have problems using them

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 t/t4030-diff-textconv.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

------=_Part_34617_9225641.1227093290529
Content-Type: text/x-diff; name=0001-Fix-t4030-diff-textconv.sh.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fnpvmt580
Content-Disposition: attachment;
 filename=0001-Fix-t4030-diff-textconv.sh.patch

RnJvbSBlODU2MjQ4N2RhMDMzNmYwZjE2ODMyZTcyMjY0Zjk4ODc5ZTAzOTRiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUdWUsIDE4IE5vdiAyMDA4IDExOjM5OjQ2ICswMTAwClN1YmplY3Q6IFtQQVRDSF0gRml4IHQ0
MDMwLWRpZmYtdGV4dGNvbnYuc2gKCkF2b2lkIHBhc3NpbmcgY3lnd2luIHBhdGhuYW1lcyB0byBQ
ZXJsLiBTb21lIFBlcmxzIGhhdmUgcHJvYmxlbXMgdXNpbmcgdGhlbQoKU2lnbmVkLW9mZi1ieTog
QWxleCBSaWVzZW4gPHJhYS5sa21sQGdtYWlsLmNvbT4KLS0tCiB0L3Q0MDMwLWRpZmYtdGV4dGNv
bnYuc2ggfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS90L3Q0MDMwLWRpZmYtdGV4dGNvbnYuc2ggYi90L3Q0MDMw
LWRpZmYtdGV4dGNvbnYuc2gKaW5kZXggMDNiYTI2YS4uMGI3NmU3YyAxMDA3NTUKLS0tIGEvdC90
NDAzMC1kaWZmLXRleHRjb252LnNoCisrKyBiL3QvdDQwMzAtZGlmZi10ZXh0Y29udi5zaApAQCAt
MjEsNyArMjEsNyBAQCBFT0YKIAogY2F0ID5oZXhkdW1wIDw8J0VPRicKICMhL2Jpbi9zaAotcGVy
bCAtZSAnJC8gPSB1bmRlZjsgJF8gPSA8Pjsgcy8uL29yZCgkJikvZ2U7IHByaW50ICRfJyAiJDEi
CitwZXJsIC1lICckLyA9IHVuZGVmOyAkXyA9IDw+OyBzLy4vb3JkKCQmKS9nZTsgcHJpbnQgJF8n
IDwgIiQxIgogRU9GCiBjaG1vZCAreCBoZXhkdW1wCiAKLS0gCjEuNi4wLjQuNjQ0LmdiNjE5YQoK

------=_Part_34617_9225641.1227093290529--
