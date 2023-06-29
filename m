Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D83EB64D9
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 10:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjF2KtS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 06:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjF2KtM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 06:49:12 -0400
X-Greylist: delayed 396 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Jun 2023 03:49:09 PDT
Received: from mail.zombino.com (c2.zombino.com [IPv6:2a01:4f9:c010:1e4d::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953F0E57
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 03:49:09 -0700 (PDT)
Received: from [10.168.4.114] (unknown [81.95.8.244])
        by mail.zombino.com (Postfix) with ESMTPS id E14BB3E98D;
        Thu, 29 Jun 2023 10:42:30 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------GIPR5ABFLISLT9217948J4AT"
Message-ID: <c8a8f298-f328-f24e-35ee-5b97cafca721@zombino.com>
Date:   Thu, 29 Jun 2023 12:42:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: SHA256 support not experimental, or?
Content-Language: en-US
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>
 <ZJzlezhHk4HpPmRk@tapette.crustytoothpaste.net>
From:   Adam Majer <adamm@zombino.com>
In-Reply-To: <ZJzlezhHk4HpPmRk@tapette.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------GIPR5ABFLISLT9217948J4AT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/29/23 03:59, brian m. carlson wrote:
> I have no intention of changing things at this point.  I think it should
> be viewed as stable by now, and I'd support this patch, although to get
> it picked up it will need a commit message and a sign-off.

Sounds good. Patch follows.

- Adam
--------------GIPR5ABFLISLT9217948J4AT
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-doc-sha256-is-no-longer-experimental.patch"
Content-Disposition: attachment;
 filename="0001-doc-sha256-is-no-longer-experimental.patch"
Content-Transfer-Encoding: base64

RnJvbSA5MGJlNTExNDNlNzQxMDUzMzkwODEwNzIwYmE0YTYzOWMzYjBiNzRjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBBZGFtIE1hamVyIDxhZGFtbUB6b21iaW5vLmNvbT4K
RGF0ZTogV2VkLCAyOCBKdW4gMjAyMyAxNDo0NjowMiArMDIwMApTdWJqZWN0OiBbUEFUQ0hd
IGRvYzogc2hhMjU2IGlzIG5vIGxvbmdlciBleHBlcmltZW50YWwKClRoZSBwdXJwb3NlIG9m
IHRoaXMgcGF0Y2ggaXMgdG8gcmVtb3ZlIHNjYXJ5IHdvcmRpbmcgdGhhdCBiYXNpY2FsbHkK
c3RvcHMgcGVvcGxlIHVzaW5nIHNoYTI1NiByZXBvc2l0b3JpZXMgbm90IGJlY2F1c2Ugb2Yg
aW50ZXJvcGVyYWJpbGl0eQppc3N1ZXMgd2l0aCBzaGExIHJlcG9zaXRvcmllcywgYnV0IGZy
b20gZmVhciB0aGF0IHRoZWlyIHdvcmsgd2lsbApzdWRkZW5seSBiZWNvbWUgaW5jb21wYXRp
YmxlIGluIHNvbWUgZnV0dXJlIHZlcnNpb24gb2YgZ2l0LgoKV2Ugc2hvdWxkIGJlIGNsZWFy
IHRoYXQgY3VycmVudGx5IHNoYTI1NiByZXBvc2l0b3JpZXMgd2lsbCBub3Qgd29yayB3aXRo
CnNoYTEgcmVwb3NpdG9yaWVzIGJ1dCBzdG9wIHRoZSBzY2FyeSB3b3Jkcy4KClNpZ25lZC1v
ZmYtYnk6IEFkYW0gTWFqZXIgPGFkYW1tQHpvbWJpbm8uY29tPgotLS0KIERvY3VtZW50YXRp
b24vZ2l0LnR4dCAgICAgICAgICAgICAgICAgICAgICB8IDQgKystLQogRG9jdW1lbnRhdGlv
bi9vYmplY3QtZm9ybWF0LWRpc2NsYWltZXIudHh0IHwgOCArKy0tLS0tLQogMiBmaWxlcyBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9naXQudHh0IGIvRG9jdW1lbnRhdGlvbi9naXQudHh0CmluZGV4IGYw
Y2FmYTIyOTAuLjY2NmRiZGI1NWMgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vZ2l0LnR4
dAorKysgYi9Eb2N1bWVudGF0aW9uL2dpdC50eHQKQEAgLTU1Myw4ICs1NTMsOCBAQCBkb3Vi
bGUtcXVvdGVzIGFuZCByZXNwZWN0aW5nIGJhY2tzbGFzaCBlc2NhcGVzLiBFLmcuLCB0aGUg
dmFsdWUKIAlJZiB0aGlzIHZhcmlhYmxlIGlzIHNldCwgdGhlIGRlZmF1bHQgaGFzaCBhbGdv
cml0aG0gZm9yIG5ldwogCXJlcG9zaXRvcmllcyB3aWxsIGJlIHNldCB0byB0aGlzIHZhbHVl
LiBUaGlzIHZhbHVlIGlzCiAJaWdub3JlZCB3aGVuIGNsb25pbmcgYW5kIHRoZSBzZXR0aW5n
IG9mIHRoZSByZW1vdGUgcmVwb3NpdG9yeQotCWlzIGFsd2F5cyB1c2VkLiBUaGUgZGVmYXVs
dCBpcyAic2hhMSIuIFRISVMgVkFSSUFCTEUgSVMKLQlFWFBFUklNRU5UQUwhIFNlZSBgLS1v
YmplY3QtZm9ybWF0YCBpbiBsaW5rZ2l0OmdpdC1pbml0WzFdLgorCWlzIGFsd2F5cyB1c2Vk
LiBUaGUgZGVmYXVsdCBpcyAic2hhMSIuIFNlZSBgLS1vYmplY3QtZm9ybWF0YAorCWluIGxp
bmtnaXQ6Z2l0LWluaXRbMV0uCiAKIEdpdCBDb21taXRzCiB+fn5+fn5+fn5+fgpkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9vYmplY3QtZm9ybWF0LWRpc2NsYWltZXIudHh0IGIvRG9j
dW1lbnRhdGlvbi9vYmplY3QtZm9ybWF0LWRpc2NsYWltZXIudHh0CmluZGV4IDRjYjEwNmYw
ZDEuLjFlOTc2Njg4YmUgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vb2JqZWN0LWZvcm1h
dC1kaXNjbGFpbWVyLnR4dAorKysgYi9Eb2N1bWVudGF0aW9uL29iamVjdC1mb3JtYXQtZGlz
Y2xhaW1lci50eHQKQEAgLTEsNiArMSwyIEBACi1USElTIE9QVElPTiBJUyBFWFBFUklNRU5U
QUwhIFNIQS0yNTYgc3VwcG9ydCBpcyBleHBlcmltZW50YWwgYW5kIHN0aWxsCi1pbiBhbiBl
YXJseSBzdGFnZS4gIEEgU0hBLTI1NiByZXBvc2l0b3J5IHdpbGwgaW4gZ2VuZXJhbCBub3Qg
YmUgYWJsZSB0bwotc2hhcmUgd29yayB3aXRoICJyZWd1bGFyIiBTSEEtMSByZXBvc2l0b3Jp
ZXMuICBJdCBzaG91bGQgYmUgYXNzdW1lZAotdGhhdCwgZS5nLiwgR2l0IGludGVybmFsIGZp
bGUgZm9ybWF0cyBpbiByZWxhdGlvbiB0byBTSEEtMjU2Ci1yZXBvc2l0b3JpZXMgbWF5IGNo
YW5nZSBpbiBiYWNrd2FyZHMtaW5jb21wYXRpYmxlIHdheXMuICBPbmx5IHVzZQotYC0tb2Jq
ZWN0LWZvcm1hdD1zaGEyNTZgIGZvciB0ZXN0aW5nIHB1cnBvc2VzLgorTm90ZTogU0hBLTI1
NiByZXBvc2l0b3JpZXMgY3VycmVudGx5IHdpbGwgbm90IGJlIGFibGUgdG8gc2hhcmUgd29y
aword2l0aCAicmVndWxhciIgU0hBLTEgcmVwb3NpdG9yaWVzLgotLSAKMi40MS4wCgo=

--------------GIPR5ABFLISLT9217948J4AT--
