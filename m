Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECBD120966
	for <e@80x24.org>; Thu, 30 Mar 2017 20:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934179AbdC3U7f (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 16:59:35 -0400
Received: from mxo2.nje.dmz.twosigma.com ([208.77.214.162]:39290 "EHLO
        mxo2.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754435AbdC3U7e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 16:59:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTP id 4CBC2100049;
        Thu, 30 Mar 2017 20:59:32 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id O2Hsmi09NL9U; Thu, 30 Mar 2017 20:59:32 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (msx.twosigma.com [172.22.2.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTPS id 3D6338002E;
        Thu, 30 Mar 2017 20:59:32 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft7.ad.twosigma.com (172.22.2.43) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Thu, 30 Mar 2017 20:59:31 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Thu, 30 Mar 2017 20:59:31 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     Shawn Pearce <spearce@spearce.org>
CC:     git <git@vger.kernel.org>
Subject: RE: [PATCH] http.postbuffer: make a size_t
Thread-Topic: [PATCH] http.postbuffer: make a size_t
Thread-Index: AQHSqZYnXYCW+MDS6EGx8AavIUjVVqGt3bZQ
Date:   Thu, 30 Mar 2017 20:59:31 +0000
Message-ID: <82ec49a3ae4d402daf6113cf19c47fb0@exmbdft7.ad.twosigma.com>
References: <20170330202917.24281-1-dturner@twosigma.com>
 <CAJo=hJvs0UKO_NLbWAi8Y8XRJJ0v5kdjf9BN0V=pN_9yYrDp7Q@mail.gmail.com>
In-Reply-To: <CAJo=hJvs0UKO_NLbWAi8Y8XRJJ0v5kdjf9BN0V=pN_9yYrDp7Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.13]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

R2l0TGFiLiAgSSBjYW4ndCBzcGVhayB0byBvdXIgcGFydGljdWxhciBjb25maWd1cmF0aW9uIG9m
IGl0IC0tIGJ1dCBpZiB5b3UgaGF2ZSBhIHNwZWNpZmljIHF1ZXN0aW9uIGFib3V0IHdoYXQgdGhl
IGNvbmZpZyBpcywgSSBjYW4gYXNrIG91ciBnaXRsYWIgYWRtaW5zLg0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNoYXduIFBlYXJjZSBbbWFpbHRvOnNwZWFyY2VAc3Bl
YXJjZS5vcmddDQo+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAzMCwgMjAxNyA0OjQyIFBNDQo+IFRv
OiBEYXZpZCBUdXJuZXIgPERhdmlkLlR1cm5lckB0d29zaWdtYS5jb20+DQo+IENjOiBnaXQgPGdp
dEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGh0dHAucG9zdGJ1ZmZl
cjogbWFrZSBhIHNpemVfdA0KPiANCj4gT24gVGh1LCBNYXIgMzAsIDIwMTcgYXQgMToyOSBQTSwg
RGF2aWQgVHVybmVyIDxkdHVybmVyQHR3b3NpZ21hLmNvbT4NCj4gd3JvdGU6DQo+ID4gVW5mb3J0
dW5hdGVseSwgaW4gb3JkZXIgdG8gcHVzaCBzb21lIGxhcmdlIHJlcG9zLCB0aGUgaHR0cCBwb3N0
YnVmZmVyDQo+ID4gbXVzdCBzb21ldGltZXMgZXhjZWVkIHR3byBnaWdhYnl0ZXMuICBPbiBhIDY0
LWJpdCBzeXN0ZW0sIHRoaXMgaXMgT0s6DQo+ID4gd2UganVzdCBtYWxsb2MgYSBsYXJnZXIgYnVm
ZmVyLg0KPiANCj4gSSdtIHNsaWdodGx5IGN1cmlvdXMgd2hhdCBzZXJ2ZXIgeW91IGFyZSBwdXNo
aW5nIHRvIHRoYXQgbmVlZHMgdGhlIGVudGlyZSB0aGluZw0KPiBidWZmZXJlZCB0byBjb21wdXRl
IGEgQ29udGVudC1MZW5ndGgsIHJhdGhlciB0aGFuIHVzaW5nDQo+IFRyYW5zZmVyLUVuY29kaW5n
OiBjaHVua2VkLiBNb3N0IEdpdC1vdmVyLUhUVFAgc2hvdWxkIGJlIGFjY2VwdGluZw0KPiBUcmFu
c2Zlci1FbmNvZGluZzogY2h1bmtlZCB3aGVuIHRoZSBzdHJlYW0gZXhjZWVkcyBwb3N0QnVmZmVy
Lg0K
