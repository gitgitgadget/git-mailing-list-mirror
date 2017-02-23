Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0B8520254
	for <e@80x24.org>; Thu, 23 Feb 2017 20:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbdBWUFM (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 15:05:12 -0500
Received: from mxo2.nje.dmz.twosigma.com ([208.77.214.162]:37031 "EHLO
        mxo2.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbdBWUFK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 15:05:10 -0500
Received: from localhost (localhost [127.0.0.1])
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTP id A591010010C;
        Thu, 23 Feb 2017 20:05:08 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7Pc3YR3zW4Nk; Thu, 23 Feb 2017 20:05:08 +0000 (GMT)
Received: from exmbdft6.ad.twosigma.com (exmbdft6.ad.twosigma.com [172.22.1.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTPS id 93F2A8002E;
        Thu, 23 Feb 2017 20:05:08 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft6.ad.twosigma.com (172.22.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Thu, 23 Feb 2017 20:05:08 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%23]) with mapi id
 15.00.1263.000; Thu, 23 Feb 2017 20:05:08 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Jeff King' <peff@peff.net>
CC:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: RE: [PATCH 2/2] http: add an "auto" mode for http.emptyauth
Thread-Topic: [PATCH 2/2] http: add an "auto" mode for http.emptyauth
Thread-Index: AQHSjWUg+yBJWek6a0SPI8i/WVMpNaF1yAXggAAIDgCAAPjBoIAANtOAgAADyxA=
Date:   Thu, 23 Feb 2017 20:05:08 +0000
Message-ID: <363ee9e9f043443e8ad096e2c2d8bd77@exmbdft7.ad.twosigma.com>
References: <20170222233333.dx5lknw4fpopu5hy@sigill.intra.peff.net>
 <20170222234059.iajn2zuwzkzjxit2@sigill.intra.peff.net>
 <b5778a7988ad4dfa9adfc8d312432189@exmbdft7.ad.twosigma.com>
 <20170223013746.lturqad7lnehedb4@sigill.intra.peff.net>
 <092a87cf9aa94d53aebf42facb75b985@exmbdft7.ad.twosigma.com>
 <20170223194418.eqi5ynhyhrcybiok@sigill.intra.peff.net>
In-Reply-To: <20170223194418.eqi5ynhyhrcybiok@sigill.intra.peff.net>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKZWZmIEtpbmcgW21haWx0bzpw
ZWZmQHBlZmYubmV0XQ0KPiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMjMsIDIwMTcgMjo0NCBQ
TQ0KPiBUbzogRGF2aWQgVHVybmVyIDxEYXZpZC5UdXJuZXJAdHdvc2lnbWEuY29tPg0KPiBDYzog
SnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJAcG9ib3guY29tPjsgZ2l0QHZnZXIua2VybmVsLm9yZzsN
Cj4gc2FuZGFsc0BjcnVzdHl0b290aHBhc3RlLm5ldDsgSm9oYW5uZXMgU2NoaW5kZWxpbg0KPiA8
am9oYW5uZXMuc2NoaW5kZWxpbkBnbXguZGU+OyBFcmljIFN1bnNoaW5lIDxzdW5zaGluZUBzdW5z
aGluZWNvLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGh0dHA6IGFkZCBhbiAiYXV0
byIgbW9kZSBmb3IgaHR0cC5lbXB0eWF1dGgNCj4gDQo+IE9uIFRodSwgRmViIDIzLCAyMDE3IGF0
IDA0OjMxOjEzUE0gKzAwMDAsIERhdmlkIFR1cm5lciB3cm90ZToNCj4gDQo+ID4gPiBBcyBzb21l
Ym9keSB3aG8gaXMgdXNpbmcgbm9uLUJhc2ljIGF1dGgsIGNhbiB5b3UgYXBwbHkgdGhlc2UgcGF0
Y2hlcw0KPiA+ID4gYW5kIHNob3cgdXMgdGhlIG91dHB1dCBvZjoNCj4gPiA+DQo+ID4gPiAgICBH
SVRfVFJBQ0VfQ1VSTD0xIFwNCj4gPiA+ICAgIGdpdCBscy1yZW1vdGUgaHR0cHM6Ly95b3VyLXNl
cnZlciAyPiYxID4vZGV2L251bGwgfA0KPiA+ID4gICAgZWdyZXAgJyhTZW5kfFJlY3YpIGhlYWRl
cjogKEdFVHxIVFRQfEF1dGgpJw0KPiA+ID4NCj4gPiA+ICh3aXRob3V0IGh0dHAuZW1wdHlhdXRo
IHR1cm5lZCBvbiwgb2J2aW91c2x5KS4NCj4gPg0KPiA+IFRoZSByZXN1bHRzIGFwcGVhciB0byBi
ZSBpZGVudGljYWwgd2l0aCBhbmQgd2l0aG91dCB0aGUgcGF0Y2guICBXaXRoDQo+ID4gaHR0cC5l
bXB0eWF1dGggdHVybmVkIG9mZiwNCj4gPiAxNjoyNzoyOC4yMDg5MjQgaHR0cC5jOjUyNCAgICAg
ICAgICAgICAgPT4gU2VuZCBoZWFkZXI6IEdFVA0KPiAvaW5mby9yZWZzP3NlcnZpY2U9Z2l0LXVw
bG9hZC1wYWNrIEhUVFAvMS4xDQo+ID4gMTY6Mjc6MjguMjEyODcyIGh0dHAuYzo1MjQgICAgICAg
ICAgICAgIDw9IFJlY3YgaGVhZGVyOiBIVFRQLzEuMSA0MDENCj4gQXV0aG9yaXphdGlvbiBSZXF1
aXJlZA0KPiA+IFVzZXJuYW1lIGZvciAnaHR0cDovL2dpdCc6IFtJIGp1c3QgcHJlc3NlZCBlbnRl
cl0gUGFzc3dvcmQgZm9yDQo+ID4gJ2h0dHA6Ly9naXQnOiBbZGl0dG9dDQo+ID4gMTY6Mjc6Mjku
OTI4ODcyIGh0dHAuYzo1MjQgICAgICAgICAgICAgID0+IFNlbmQgaGVhZGVyOiBHRVQNCj4gL2lu
Zm8vcmVmcz9zZXJ2aWNlPWdpdC11cGxvYWQtcGFjayBIVFRQLzEuMQ0KPiA+IDE2OjI3OjI5Ljky
OTc4NyBodHRwLmM6NTI0ICAgICAgICAgICAgICA8PSBSZWN2IGhlYWRlcjogSFRUUC8xLjEgNDAx
DQo+IEF1dGhvcml6YXRpb24gUmVxdWlyZWQNCj4gDQo+IEp1c3QgdG8gYmUgc3VyZTogZGlkIHlv
dSByZW1vdmUgaHR0cC5lbXB0eWF1dGggY29uZmlnIGNvbXBsZXRlbHkgZnJvbSB5b3VyDQo+IGNv
bmZpZyBmaWxlcywgb3IgZGlkIHlvdSB0dXJuIGl0IHRvICJmYWxzZSI/IEJlY2F1c2UgdGhlIG5l
dyBiZWhhdmlvciBvbmx5IGtpY2tzDQo+IGluIHdoZW4gaXQgaXNuJ3QgY29uZmlndXJlZCBhdCBh
bGwgKHByb2JhYmx5IHdlIHNob3VsZCByZXNwZWN0ICJhdXRvIiBhcyBhIHVzZXItDQo+IHByb3Zp
ZGVkIG5hbWUpLg0KDQpJIHR1cm5lZCBpdCB0byBmYWxzZS4gV2l0aCBpdCBjb21wbGV0ZWx5IHJl
bW92ZWQsIEkgZ2V0IHRoaXMsIGJvdGggdGltZXM6DQoNCjIwOjAzOjQ5Ljg5Njc5NyBodHRwLmM6
NTI0ICAgICAgICAgICAgICA9PiBTZW5kIGhlYWRlcjogR0VUIC9pbmZvL3JlZnM/c2VydmljZT1n
aXQtdXBsb2FkLXBhY2sgSFRUUC8xLjENCjIwOjAzOjQ5LjkwMDc3NiBodHRwLmM6NTI0ICAgICAg
ICAgICAgICA8PSBSZWN2IGhlYWRlcjogSFRUUC8xLjEgNDAxIEF1dGhvcml6YXRpb24gUmVxdWly
ZWQNCjIwOjAzOjQ5LjkwMDkyOSBodHRwLmM6NTI0ICAgICAgICAgICAgICA9PiBTZW5kIGhlYWRl
cjogR0VUIC9pbmZvL3JlZnM/c2VydmljZT1naXQtdXBsb2FkLXBhY2sgSFRUUC8xLjENCjIwOjAz
OjQ5LjkwNDc1NCBodHRwLmM6NTI0ICAgICAgICAgICAgICA8PSBSZWN2IGhlYWRlcjogSFRUUC8x
LjEgNDAxIEF1dGhvcml6YXRpb24gUmVxdWlyZWQNCjIwOjAzOjQ5LjkwNjY0OSBodHRwLmM6NTI0
ICAgICAgICAgICAgICA9PiBTZW5kIGhlYWRlcjogR0VUIC9pbmZvL3JlZnM/c2VydmljZT1naXQt
dXBsb2FkLXBhY2sgSFRUUC8xLjENCjIwOjAzOjQ5LjkwNjY1NCBodHRwLmM6NTI0ICAgICAgICAg
ICAgICA9PiBTZW5kIGhlYWRlcjogQXV0aG9yaXphdGlvbjogTmVnb3RpYXRlIDxyZWRhY3RlZD4N
CjIwOjAzOjQ5Ljk1Njc1MyBodHRwLmM6NTI0ICAgICAgICAgICAgICA8PSBSZWN2IGhlYWRlcjog
SFRUUC8xLjEgMjAwIE9LIC0gJGdpdHNlcnZlcm5hbWUNCg0KPiA+IChpZiBzb21lb25lIGVsc2Ug
d2FudHMgdG8gcmVwbGljYXRlIHRoaXMsIGRlbGV0ZSA+L2Rldi9udWxsIGJpdCBmcm9tDQo+ID4g
SmVmZidzIHNoZWxsIHNuaXBwZXQpDQo+IA0KPiBIcm0sIHlvdSBzaG91bGRuJ3QgbmVlZCB0by4g
VGhlIHN0ZGVyciByZWRpcmVjdGlvbiBjb21lcyBmaXJzdCwgc28gaXQgc2hvdWxkDQo+IGJlY29t
ZSB0aGUgbmV3IHN0ZG91dC4NCg0KV2VpcmQuICBJdCBkaWRuJ3QgYXBwZWFyIHdvcmsgZWFybGll
ciwgYnV0IEkgbXVzdCBoYXZlIHNjcmV3ZWQgc29tZXRoaW5nIHVwLg0KQW5kIEkgbGVhcm5lZCBz
b21ldGhpbmcgYWJvdXQgc2hlbGwgcmVkaXJlY3Rpb24uDQo=
