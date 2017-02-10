Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01BB61FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 21:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752385AbdBJVbD (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 16:31:03 -0500
Received: from mxo1.dft.dmz.twosigma.com ([208.77.212.183]:59097 "EHLO
        mxo1.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751767AbdBJVbC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 16:31:02 -0500
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Feb 2017 16:31:02 EST
Received: from localhost (localhost [127.0.0.1])
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTP id 3039D10012C;
        Fri, 10 Feb 2017 21:23:16 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2nUpBy3LU9Na; Fri, 10 Feb 2017 21:23:16 +0000 (GMT)
Received: from exmbdft6.ad.twosigma.com (exmbdft6.ad.twosigma.com [172.22.1.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTPS id 1D1F080035;
        Fri, 10 Feb 2017 21:23:16 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft6.ad.twosigma.com (172.22.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Fri, 10 Feb 2017 21:23:15 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%23]) with mapi id
 15.00.1263.000; Fri, 10 Feb 2017 21:23:15 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Jeff King' <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: RE: [PATCH v5] gc: ignore old gc.log files
Thread-Topic: [PATCH v5] gc: ignore old gc.log files
Thread-Index: AQHSg+LED5COMCeX/kuoXyGkJ5bBWKFiv8tw
Date:   Fri, 10 Feb 2017 21:23:15 +0000
Message-ID: <069b229470204235b7155b33da52421c@exmbdft7.ad.twosigma.com>
References: <20170210205931.5348-1-dturner@twosigma.com>
 <20170210211510.zbustcl5ickfiqdy@sigill.intra.peff.net>
In-Reply-To: <20170210211510.zbustcl5ickfiqdy@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.15]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVmZiBLaW5nIFttYWls
dG86cGVmZkBwZWZmLm5ldF0NCj4gU2VudDogRnJpZGF5LCBGZWJydWFyeSAxMCwgMjAxNyA0OjE1
IFBNDQo+IFRvOiBEYXZpZCBUdXJuZXIgPERhdmlkLlR1cm5lckB0d29zaWdtYS5jb20+DQo+IENj
OiBnaXRAdmdlci5rZXJuZWwub3JnOyBwY2xvdWRzQGdtYWlsLmNvbTsgSnVuaW8gQyBIYW1hbm8N
Cj4gPGdpdHN0ZXJAcG9ib3guY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1XSBnYzogaWdu
b3JlIG9sZCBnYy5sb2cgZmlsZXMNCj4gDQo+ID4gQEAgLTc2LDEwICs3OCwzMCBAQCBzdGF0aWMg
dm9pZCBnaXRfY29uZmlnX2RhdGVfc3RyaW5nKGNvbnN0IGNoYXINCj4gPiAqa2V5LCBjb25zdCBj
aGFyICoqb3V0cHV0KSAgc3RhdGljIHZvaWQgcHJvY2Vzc19sb2dfZmlsZSh2b2lkKSAgew0KPiA+
ICAJc3RydWN0IHN0YXQgc3Q7DQo+ID4gLQlpZiAoIWZzdGF0KGdldF9sb2NrX2ZpbGVfZmQoJmxv
Z19sb2NrKSwgJnN0KSAmJiBzdC5zdF9zaXplKQ0KPiA+ICsJaWYgKGZzdGF0KGdldF9sb2NrX2Zp
bGVfZmQoJmxvZ19sb2NrKSwgJnN0KSkgew0KPiA+ICsJCS8qDQo+ID4gKwkJICogUGVyaGFwcyB0
aGVyZSB3YXMgYW4gaS9vIGVycm9yIG9yIGFub3RoZXINCj4gPiArCQkgKiB1bmxpa2VseSBzaXR1
YXRpb24uICBUcnkgdG8gbWFrZSBhIG5vdGUgb2YNCj4gPiArCQkgKiB0aGlzIGluIGdjLmxvZyBh
bG9uZyB3aXRoIGFueSBleGlzdGluZw0KPiA+ICsJCSAqIG1lc3NhZ2VzLg0KPiA+ICsJCSAqLw0K
PiA+ICsJCUZJTEUgKmZwOw0KPiA+ICsJCWludCBzYXZlZF9lcnJubyA9IGVycm5vOw0KPiA+ICsJ
CWZwID0gZmRvcGVuKGxvZ19sb2NrLnRlbXBmaWxlLmZkLCAiYSIpOw0KPiANCj4gV2UgdXN1YWxs
eSB1c2UgeGZkb3BlbigpIHRvIGhhbmRsZSAodW5saWtlbHkpIGVycm9ycyByYXRoZXIgdGhhbiBz
ZWdmYXVsdGluZy4gIEJ1dA0KPiBJIHRoaW5rIHlvdSdkIGFjdHVhbGx5IHdhbnQgZmRvcGVuX2xv
Y2tfZmlsZSgpLCB3aGljaCBhdHRhY2hlcyB0aGUgZmQgdG8gdGhlDQo+IHRlbXBmaWxlIGZvciBm
bHVzaGluZyBhbmQgY2xlYW51cCBwdXJwb3Nlcy4NCj4gDQo+IFRoYXQgc2FpZCwgSSdtIG5vdCBz
dXJlIEkgdW5kZXJzdGFuZCB3aHkgeW91J3JlIG9wZW5pbmcgYSBuZXcgc3RkaW8gZmlsZWhhbmRs
ZS4NCj4gV2Uga25vdyB0aGF0IHN0ZGVyciBhbHJlYWR5IHBvaW50cyB0byBvdXIgbG9nZmlsZSAo
dGhhdCdzIGhvdyBjb250ZW50IGdldHMgdGhlcmUNCj4gaW4gdGhlIGZpcnN0IHBsYWNlKS4gSWYg
dGhlcmUncyBhIHByb2JsZW0gd2l0aCB0aGUgZmlsZSBvciB0aGUgZGVzY3JpcHRvciwgb3Blbmlu
ZyBhDQo+IG5ldyBmaWxlaGFuZGxlIGFyb3VuZCB0aGUgc2FtZSBkZXNjcmlwdG9yIHdvbid0IGhl
bHAuDQo+IA0KPiBTcGVha2luZyBvZiBzdGRlcnIsIEkgd29uZGVyIGlmIHRoaXMgZnVuY3Rpb24g
c2hvdWxkIGJlIGNhbGxpbmcNCj4gZmZsdXNoKHN0ZGVycikgYmVmb3JlIGxvb2tpbmcgYXQgdGhl
IGZzdGF0IHJlc3VsdC4gVGhlcmUgY291bGQgYmUgY29udGVudHMgYnVmZmVyZWQNCj4gdGhlcmUg
dGhhdCBoYXZlbid0IGJlZW4gd3JpdHRlbiBvdXQgeWV0IChub3QgZnJvbSBjaGlsZCBwcm9jZXNz
ZXMsIGJ1dCBwZXJoYXBzDQo+IG9uZXMgd3JpdHRlbiBpbiB0aGlzIHByb2Nlc3MgaXRzZWxmKS4N
Cj4gUHJvYmFibHkgdW5saWtlbHkgaW4gcHJhY3RpY2UsIHNpbmNlIHN0ZGVyciBpcyB0eXBpY2Fs
bHkgdW5idWZmZXJlZCBieSBkZWZhdWx0Lg0KDQpQcm9jZXNzX2xvZ19maWxlX2F0X2V4aXQgY2Fs
bHMgZmZsdXNoLiAgV2lsbCBmaXggdGhlIG90aGVyLg0K
