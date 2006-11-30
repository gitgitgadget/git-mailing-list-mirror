X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH 2/2] add a flag to disable using of Perls MakeMaker module.
Date: Thu, 30 Nov 2006 17:30:51 +0100
Message-ID: <81b0412b0611300830t3799b80dl1d469f94cab35e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_46734_14303964.1164904251834"
NNTP-Posting-Date: Thu, 30 Nov 2006 16:31:24 +0000 (UTC)
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=Upo72C0nA0z2D8U+orhmWNrnP4XeXIBxq4b+86QVEcKFf4XrdPYCbpgiKQwtW410N5c5raTXRRBN8/lG+AT0hgiSY0td9fWzS5BJHMpIaW/YEndYqTQUbqh3Y0pd5mg9kk39ZYQKUs0z1t4Vwf9BuoFqkiiSkp9zFEZvQne3pcs=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32771>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpooL-0002aV-MK for gcvg-git@gmane.org; Thu, 30 Nov
 2006 17:30:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030722AbWK3Qay (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 11:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759261AbWK3Qay
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 11:30:54 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:15940 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1759259AbWK3Qax
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 11:30:53 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2164130uga for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 08:30:52 -0800 (PST)
Received: by 10.78.97.7 with SMTP id u7mr3706462hub.1164904252043; Thu, 30
 Nov 2006 08:30:52 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Thu, 30 Nov 2006 08:30:51 -0800 (PST)
To: "Alex Riesen" <fork0@t-online.de>
Sender: git-owner@vger.kernel.org

------=_Part_46734_14303964.1164904251834
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

There installations (Cygwin + ActivateState Perl) where the generated makefiles
are not usable, because of lineendings and backslashes. The flags is
NO_PERL_MAKEMAKER.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

---
Just remembered configure script. Maybe it could be taught to
notice the situation and do something about it (like setting the NO_MAKEMAKER).

------=_Part_46734_14303964.1164904251834
Content-Type: text/plain; name="0002-add-a-flag-to-disable-using-of-Perls-MakeMaker-module.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0002-add-a-flag-to-disable-using-of-Perls-MakeMaker-module.txt"
X-Attachment-Id: file0

RnJvbSAwNmZjNWU5ODc1NGRlOThiNDQ3NDZkODk2MmRhMTZhNThhNWE1ZDI4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUaHUsIDMwIE5vdiAyMDA2IDE3OjE1OjMzICswMTAwClN1YmplY3Q6IFtQQVRDSF0gYWRkIGEg
ZmxhZyB0byBkaXNhYmxlIHVzaW5nIG9mIFBlcmxzIE1ha2VNYWtlciBtb2R1bGUuCgpUaGVyZSBp
bnN0YWxsYXRpb25zIChDeWd3aW4gKyBBY3RpdmF0ZVN0YXRlIFBlcmwpIHdoZXJlIHRoZSBnZW5l
cmF0ZWQgbWFrZWZpbGVzCmFyZSBub3QgdXNhYmxlLCBiZWNhdXNlIG9mIGxpbmVlbmRpbmdzIGFu
ZCBiYWNrc2xhc2hlcy4gVGhlIGZsYWdzIGlzCk5PX1BFUkxfTUFLRU1BS0VSLgotLS0KIE1ha2Vm
aWxlICAgICAgfCAgICAzICsrKwogcGVybC9NYWtlZmlsZSB8ICAgMTUgKysrKysrKysrKysrKysr
CiAyIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvTWFrZWZpbGUgYi9NYWtlZmlsZQppbmRleCA1OTAzYTZmLi4zZTY4MjViIDEwMDY0
NAotLS0gYS9NYWtlZmlsZQorKysgYi9NYWtlZmlsZQpAQCAtNTM5LDYgKzUzOSw5IEBAIGVuZGlm
CiBpZmRlZiBOT19BQ0NVUkFURV9ESUZGCiAJQkFTSUNfQ0ZMQUdTICs9IC1ETk9fQUNDVVJBVEVf
RElGRgogZW5kaWYKK2lmZGVmIE5PX1BFUkxfTUFLRU1BS0VSCisJZXhwb3J0IE5PX1BFUkxfTUFL
RU1BS0VSCitlbmRpZgogCiAjIFNoZWxsIHF1b3RlIChkbyBub3QgdXNlICQoY2FsbCkgdG8gYWNj
b21tb2RhdGUgYW5jaWVudCBzZXR1cHMpOwogCmRpZmYgLS1naXQgYS9wZXJsL01ha2VmaWxlIGIv
cGVybC9NYWtlZmlsZQppbmRleCBjZmYyNGRkLi5hMWI5OGJkIDEwMDY0NAotLS0gYS9wZXJsL01h
a2VmaWxlCisrKyBiL3BlcmwvTWFrZWZpbGUKQEAgLTE0LDEwICsxNCwyNSBAQCBjbGVhbjoKIAkk
KFJNKSBwcHBvcnQuaAogCSQoUk0pICQobWFrZmlsZSkKIAoraWZkZWYgTk9fUEVSTF9NQUtFTUFL
RVIKK2luc3RkaXJfU1EgPSAkKHN1YnN0ICcsJ1wnJywkKHByZWZpeCkvbGliKQorJChtYWtmaWxl
KTogLi4vR0lULUNGTEFHUyBNYWtlZmlsZQorCWVjaG8gYWxsOiA+ICRACisJZWNobyAnCTonID4+
ICRACisJZWNobyBpbnN0YWxsOiA+PiAkQAorCWVjaG8gJwlta2RpciAtcCAkKGluc3RkaXJfU1Ep
JyA+PiAkQAorCWVjaG8gJwkkKFJNKSAkKGluc3RkaXJfU1EpL0dpdC5wbTsgY3AgR2l0LnBtICQo
aW5zdGRpcl9TUSknID4+ICRACisJZWNobyAnCSQoUk0pICQoaW5zdGRpcl9TUSkvRXJyb3IucG07
IFwKKwljcCBwcml2YXRlLUVycm9yLnBtICQoaW5zdGRpcl9TUSkvRXJyb3IucG0nID4+ICRACisJ
ZWNobyBpbnN0bGliZGlyOiA+PiAkQAorCWVjaG8gJwllY2hvICQoaW5zdGRpcl9TUSknID4+ICRA
CitlbHNlCiAkKG1ha2ZpbGUpOiBNYWtlZmlsZS5QTCAuLi9HSVQtQ0ZMQUdTCiAJJyQoUEVSTF9Q
QVRIX1NRKScgJDwgRklSU1RfTUFLRUZJTEU9JyRAJyBQUkVGSVg9JyQocHJlZml4X1NRKScKK2Vu
ZGlmCiAKICMgdGhpcyBpcyBqdXN0IGFkZGVkIGNvbWZvcnQgZm9yIGNhbGxpbmcgbWFrZSBkaXJl
Y3RseSBpbiBwZXJsIGRpcgogIyAoZXZlbiB0aG91Z2ggR0lULUNGTEFHUyBhcmVuJ3QgdXNlZCB5
ZXQuIElmIGV2ZXIpCiAuLi9HSVQtQ0ZMQUdTOgogCSQoTUFLRSkgLUMgLi4gR0lULUNGTEFHUwor
Ci0tIAoxLjQuNC4xLmczOTI0LWRpcnR5Cgo=
