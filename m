Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6147AC2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 08:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B04B206DC
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 08:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgKFIvh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 03:51:37 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2057 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgKFIvh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 03:51:37 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CSDdQ5HQTzVl8y;
        Fri,  6 Nov 2020 16:51:22 +0800 (CST)
Received: from dggemi706-chm.china.huawei.com (10.3.20.105) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 6 Nov 2020 16:51:32 +0800
Received: from dggeme755-chm.china.huawei.com (10.3.19.101) by
 dggemi706-chm.china.huawei.com (10.3.20.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 6 Nov 2020 16:51:32 +0800
Received: from dggeme755-chm.china.huawei.com ([10.7.64.71]) by
 dggeme755-chm.china.huawei.com ([10.7.64.71]) with mapi id 15.01.1913.007;
 Fri, 6 Nov 2020 16:51:32 +0800
From:   hukeping <hukeping@huawei.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Zhengjunling (JRing, Task Force)" <zhengjunling@huawei.com>,
        zhuangbiaowei <zhuangbiaowei@huawei.com>,
        "git@stormcloud9.net" <git@stormcloud9.net>,
        "rafa.almas@gmail.com" <rafa.almas@gmail.com>,
        "l.s.r@web.de" <l.s.r@web.de>
Subject: RE: [PATCH] Lengthening FORMAT_PATCH_NAME_MAX to 80
Thread-Topic: [PATCH] Lengthening FORMAT_PATCH_NAME_MAX to 80
Thread-Index: AQHWs4SWyZPIqzttbUOgU2sUca/WpKm6Cw8dgACvolA=
Date:   Fri, 6 Nov 2020 08:51:32 +0000
Message-ID: <d5338d5f83584f7caf3ff0f4309f2275@huawei.com>
References: <20201105201548.2333425-1-hukeping@huawei.com>
        <20201105150149.GA107127@coredump.intra.peff.net>
 <xmqqimajijwa.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqimajijwa.fsf@gitster.c.googlers.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.109.46.251]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSnVuaW8gQyBIYW1hbm8gW21haWx0
bzpnaXRzdGVyQHBvYm94LmNvbV0NCj5TZW50OiBGcmlkYXksIE5vdmVtYmVyIDYsIDIwMjAgNTox
NyBBTQ0KPlRvOiBKZWZmIEtpbmcgPHBlZmZAcGVmZi5uZXQ+DQo+Q2M6IGh1a2VwaW5nIDxodWtl
cGluZ0BodWF3ZWkuY29tPjsgZ2l0QHZnZXIua2VybmVsLm9yZzsgWmhlbmdqdW5saW5nIChKUmlu
ZywNCj5UYXNrIEZvcmNlKSA8emhlbmdqdW5saW5nQGh1YXdlaS5jb20+OyB6aHVhbmdiaWFvd2Vp
DQo+PHpodWFuZ2JpYW93ZWlAaHVhd2VpLmNvbT47IGdpdEBzdG9ybWNsb3VkOS5uZXQ7IHJhZmEu
YWxtYXNAZ21haWwuY29tOw0KPmwucy5yQHdlYi5kZQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIExl
bmd0aGVuaW5nIEZPUk1BVF9QQVRDSF9OQU1FX01BWCB0byA4MA0KPg0KPkplZmYgS2luZyA8cGVm
ZkBwZWZmLm5ldD4gd3JpdGVzOg0KPg0KPj4+IENvbnNpZGVyZWQgdGhlIHByZWZpeCBwYXRjaCBu
dW1iZXIgIjAwMDEtIiB3b3VsZCB0YWtlIDUgY2hhcmFjdGVycywNCj4+PiBpbmNyZWFzZSB0aGUg
Rk9STUFUX1BBVENIX05BTUVfTUFYIHRvIDgwLg0KPj4NCj4+IEFzIHRoZSBjb2RlIGlzIHdyaXR0
ZW4gbm93LCB0aGUgbGVuZ3RoIGFsc28gaW5jbHVkZXMgdGhlICIucGF0Y2giDQo+PiBzdWZmaXgs
IGFzIHdlbGwgYXMgYW4gZXh0cmEgYnl0ZSAobWF5YmUgZm9yIGEgTlVMPyBPbmNlIHVwb24gYSB0
aW1lIEkNCj4+IGltYWdpbmUgd2UgdXNlZCBzdGF0aWMgYnVmZmVycywgYnV0IHRoZXNlIGRheXMg
aXQncyBhbGwgaW4gYSBzdHJidWYpLg0KPj4NCj4+IEEgc2ltcGxlIHRlc3Qgd2l0aDoNCj4+DQo+
PiAgIGdpdCBpbml0DQo+PiAgIGZvciBpIGluICQoc2VxIDgpOyBkbyBwcmludGYgMTIzNDU2Nzg5
MDsgZG9uZSB8DQo+PiAgIGdpdCBjb21taXQgLS1hbGxvdy1lbXB0eSAtRiAtDQo+PiAgIGdpdCBm
b3JtYXQtcGF0Y2ggLTENCj4+DQo+PiBzaG93cyB1cyBnZW5lcmF0aW5nOg0KPj4NCj4+ICAgMDAw
MS0xMjM0NTY3ODkwMTIzNDU2Nzg5MDEyMzQ1Njc4OTAxMjM0NTY3ODkwMTIzNDU2Nzg5MDEyLnBh
dGNoDQo+Pg0KPj4gU28gdGhhdCdzIG9ubHkgNTIgY2hhcmFjdGVycywgZnJvbSBvdXIgY29uc3Rh
bnQgb2YgNjQuIEJ1bXBpbmcgdG8gODANCj4+IGdpdmVzIHVzIDY2LCB3aGljaCBpcyByZWFzb25h
YmxlIHRob3VnaCBwcm9iYWJseSBzdGlsbCBpbnZvbHZlcw0KPj4gb2NjYXNpb25hbCB0cnVuY2F0
aW9uLiBCdXQgbWF5YmUga2VlcGluZyB0aGUgdG90YWwgbGVuZ3RoIHRvIDgwICg3OSwNCj4+IHJl
YWxseSwgYmVjYXVzZSBvZiB0aGUgZXh0cmEgYnl0ZSkgbWF5IGJlIHdvcnRoIGRvaW5nLg0KPj4N
Cj4+IFdoaWNoIGlzIGFsbCBhIGxvbmctd2luZGVkIHdheSBvZiBzYXlpbmcgdGhhdCB5b3VyIHBh
dGNoIHNlZW1zDQo+PiByZWFzb25hYmxlIHRvIG1lLg0KPg0KPkEgZGV2aWwncyBhZHZvY2F0ZSB0
aGlua3MgdGhhdCB3ZSBzaG91bGQgc2hvcnRlbiBpdCAoYW5kIHJlbmFtZSBpdCB0byBmb3JtYXQt
DQo+cGF0Y2gtc3ViamVjdC1wcmVmaXgtbGVuZ3RoIG9yIHNvbWV0aGluZykgaW5zdGVhZC4gIFRo
YXQgd2F5LCAibHMiIG91dHB1dCBjYW4NCj5zaG93IG1vcmUgdGhhbiBvbmUgZmlsZXMgb24gYSBz
aW5nbGUgbGluZSBldmVuIG9uIGEgODAtY29sdW1uIHRlcm1pbmFsLiAgVGhlDQo+bGVhZGluZyBk
aWdpdHMgYWxyZWFkeSBndWFyYW50ZWUgdGhlIHVuaXF1ZW5lc3MgYW55d2F5Lg0KPg0KPkkgZG8g
bm90IG1pbmQgZ2V0dGluZyByaWQgb2YgdGhlICJGT1JNQVRfUEFUQ0hfTkFNRV9NQVgiIGNvbnN0
YW50IGFuZA0KPnJlcGxhY2luZyBpdCB3aXRoIGEgdmFyaWFibGUgdGhhdCBkZWZhdWx0cyB0byA2
NCBhbmQgY2FuIGJlIHR3ZWFrZWQgYnkgYSBjb21tYW5kDQo+bGluZSBvcHRpb24gYW5kL29yIGEg
Y29uZmlndXJhdGlvbiB2YXJpYWJsZS4NCj5JdCBkb2VzIG5vdCBmZWVsIGl0IGlzIHdvcnRoIHRo
ZSBlZmZvcnQgdG8gcmVwbGFjZSBvbmUgaGFyZGNvZGVkIGNvbnN0YW50IHdpdGgNCj5hbm90aGVy
IGhhcmRjb2RlZCBjb25zdGFudC4NCj4NCj4+IExvb2tpbmcgYXQgdGhlIGNvZGUgd2hpY2ggdXNl
cyB0aGUgY29uc3RhbnQsIEkgc3VzcGVjdCBpdCBjb3VsZCBhbHNvDQo+PiBiZSBtYWRlIHNpbXBs
ZXI6DQo+Pg0KPj4gICAtIHRoZSBQQVRIX01BWCBjaGVjayBpbiBvcGVuX25leHRfZmlsZSgpIHNl
ZW1zIHBvaW50bGVzcy4gT25jZSB1cG9uIGENCj4+ICAgICB0aW1lIGl0IG1hdHRlcmVkIGZvciBm
aXR0aW5nIGludG8gYSBQQVRIX01BWCBidWZmZXIsIGJ1dCB0aGVzZSBkYXlzDQo+PiAgICAgd2Ug
dXNlIGEgZHluYW1pYyBidWZmZXIgYW55d2F5LiBXZSBhcmUgcHJvYmFibHkgYmV0dGVyIG9mZiB0
byBqdXN0DQo+PiAgICAgZmVlZCB0aGUgcmVzdWx0IHRvIHRoZSBmaWxlc3lzdGVtIGFuZCBzZWUg
aWYgaXQgY29tcGxhaW5zIChzaW5jZQ0KPj4gICAgIGVpdGhlciB3YXkgd2UgYXJlIGFib3J0aW5n
OyBJJ2QgZmVlbCBkaWZmZXJlbnRseSBpZiB3ZSBhZGp1c3RlZCBvdXINCj4+ICAgICB0cnVuY2F0
aW9uIHNpemUpDQo+Pg0KPj4gICAtIHRoZSBsb2dpYyBpbiBmbXRfb3V0cHV0X3N1YmplY3QoKSBj
b3VsZCBwcm9iYWJseSBiZSBzaW1wbGVyIGlmIHRoZQ0KPj4gICAgIGNvbnN0YW50IHdhcyAiaGVy
ZSdzIGhvdyBsb25nIHRoZSBzdWJqZWN0IHNob3VsZCBiZSIsIG5vdCAiaGVyZSdzDQo+PiAgICAg
aG93IGxvbmcgdGhlIHdob2xlIHRoaW5nIG11c3QgYmUiLg0KPj4NCj4+IEJ1dCB0aG9zZSBhcmUg
Ym90aCBvcnRob2dvbmFsIHRvIHlvdXIgcGF0Y2ggYW5kIGNhbiBiZSBkb25lIHNlcGFyYXRlbHku
DQo+DQo+WWVzLCB0aGVzZSBjbGVhbi11cHMgc2VlbSB3b3J0aCBkb2luZy4NCg0KQWdyZWVkLCBh
bmQgSSdkIGxpa2UgdG8gZG8gaXQgd2l0aCB0d28gc2VwYXJhdGVkIGNvbW1pdHM6DQotIGNvbW1p
dC0xLCAgY2xlYW51cCB0aGUgb3Blbl9uZXh0X2ZpbGUoKSBieSBkcm9wIHRoZSBpZiAoZmlsZW5h
bWUubGVuPj0uLikgc3RhdGVtZW50cy4NCg0KLSBjb21taXQtMiwgIHJlcGxhY2UgRk9STUFUX1BB
VENIX05BTUVfTUFYIGluIGZtdF9vdXRwdXRfc3ViamVjdCgpIHdpdGggYSBjb25zdGFudA0KICBp
biB0aGVyZSBhbmQgbWFrZSBpdCB0byA4MChvciBvdGhlciB2YWx1ZT8pLCBhbmQgZHJvcCBGT1JN
QVRfUEFUQ0hfTkFNRV9NQVgNCiAgZnJvbSBsb2ctdHJlZS5oLg0KDQpJcyB0aGlzIHdvcmtzIGZv
ciB5b3U/DQoNClRoYW5rcy4NCg==
