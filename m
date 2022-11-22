Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7158C4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 02:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiKVC1h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 21:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbiKVC0a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 21:26:30 -0500
Received: from mail10.tencent.com (mail10.tencent.com [14.18.183.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7146672082
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 18:22:54 -0800 (PST)
Received: from EX-SZ023.tencent.com (unknown [10.28.6.89])
        by mail10.tencent.com (Postfix) with ESMTP id D8156D46B9;
        Tue, 22 Nov 2022 10:22:51 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1669083771;
        bh=h160dch5SZoJFLG0/S0bZt0Zh1AmpMiLTL7uWYNaI6E=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=Z8TlkMwdgdsic/K1sFTsquoh26/QthO/832FxYSKUnZ/deMgxUkEmkkHGBFQeJTu5
         OyXrnFu5SMVNDALJehAb7Yd/7a5fMlBX+mFP3rkiDAXnPdxBBwxgRtHV5mNMI4KhNg
         VJ38VcpuyIDNH06bMYdCIRzbd0zs6UyayJ2Cei+0=
Received: from EX-SZ091.tencent.com (10.28.6.63) by EX-SZ023.tencent.com
 (10.28.6.89) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 22 Nov
 2022 10:22:51 +0800
Received: from EX-SZ066.tencent.com (10.28.6.18) by EX-SZ091.tencent.com
 (10.28.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 22 Nov
 2022 10:22:36 +0800
Received: from EX-SZ066.tencent.com ([fe80::d867:3d3d:29a0:f571]) by
 EX-SZ066.tencent.com ([fe80::d867:3d3d:29a0:f571%6]) with mapi id
 15.01.2242.008; Tue, 22 Nov 2022 10:22:36 +0800
From:   =?gb2312?B?a3lsZXpoYW8o1dS/wtPuKQ==?= <kylezhao@tencent.com>
To:     Jiang Xin <worldhello.net@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, "Git List" <git@vger.kernel.org>
CC:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: RE: [Internet][PATCH] t5516: fail to run in verbose mode
Thread-Topic: [Internet][PATCH] t5516: fail to run in verbose mode
Thread-Index: AQHY/a7gyoDCmGAnc0yWSU9Nh7XAFK5KNuOQ
Date:   Tue, 22 Nov 2022 02:22:35 +0000
Message-ID: <a7abaa2cc8d248faa50ad95fc3670ee0@tencent.com>
References: <20221121134040.12260-1-worldhello.net@gmail.com>
In-Reply-To: <20221121134040.12260-1-worldhello.net@gmail.com>
Accept-Language: en-AS, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.17.237]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBUaGUgdGVzdCBjYXNlICJwdXNoIHdpdGggY29uZmlnIHB1c2gudXNlQml0bWFwIiBvZiB0NTUx
NiB3YXMgaW50cm9kdWNlZCBpbg0KPiBjb21taXQgODJmNjdlZTEzZiAoc2VuZC1wYWNrLmM6IGFk
ZCBjb25maWcgcHVzaC51c2VCaXRtYXBzLCAyMDIyLTA2LTE3KS4gSXQNCj4gd29uJ3Qgd29yayBp
biB2ZXJib3NlIG1vZGUsIGUuZy46DQo+IA0KPiAgICAgJCBzaCB0NTUxNi1mZXRjaC1wdXNoLnNo
IC0tcnVuPScxLDExNScgLXYNCj4gDQo+IFRoaXMgaXMgYmVjYXVzZSAiZ2l0LXB1c2giIHdpbGwg
cnVuIGluIGEgdHR5IGluIHRoaXMgY2FzZSwgYW5kIHRoZSBzdWJjb21tYW5kDQo+ICJnaXQgcGFj
ay1vYmplY3RzIiB3aWxsIGNvbnRhaW4gYW4gYXJndW1lbnQgIi0tcHJvZ3Jlc3MiDQo+IGluc3Rl
YWQgb2YgIi1xIi4gQWRkaW5nIGEgc3BlY2lmaWMgb3B0aW9uICItLXF1aWV0IiB0byAiZ2l0IHB1
c2giIHdpbGwgZ2V0IGEgc3RhYmxlDQo+IHJlc3VsdCBmb3IgdDU1MTYuDQo+IA0KDQpUaGF0J3Mg
dHJ1ZS4gVGhhbmtzIGZvciBub3RpY2luZyBhbmQgZml4aW5nLg0KDQpJIGRpZG4ndCBjb25zaWRl
ciB0aGlzIHVzYWdlIG9mIHRlc3QgY2FzZSwgYW5kIGl0IHdvcmtzIGFmdGVyIHlvdXIgcGF0Y2gu
DQoNClRoYW5rcywNCkt5bGUNCg==
