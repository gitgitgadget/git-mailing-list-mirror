Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71FAC388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 04:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 797C9206B6
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 04:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbgKJEo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 23:44:26 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:3658 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729885AbgKJEoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 23:44:25 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CVZyS0cWnzXktk;
        Tue, 10 Nov 2020 12:44:16 +0800 (CST)
Received: from dggemi758-chm.china.huawei.com (10.1.198.144) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 10 Nov 2020 12:44:21 +0800
Received: from dggeme755-chm.china.huawei.com (10.3.19.101) by
 dggemi758-chm.china.huawei.com (10.1.198.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 10 Nov 2020 12:44:21 +0800
Received: from dggeme755-chm.china.huawei.com ([10.7.64.71]) by
 dggeme755-chm.china.huawei.com ([10.7.64.71]) with mapi id 15.01.1913.007;
 Tue, 10 Nov 2020 12:44:21 +0800
From:   hukeping <hukeping@huawei.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Zhengjunling (JRing, Task Force)" <zhengjunling@huawei.com>,
        zhuangbiaowei <zhuangbiaowei@huawei.com>,
        Patrick Hemmer <git@stormcloud9.net>,
        "Rafael Ascensao" <rafa.almas@gmail.com>,
        =?utf-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: RE: [PATCH v2] format-patch: make output filename configurable
Thread-Topic: [PATCH v2] format-patch: make output filename configurable
Thread-Index: AQHWts3qvxQgrI6CmE273AixfIxBvqnAn0nQgAAIPYyAAAmbYA==
Date:   Tue, 10 Nov 2020 04:44:21 +0000
Message-ID: <8b97c61e983c432aab1063912d6266b9@huawei.com>
References: <20201105201548.2333425-1-hukeping@huawei.com>
        <20201105150149.GA107127@coredump.intra.peff.net>
        <xmqqimajijwa.fsf@gitster.c.googlers.com>
        <xmqqwnyydxaw.fsf@gitster.c.googlers.com>
        <xmqqo8kadu9j.fsf_-_@gitster.c.googlers.com>
        <CAPig+cQAreDJn_tS_K4sR9HwsSVNoFid9sWSdxzwSqkJLRidgQ@mail.gmail.com>
        <xmqqwnyubagr.fsf@gitster.c.googlers.com>
        <9d4b387655024b24a20ce2384740b03a@huawei.com>
 <xmqqr1p27x8d.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1p27x8d.fsf@gitster.c.googlers.com>
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

Pj4gSXQgd291bGQgYmUgdmVyeSBoYXJkIHRvIHJlbW92ZSBhIGNvbmZpZyBrbm9iIHJhdGhlciB0
aGFuIGFkZCBhIG5ldw0KPj4gb25lIGFuZCB3ZSBhbHJlYWR5IGhhdmUgdG9vIG1hbnkuDQo+Pg0K
Pj4gRG9lcyBpdCB3b3J0aCB0byBhZGQgYSBuZXcgY29uZmlndXJhdGlvbiB2YXJpYWJsZSBmb3Ig
dGhpcyBvciBqdXN0IGENCj4+IGhhcmQtY29kZWQgdmFsdWUgaXMgZW5vdWdoPw0KPg0KPkkgcGVy
c29uYWxseSB3b3VsZCBzYXkgInllcywgdGhlIGN1cnJlbnQgY29kZSB0aGF0IGxpbWl0cyB0byA2
NCBpcyBlbm91Z2giLCBidXQgeW91LA0KPmFzIHRoZSBwZXJzb24gd2hvIHNhaWQgdGhhdCB5b3Ug
ZG8gbm90IGxpa2UgdGhlIGN1cnJlbnQgaGFyZC1jb2RlZCB2YWx1ZSwgYXJlIG5vdA0KPmluIHRo
ZSBwb3NpdGlvbiB0byBhc2sgdGhhdCBxdWVzdGlvbiwgSSB3b3VsZCBoYXZlIHRvIHNheS0tLWlm
IGl0IHdlcmUgZW5vdWdoIGZvcg0KPnlvdSwgeW91IHdvdWxkbid0IGhhdmUgY29tcGxhaW5lZCBh
Ym91dCA2NCBpbiB0aGUgZmlyc3QgcGxhY2UgOy0pDQoNClRoZSBvcmlnaW5hbCBtb3RpdmF0aW9u
IGlzIHRvIGxlbmd0aGVuaW5nIHRoZSBsaW1pdCBiZWNhdXNlIG9mIGZpbGUgbmFtZSB0cnVuY2F0
ZWQgcHJvYmxlbSwNCnNvIHVwZGF0ZSB0aGUgdmFsdWUgdG8gYSBsYXJnZXIgb25lIHNlZW1zIGxp
a2UgdGhlIHNpbXBsZXN0IHdheSBmb3IgbWUuDQoNClRoZSB2MiBwYXRjaCBjYW4gZnVuZGFtZW50
YWxseSBzb2x2ZSB0aGlzIHByb2JsZW0sICBqdXN0IGEgbGl0dGxlIHdvcnJ5IGFib3V0IHRoZSBt
b3JlIGFuZA0KbW9yZSBnaXQtY29uZmlnIGtub2JzLg0K
