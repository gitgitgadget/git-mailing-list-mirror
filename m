Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DECA2018E
	for <e@80x24.org>; Thu, 25 Aug 2016 18:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754087AbcHYSdf (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 14:33:35 -0400
Received: from smtp5.opentext.com ([205.211.178.41]:52834 "EHLO
        smtp5.opentext.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753453AbcHYSdd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 14:33:33 -0400
Received: from otwlxg12.opentext.net (otwlxg12.opentext.net [10.2.103.213])
        by wldmzsvc05.dmz.opentext.com (8.14.4/8.14.4) with ESMTP id u7PIXvto031320
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 25 Aug 2016 14:33:57 -0400
Received: from OTWLXG13.opentext.net (10.2.103.163) by otwlxg12.opentext.net
 (10.2.103.213) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 25 Aug
 2016 14:33:07 -0400
Received: from OTWLXG21.opentext.net ([169.254.3.76]) by otwlxg13.opentext.net
 ([10.2.103.163]) with mapi id 14.03.0294.000; Thu, 25 Aug 2016 14:33:06 -0400
From:   David McGough <dmcgough@opentext.com>
To:     Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Smart HTTP push permissions failure
Thread-Topic: Smart HTTP push permissions failure
Thread-Index: AdH9UAqG/VuKfPWxRkeGHFrHOKkKBgA+oBEAAC0ebVA=
Date:   Thu, 25 Aug 2016 18:33:06 +0000
Message-ID: <89CBBBEBEE33F5469A9FA456B5F70625CCDC7A1B@otwlxg21.opentext.net>
References: <89CBBBEBEE33F5469A9FA456B5F70625CCDB9BEB@otwlxg20.opentext.net>
 <20160824170028.y4kr5jchsnb5xdge@sigill.intra.peff.net>
In-Reply-To: <20160824170028.y4kr5jchsnb5xdge@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.2.111.33]
X-TM-AS-Product-Ver: SMEX-11.0.0.1191-8.000.1202-22534.005
X-TM-AS-Result: No--16.751300-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmsgeW91IGZvciB5b3VyIHJlcGx5IEplZmYuICBJIGhhdmUgbW92ZWQgb24gdG8gaW5zdGFs
bGluZyBHaXRMYWIuICBJdCBoYXMgYmVlbiBhIHN1Y2Nlc3Mgc28gZmFyLg0KDQpUaGFua3MsDQpE
YXZlDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKZWZmIEtpbmcgW21haWx0
bzpwZWZmQHBlZmYubmV0XSANClNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDI0LCAyMDE2IDE6MDAg
UE0NClRvOiBEYXZpZCBNY0dvdWdoIDxkbWNnb3VnaEBvcGVudGV4dC5jb20+DQpDYzogZ2l0QHZn
ZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFNtYXJ0IEhUVFAgcHVzaCBwZXJtaXNzaW9ucyBm
YWlsdXJlDQoNCk9uIFR1ZSwgQXVnIDIzLCAyMDE2IGF0IDAzOjQ1OjMzUE0gKzAwMDAsIERhdmlk
IE1jR291Z2ggd3JvdGU6DQoNCj4gV2hlbiBJIHRyeSB0byBwdXNoIHRvIHRoZSBzZXJ2ZXIgSSBn
ZXQgdGhpcyBtZXNzYWdlOg0KPiByZW1vdGU6IGVycm9yOiBpbnN1ZmZpY2llbnQgcGVybWlzc2lv
biBmb3IgYWRkaW5nIGFuIG9iamVjdCB0byANCj4gcmVwb3NpdG9yeSBkYXRhYmFzZSAuL29iamVj
dHMNCj4gcmVtb3RlOiBmYXRhbDogZmFpbGVkIHRvIHdyaXRlIG9iamVjdA0KPiBbLi4uXQ0KPiBT
byBJIGFtIHByZXR0eSBjb25mdXNlZCBhYm91dCB3aGF0IHRoZSBpc3N1ZS4gIFdoaWNoIE9TIHVz
ZXIgaXMgZ2l0IA0KPiB1c2luZyB0byB3cml0ZSB0aGUgZmlsZXM/ICBJIGhvcGUgc29tZWJvZHkg
Y2FuIGhlbHAgbWUgdW5kZXJzdGFuZCB3aHkgDQo+IHRoZSBwcm9qZWN0IGNhbm5vdCBiZSBwdXNo
ZWQgdG8gdGhlIGdpdCBzZXJ2ZXIuDQoNCkZvciBhIHNtYXJ0LWh0dHAgcHVzaCwgaXQgd2lsbCBi
ZSB3aGF0ZXZlciB1c2VyIHRoZSB3ZWIgc2VydmVyIGV4ZWNzIHRoZSBDR0kgYXMuIFNvIEknZCB0
aGluayAiYXBhY2hlIiB3b3VsZCBiZSB0aGUgZGVmYXVsdCwgYnV0IGl0J3MgcG9zc2libGUgdGhh
dCBpdCBydW5zIENHSXMgYXMgYSBkaWZmZXJlbnQgdXNlciwgZGVwZW5kaW5nIG9uIHlvdXIgY29u
ZmlnLg0KDQpPbmUgcG9zc2liaWxpdHkgbWF5IGJlIHRvIGFkZCBhIHNpbXBsZSBzaGVsbCBzY3Jp
cHQgQ0dJIHRoYXQgZG9lcyBzb21ldGhpbmcgbGlrZToNCg0KICAjIS9iaW4vc2gNCiAgZWNobyAi
Q29udGVudC10eXBlOiB0ZXh0L3BsYWluIg0KICBlY2hvDQogIGlkDQoNCmp1c3QgdG8gc2VlIHdo
YXQncyBoYXBwZW5pbmcuDQoNCkJhc2VkIG9uIHRoZSBkYXRhIHlvdSBzaG93ZWQsIGhlcmUgYXJl
IHNvbWUgd2lsZCBwb3NzaWJpbGl0aWVzIEkgY2FuIHRoaW5rIG9mOg0KDQogIC0gdGhlIENHSSBy
dW5zIGFzICJhcGFjaGUiLCBidXQgeW91ciBmaWxlcyBhcmUgb3duZWQgYnkgImdpdCIuDQogICAg
ImFwYWNoZSIgaXMgaW4gdGhlICJzdGFmZiIgZ3JvdXAsIGFuZCB0aGUgZGlyZWN0b3JpZXMgYWxs
IGhhdmUgd3JpdGUNCiAgICBwZXJtaXNzaW9uIGZvciB0aGF0IGdyb3VwLiBCdXQgYXJlIHdlIHN1
cmUgdGhhdCBhcGFjaGUgZG9lcyBub3Qgc2hlZA0KICAgIGFueSBncm91cCBwZXJtaXNzaW9ucyB3
aGVuIHJ1bm5pbmcgYSBDR0k/IFRoZSAiaWQiIHNjcmlwdCBhYm92ZQ0KICAgIHNob3VsZCBob3Bl
ZnVsbHkgc2hvdyB0aGF0Lg0KDQogIC0gWW91IG1lbnRpb25lZCBDZW50T1MuIEl0IGhhcyBiZWVu
IGEgd2hpbGUgc2luY2UgSSBkZWFsdCB3aXRoIFJIRUwNCiAgICBhbmQgaXRzIGRlcml2YXRpdmVz
LCBidXQgSSB0aGluayBzZWxpbnV4IGlzIHR1cm5lZCBvbiBieSBkZWZhdWx0DQogICAgdGhlcmUu
IElzIGl0IHBvc3NpYmxlIHRoYXQgdGhlIHdlYnNlcnZlciBydW5zIGluIGFuIHNlbGludXggcHJv
ZmlsZQ0KICAgIHRoYXQgZG9lcyBub3QgYWxsb3cgd3JpdGluZyB0byB0aGUgcmVwb3NpdG9yeSBk
aXJlY3Rvcnk/DQoNCiAgICBJIGRvbid0IHJlY2FsbCB0aGUgc3BlY2lmaWNzIG9mIGRlYnVnZ2lu
ZyBzZWxpbnV4IHByb2JsZW1zLCBidXQNCiAgICB0aGVyZSBtYXkgYmUgbG9ncyB0aGVyZS4NCg0K
U29ycnkgdGhvc2UgYXJlIGp1c3Qgc3RhYnMgaW4gdGhlIGRhcmssIGJ1dCBJIGRvbid0IHNlZSBh
bnl0aGluZyBlbHNlIG9idmlvdXNseSB3cm9uZyB3aXRoIHdoYXQgeW91J3ZlIHBvc3RlZC4NCg0K
LVBlZmYNCg==
