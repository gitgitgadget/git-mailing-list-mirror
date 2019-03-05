Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82D0720374
	for <e@80x24.org>; Tue,  5 Mar 2019 06:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfCEGZ3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 01:25:29 -0500
Received: from mx-relay66-hz2.antispameurope.com ([94.100.136.166]:57871 "EHLO
        mx-relay66-hz2.antispameurope.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725818AbfCEGZ2 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 Mar 2019 01:25:28 -0500
Received: from unknown ([91.229.168.76]) by mx-relay66-hz2.antispameurope.com;
 Tue, 05 Mar 2019 07:25:26 +0100
Received: from bruexc101.brumgt.local (10.251.3.120) by bruexc104.brumgt.local
 (10.251.3.119) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 5 Mar
 2019 07:25:11 +0100
Received: from bruexc101.brumgt.local ([fe80::8192:a565:2dec:8204]) by
 bruexc101.brumgt.local ([fe80::8192:a565:2dec:8204%19]) with mapi id
 15.00.1473.003; Tue, 5 Mar 2019 07:25:11 +0100
From:   "Wendeborn, Jonathan" <Jonathan.Wendeborn@bruker.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: AW: AW: fast-import fails with case sensitive tags due to case
 insensitive lock files
Thread-Topic: AW: fast-import fails with case sensitive tags due to case
 insensitive lock files
Thread-Index: AdTPonIg/9QWZqseSg6y1MSsuJUGaABrM6kAAEQUNaAADcUQgAAhW2vQ
Date:   Tue, 5 Mar 2019 06:25:11 +0000
Message-ID: <b8976ee7d99547649cdded5a80ab118d@bruexc101.brumgt.local>
References: <ceb9b34681c14d9ab2a33ba909b5ca75@bruexc101.brumgt.local>
 <20190303002542.GG601925@genre.crustytoothpaste.net>
 <3dbce0f1c80e4e67b114f8c84e2106c8@bruexc101.brumgt.local>
 <nycvar.QRO.7.76.6.1903041627230.45@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1903041627230.45@tvgsbejvaqbjf.bet>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay66-hz2.antispameurope.com with EF9CBCA72A1
X-cloud-security-connect: unknown[91.229.168.76], TLS=1, IP=91.229.168.76
X-cloud-security: scantime:.1597
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgSm9oYW5uZXMsDQoNCj4+IE9uZSB0aGluZyBJIHN0aWxsIHdvdWxkIGxpa2UgdG8gZW5jb3Vy
YWdlIHRvIGlzIHRvIGltcHJvdmUgdGhlIGVycm9yIA0KPj4gbWVzc2FnZSB3aGljaCBpcyByZWFs
bHkgbWlzbGVhZGluZyBpbiB0aGlzIGNhc2UuDQoNCj4gV2VsbCwgdGhhdCBpcyBhdCBsZWFzdCBz
b21ldGhpbmcgeW91IGNvdWxkIGRvLiBBZnRlciBhbGwsIHlvdSB1c2UgYSB2b2x1bnRlZXItZHJp
dmVuIHByb2plY3QsIHNvIHlvdSBjb3VsZCBhdCBsZWFzdCB2b2x1bnRlZXIgYSBsaXR0bGUgdGlt
ZSB0byBpbXByb3ZpbmcgaXQgeW91cnNlbGYuDQoNClRoYXQncyB0cnVlIDopDQoNClRoYW5rIHlv
dSENCkpvbmF0aGFuDQoNCi0tLS0tVXJzcHLDvG5nbGljaGUgTmFjaHJpY2h0LS0tLS0NClZvbjog
Sm9oYW5uZXMgU2NoaW5kZWxpbiA8Sm9oYW5uZXMuU2NoaW5kZWxpbkBnbXguZGU+IA0KR2VzZW5k
ZXQ6IE1vbnRhZywgNC4gTcOkcnogMjAxOSAxNjoyOQ0KQW46IFdlbmRlYm9ybiwgSm9uYXRoYW4g
PEpvbmF0aGFuLldlbmRlYm9ybkBicnVrZXIuY29tPg0KQ2M6IGJyaWFuIG0uIGNhcmxzb24gPHNh
bmRhbHNAY3J1c3R5dG9vdGhwYXN0ZS5uZXQ+OyBnaXRAdmdlci5rZXJuZWwub3JnDQpCZXRyZWZm
OiBSZTogQVc6IGZhc3QtaW1wb3J0IGZhaWxzIHdpdGggY2FzZSBzZW5zaXRpdmUgdGFncyBkdWUg
dG8gY2FzZSBpbnNlbnNpdGl2ZSBsb2NrIGZpbGVzDQoNCkhpIEpvbmF0aGFuLA0KDQpPbiBNb24s
IDQgTWFyIDIwMTksIFdlbmRlYm9ybiwgSm9uYXRoYW4gd3JvdGU6DQoNCj4gPiBSaWdodCBub3cs
IHlvdSBoYXZlIHNvbWUgY2hvaWNlczogDQo+ID4g4oCiIFZvbHVudGVlciB0byBpbXBsZW1lbnQg
cmVmdGFibGUuIA0KPiA+IOKAoiBTaW5jZSB5b3UncmUgb24gV2luZG93cyAxMCwgc2V0IHlvdXIg
R2l0IHJlcG9zaXRvcnkgZGlyZWN0b3J5IGFzDQo+ID4gwqAgY2FzZS1zZW5zaXRpdmUuIA0KPiA+
IOKAoiBVc2UgV2luZG93cyBTdWJzeXN0ZW0gZm9yIExpbnV4LCB3aGljaCBpcyBjYXNlIHNlbnNp
dGl2ZSBhbmQgDQo+ID4gY3JlYXRlcw0KPiA+IMKgIGRpcmVjdG9yaWVzIHdpdGggdGhhdCBmbGFn
IChldmVuIG9uIE5URlMpLCB0byBkbyB5b3VyIGltcG9ydC4gDQo+ID4g4oCiIElmIHlvdSBjb250
cm9sIHRoZSBmYXN0LWV4cG9ydCBvdXRwdXQsIGFkanVzdCB0aGUgYXJndW1lbnRzIHlvdSANCj4g
PiBwYXNzDQo+ID4gwqAgc3VjaCB0aGF0IHRoZSBvdXRwdXQgZG9lcyBub3QgY29udGFpbiBvbmUg
b2YgdGhlIG9mZmVuZGluZyB0YWdzLiANCj4gDQo+IEhpIEJyaWFuLA0KPiANCj4gVGhhbmsgeW91
IHZlcnkgbXVjaCBmb3IgeW91ciBhbnN3ZXIhDQo+IA0KPiBVbmZvcnR1bmF0ZWx5IEkgYW0gc3R1
Y2sgd2l0aCBXaW5kb3dzIDEwIDE3MDMgd2hpY2ggbmVpdGhlciBzdXBwb3J0cyANCj4gY2FzZS1z
ZW5zaXRpdml0eSBub3IgYW55IExpbnV4IHN1YnN5c3RlbSBmcm9tIHRoZSBNaWNyb3NvZnQgU3Rv
cmUgOigNCg0KVG9vIGJhZC4NCg0KPiBBbHNvLCBteSBlbXBsb3llciB1bmZvcnR1bmF0ZWx5IGRv
ZXNu4oCZdCBhbGxvdyBtZSB0byBpbnZlc3QgdGhlIHRpbWUgdG8gDQo+IGltcGxlbWVudCByZWZ0
YWJsZSwNCg0KRXZlbiB3b3JzZSENCg0KPiBzbyBJIGd1ZXNzIEkgZ28gd2l0aCBtYW51YWxseSBs
ZWF2aW5nIG91dCB0aGUgb25lIGNvbmZsaWN0aW5nIGxhYmVsIEkgDQo+IGZvdW5kIGFuZCB0YWdn
aW5nIGl0IG1hbnVhbGx5IGFmdGVyd2FyZC4NCg0KVGhhdCBpcyBhIHZhbGlkIHdvcmthcm91bmQu
DQoNCj4gT25lIHRoaW5nIEkgc3RpbGwgd291bGQgbGlrZSB0byBlbmNvdXJhZ2UgdG8gaXMgdG8g
aW1wcm92ZSB0aGUgZXJyb3IgDQo+IG1lc3NhZ2Ugd2hpY2ggaXMgcmVhbGx5IG1pc2xlYWRpbmcg
aW4gdGhpcyBjYXNlLg0KDQpXZWxsLCB0aGF0IGlzIGF0IGxlYXN0IHNvbWV0aGluZyB5b3UgY291
bGQgZG8uIEFmdGVyIGFsbCwgeW91IHVzZSBhIHZvbHVudGVlci1kcml2ZW4gcHJvamVjdCwgc28g
eW91IGNvdWxkIGF0IGxlYXN0IHZvbHVudGVlciBhIGxpdHRsZSB0aW1lIHRvIGltcHJvdmluZyBp
dCB5b3Vyc2VsZi4NCg0KQ2lhbywNCkpvaGFubmVzDQo=
