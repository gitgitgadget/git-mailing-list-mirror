From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Allow default core.logallrefupdates to be overridden with template's config
Date: Tue, 23 Jan 2007 16:54:27 +0100
Message-ID: <81b0412b0701230754p3425ded4k1f37dd26500c1744@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_169956_28549331.1169567667084"
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 23 16:54:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9Nym-00062F-Az
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 16:54:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932739AbXAWPyd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 10:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932793AbXAWPyd
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 10:54:33 -0500
Received: from wr-out-0506.google.com ([64.233.184.233]:9867 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932739AbXAWPyd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 10:54:33 -0500
Received: by wr-out-0506.google.com with SMTP id i22so1034061wra
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 07:54:32 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=pbfvx3luCpbnK7TTl17GZEdLFnyX3SkVelW1X/x5rVTe+mP1iRBepvVXfyL9/t+MIt5mTQmPMbedAiS2LoV3Sm7pvBo1OTzW8TdhhPXQVe0VuH7IaLLP4k8JQTzzI3lU952ca6+/dPL0HHkU0D2v9inTsa4ePTaOYpxbAr148a0=
Received: by 10.78.204.7 with SMTP id b7mr424153hug.1169567667231;
        Tue, 23 Jan 2007 07:54:27 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Tue, 23 Jan 2007 07:54:27 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37539>

------=_Part_169956_28549331.1169567667084
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Never found a use for the reflogs and tried to switch
them off. Didn't work - init-db rewrote it.

 builtin-init-db.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

------=_Part_169956_28549331.1169567667084
Content-Type: text/plain; 
	name=0001-Allow-default-core.logallrefupdates-to-be-overridden-with-template-s-config.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_exaidqnq
Content-Disposition: attachment; filename="0001-Allow-default-core.logallrefupdates-to-be-overridden-with-template-s-config.txt"

RnJvbSA3MTNjNDg5MGNlNzk1Yzg0MGY1YjQ0NjhkYjg2ODlkZTQ0NTcyZWY4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUdWUsIDIzIEphbiAyMDA3IDE2OjUxOjE4ICswMTAwClN1YmplY3Q6IFtQQVRDSF0gQWxsb3cg
ZGVmYXVsdCBjb3JlLmxvZ2FsbHJlZnVwZGF0ZXMgdG8gYmUgb3ZlcnJpZGRlbiB3aXRoIHRlbXBs
YXRlJ3MgY29uZmlnCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwu
Y29tPgotLS0KIGJ1aWx0aW4taW5pdC1kYi5jIHwgICAgNCArKystCiAxIGZpbGVzIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9idWlsdGluLWlu
aXQtZGIuYyBiL2J1aWx0aW4taW5pdC1kYi5jCmluZGV4IDhlNzU0MGIuLjE4NjU0ODkgMTAwNjQ0
Ci0tLSBhL2J1aWx0aW4taW5pdC1kYi5jCisrKyBiL2J1aWx0aW4taW5pdC1kYi5jCkBAIC0yNTcs
NyArMjU3LDkgQEAgc3RhdGljIGludCBjcmVhdGVfZGVmYXVsdF9maWxlcyhjb25zdCBjaGFyICpn
aXRfZGlyLCBjb25zdCBjaGFyICp0ZW1wbGF0ZV9wYXRoKQogCX0KIAllbHNlIHsKIAkJZ2l0X2Nv
bmZpZ19zZXQoImNvcmUuYmFyZSIsICJmYWxzZSIpOwotCQlnaXRfY29uZmlnX3NldCgiY29yZS5s
b2dhbGxyZWZ1cGRhdGVzIiwgInRydWUiKTsKKwkJLyogYWxsb3cgdGVtcGxhdGUgY29uZmlnIGZp
bGUgdG8gb3ZlcnJpZGUgdGhlIGRlZmF1bHQgKi8KKwkJaWYgKGxvZ19hbGxfcmVmX3VwZGF0ZXMg
PT0gLTEpCisJCSAgICBnaXRfY29uZmlnX3NldCgiY29yZS5sb2dhbGxyZWZ1cGRhdGVzIiwgInRy
dWUiKTsKIAl9CiAJcmV0dXJuIHJlaW5pdDsKIH0KLS0gCjEuNS4wLnJjMi5nODNkMwoK
------=_Part_169956_28549331.1169567667084--
