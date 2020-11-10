Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084D9C4741F
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 02:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C86DA205CB
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 02:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbgKJCbm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 21:31:42 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2428 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKJCbm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 21:31:42 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CVX1H2tmNz53WL;
        Tue, 10 Nov 2020 10:31:31 +0800 (CST)
Received: from dggemi756-chm.china.huawei.com (10.1.198.142) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 10 Nov 2020 10:31:38 +0800
Received: from dggeme755-chm.china.huawei.com (10.3.19.101) by
 dggemi756-chm.china.huawei.com (10.1.198.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 10 Nov 2020 10:31:38 +0800
Received: from dggeme755-chm.china.huawei.com ([10.7.64.71]) by
 dggeme755-chm.china.huawei.com ([10.7.64.71]) with mapi id 15.01.1913.007;
 Tue, 10 Nov 2020 10:31:38 +0800
From:   hukeping <hukeping@huawei.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
CC:     Eric Sunshine <sunshine@sunshineco.com>,
        "Zhengjunling (JRing, Task Force)" <zhengjunling@huawei.com>,
        zhuangbiaowei <zhuangbiaowei@huawei.com>,
        Patrick Hemmer <git@stormcloud9.net>,
        Rafael Ascensao <rafa.almas@gmail.com>,
        =?utf-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: RE: [PATCH v2] format-patch: make output filename configurable
Thread-Topic: [PATCH v2] format-patch: make output filename configurable
Thread-Index: AQHWts3qvxQgrI6CmE273AixfIxBvqnAn0nQ
Date:   Tue, 10 Nov 2020 02:31:38 +0000
Message-ID: <9d4b387655024b24a20ce2384740b03a@huawei.com>
References: <20201105201548.2333425-1-hukeping@huawei.com>
        <20201105150149.GA107127@coredump.intra.peff.net>
        <xmqqimajijwa.fsf@gitster.c.googlers.com>
        <xmqqwnyydxaw.fsf@gitster.c.googlers.com>
        <xmqqo8kadu9j.fsf_-_@gitster.c.googlers.com>
        <CAPig+cQAreDJn_tS_K4sR9HwsSVNoFid9sWSdxzwSqkJLRidgQ@mail.gmail.com>
 <xmqqwnyubagr.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqwnyubagr.fsf@gitster.c.googlers.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.44.11]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PkZvciB0aGUgcGFzdCAxNSB5ZWFycywgd2UndmUgdXNlZCB0aGUgaGFyZGNvZGVkIDY0IGFzIHRo
ZSBsZW5ndGggbGltaXQgb2YgdGhlDQo+ZmlsZW5hbWUgb2YgdGhlIG91dHB1dCBmcm9tIHRoZSAi
Z2l0IGZvcm1hdC1wYXRjaCINCj5jb21tYW5kLiAgU2luY2UgdGhlIHZhbHVlIGlzIHNob3J0ZXIg
dGhhbiB0aGUgODAtY29sdW1uIHRlcm1pbmFsLCBpdCBjb3VsZCBncm93DQo+d2l0aG91dCBsaW5l
IHdyYXBwaW5nIGEgYml0LiAgQXQgdGhlIHNhbWUgdGltZSwgc2luY2UgdGhlIHZhbHVlIGlzIGxv
bmdlciB0aGFuIGhhbGYNCj5vZiB0aGUgODAtY29sdW1uIHRlcm1pbmFsLCB3ZSBjb3VsZCBmaXQg
dHdvIG9yIG1vcmUgb2YgdGhlbSBpbiAibHMiIG91dHB1dCBvbg0KPnN1Y2ggYSB0ZXJtaW5hbCBp
ZiB3ZSBhbGxvd2VkIHRvIGxvd2VyIGl0Lg0KPg0KPkludHJvZHVjZSBhIG5ldyBjb21tYW5kIGxp
bmUgb3B0aW9uIC0tZmlsZW5hbWUtbWF4LWxlbmd0aD08bj4gYW5kIGEgbmV3DQo+Y29uZmlndXJh
dGlvbiB2YXJpYWJsZSBmb3JtYXQuZmlsZW5hbWVNYXhMZW5ndGggdG8gb3ZlcnJpZGUgdGhlIGhh
cmRjb2RlZA0KPmRlZmF1bHQuDQo+DQpJdCB3b3VsZCBiZSB2ZXJ5IGhhcmQgdG8gcmVtb3ZlIGEg
Y29uZmlnIGtub2IgcmF0aGVyIHRoYW4gYWRkICBhIG5ldyBvbmUgYW5kIHdlIGFscmVhZHkNCmhh
dmUgdG9vIG1hbnkuDQoNCkRvZXMgaXQgd29ydGggdG8gYWRkIGEgbmV3IGNvbmZpZ3VyYXRpb24g
dmFyaWFibGUgZm9yIHRoaXMgb3IganVzdCBhIGhhcmQtY29kZWQgdmFsdWUgaXMgZW5vdWdoPw0K
DQo+V2hpbGUgd2UgYXJlIGF0IGl0LCByZW1vdmUgYSBjaGVjayB0aGF0IHRoZSBuYW1lIG9mIG91
dHB1dCBkaXJlY3RvcnkgZG9lcyBub3QNCj5leGNlZWQgUEFUSF9NQVgtLS10aGlzIGNoZWNrIGlz
IHBvaW50bGVzcyBpbiB0aGF0IGJ5IHRoZSB0aW1lIGNvbnRyb2wgcmVhY2hlcyB0aGUNCj5mdW5j
dGlvbiwgdGhlIGNhbGxlciB3b3VsZCBhbHJlYWR5IGhhdmUgZG9uZSBhbiBlcXVpdmFsZW50IG9m
ICJta2RpciAtcCIsIHNvIGlmIHRoZQ0KPnN5c3RlbSBkb2VzIG5vdCBsaWtlIGFuIG92ZXJseSBs
b25nIGRpcmVjdG9yeSBuYW1lLCB0aGUgY29udHJvbCB3b3VsZG4ndCBoYXZlDQo+cmVhY2hlZCBo
ZXJlLCBhbmQgb3RoZXJ3aXNlLCB3ZSBrbm93IHRoYXQgdGhlIHN5c3RlbSBhbGxvd2VkIHRoZSBv
dXRwdXQNCj5kaXJlY3RvcnkgdG8gZXhpc3QuICBJbiB0aGUgd29yc3QgY2FzZSwgd2Ugd2lsbCBn
ZXQgYW4gZXJyb3Igd2hlbiB3ZSB0cnkgdG8gb3BlbiB0aGUNCj5vdXRwdXQgZmlsZSBhbmQgaGFu
ZGxlIHRoZSBlcnJvciBjb3JyZWN0bHkgYW55d2F5Lg0KPg0KPlNpZ25lZC1vZmYtYnk6IEp1bmlv
IEMgSGFtYW5vIDxnaXRzdGVyQHBvYm94LmNvbT4NCg0K
