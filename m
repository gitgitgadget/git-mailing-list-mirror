Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 249282022D
	for <e@80x24.org>; Thu, 23 Feb 2017 16:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751125AbdBWQlg (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 11:41:36 -0500
Received: from mxo1.dft.dmz.twosigma.com ([208.77.212.183]:49623 "EHLO
        mxo1.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751041AbdBWQlf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 11:41:35 -0500
Received: from localhost (localhost [127.0.0.1])
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTP id 0CDB4100119;
        Thu, 23 Feb 2017 16:31:14 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gN35LCfhLMMn; Thu, 23 Feb 2017 16:31:13 +0000 (GMT)
Received: from exmbdft5.ad.twosigma.com (exmbdft5.ad.twosigma.com [172.22.1.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTPS id EE96780035;
        Thu, 23 Feb 2017 16:31:13 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft5.ad.twosigma.com (172.22.1.56) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Thu, 23 Feb 2017 16:31:13 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%23]) with mapi id
 15.00.1263.000; Thu, 23 Feb 2017 16:31:13 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Jeff King' <peff@peff.net>
CC:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: RE: [PATCH 2/2] http: add an "auto" mode for http.emptyauth
Thread-Topic: [PATCH 2/2] http: add an "auto" mode for http.emptyauth
Thread-Index: AQHSjWUg+yBJWek6a0SPI8i/WVMpNaF1yAXggAAIDgCAAPjBoA==
Date:   Thu, 23 Feb 2017 16:31:13 +0000
Message-ID: <092a87cf9aa94d53aebf42facb75b985@exmbdft7.ad.twosigma.com>
References: <20170222233333.dx5lknw4fpopu5hy@sigill.intra.peff.net>
 <20170222234059.iajn2zuwzkzjxit2@sigill.intra.peff.net>
 <b5778a7988ad4dfa9adfc8d312432189@exmbdft7.ad.twosigma.com>
 <20170223013746.lturqad7lnehedb4@sigill.intra.peff.net>
In-Reply-To: <20170223013746.lturqad7lnehedb4@sigill.intra.peff.net>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVmZiBLaW5nIFttYWls
dG86cGVmZkBwZWZmLm5ldF0NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAyMiwgMjAxNyA4
OjM4IFBNDQo+IFRvOiBEYXZpZCBUdXJuZXIgPERhdmlkLlR1cm5lckB0d29zaWdtYS5jb20+DQo+
IENjOiBKdW5pbyBDIEhhbWFubyA8Z2l0c3RlckBwb2JveC5jb20+OyBnaXRAdmdlci5rZXJuZWwu
b3JnOw0KPiBzYW5kYWxzQGNydXN0eXRvb3RocGFzdGUubmV0OyBKb2hhbm5lcyBTY2hpbmRlbGlu
DQo+IDxqb2hhbm5lcy5zY2hpbmRlbGluQGdteC5kZT47IEVyaWMgU3Vuc2hpbmUgPHN1bnNoaW5l
QHN1bnNoaW5lY28uY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gaHR0cDogYWRkIGFu
ICJhdXRvIiBtb2RlIGZvciBodHRwLmVtcHR5YXV0aA0KPiANCj4gT24gVGh1LCBGZWIgMjMsIDIw
MTcgYXQgMDE6MTY6MzNBTSArMDAwMCwgRGF2aWQgVHVybmVyIHdyb3RlOg0KPiANCj4gPiBJIGRv
bid0IGtub3cgZW5vdWdoIGFib3V0IGhvdyBsaWJjdXJsIGhhbmRsZXMgYXV0aGVudGljYXRpb24g
dG8ga25vdw0KPiA+IHdoZXRoZXIgdGhlc2UgcGF0Y2hlcyBhcmUgYSBnb29kIGlkZWEsIGJ1dCBJ
IGhhdmUgYSBtaW5vciBjb21tZW50DQo+IGFueXdheS4NCj4gDQo+IEFzIHNvbWVib2R5IHdobyBp
cyB1c2luZyBub24tQmFzaWMgYXV0aCwgY2FuIHlvdSBhcHBseSB0aGVzZSBwYXRjaGVzIGFuZA0K
PiBzaG93IHVzIHRoZSBvdXRwdXQgb2Y6DQo+IA0KPiAgICBHSVRfVFJBQ0VfQ1VSTD0xIFwNCj4g
ICAgZ2l0IGxzLXJlbW90ZSBodHRwczovL3lvdXItc2VydmVyIDI+JjEgPi9kZXYvbnVsbCB8DQo+
ICAgIGVncmVwICcoU2VuZHxSZWN2KSBoZWFkZXI6IChHRVR8SFRUUHxBdXRoKScNCj4gDQo+ICh3
aXRob3V0IGh0dHAuZW1wdHlhdXRoIHR1cm5lZCBvbiwgb2J2aW91c2x5KS4NCg0KVGhlIHJlc3Vs
dHMgYXBwZWFyIHRvIGJlIGlkZW50aWNhbCB3aXRoIGFuZCB3aXRob3V0DQp0aGUgcGF0Y2guICBX
aXRoIGh0dHAuZW1wdHlhdXRoIHR1cm5lZCBvZmYsDQoxNjoyNzoyOC4yMDg5MjQgaHR0cC5jOjUy
NCAgICAgICAgICAgICAgPT4gU2VuZCBoZWFkZXI6IEdFVCAvaW5mby9yZWZzP3NlcnZpY2U9Z2l0
LXVwbG9hZC1wYWNrIEhUVFAvMS4xDQoxNjoyNzoyOC4yMTI4NzIgaHR0cC5jOjUyNCAgICAgICAg
ICAgICAgPD0gUmVjdiBoZWFkZXI6IEhUVFAvMS4xIDQwMSBBdXRob3JpemF0aW9uIFJlcXVpcmVk
DQpVc2VybmFtZSBmb3IgJ2h0dHA6Ly9naXQnOiBbSSBqdXN0IHByZXNzZWQgZW50ZXJdDQpQYXNz
d29yZCBmb3IgJ2h0dHA6Ly9naXQnOiBbZGl0dG9dDQoxNjoyNzoyOS45Mjg4NzIgaHR0cC5jOjUy
NCAgICAgICAgICAgICAgPT4gU2VuZCBoZWFkZXI6IEdFVCAvaW5mby9yZWZzP3NlcnZpY2U9Z2l0
LXVwbG9hZC1wYWNrIEhUVFAvMS4xDQoxNjoyNzoyOS45Mjk3ODcgaHR0cC5jOjUyNCAgICAgICAg
ICAgICAgPD0gUmVjdiBoZWFkZXI6IEhUVFAvMS4xIDQwMSBBdXRob3JpemF0aW9uIFJlcXVpcmVk
DQoNCihpZiBzb21lb25lIGVsc2Ugd2FudHMgdG8gcmVwbGljYXRlIHRoaXMsIGRlbGV0ZSA+L2Rl
di9udWxsIGJpdCANCmZyb20gSmVmZidzIHNoZWxsIHNuaXBwZXQpDQoNCg0K
