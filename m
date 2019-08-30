Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B07331F4B9
	for <e@80x24.org>; Fri, 30 Aug 2019 13:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfH3Nw1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 09:52:27 -0400
Received: from mxo1.nje.dmz.twosigma.com ([208.77.214.160]:56287 "EHLO
        mxo1.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbfH3Nw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 09:52:27 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Aug 2019 09:52:27 EDT
Received: from localhost (localhost [127.0.0.1])
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTP id 46KglH5rTYz7t8s;
        Fri, 30 Aug 2019 13:47:23 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1jV8VeUtQY67; Fri, 30 Aug 2019 13:47:23 +0000 (GMT)
Received: from exmbdft5.ad.twosigma.com (exmbdft5.ad.twosigma.com [172.22.1.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTPS id 46KglH57w0z3wZ3;
        Fri, 30 Aug 2019 13:47:23 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft5.ad.twosigma.com (172.22.1.56) with Microsoft SMTP Server (TLS) id
 15.0.1365.1; Fri, 30 Aug 2019 13:47:23 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1365.000; Fri, 30 Aug 2019 13:47:23 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     =?utf-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>
CC:     Git Mailing List <git@vger.kernel.org>
Subject: RE: [PATCH] clarify documentation for remote helpers
Thread-Topic: [PATCH] clarify documentation for remote helpers
Thread-Index: AQHVXufUGlQGo8OOjkuzhV2FyVjf1acTtGxw
Date:   Fri, 30 Aug 2019 13:47:23 +0000
Message-ID: <88d9063060644dd99122bf0933f23fa9@exmbdft7.ad.twosigma.com>
References: <20190829210301.18467-1-dturner@twosigma.com>
 <CAN0heSosCnn5msMX18YPwrKJzWkSWptWSFRunQdLE7T7Lc4-OA@mail.gmail.com>
In-Reply-To: <CAN0heSosCnn5msMX18YPwrKJzWkSWptWSFRunQdLE7T7Lc4-OA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.189.105]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SSB3YXMgY29uZnVzZWQsIGJlY2F1c2UgSSByZWFkICJhIGZpbGUgdW5kZXIgR0lUX0RJUi9vYmpl
Y3RzL3BhY2siIHRvIG1lYW4gImp1c3QgdGhlIGZpbGVuYW1lIi4gIFNvbWUgb2YgdGhlIHRoaW5n
cyB0aGF0IGRlYWwgd2l0aCBwYWNrcyB0YWtlIGp1c3QgdGhlIGZpbGVuYW1lIChlLmcuIC0ta2Vl
cC1wYWNrIGZvciBnaXQgcmVwYWNrKS4gIEknbGwgZml4IHRoZSB1bmRlciB1bmRlciBhbmQgYWRk
ICQsIGJ1dCBJIGRvIHdhbnQgdG8gY2xhcmlmeSB0aGF0IGl0J3MgdGhlIGZ1bGwgcGF0aC4NCg0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJ0aW4gw4VncmVuIDxtYXJ0
aW4uYWdyZW5AZ21haWwuY29tPg0KPiBTZW50OiBGcmlkYXksIEF1Z3VzdCAzMCwgMjAxOSAxMjow
MyBBTQ0KPiBUbzogRGF2aWQgVHVybmVyIDxEYXZpZC5UdXJuZXJAdHdvc2lnbWEuY29tPg0KPiBD
YzogR2l0IE1haWxpbmcgTGlzdCA8Z2l0QHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSF0gY2xhcmlmeSBkb2N1bWVudGF0aW9uIGZvciByZW1vdGUgaGVscGVycw0KPiANCj4g
T24gVGh1LCAyOSBBdWcgMjAxOSBhdCAyMzowNiwgRGF2aWQgVHVybmVyIDxkdHVybmVyQHR3b3Np
Z21hLmNvbT4gd3JvdGU6DQo+IA0KPiA+IC1PcHRpb25hbGx5IG1heSBvdXRwdXQgYSAnbG9jayA8
ZmlsZT4nIGxpbmUgaW5kaWNhdGluZyBhIGZpbGUgdW5kZXINCj4gPiAtR0lUX0RJUi9vYmplY3Rz
L3BhY2sgd2hpY2ggaXMga2VlcGluZyBhIHBhY2sgdW50aWwgcmVmcyBjYW4gYmUNCj4gPiAtc3Vp
dGFibHkgdXBkYXRlZC4NCj4gPiArT3B0aW9uYWxseSBtYXkgb3V0cHV0IGEgJ2xvY2sgPGZpbGU+
JyBsaW5lIGluZGljYXRpbmcgdGhlIGZ1bGwgcGF0aA0KPiA+ICtvZiBhIGZpbGUgdW5kZXIgdW5k
ZXIgR0lUX0RJUi9vYmplY3RzL3BhY2sgd2hpY2ggaXMga2VlcGluZyBhIHBhY2sNCj4gPiArdW50
aWwgcmVmcyBjYW4gYmUgc3VpdGFibHkgdXBkYXRlZC4gIFRoZSBwYXRoIG11c3QgZW5kIHdpdGgg
Ii5rZWVwIi4NCj4gDQo+ICJ1bmRlciB1bmRlciIuDQo+IA0KPiBBbHNvIC0tIGFuZCBJIHJlYWxp
emUgdGhpcyBpcyBub3RoaW5nIG5ldyBpbiB5b3VyIHBhdGNoIC0tICJHSVRfRElSIg0KPiBzaG91
bGQgYmUgcHJlZml4ZWQgd2l0aCBhICckJyBhbmQgdGhhdCB3aG9sZSBwYXRoIHdyYXBwZWQgaW4g
YmFja3RpY2tzIHNvIGl0DQo+IGdldHMgbW9ub3NwYWNlZC4gSW4gdG90YWwsIG15IHN1Z2dlc3Rp
b24gd291bGQgYmUNCj4gDQo+IC0rYSBmaWxlIHVuZGVyIHVuZGVyIEdJVF9ESVIvb2JqZWN0cy9w
YWNrIHdoaWNoIGlzIGtlZXBpbmcgYSBwYWNrIHVudGlsDQo+ICsrYSBmaWxlIHVuZGVyIGAkR0lU
X0RJUi9vYmplY3RzL3BhY2tgIHdoaWNoIGlzIGtlZXBpbmcgYSBwYWNrIHVudGlsDQo+IA0KPiBX
aGV0aGVyIHdoYXQgeW91J3JlIHNheWluZyBpcyBhY3R1YWxseSAqdHJ1ZSosIHNvcnJ5LCBubyBp
ZGVhLiBJIGp1c3QgaGF2ZSB0aG9zZQ0KPiBuaXRzIGFib3ZlIHRvIG9mZmVyLg0KPiANCj4gTWFy
dGluDQo=
