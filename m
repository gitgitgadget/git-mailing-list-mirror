Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FB1D2018A
	for <e@80x24.org>; Tue, 28 Jun 2016 14:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258AbcF1Oau (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 10:30:50 -0400
Received: from mailout.micron.com ([137.201.242.129]:33249 "EHLO
	mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752236AbcF1Oat (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 10:30:49 -0400
Received: from mail.micron.com (bowex36c.micron.com [137.201.84.132])
	by mailout.micron.com (8.14.4/8.14.6) with ESMTP id u5SEUl7b020073
	for <git@vger.kernel.org>; Tue, 28 Jun 2016 08:30:48 -0600
Received: from bowex17b.micron.com (137.201.21.210) by bowex36c.micron.com
 (137.201.84.132) with Microsoft SMTP Server (TLS) id 15.0.1178.4; Tue, 28 Jun
 2016 08:30:47 -0600
Received: from bowex17b.micron.com ([fe80::c4b6:ba92:bbc7:49e8]) by
 bowex17b.micron.com ([fe80::c4b6:ba92:bbc7:49e8%21]) with mapi id
 15.00.1178.000; Tue, 28 Jun 2016 08:30:47 -0600
From:	"Andy Falanga (afalanga)" <afalanga@micron.com>
To:	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: What's happening to the index
Thread-Topic: What's happening to the index
Thread-Index: AQHR0UmpYyKI5mtRV0y4jBNtBkclFA==
Date:	Tue, 28 Jun 2016 14:30:47 +0000
Message-ID: <57728A17.3010207@micron.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.201.84.23]
x-tm-as-product-ver: SMEX-11.0.0.4255-8.000.1202-22418.005
x-tm-as-result:	No--33.052200-0.000000-31
x-tm-as-user-approved-sender: Yes
x-tm-as-user-blocked-sender: No
x-mt-checkinternalsenderrule: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F451D34BE577DD45B7D7CF8E7CCBB384@micron.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 137.201.130.65
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

SGksDQoNCkknbSB1c2luZyBnaXQgdmVyc2lvbiAxLjguMy4xLiAgSSBoYXZlIGEgcHJvY2VzcyBm
b3IgYnVpbGRpbmcgUlBNcyBpbiBteSANCnJlcG9zaXRvcnkuICBUaGUgUlBNcyBhcmUgdmVyc2lv
bmVkIHVzaW5nIGEgImJ1aWxkIG51bWJlciIuIEluIG9yZGVyIHRvIA0KbWFpbnRhaW4gdW5pcXVl
bmVzcyBmb3IgdGhpcyBidWlsZCBudW1iZXIsIEkgaGF2ZSBzdG9yZWQgdGhpcyBudW1iZXIgdG8g
DQphIGZpbGUgd2hpY2ggZXhpc3RzIG9uIG9ubHkgYSB1bmlxdWUgYnJhbmNoLg0KDQpUaGUgYnVp
bGQgcHJvY2VzcywgZm9yIGFuIGFjdHVhbCByZWxlYXNlLCBpcyBpbnRlbmRlZCB0byBiZSBkb25l
IGJ5IA0KYnJhbmNoaW5nIG9uIGEgdGFnLiAgRHVyaW5nIHRoYXQgcHJvY2VzcywgYSBCQVNIIHNj
cmlwdCBpcyBjYWxsZWQgd2l0aCANCmNoZWNrcyBvdXQgInJwbSIsIGZldGNoZXMgdGhlIHJlcG8g
ZnJvbSByZW1vdGUsIG1lcmdlcyB3aXRoIG9yaWdpbi9ycG0sIA0KaW5jcmVtZW50cyB0aGUgbnVt
YmVyIGFuZCBwdXNoZXMgYmFjayB0byBvcmlnaW4uICBJdCB0aGVuIHJldHVybnMgdGhlIA0KYnJh
bmNoIHRvIHRoZSBvcmlnaW5hbCBicmFuY2ggaW4gd2hpY2ggdGhlIHNjcmlwdCB3YXMgY2FsbGVk
LiAgVGhlIG1ha2UgDQpyZWNpcGUgbG9va3MgbGlrZSB0aGlzOg0KDQoNCnJlbGVhc2U6DQogICAg
IG1ha2UgY2xlYW4NCiAgICAgY2QgLi4vLi4gICYmIC4uL3Rvb2xzL2luY3JlbG51bSAmJiBjZCAt
DQogICAgIGlmIFtbICQoVEFHKSA9IC4uLi4uLi4uLiBdXTsgdGhlbiBcDQogICAgICAgICBnaXQg
Y2hlY2tvdXQgLWIgcnBtX2J1aWxkXyQoVEFHKSAkKFRBRyk7IFwNCiAgICAgZmkNCiAgICAgbWFr
ZSBycG0gUlBNX0JVSUxEX05VTT0kKHNoZWxsIGdpdCBzaG93IHJwbTouL3JwbV9idWlsZF9udW0p
DQoNCkFmdGVyIHRoZSBsaW5lIGNhbGxpbmcgaW5jcmVsbnVtIGlzIGV4ZWN1dGVkLCBJIG9mdGVu
IGhhdmUgaXNzdWVzIHdpdGggDQptYWtlIHVuYWJsZSB0byBzcGF3biB0aGUgbmV4dCBjb21tYW5k
IGJlY2F1c2UgaXQgY2FuJ3QgcmVhZCB0aGUgY3VycmVudCANCmRpcmVjdG9yeSBpbmZvLiAgTWFr
ZSBzdG9wcyB3aXRoIGVycm9ycyBhbmQgSSdtIGRvbmUuICBJIGhhdmUgdGhlIGJyYW5jaCANCm5h
bWUgZGlzcGxheWVkIGluIG15IFBTMSBwcm9tcHQuICBJJ3ZlIG5vdGljZWQgdGhhdCwgd2hlbiBt
YWtlIGVycm9ycyBhdCANCnRoaXMgcG9pbnQsIHRoZSBicmFuY2ggaXNuJ3QgZGlzcGxheWVkLiAg
SXQncyBhcyBpZiB0aGUgaW5kZXggaGFzIGJlY29tZSANCnVuc3RhYmxlIChvciBzb21ldGhpbmcg
c2ltaWxhcikuICBJZiBJIGRvOiBjZCAuLiAmJiBjZCAtOyBhbGwgaXMgd2VsbC4NCg0KV2hhdCBp
cyB0aGUgcHJvYmxlbSAoSSdkIHJlYWxseSBsaWtlIHRvIHVuZGVyc3RhbmQpIGFuZCB3aGF0IG1p
Z2h0IEkgZG8gDQp0byBjb3JyZWN0IGl0Pw0KDQpBbmR5
