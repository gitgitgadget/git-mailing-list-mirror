Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04ACD2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 01:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933325AbdBWB0d (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 20:26:33 -0500
Received: from mxo1.dft.dmz.twosigma.com ([208.77.212.183]:52150 "EHLO
        mxo1.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932667AbdBWB0c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 20:26:32 -0500
Received: from localhost (localhost [127.0.0.1])
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTP id D5E381000C1;
        Thu, 23 Feb 2017 01:16:33 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZMHJ4BTRmilc; Thu, 23 Feb 2017 01:16:33 +0000 (GMT)
Received: from exmbdft6.ad.twosigma.com (exmbdft6.ad.twosigma.com [172.22.1.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTPS id C54C280035;
        Thu, 23 Feb 2017 01:16:33 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft6.ad.twosigma.com (172.22.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Thu, 23 Feb 2017 01:16:33 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%23]) with mapi id
 15.00.1263.000; Thu, 23 Feb 2017 01:16:33 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Jeff King' <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: RE: [PATCH 2/2] http: add an "auto" mode for http.emptyauth
Thread-Topic: [PATCH 2/2] http: add an "auto" mode for http.emptyauth
Thread-Index: AQHSjWUg+yBJWek6a0SPI8i/WVMpNaF1yAXg
Date:   Thu, 23 Feb 2017 01:16:33 +0000
Message-ID: <b5778a7988ad4dfa9adfc8d312432189@exmbdft7.ad.twosigma.com>
References: <20170222233333.dx5lknw4fpopu5hy@sigill.intra.peff.net>
 <20170222234059.iajn2zuwzkzjxit2@sigill.intra.peff.net>
In-Reply-To: <20170222234059.iajn2zuwzkzjxit2@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SSBkb24ndCBrbm93IGVub3VnaCBhYm91dCBob3cgbGliY3VybCBoYW5kbGVzIGF1dGhlbnRpY2F0
aW9uIHRvIGtub3cgd2hldGhlciANCnRoZXNlIHBhdGNoZXMgYXJlIGEgZ29vZCBpZGVhLCBidXQg
SSBoYXZlIGEgbWlub3IgY29tbWVudCBhbnl3YXkuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogSmVmZiBLaW5nIFttYWlsdG86cGVmZkBwZWZmLm5ldF0NCj4gK3N0YXRp
YyBpbnQgY3VybF9lbXB0eV9hdXRoX2VuYWJsZWQodm9pZCkgew0KPiArCWlmIChjdXJsX2VtcHR5
X2F1dGggPCAwKSB7DQo+ICsjaWZkZWYgTElCQ1VSTF9DQU5fSEFORExFX0FVVEhfQU5ZDQo+ICsJ
CS8qDQo+ICsJCSAqIEluIHRoZSBhdXRvbWF0aWMgY2FzZSwga2ljayBpbiB0aGUgZW1wdHktYXV0
aA0KPiArCQkgKiBoYWNrIGFzIGxvbmcgYXMgd2Ugd291bGQgcG90ZW50aWFsbHkgdHJ5IHNvbWUN
Cj4gKwkJICogbWV0aG9kIG1vcmUgZXhvdGljIHRoYW4gIkJhc2ljIi4NCj4gKwkJICoNCj4gKwkJ
ICogQnV0IG9ubHkgZG8gc28gd2hlbiB0aGlzIGlzIF9ub3RfIG91ciBpbml0aWFsDQo+ICsJCSAq
IHJlcXVlc3QsIGFzIHdlIHdvdWxkIG5vdCB0aGVuIHlldCBrbm93IHdoYXQNCj4gKwkJICogbWV0
aG9kcyBhcmUgYXZhaWxhYmxlLg0KPiArCQkgKi8NCg0KRWxpbWluYXRlIGRvdWJsZS1uZWdhdGl2
ZToNCg0KIkJ1dCBvbmx5IGRvIHRoaXMgd2hlbiB0aGlzIGlzIG91ciBzZWNvbmQgb3Igc3Vic2Vx
dWVudCByZXF1ZXN0LCANCmFzIGJ5IHRoZW4gd2Uga25vdyB3aGF0IG1ldGhvZHMgYXJlIGF2YWls
YWJsZS4iDQoNCg==
