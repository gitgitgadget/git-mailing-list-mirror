From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Fix passing of TCLTK_PATH to git-gui
Date: Thu, 5 Apr 2007 09:49:57 +0200
Message-ID: <81b0412b0704050049u746842ebn270998c5732927d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_75002_13577871.1175759397062"
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Eygene Ryabinkin" <rea-git@codelabs.ru>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 05 09:50:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZMjJ-0007HG-Kw
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 09:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946054AbXDEHt6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 03:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946056AbXDEHt6
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 03:49:58 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:48191 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946054AbXDEHt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 03:49:57 -0400
Received: by an-out-0708.google.com with SMTP id b33so563638ana
        for <git@vger.kernel.org>; Thu, 05 Apr 2007 00:49:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=SPNZdrX3SCnJXQh4+1f2zMzk0arPhm59iHU0GP0AMzgJBIV+1F9mVDw/ACbdJbEOCjTHyj2BIASCO5940Wr6wf7DSrA6IshL4CT9XthB+iEYUKx0MrqusahhuHaPKpLTfFKXaCS+BHnFab1qYE02t1Mj/FqJqlVXdCiXj2Wkkl0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=kozsYE6+AXfe9eu4lns2N3oluHbGY6yn2zyJsqKYoeF0DUai9b7oyvpdu6azAzJk9xMg5qwRZN2iwW7xsTk/lqKWxo/pVmPoxVWAo+M2TA9XTBInGrxGIegaXhHAqzg2PSrXjUlxiC5/GGqpe1rZGj7BXMn7Pqwo6Aqx8KV0w28=
Received: by 10.100.154.13 with SMTP id b13mr1096594ane.1175759397105;
        Thu, 05 Apr 2007 00:49:57 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Thu, 5 Apr 2007 00:49:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43804>

------=_Part_75002_13577871.1175759397062
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

GNU make does not include environment variables by default
in its namespace.

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

------=_Part_75002_13577871.1175759397062
Content-Type: text/plain; name=0001-Fix-passing-of-TCLTK_PATH-to-git-gui.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f04ws2wj
Content-Disposition: attachment; filename="0001-Fix-passing-of-TCLTK_PATH-to-git-gui.txt"

RnJvbSAxZGY2MWE5ZjFmMzU1MWVhYWQ2OTljZTFjNGVmNGFkYTczNGM5ODM2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUaHUsIDUgQXByIDIwMDcgMDk6NDU6MDMgKzAyMDAKU3ViamVjdDogW1BBVENIXSBGaXggcGFz
c2luZyBvZiBUQ0xUS19QQVRIIHRvIGdpdC1ndWkKClNpZ25lZC1vZmYtYnk6IEFsZXggUmllc2Vu
IDxyYWEubGttbEBnbWFpbC5jb20+Ci0tLQogTWFrZWZpbGUgfCAgICAyICstCiAxIGZpbGVzIGNo
YW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9NYWtl
ZmlsZSBiL01ha2VmaWxlCmluZGV4IGFkMzIxYjMuLjUwN2FkOTEgMTAwNjQ0Ci0tLSBhL01ha2Vm
aWxlCisrKyBiL01ha2VmaWxlCkBAIC03MDMsNyArNzAzLDcgQEAgZW5kaWYKIAogYWxsOjoKIGlm
bmRlZiBOT19UQ0xUSwotCSQoUVVJRVRfU1VCRElSMClnaXQtZ3VpIFRDTFRLX1BBVEg9JyQoVENM
VEtfUEFUSF9TUSknICQoUVVJRVRfU1VCRElSMSkgYWxsCisJJChRVUlFVF9TVUJESVIwKWdpdC1n
dWkgJChRVUlFVF9TVUJESVIxKSBUQ0xUS19QQVRIPSckKFRDTFRLX1BBVEhfU1EpJyBhbGwKIGVu
ZGlmCiAJJChRVUlFVF9TVUJESVIwKXBlcmwgJChRVUlFVF9TVUJESVIxKSBQRVJMX1BBVEg9JyQo
UEVSTF9QQVRIX1NRKScgcHJlZml4PSckKHByZWZpeF9TUSknIGFsbAogCSQoUVVJRVRfU1VCRElS
MCl0ZW1wbGF0ZXMgJChRVUlFVF9TVUJESVIxKQotLSAKMS41LjEuNDEuZzNlYTkyCgo=
------=_Part_75002_13577871.1175759397062--
