Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2475BC433F5
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 02:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243430AbhKYC6r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 21:58:47 -0500
Received: from outboundhk.mxmail.xiaomi.com ([207.226.244.123]:61042 "EHLO
        hkspamc1-admin.mioffice.cn" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243067AbhKYC4q (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Nov 2021 21:56:46 -0500
X-IronPort-AV: E=Sophos;i="5.87,261,1631548800"; 
   d="scan'208";a="12730847"
Received: from hk-mbx01.mioffice.cn (HELO xiaomi.com) ([10.56.8.121])
  by hkspamc1-admin.mioffice.cn with ESMTP; 25 Nov 2021 10:53:34 +0800
Received: from BJ-MBX01.mioffice.cn (10.237.8.121) by HK-MBX01.mioffice.cn
 (10.56.8.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 25 Nov
 2021 10:53:33 +0800
Received: from BJ-MBX01.mioffice.cn (10.237.8.121) by BJ-MBX01.mioffice.cn
 (10.237.8.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 25 Nov
 2021 10:53:33 +0800
Received: from BJ-MBX01.mioffice.cn ([::1]) by BJ-MBX01.mioffice.cn
 ([fe80::e466:4850:4a72:f2da%9]) with mapi id 15.02.0986.014; Thu, 25 Nov 2021
 10:53:33 +0800
From:   =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
To:     Jeff King <peff@peff.net>
CC:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [External Mail]Re: why git is so slow for a tiny git push?
Thread-Topic: [External Mail]Re: why git is so slow for a tiny git push?
Thread-Index: Ade84mmmstEBXQTRSsexpdzlhc8vnAAVTYYAAAAT7KAAUV7NAAAwVDmA//+FzYCAABgnAIAAw5wA/751pyCAhOObAP/+6lbw
Date:   Thu, 25 Nov 2021 02:53:33 +0000
Message-ID: <a39b72ed59f045c19fad8fcb259821d2@xiaomi.com>
References: <c5a8595658d6416684c2bbd317494c49@xiaomi.com>
 <5a6f3e8f29f74c93bf3af5da636df973@xiaomi.com>
 <576b2f3e162e4f86992d8f4e680d0881@xiaomi.com>
 <YWRr9g32cMlIc37V@coredump.intra.peff.net>
 <ef2aa0d3ea8a4d98b910abdfd55191d0@xiaomi.com>
 <YWVJyRJhRTdg39tX@coredump.intra.peff.net>
 <87pmsak0hl.fsf@evledraar.gmail.com>
 <YWYCIndv/u67lNQU@coredump.intra.peff.net>
 <56994f02ed4542b89cc6f9586d703e05@xiaomi.com>
 <YZ6BJpAY4ZAWaqkr@coredump.intra.peff.net>
In-Reply-To: <YZ6BJpAY4ZAWaqkr@coredump.intra.peff.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.237.8.11]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V2VsbCwgd2UgZG8gaGF2ZSAzMDBrIHJlZnMsIGJ1dCBvbmx5IDEwMDAgcmVmcy9oZWFkcy4NCkhv
d2V2ZXIsIEkgdGhpbmsgbW9zdCB1c2VycyBvbmx5IHJlcXVpcmVzIHJlZnMvaGVhZHMsIGEgZmV3
IHBlb3BsZSBvbmx5IHJlcXVpcmUgcmVmcy90YWdzLiBBcyBmb3Igb3RoZXIgcmVmcywgd2UgaGFy
ZGx5IHNlZSBhbnkgdXNlciBjYXNlLg0KDQpTbyBqZ2l0IHRyZWF0IGl0IHdpdGggYSBzbWFydCB3
YXksICBpdCB3aWxsIGNyZWF0ZSAyIHBhY2sgZmlsZXMgYW5kIDIgYml0bWFwcywgcGFjayBBIGNv
bnRhaW4gYWxsIHJlZnMvaGVhZHMsIGFuZCBwYWNrIEIgY29udGFpbnMgb3RoZXIgcmVmcy4gQW5k
IHdoZW4gdXNlciBkbyBhIGZyZXNoIGNsb25lLCBpdCBqdXN0IG5lZWQgdG8gc2VuZCB0aGUgcGFj
ayBBIHdpdGhvdXQgZGV0ZXJtaW5lIGlmIHdlIGNhbiByZXVzZSBvciBub3QNCg0KLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEplZmYgS2luZyA8cGVmZkBwZWZmLm5ldD4NClNlbnQ6
IFRodXJzZGF5LCBOb3ZlbWJlciAyNSwgMjAyMSAyOjE1IEFNDQpUbzog56iL5rSLIDxjaGVuZ3lh
bmdAeGlhb21pLmNvbT4NCkNjOiBUYXlsb3IgQmxhdSA8bWVAdHRheWxvcnIuY29tPjsgw4Z2YXIg
QXJuZmrDtnLDsCBCamFybWFzb24gPGF2YXJhYkBnbWFpbC5jb20+OyBnaXRAdmdlci5rZXJuZWwu
b3JnDQpTdWJqZWN0OiBSZTogW0V4dGVybmFsIE1haWxdUmU6IHdoeSBnaXQgaXMgc28gc2xvdyBm
b3IgYSB0aW55IGdpdCBwdXNoPw0KDQoqVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBvdXRz
aWRlIG9mIFhJQU9NSS4gUGxlYXNlIHRyZWF0IHRoaXMgZW1haWwgd2l0aCBjYXV0aW9uKg0KDQoN
Ck9uIFR1ZSwgTm92IDIzLCAyMDIxIGF0IDA2OjQyOjEyQU0gKzAwMDAsIOeoi+a0iyB3cm90ZToN
Cg0KPiBJIGdvdCBhbm90aGVyIHByb2JsZW0gaGVyZS4NCj4gV2hlbiBJIHRyaWVzIHRvIGNsb25l
IGZyb20gcmVtb3RlIHNlcnZlci4gSXQgdG9vayBtZSAyNSBzZWNvbmRzIHRvIGVudW1lcmF0aW5n
IG9iamVjdHMuIEFuZCB0aGVuIDEgc2Vjb25kIHRvIGBjb3V0aW5nIG9iamVjdHNgIGJ5IGJpdG1h
cC4NCj4gSSBkb24ndCB1bmRlcnN0YW5kLCB3aHkgYSBmcmVzaCBjbG9uZSBuZWVkIGBlbnVtZXJh
dGluZyBvYmplY3RzYCA/IElzIGBjb3V0aW5nIG9iamVjdHNgIGVub3VnaCBmb3IgdGhlIHNlcnZl
ciB0byBkZXRlcm1pbmUgd2hhdCB0byBzZW5kPw0KDQpJbiBvbGRlciB2ZXJzaW9ucyBvZiBHaXQs
IHRoZSAiY291bnRpbmcgb2JqZWN0cyIgcHJvZ3Jlc3MgbWV0ZXIgdXNlZCB0byBiZSB0aGUgYWN0
dWFsIG9iamVjdCBncmFwaCB0cmF2ZXJzYWwuIFRoYXQgY2hhbmdlZCBpbiB2Mi4xOCAodmlhIDVh
ZjA1MDQzN2EpLCBidXQgeW91IG1heSBzdGlsbCBzZWVtIHNvbWUgcmVmZXJlbmNlIHRvICJjb3Vu
dGluZyBvYmplY3RzIGlzIGV4cGVuc2l2ZSIuDQoNClRoZXNlIGRheXMgdGhhdCBpcyBjYWxsZWQg
ImVudW1lcmF0aW5nIG9iamVjdHMiLCBhbmQgImNvdW50aW5nIG9iamVjdHMiDQppcyBqdXN0IGRv
aW5nIGEgcXVpY2staXNoIHBhc3Mgb3ZlciB0aGF0IGxpc3QgdG8gZG8gc29tZSBsaWdodCBhbmFs
eXNpcyAoZS5nLiwgaWYgd2UgY2FuIHJldXNlIGFuIG9uLWRpc2sgZGVsdGEpLiBJJ2QgZXhwZWN0
ICJlbnVtZXJhdGluZyIgdG8gYmUgZXhwZW5zaXZlIGluIGdlbmVyYWwsIGFuZCAiY291bnRpbmci
IHRvIGJlIHF1aWNrIGluIGdlbmVyYWwuDQoNClRoZSAiZW51bWVyYXRpbmciIHBoYXNlIGlzIHdo
ZXJlIHdlIGRldGVybWluZSB3aGF0IHRvIHNlbmQgd2hldGhlciBpdCdzIGZvciBhIGNsb25lIG9y
IGEgZmV0Y2gsIGFuZCBtYXkgaW52b2x2ZSBvcGVuaW5nIHVwIGEgYnVuY2ggb2YgdHJlZXMgdG8g
d2FsayB0aGUgZ3JhcGguIEl0J3Mgd2hhdCByZWFjaGFiaWxpdHkgYml0bWFwcyBhcmUgc3VwcG9z
ZWQgdG8gbWFrZSBmYXN0ZXIuIEJ1dCBpZiB5b3UgaGF2ZSAzMDBrIHJlZnMsIGFzIHlvdSd2ZSBt
ZW50aW9uZWQsIHlvdSBhbG1vc3QgY2VydGFpbmx5IGRvbid0IGhhdmUgY29tcGxldGUgY292ZXJh
Z2Ugb2YgYWxsIG9mIHRoZSByZWYgdGlwcywgc28gd2UnbGwgaGF2ZSB0byBmYWxsYmFjayB0byBk
b2luZyBhdCBsZWFzdCBhIHBhcnRpYWwgZ3JhcGggdHJhdmVyc2FsLg0KDQpUYXlsb3IgKGNjJ2Qp
IGhhcyBiZWVuIGxvb2tpbmcgYXQgc29tZSB0cmlja3MgZm9yIHNwZWVkaW5nIHVwIGNhc2VzIGxp
a2UgdGhpcyB3aXRoIGEgbG90IG9mIHJlZnMuIEJ1dCBJIGRvbid0IHRoaW5rIHRoZXJlJ3MgYW55
dGhpbmcgdG8gc2hvdyBwdWJsaWNseSB5ZXQuDQoNCi1QZWZmDQojLyoqKioqKuacrOmCruS7tuWP
iuWFtumZhOS7tuWQq+acieWwj+exs+WFrOWPuOeahOS/neWvhuS/oeaBr++8jOS7hemZkOS6juWP
kemAgee7meS4iumdouWcsOWdgOS4reWIl+WHuueahOS4quS6uuaIlue+pOe7hOOAguemgeatouS7
u+S9leWFtuS7luS6uuS7peS7u+S9leW9ouW8j+S9v+eUqO+8iOWMheaLrOS9huS4jemZkOS6juWF
qOmDqOaIlumDqOWIhuWcsOazhOmcsuOAgeWkjeWItuOAgeaIluaVo+WPke+8ieacrOmCruS7tuS4
reeahOS/oeaBr+OAguWmguaenOaCqOmUmeaUtuS6huacrOmCruS7tu+8jOivt+aCqOeri+WNs+eU
teivneaIlumCruS7tumAmuefpeWPkeS7tuS6uuW5tuWIoOmZpOacrOmCruS7tu+8gSBUaGlzIGUt
bWFpbCBhbmQgaXRzIGF0dGFjaG1lbnRzIGNvbnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9u
IGZyb20gWElBT01JLCB3aGljaCBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVu
dGl0eSB3aG9zZSBhZGRyZXNzIGlzIGxpc3RlZCBhYm92ZS4gQW55IHVzZSBvZiB0aGUgaW5mb3Jt
YXRpb24gY29udGFpbmVkIGhlcmVpbiBpbiBhbnkgd2F5IChpbmNsdWRpbmcsIGJ1dCBub3QgbGlt
aXRlZCB0bywgdG90YWwgb3IgcGFydGlhbCBkaXNjbG9zdXJlLCByZXByb2R1Y3Rpb24sIG9yIGRp
c3NlbWluYXRpb24pIGJ5IHBlcnNvbnMgb3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50
KHMpIGlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNlaXZlIHRoaXMgZS1tYWlsIGluIGVycm9yLCBw
bGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcGhvbmUgb3IgZW1haWwgaW1tZWRpYXRlbHkgYW5k
IGRlbGV0ZSBpdCEqKioqKiovIw0K
