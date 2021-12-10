Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7C3C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 01:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbhLJBaI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 20:30:08 -0500
Received: from zg8tmtyylji0my4xnjqunzqa.icoremail.net ([162.243.164.74]:60304
        "HELO zg8tmtyylji0my4xnjqunzqa.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S235354AbhLJBaH (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Dec 2021 20:30:07 -0500
Received: from mailtech.cn (unknown [10.12.1.20])
        by hzbj-icmmx-1 (Coremail) with SMTP id AQAAfwDXqbaBrLJh09f6CQ--.18488S2;
        Fri, 10 Dec 2021 09:25:21 +0800 (CST)
Received: from pwxu$coremail.cn ( [112.94.4.17] ) by
 ajax-webmail-mailtech_rd (Coremail) ; Fri, 10 Dec 2021 09:26:28 +0800 (CST)
X-Originating-IP: [112.94.4.17]
Date:   Fri, 10 Dec 2021 09:26:28 +0800 (CST)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?Q?Aleen_=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>
To:     "Bagas Sanjaya" <bagasdotme@gmail.com>
Cc:     =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87_=28Aleen=29_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "Phillip Wood" <phillip.wood123@gmail.com>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        "Elijah Newren" <newren@gmail.com>, Aleen <aleen42@vip.qq.com>,
        "Junio C Hamano" <gitster@pobox.com>
Subject: Re: [PATCH v19 1/3] doc: git-format-patch: describe the option
 --always
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.3 build 20211103(a39c0bb8)
 Copyright (c) 2002-2021 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <1ad4a3ee-af05-9bb2-67fe-566d5e4c39a8@gmail.com>
References: <pull.1076.v18.git.1638939946.gitgitgadget@gmail.com>
 <pull.1076.v19.git.1639034755.gitgitgadget@gmail.com>
 <a524ca6adfa2adc02e517b7be5199b0c071134c4.1639034755.git.gitgitgadget@gmail.com>
 <1ad4a3ee-af05-9bb2-67fe-566d5e4c39a8@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7bd729fd.29.17da1f2df5d.Coremail.pwxu@coremail.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AgIMCgCnrR_ErLJhNAIAAA--.73W
X-CM-SenderInfo: psz03q5fruvzxdlohubq/1tbiAQcLCFGCdOTuCAAGsm
Authentication-Results: hzbj-icmmx-1; spf=neutral smtp.mail=pwxu@corem
        ail.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrKFW7AF4Duw48KFy3Cw4kZwb_yoWDXrXE9r
        9rAF4qka4DJFyUZF12qFsxZrya934v934rXrn5Xr9xKasaqaykXa4kJ3yIkrWUCFsagFy3
        uryDXw4UAFnxujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
        Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
        UUUU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBXaGF0IGFib3V0IHRoaXMgd29yZGluZyBiZWxvdz8KPiAKPiBkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9naXQtZm9ybWF0LXBhdGNoLnR4dCBiL0RvY3VtZW50YXRpb24vZ2l0LWZvcm1hdC1w
YXRjaC50eHQKPiBpbmRleCBiZTc5N2Q3YTI4Li4zMDI2NTljZmQ1IDEwMDY0NAo+IC0tLSBhL0Rv
Y3VtZW50YXRpb24vZ2l0LWZvcm1hdC1wYXRjaC50eHQKPiArKysgYi9Eb2N1bWVudGF0aW9uL2dp
dC1mb3JtYXQtcGF0Y2gudHh0Cj4gQEAgLTE5Myw4ICsxOTMsOCBAQCB3aWxsIHdhbnQgdG8gZW5z
dXJlIHRoYXQgdGhyZWFkaW5nIGlzIGRpc2FibGVkIGZvciBgZ2l0IHNlbmQtZW1haWxgLgo+ICAg
CWlnbm9yZWQuCj4gICAKPiAgIC0tYWx3YXlzOjoKPiAtCUluY2x1ZGUgcGF0Y2hlcyBmb3IgY29t
bWl0cyB0aGF0IGRvIG5vdCBpbnRyb2R1Y2UgYW55IGNoYW5nZSwKPiAtCXdoaWNoIGFyZSBvbWl0
dGVkIGJ5IGRlZmF1bHQuCj4gKwlBbHdheXMgZ2VuZXJhdGUgcGF0Y2hlcywgZXZlbiBpZiB0aGVy
ZSBhcmUgZW1wdHktY2hhbmdlIGNvbW1pdHMuCj4gKwlEZWZhdWx0IGlzIHRvIG9taXQgc3VjaCBj
b21taXRzLgo+ICAgCj4gICAtLWNvdmVyLWZyb20tZGVzY3JpcHRpb249PG1vZGU+OjoKPiAgIAlD
b250cm9scyB3aGljaCBwYXJ0cyBvZiB0aGUgY292ZXIgbGV0dGVyIHdpbGwgYmUgYXV0b21hdGlj
YWxseQo+IAo+IAo+IC0tIAo+IEFuIG9sZCBtYW4gZG9sbC4uLiBqdXN0IHdoYXQgSSBhbHdheXMg
d2FudGVkISAtIENsYXJhCgpEZWFycyBTYW5qYXlhLAoKICAgIFRoYW5rcyBmb3IgeW91ciBzdWdn
ZXN0aW9uLiBJIGRvbid0IHNlZSB0aGUgYWN0dWFsIGRpZmZlcmVuY2UgYmV0d2VlbgogICAgdGhl
IHR3byBzZW50ZW5jZXMsIGFuZCBkbyB5b3Ugd2FudCB0byBlbmhhbmNlIHRoZSB3b3JkICJhbHdh
eXMiPwogICAgSWYgeW91IGRvLCBob3cgYWJvdXQganVzdCBkZXNjcmliaW5nIHRoZSBvcHRpb24g
YXMgIkFsd2F5cyBpbmNsdWRlIHBhdGNoZXMuLi4iPwoKQWxlZW4=

