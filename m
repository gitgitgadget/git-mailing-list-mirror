Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF16720248
	for <e@80x24.org>; Mon,  4 Mar 2019 07:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbfCDH4l (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 02:56:41 -0500
Received: from mx-relay47-hz2.antispameurope.com ([94.100.136.247]:45504 "EHLO
        mx-relay47-hz2.antispameurope.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725974AbfCDH4l (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 Mar 2019 02:56:41 -0500
Received: from unknown ([91.229.168.76]) by mx-relay47-hz2.antispameurope.com;
 Mon, 04 Mar 2019 08:56:38 +0100
Received: from bruexc101.brumgt.local (10.251.3.120) by bruexc101.brumgt.local
 (10.251.3.120) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 Mar
 2019 08:55:47 +0100
Received: from bruexc101.brumgt.local ([fe80::8192:a565:2dec:8204]) by
 bruexc101.brumgt.local ([fe80::8192:a565:2dec:8204%19]) with mapi id
 15.00.1473.003; Mon, 4 Mar 2019 08:55:47 +0100
From:   "Wendeborn, Jonathan" <Jonathan.Wendeborn@bruker.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: AW: fast-import fails with case sensitive tags due to case
 insensitive lock files
Thread-Topic: fast-import fails with case sensitive tags due to case
 insensitive lock files
Thread-Index: AdTPonIg/9QWZqseSg6y1MSsuJUGaABrM6kAAEQUNaA=
Date:   Mon, 4 Mar 2019 07:55:47 +0000
Message-ID: <3dbce0f1c80e4e67b114f8c84e2106c8@bruexc101.brumgt.local>
References: <ceb9b34681c14d9ab2a33ba909b5ca75@bruexc101.brumgt.local>
 <20190303002542.GG601925@genre.crustytoothpaste.net>
In-Reply-To: <20190303002542.GG601925@genre.crustytoothpaste.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.251.3.124]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-cloud-security-sender: jonathan.wendeborn@bruker.com
X-cloud-security-recipient: git@vger.kernel.org
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay47-hz2.antispameurope.com with 2C9664036C
X-cloud-security-connect: unknown[91.229.168.76], TLS=1, IP=91.229.168.76
X-cloud-security: scantime:.5300
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBSaWdodCBub3csIHlvdSBoYXZlIHNvbWUgY2hvaWNlczogDQo+IOKAoiBWb2x1bnRlZXIgdG8g
aW1wbGVtZW50IHJlZnRhYmxlLiANCj4g4oCiIFNpbmNlIHlvdSdyZSBvbiBXaW5kb3dzIDEwLCBz
ZXQgeW91ciBHaXQgcmVwb3NpdG9yeSBkaXJlY3RvcnkgYXMgDQo+IMKgIGNhc2Utc2Vuc2l0aXZl
LiANCj4g4oCiIFVzZSBXaW5kb3dzIFN1YnN5c3RlbSBmb3IgTGludXgsIHdoaWNoIGlzIGNhc2Ug
c2Vuc2l0aXZlIGFuZCBjcmVhdGVzIA0KPiDCoCBkaXJlY3RvcmllcyB3aXRoIHRoYXQgZmxhZyAo
ZXZlbiBvbiBOVEZTKSwgdG8gZG8geW91ciBpbXBvcnQuIA0KPiDigKIgSWYgeW91IGNvbnRyb2wg
dGhlIGZhc3QtZXhwb3J0IG91dHB1dCwgYWRqdXN0IHRoZSBhcmd1bWVudHMgeW91IHBhc3MgDQo+
IMKgIHN1Y2ggdGhhdCB0aGUgb3V0cHV0IGRvZXMgbm90IGNvbnRhaW4gb25lIG9mIHRoZSBvZmZl
bmRpbmcgdGFncy4gDQoNCkhpIEJyaWFuLA0KDQpUaGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3Vy
IGFuc3dlciENCg0KVW5mb3J0dW5hdGVseSBJIGFtIHN0dWNrIHdpdGggV2luZG93cyAxMCAxNzAz
IHdoaWNoIG5laXRoZXIgc3VwcG9ydHMgY2FzZS1zZW5zaXRpdml0eSBub3IgYW55IExpbnV4IHN1
YnN5c3RlbSBmcm9tIHRoZSBNaWNyb3NvZnQgU3RvcmUgOiggQWxzbywgbXkgZW1wbG95ZXIgdW5m
b3J0dW5hdGVseSBkb2VzbuKAmXQgYWxsb3cgbWUgdG8gaW52ZXN0IHRoZSB0aW1lIHRvIGltcGxl
bWVudCByZWZ0YWJsZSwgc28gSSBndWVzcyBJIGdvIHdpdGggbWFudWFsbHkgbGVhdmluZyBvdXQg
dGhlIG9uZSBjb25mbGljdGluZyBsYWJlbCBJIGZvdW5kIGFuZCB0YWdnaW5nIGl0IG1hbnVhbGx5
IGFmdGVyd2FyZC4NCg0KT25lIHRoaW5nIEkgc3RpbGwgd291bGQgbGlrZSB0byBlbmNvdXJhZ2Ug
dG8gaXMgdG8gaW1wcm92ZSB0aGUgZXJyb3IgbWVzc2FnZSB3aGljaCBpcyByZWFsbHkgbWlzbGVh
ZGluZyBpbiB0aGlzIGNhc2UuDQoNCkJlc3QgcmVnYXJkcyBhbmQgdGhhbmtzIGFnYWluLA0KSm9u
YXRoYW4NCg==
