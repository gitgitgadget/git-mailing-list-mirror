X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH 1/2] move Git.pm build instructions into perl/Makefile
Date: Thu, 30 Nov 2006 17:27:34 +0100
Message-ID: <81b0412b0611300827h64722fa0i7e32808994a97a51@mail.gmail.com>
References: <20061121225911.GA24201@steel.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_46634_15347055.1164904054730"
NNTP-Posting-Date: Thu, 30 Nov 2006 16:27:50 +0000 (UTC)
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=FHoxGMan8Wa39FRZSFEDwNctJ70LVdhrWZ6uILaQeIchutask5+J3G29wO5AqRxflVqyPWnBrbJ0vuwrGHch/cBrBi/EKxrikBlMzPnCl47dpvdDzSqnbdMqMdzYFnunioOUVrGRlGrzlmrY+eL/FitmwqiCuQF+pWWJVz94WsA=
In-Reply-To: <20061121225911.GA24201@steel.home>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32770>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpolA-0001pb-Tm for gcvg-git@gmane.org; Thu, 30 Nov
 2006 17:27:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758520AbWK3Q1h (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 11:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759257AbWK3Q1h
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 11:27:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:9775 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1758520AbWK3Q1g
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 11:27:36 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2163111uga for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 08:27:35 -0800 (PST)
Received: by 10.78.203.13 with SMTP id a13mr3716914hug.1164904054816; Thu, 30
 Nov 2006 08:27:34 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Thu, 30 Nov 2006 08:27:34 -0800 (PST)
To: "Alex Riesen" <fork0@t-online.de>
Sender: git-owner@vger.kernel.org

------=_Part_46634_15347055.1164904054730
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

---

This is the first patch, just rebased upon current master.
The ActiveState-related parts follow

------=_Part_46634_15347055.1164904054730
Content-Type: text/plain; name="0001-move-Git.pm-build-instructions-into-perl-Makefile.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-move-Git.pm-build-instructions-into-perl-Makefile.txt"
X-Attachment-Id: file0

RnJvbSA5NTQ4M2YyN2FhMGFlZGU3ZDE5YjY0M2YzMjE5OTQwMDFhYjFmMDY1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUdWUsIDIxIE5vdiAyMDA2IDIzOjU5OjExICswMTAwClN1YmplY3Q6IFtQQVRDSF0gbW92ZSBH
aXQucG0gYnVpbGQgaW5zdHJ1Y3Rpb25zIGludG8gcGVybC9NYWtlZmlsZQoKU2lnbmVkLW9mZi1i
eTogQWxleCBSaWVzZW4gPHJhYS5sa21sQGdtYWlsLmNvbT4KLS0tCiBNYWtlZmlsZSAgICAgICAg
fCAgIDE1ICsrKysrKysrKy0tLS0tLQogcGVybC8uZ2l0aWdub3JlIHwgICAgMyArKy0KIHBlcmwv
TWFrZWZpbGUgICB8ICAgMjMgKysrKysrKysrKysrKysrKysrKysrKysKIDMgZmlsZXMgY2hhbmdl
ZCwgMzQgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9NYWtlZmls
ZSBiL01ha2VmaWxlCmluZGV4IGRlM2U5ZjMuLjU5MDNhNmYgMTAwNjQ0Ci0tLSBhL01ha2VmaWxl
CisrKyBiL01ha2VmaWxlCkBAIC01NjgsOCArNTY4LDggQEAgZXhwb3J0IHByZWZpeCBUQVIgSU5T
VEFMTCBERVNURElSIFNIRUxMX1BBVEggdGVtcGxhdGVfZGlyCiAKIGFsbDogJChBTExfUFJPR1JB
TVMpICQoQlVJTFRfSU5TKSBnaXQkWCBnaXRrIGdpdHdlYi9naXR3ZWIuY2dpCiAKLWFsbDogcGVy
bC9NYWtlZmlsZQotCSQoTUFLRSkgLUMgcGVybAorYWxsOgorCSQoTUFLRSkgLUMgcGVybCBQRVJM
X1BBVEg9JyQoUEVSTF9QQVRIX1NRKScgcHJlZml4PSckKHByZWZpeF9TUSknIGFsbAogCSQoTUFL
RSkgLUMgdGVtcGxhdGVzCiAKIHN0cmlwOiAkKFBST0dSQU1TKSBnaXQkWApAQCAtNjAyLDcgKzYw
MiwxMSBAQCAkKHBhdHN1YnN0ICUuc2gsJSwkKFNDUklQVF9TSCkpIDogJSA6ICUuc2gKIAljaG1v
ZCAreCAkQCsKIAltdiAkQCsgJEAKIAotJChwYXRzdWJzdCAlLnBlcmwsJSwkKFNDUklQVF9QRVJM
KSk6IHBlcmwvTWFrZWZpbGUKKyQocGF0c3Vic3QgJS5wZXJsLCUsJChTQ1JJUFRfUEVSTCkpOiBw
ZXJsL3BlcmwubWFrCisKK3BlcmwvcGVybC5tYWs6IEdJVC1DRkxBR1MKKwkkKE1BS0UpIC1DIHBl
cmwgUEVSTF9QQVRIPSckKFBFUkxfUEFUSF9TUSknIHByZWZpeD0nJChwcmVmaXhfU1EpJyAkKEBG
KQorCiAkKHBhdHN1YnN0ICUucGVybCwlLCQoU0NSSVBUX1BFUkwpKTogJSA6ICUucGVybAogCXJt
IC1mICRAICRAKwogCUlOU1RMSUJESVI9YCQoTUFLRSkgLUMgcGVybCAtcyAtLW5vLXByaW50LWRp
cmVjdG9yeSBpbnN0bGliZGlyYCAmJiBcCkBAIC03OTYsNyArODAwLDcgQEAgaW5zdGFsbDogYWxs
CiAJJChJTlNUQUxMKSAkKEFMTF9QUk9HUkFNUykgJyQoREVTVERJUl9TUSkkKGdpdGV4ZWNkaXJf
U1EpJwogCSQoSU5TVEFMTCkgZ2l0JFggZ2l0ayAnJChERVNURElSX1NRKSQoYmluZGlyX1NRKScK
IAkkKE1BS0UpIC1DIHRlbXBsYXRlcyBERVNURElSPSckKERFU1RESVJfU1EpJyBpbnN0YWxsCi0J
JChNQUtFKSAtQyBwZXJsIGluc3RhbGwKKwkkKE1BS0UpIC1DIHBlcmwgcHJlZml4PSckKHByZWZp
eF9TUSknIGluc3RhbGwKIAlpZiB0ZXN0ICd6JChiaW5kaXJfU1EpJyAhPSAneiQoZ2l0ZXhlY2Rp
cl9TUSknOyBcCiAJdGhlbiBcCiAJCWxuIC1mICckKERFU1RESVJfU1EpJChiaW5kaXJfU1EpL2dp
dCRYJyBcCkBAIC04NjYsOCArODcwLDcgQEAgY2xlYW46CiAJcm0gLWYgJChodG1sZG9jcykudGFy
Lmd6ICQobWFucGFnZXMpLnRhci5negogCXJtIC1mIGdpdHdlYi9naXR3ZWIuY2dpCiAJJChNQUtF
KSAtQyBEb2N1bWVudGF0aW9uLyBjbGVhbgotCVsgISAtZiBwZXJsL01ha2VmaWxlIF0gfHwgJChN
QUtFKSAtQyBwZXJsLyBjbGVhbiB8fCAkKE1BS0UpIC1DIHBlcmwvIGNsZWFuCi0Jcm0gLWYgcGVy
bC9wcHBvcnQuaCBwZXJsL01ha2VmaWxlLm9sZAorCSQoTUFLRSkgLUMgcGVybCBjbGVhbgogCSQo
TUFLRSkgLUMgdGVtcGxhdGVzLyBjbGVhbgogCSQoTUFLRSkgLUMgdC8gY2xlYW4KIAlybSAtZiBH
SVQtVkVSU0lPTi1GSUxFIEdJVC1DRkxBR1MKZGlmZiAtLWdpdCBhL3BlcmwvLmdpdGlnbm9yZSBi
L3BlcmwvLmdpdGlnbm9yZQppbmRleCBlOTkwY2FlLi45OGIyNDc3IDEwMDY0NAotLS0gYS9wZXJs
Ly5naXRpZ25vcmUKKysrIGIvcGVybC8uZ2l0aWdub3JlCkBAIC0xLDQgKzEsNSBAQAotTWFrZWZp
bGUKK3BlcmwubWFrCitwZXJsLm1hay5vbGQKIGJsaWIKIGJsaWJkaXJzCiBwbV90b19ibGliCmRp
ZmYgLS1naXQgYS9wZXJsL01ha2VmaWxlIGIvcGVybC9NYWtlZmlsZQpuZXcgZmlsZSBtb2RlIDEw
MDY0NAppbmRleCAwMDAwMDAwLi5jZmYyNGRkCi0tLSAvZGV2L251bGwKKysrIGIvcGVybC9NYWtl
ZmlsZQpAQCAtMCwwICsxLDIzIEBACisjCisjIE1ha2VmaWxlIGZvciBwZXJsIHN1cHBvcnQgbW9k
dWxlcyBhbmQgcm91dGluZQorIworbWFrZmlsZTo9cGVybC5tYWsKKworUEVSTF9QQVRIX1NRID0g
JChzdWJzdCAnLCdcJycsJChQRVJMX1BBVEgpKQorcHJlZml4X1NRID0gJChzdWJzdCAnLCdcJycs
JChwcmVmaXgpKQorCithbGwgaW5zdGFsbCBpbnN0bGliZGlyOiAkKG1ha2ZpbGUpCisJJChNQUtF
KSAtZiAkKG1ha2ZpbGUpICRACisKK2NsZWFuOgorCXRlc3QgLWYgJChtYWtmaWxlKSAmJiAkKE1B
S0UpIC1mICQobWFrZmlsZSkgJEAgfHwgZXhpdCAwCisJJChSTSkgcHBwb3J0LmgKKwkkKFJNKSAk
KG1ha2ZpbGUpCisKKyQobWFrZmlsZSk6IE1ha2VmaWxlLlBMIC4uL0dJVC1DRkxBR1MKKwknJChQ
RVJMX1BBVEhfU1EpJyAkPCBGSVJTVF9NQUtFRklMRT0nJEAnIFBSRUZJWD0nJChwcmVmaXhfU1Ep
JworCisjIHRoaXMgaXMganVzdCBhZGRlZCBjb21mb3J0IGZvciBjYWxsaW5nIG1ha2UgZGlyZWN0
bHkgaW4gcGVybCBkaXIKKyMgKGV2ZW4gdGhvdWdoIEdJVC1DRkxBR1MgYXJlbid0IHVzZWQgeWV0
LiBJZiBldmVyKQorLi4vR0lULUNGTEFHUzoKKwkkKE1BS0UpIC1DIC4uIEdJVC1DRkxBR1MKLS0g
CjEuNC40LjEuZzM5MjQtZGlydHkKCg==
