From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Support of "make -s" in git-gui: do not output anything of the build itself
Date: Wed, 7 Mar 2007 00:57:27 +0100
Message-ID: <81b0412b0703061557j1cade6f6k4577da5e447a4e2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_59061_31951547.1173225447739"
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 07 00:57:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOjXB-0002bC-3K
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 00:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030735AbXCFX5a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 18:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030736AbXCFX5a
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 18:57:30 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:32216 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030735AbXCFX53 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 18:57:29 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2670230nfa
        for <git@vger.kernel.org>; Tue, 06 Mar 2007 15:57:28 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=Ya0J58EO43EvlpIlZ2RH9oz8VA3lDUevrBPqZWqtegTd2fu8uhQTjxZ9J/Agw6jGj5l/dlB1qHpsXOSVBMGetNQfoYCY+WiyFq4zGh4KLNpfqq7m+TgmYQZnsg6kucW+SVUw78OQyQsq0Aex9RomrrzS0mWGFnC6kJbC3sHB0X8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=N5yxoMnDLFL/VcOp5s39b9iG73qce2embH5iNjZ/U4JUK+axpTABPhQQZVpCWZOjyRXUXyWnGIodxvGyljtQ6l5ErM8Xu1vygCmnNhPr9++P+kukuG1qrgxAf+t4SBbk+xe1oI+IvLBweyrZOA8p8i8+OzJSPXaSYmgGToaw29s=
Received: by 10.78.204.7 with SMTP id b7mr888493hug.1173225448248;
        Tue, 06 Mar 2007 15:57:28 -0800 (PST)
Received: by 10.78.138.5 with HTTP; Tue, 6 Mar 2007 15:57:27 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41622>

------=_Part_59061_31951547.1173225447739
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 git-gui/Makefile |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

------=_Part_59061_31951547.1173225447739
Content-Type: text/x-patch; name="0002-Support-of-make-s-in-git-gui-do-not-output-anyth.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0002-Support-of-make-s-in-git-gui-do-not-output-anyth.patch"
X-Attachment-Id: f_eyz04p0z

RnJvbSBiMzQ3Yzg1NTg3M2QzMTkzYTZlODMzOWYxMDY4MmJhOGEzOTMxMDE4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBXZWQsIDcgTWFyIDIwMDcgMDA6NDQ6MzcgKzAxMDAKU3ViamVjdDogW1BBVENIXSBTdXBwb3J0
IG9mICJtYWtlIC1zIiBpbiBnaXQtZ3VpOiBkbyBub3Qgb3V0cHV0IGFueXRoaW5nIG9mIHRoZSBi
dWlsZCBpdHNlbGYKClNpZ25lZC1vZmYtYnk6IEFsZXggUmllc2VuIDxyYWEubGttbEBnbWFpbC5j
b20+Ci0tLQogZ2l0LWd1aS9NYWtlZmlsZSB8ICAgIDUgKysrKysKIDEgZmlsZXMgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2dpdC1ndWkvTWFr
ZWZpbGUgYi9naXQtZ3VpL01ha2VmaWxlCmluZGV4IGU0ODZlOGYuLmEyMTliNWQgMTAwNjQ0Ci0t
LSBhL2dpdC1ndWkvTWFrZWZpbGUKKysrIGIvZ2l0LWd1aS9NYWtlZmlsZQpAQCAtMjcsNiArMjcs
MTEgQEAgaWZuZGVmIFYKIAlRVUlFVF9CVUlMVF9JTiA9IEBlY2hvICcgICAnIEJVSUxUSU4gJEA7
CiBlbmRpZgogCitpZmVxICgkKGZpbmRzdHJpbmcgJChNQUtFRkxBR1MpLHMpLHMpCitRVUlFVF9H
RU4gPQorUVVJRVRfQlVJTFRfSU4gPQorZW5kaWYKKwogREVTVERJUl9TUSA9ICQoc3Vic3QgJywn
XCcnLCQoREVTVERJUikpCiBnaXRleGVjZGlyX1NRID0gJChzdWJzdCAnLCdcJycsJChnaXRleGVj
ZGlyKSkKIFNIRUxMX1BBVEhfU1EgPSAkKHN1YnN0ICcsJ1wnJywkKFNIRUxMX1BBVEgpKQotLSAK
MS41LjAuMy40MzAuZzU1NzNmCgo=
------=_Part_59061_31951547.1173225447739--
