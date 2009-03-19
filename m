From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] git clone needs to know executability of template files
Date: Thu, 19 Mar 2009 11:28:25 +0100
Message-ID: <81b0412b0903190328n17007b4alcf5d91db562db62b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e640d0f6aa128f0465764231
Cc: Johannes Sixt <j.sixt@viscovery.net>, Jeff King <peff@peff.net>,
	layer <layer@known.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 11:30:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkFWN-0000mu-2u
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 11:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754947AbZCSK23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 06:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754117AbZCSK23
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 06:28:29 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:39888 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929AbZCSK22 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 06:28:28 -0400
Received: by yw-out-2324.google.com with SMTP id 5so456796ywb.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 03:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=2oV8ccagLbxl1fP9yOOX4noLEqg/1h4SgOI2c3ar3So=;
        b=Q5exzDJJ2p6hmoN+XzFWvT+fVEeFvuVMUqciTc870/siPQLnVFmNhKyqzbDbuO+gW0
         aZg+97FytQKAf8NhoFgGSTPEkq4vxiLPPT3WfQbZBJr60LcCM1BqT7D4pXDfHEHkNPjJ
         D+gzZ+tvgljyYJOvtak9Iru2TBAzUFnRxqSbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=CXebLWX1nUYu9QN36cp0/u23O6wkQPonYy42JOv7qK13CenJX7ju3wwOgY0g1AprSU
         RYDeBqZpeTqepK9g1bCmDaYi41UomRSTITenzdl1SY0Heel1saaeso41RYqB3R01Daeu
         3c9DNPSV6VRD04E6WHgFNOhZQrOUum6it0qVY=
Received: by 10.100.45.5 with SMTP id s5mr2353157ans.159.1237458505830; Thu, 
	19 Mar 2009 03:28:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113750>

--0016e640d0f6aa128f0465764231
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use posix_lstat for template source.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 builtin-init-db.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

--0016e640d0f6aa128f0465764231
Content-Type: application/octet-stream; 
	name="0002-git-clone-needs-to-know-executability-of-template-fil.diff"
Content-Disposition: attachment; 
	filename="0002-git-clone-needs-to-know-executability-of-template-fil.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fshau85e1

RnJvbSBlN2I5MDAyZTMxNTc2MDdhYTI1MWI4NWU0Zjk0ZjU4NjZkOWJmMzc1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUaHUsIDE5IE1hciAyMDA5IDExOjE3OjU5ICswMTAwClN1YmplY3Q6IFtQQVRDSCAyLzRdIGdp
dCBjbG9uZSBuZWVkcyB0byBrbm93IGV4ZWN1dGFiaWxpdHkgb2YgdGVtcGxhdGUgZmlsZXMKClVz
ZSBwb3NpeF9sc3RhdCBmb3IgdGVtcGxhdGUgc291cmNlLgoKU2lnbmVkLW9mZi1ieTogQWxleCBS
aWVzZW4gPHJhYS5sa21sQGdtYWlsLmNvbT4KLS0tCiBidWlsdGluLWluaXQtZGIuYyB8ICAgIDIg
Ky0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2J1aWx0aW4taW5pdC1kYi5jIGIvYnVpbHRpbi1pbml0LWRiLmMKaW5kZXggZWUz
OTExZi4uMGI2ZGMxNiAxMDA2NDQKLS0tIGEvYnVpbHRpbi1pbml0LWRiLmMKKysrIGIvYnVpbHRp
bi1pbml0LWRiLmMKQEAgLTY2LDcgKzY2LDcgQEAgc3RhdGljIHZvaWQgY29weV90ZW1wbGF0ZXNf
MShjaGFyICpwYXRoLCBpbnQgYmFzZWxlbiwKIAkJZWxzZQogCQkJZXhpc3RzID0gMTsKIAotCQlp
ZiAobHN0YXQodGVtcGxhdGUsICZzdF90ZW1wbGF0ZSkpCisJCWlmIChwb3NpeF9sc3RhdCh0ZW1w
bGF0ZSwgJnN0X3RlbXBsYXRlKSkKIAkJCWRpZSgiY2Fubm90IHN0YXQgdGVtcGxhdGUgJXMiLCB0
ZW1wbGF0ZSk7CiAKIAkJaWYgKFNfSVNESVIoc3RfdGVtcGxhdGUuc3RfbW9kZSkpIHsKLS0gCjEu
Ni4yLjE0Mi5nYWY4ZGIKCg==
--0016e640d0f6aa128f0465764231--
