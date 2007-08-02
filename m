From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Handle the errors from chdir in set_work_tree
Date: Thu, 2 Aug 2007 17:27:43 +0200
Message-ID: <81b0412b0708020827p174515b7tc05fefde77f7d7c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_58674_10204754.1186068463456"
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 02 17:27:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGcac-0004g3-2N
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 17:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbXHBP1q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 11:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755164AbXHBP1q
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 11:27:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:63455 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbXHBP1p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 11:27:45 -0400
Received: by ug-out-1314.google.com with SMTP id j3so357140ugf
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 08:27:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=ehPDdx6SAi6Ftu/3dUwIYEfGtHrrqIQLYmEI7P3JNIVdCaoWYh0I6e4RAlNiBEEywy6r0o6sLv6nKWNIjX/LF8d/kDipEH4lsITAG0NsRevePWpK6j6pT6kALSpgcMSCrjhfWQeSWjEIf0+/jcWBeE9CBalVr9EKoFI2tpZXxWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=nSgdKe10Ma6BF+WjvgaefUIdM9uG0CjfzlJT4xc8tkaSpkKeZl5LHb+ktnKeYjoV7kUO7VVIdnsO5fN1vuojnJZd0NjyA4UO6t0RKaDuGgqfwbm/m/qjdP/CnET+PsI7ajRJVs2eQFBVSVpcAGWbbhrMjTXv8k8ovfI7Cvq9F3U=
Received: by 10.78.184.2 with SMTP id h2mr587517huf.1186068463744;
        Thu, 02 Aug 2007 08:27:43 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Thu, 2 Aug 2007 08:27:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54563>

------=_Part_58674_10204754.1186068463456
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

These I haven't seen yet. Wouldn't like such a surprise though.
Also unstatic rel, it seems to be declared static accidentally.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

One gets paranoid when exposed to "commercial"
systems for too long.

 setup.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

------=_Part_58674_10204754.1186068463456
Content-Type: text/plain; 
	name=0002-Handle-the-errors-from-chdir-in-set_work_tree.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f4vek8c1
Content-Disposition: attachment; filename="0002-Handle-the-errors-from-chdir-in-set_work_tree.txt"

RnJvbSA2MDJkNDlhY2QzZTUyODU5NzRjYzFiN2M0MzM3MzAxYjEzYmI1NGI4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUaHUsIDIgQXVnIDIwMDcgMTY6NTE6NTcgKzAyMDAKU3ViamVjdDogW1BBVENIXSBIYW5kbGUg
dGhlIGVycm9ycyBmcm9tIGNoZGlyIGluIHNldF93b3JrX3RyZWUKClRoZXNlIEkgaGF2ZW4ndCBz
ZWVuIHlldC4gV291bGRuJ3QgbGlrZSBzdWNoIGEgc3VycHJpc2UgdGhvdWdoLgpBbHNvIHVuc3Rh
dGljIHJlbCwgaXQgc2VlbXMgdG8gYmUgZGVjbGFyZWQgc3RhdGljIGFjY2lkZW50YWxseS4KClNp
Z25lZC1vZmYtYnk6IEFsZXggUmllc2VuIDxyYWEubGttbEBnbWFpbC5jb20+Ci0tLQogc2V0dXAu
YyB8ICAgMTAgKysrKysrLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc2V0dXAuYyBiL3NldHVwLmMKaW5kZXggMWJlYmE3
ZS4uNGU2YmI3NiAxMDA2NDQKLS0tIGEvc2V0dXAuYworKysgYi9zZXR1cC5jCkBAIC0yMDEsOCAr
MjAxLDggQEAgaW50IGlzX2luc2lkZV93b3JrX3RyZWUodm9pZCkKICAqLwogY29uc3QgY2hhciAq
c2V0X3dvcmtfdHJlZShjb25zdCBjaGFyICpkaXIpCiB7Ci0JY2hhciBkaXJfYnVmZmVyW1BBVEhf
TUFYXTsKLQlzdGF0aWMgY2hhciBidWZmZXJbUEFUSF9NQVggKyAxXSwgKnJlbCA9IE5VTEw7CisJ
Y2hhciBkaXJfYnVmZmVyW1BBVEhfTUFYXSwgKnJlbCA9IE5VTEw7CisJc3RhdGljIGNoYXIgYnVm
ZmVyW1BBVEhfTUFYICsgMV07CiAJaW50IGxlbiwgcG9zdGZpeF9sZW4gPSBzdHJsZW4oREVGQVVM
VF9HSVRfRElSX0VOVklST05NRU5UKSArIDE7CiAKIAkvKiBzdHJpcCB0aGUgdmFyaWFibGUgJ2Rp
cicgb2YgdGhlIHBvc3RmaXggIi8uZ2l0IiBpZiBpdCBoYXMgaXQgKi8KQEAgLTIyMCw4ICsyMjAs
MTAgQEAgY29uc3QgY2hhciAqc2V0X3dvcmtfdHJlZShjb25zdCBjaGFyICpkaXIpCiAJCWlmICgh
aXNfYWJzb2x1dGVfcGF0aChkaXIpKQogCQkJc2V0X2dpdF9kaXIobWFrZV9hYnNvbHV0ZV9wYXRo
KGRpcikpOwogCQlkaXIgPSBkaXJfYnVmZmVyOwotCQljaGRpcihkaXIpOwotCQlzdHJjYXQocmVs
LCAiLyIpOworCQlpZiAoY2hkaXIoZGlyKSkKKwkJCXJlbCA9IE5VTEw7CisJCWVsc2UKKwkJCXN0
cmNhdChyZWwsICIvIik7CiAJCWluc2lkZV9naXRfZGlyID0gMDsKIAl9IGVsc2UgewogCQlyZWwg
PSBOVUxMOwotLSAKMS41LjMucmMzLjE0NS5nNGQ5Y2RiCgo=
------=_Part_58674_10204754.1186068463456--
