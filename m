Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB0DEB64DA
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 16:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjF1Q2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 12:28:54 -0400
Received: from c2.zombino.com ([65.108.93.176]:37660 "EHLO mail.zombino.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231910AbjF1Q2a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 12:28:30 -0400
Received: from [192.168.1.232] (port-92-195-193-117.dynamic.as20676.net [92.195.193.117])
        by mail.zombino.com (Postfix) with ESMTPS id A2CBB3E98D
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 16:28:28 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------RDYfaGTBzRrQQij3UkVyiYZN"
Message-ID: <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>
Date:   Wed, 28 Jun 2023 18:28:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Adam Majer <adamm@zombino.com>
Subject: SHA256 support not experimental, or?
To:     git@vger.kernel.org
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------RDYfaGTBzRrQQij3UkVyiYZN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

Is sha256 still considered experimental or can it be assumed to be stable?

The usecase here is we are planning on moving to sha256 repositories 
mostly due to integrity guarantees, hypothetical or otherwise. What is 
important is not the initial interop challenges with sha1 repos, but 
whether the on-disk format will remain compatible with future versions 
of git. At minimum, the on-disk format would be converted by some future 
version(s) of git into another one and not be an end-of-the-road because 
it was "experimental" where dataloss is an implied risk.

Attached is a patch that removes the scary text, if indeed sha256 should 
be viewed as stable.

Cheers,
- Adam
--------------RDYfaGTBzRrQQij3UkVyiYZN
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-doc-sha256-is-no-longer-experimantal.patch"
Content-Disposition: attachment;
 filename="0001-doc-sha256-is-no-longer-experimantal.patch"
Content-Transfer-Encoding: base64

LS0tCiBEb2N1bWVudGF0aW9uL2dpdC50eHQgICAgICAgICAgICAgICAgICAgICAgfCA0ICsr
LS0KIERvY3VtZW50YXRpb24vb2JqZWN0LWZvcm1hdC1kaXNjbGFpbWVyLnR4dCB8IDggKyst
LS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZ2l0LnR4dCBiL0RvY3VtZW50YXRpb24v
Z2l0LnR4dAppbmRleCBmMGNhZmEyMjkwLi43YzE1MGE0NzNjIDEwMDY0NAotLS0gYS9Eb2N1
bWVudGF0aW9uL2dpdC50eHQKKysrIGIvRG9jdW1lbnRhdGlvbi9naXQudHh0CkBAIC01NTMs
OCArNTUzLDggQEAgZG91YmxlLXF1b3RlcyBhbmQgcmVzcGVjdGluZyBiYWNrc2xhc2ggZXNj
YXBlcy4gRS5nLiwgdGhlIHZhbHVlCiAJSWYgdGhpcyB2YXJpYWJsZSBpcyBzZXQsIHRoZSBk
ZWZhdWx0IGhhc2ggYWxnb3JpdGhtIGZvciBuZXcKIAlyZXBvc2l0b3JpZXMgd2lsbCBiZSBz
ZXQgdG8gdGhpcyB2YWx1ZS4gVGhpcyB2YWx1ZSBpcwogCWlnbm9yZWQgd2hlbiBjbG9uaW5n
IGFuZCB0aGUgc2V0dGluZyBvZiB0aGUgcmVtb3RlIHJlcG9zaXRvcnkKLQlpcyBhbHdheXMg
dXNlZC4gVGhlIGRlZmF1bHQgaXMgInNoYTEiLiBUSElTIFZBUklBQkxFIElTCi0JRVhQRVJJ
TUVOVEFMISBTZWUgYC0tb2JqZWN0LWZvcm1hdGAgaW4gbGlua2dpdDpnaXQtaW5pdFsxXS4K
KwlpcyBhbHdheXMgdXNlZC4gVGhlIGRlZmF1bHQgaXMgInNoYTEiLgorICAgIFNlZSBgLS1v
YmplY3QtZm9ybWF0YCBpbiBsaW5rZ2l0OmdpdC1pbml0WzFdLgogCiBHaXQgQ29tbWl0cwog
fn5+fn5+fn5+fn4KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vb2JqZWN0LWZvcm1hdC1k
aXNjbGFpbWVyLnR4dCBiL0RvY3VtZW50YXRpb24vb2JqZWN0LWZvcm1hdC1kaXNjbGFpbWVy
LnR4dAppbmRleCA0Y2IxMDZmMGQxLi5kY2NlZTljNDAwIDEwMDY0NAotLS0gYS9Eb2N1bWVu
dGF0aW9uL29iamVjdC1mb3JtYXQtZGlzY2xhaW1lci50eHQKKysrIGIvRG9jdW1lbnRhdGlv
bi9vYmplY3QtZm9ybWF0LWRpc2NsYWltZXIudHh0CkBAIC0xLDYgKzEsMiBAQAotVEhJUyBP
UFRJT04gSVMgRVhQRVJJTUVOVEFMISBTSEEtMjU2IHN1cHBvcnQgaXMgZXhwZXJpbWVudGFs
IGFuZCBzdGlsbAotaW4gYW4gZWFybHkgc3RhZ2UuICBBIFNIQS0yNTYgcmVwb3NpdG9yeSB3
aWxsIGluIGdlbmVyYWwgbm90IGJlIGFibGUgdG8KLXNoYXJlIHdvcmsgd2l0aCAicmVndWxh
ciIgU0hBLTEgcmVwb3NpdG9yaWVzLiAgSXQgc2hvdWxkIGJlIGFzc3VtZWQKLXRoYXQsIGUu
Zy4sIEdpdCBpbnRlcm5hbCBmaWxlIGZvcm1hdHMgaW4gcmVsYXRpb24gdG8gU0hBLTI1Ngot
cmVwb3NpdG9yaWVzIG1heSBjaGFuZ2UgaW4gYmFja3dhcmRzLWluY29tcGF0aWJsZSB3YXlz
LiAgT25seSB1c2UKLWAtLW9iamVjdC1mb3JtYXQ9c2hhMjU2YCBmb3IgdGVzdGluZyBwdXJw
b3Nlcy4KK05vdGU6IFNIQS0yNTYgcmVwb3NpdG9yeSB3aWxsIGluIGdlbmVyYWwgbm90IGJl
IGFibGUgdG8KK3NoYXJlIHdvcmsgd2l0aCAicmVndWxhciIgU0hBLTEgcmVwb3NpdG9yaWVz
LgotLSAKMi40MS4wCgo=

--------------RDYfaGTBzRrQQij3UkVyiYZN--
