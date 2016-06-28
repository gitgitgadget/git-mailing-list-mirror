Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE4352018A
	for <e@80x24.org>; Tue, 28 Jun 2016 22:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbcF1Wt6 (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 18:49:58 -0400
Received: from mailout.micron.com ([137.201.242.129]:26049 "EHLO
	mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbcF1Wt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 18:49:58 -0400
Received: from mail.micron.com (bowex17a.micron.com [137.201.21.209])
	by mailout.micron.com (8.14.4/8.14.6) with ESMTP id u5SMnpN5015731;
	Tue, 28 Jun 2016 16:49:51 -0600
Received: from bowex17b.micron.com (137.201.21.210) by bowex17a.micron.com
 (137.201.21.209) with Microsoft SMTP Server (TLS) id 15.0.1178.4; Tue, 28 Jun
 2016 16:49:51 -0600
Received: from bowex17b.micron.com ([fe80::c4b6:ba92:bbc7:49e8]) by
 bowex17b.micron.com ([fe80::c4b6:ba92:bbc7:49e8%21]) with mapi id
 15.00.1178.000; Tue, 28 Jun 2016 16:49:51 -0600
From:	"Andy Falanga (afalanga)" <afalanga@micron.com>
To:	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
CC:	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's happening to the index
Thread-Topic: What's happening to the index
Thread-Index: AQHR0UmpYyKI5mtRV0y4jBNtBkclFJ/+/g1dgADitQA=
Date:	Tue, 28 Jun 2016 22:49:51 +0000
Message-ID: <5772FF0E.6030503@micron.com>
References: <57728A17.3010207@micron.com> <vpq60stuyv5.fsf@anie.imag.fr>
In-Reply-To: <vpq60stuyv5.fsf@anie.imag.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.201.20.7]
x-tm-as-product-ver: SMEX-12.0.0.1220-8.000.1202-22418.005
x-tm-as-result:	No--44.042600-0.000000-31
x-tm-as-matchedid: 147014-150567-701625-704425-700685-700075-139010-703731-7
	01053-707451-700057-706737-702020-700970-711139-187236-702057-701461-188019
	-705861-701005-700274-707760-701914-707078-136070-707119-701594-701590-7006
	93-703788-700008-188198-709584-863828-706891-148004-148133-20043-42000-42003
x-tm-as-user-approved-sender: Yes
x-tm-as-user-blocked-sender: No
x-mt-checkinternalsenderrule: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E66ED5E837950C4C9B416ABBF5B71437@micron.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 137.201.130.65
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

T24gMDYvMjgvMjAxNiAwOToxNyBBTSwgTWF0dGhpZXUgTW95IHdyb3RlOg0KPiAiQW5keSBGYWxh
bmdhIChhZmFsYW5nYSkiIDxhZmFsYW5nYUBtaWNyb24uY29tPiB3cml0ZXM6DQo+DQo+PiBBZnRl
ciB0aGUgbGluZSBjYWxsaW5nIGluY3JlbG51bSBpcyBleGVjdXRlZCwgSSBvZnRlbiBoYXZlIGlz
c3VlcyB3aXRoDQo+PiBtYWtlIHVuYWJsZSB0byBzcGF3biB0aGUgbmV4dCBjb21tYW5kIGJlY2F1
c2UgaXQgY2FuJ3QgcmVhZCB0aGUgY3VycmVudA0KPj4gZGlyZWN0b3J5IGluZm8uDQo+IFRoaXMg
bWF5IGhhcHBlbiBpZiB5b3UgZGVsZXRlIHRoZSBjdXJyZW50IGRpcmVjdG9yeSwgZXZlbiBpZiB5
b3VyDQo+IHJlLWNyZWF0ZSBpdCBhZnRlcndhcmRzLiBGb3IgZXhhbXBsZToNCj4NCj4gL3RtcC90
ZXN0JCBybSAtZnIgL3RtcC90ZXN0ICYmIG1rZGlyIC90bXAvdGVzdA0KPiAvdG1wL3Rlc3QkIHRv
dWNoIGZvbw0KPiB0b3VjaDogY2Fubm90IHRvdWNoIOKAmGZvb+KAmTogTm8gc3VjaCBmaWxlIG9y
IGRpcmVjdG9yeQ0KPiAvdG1wL3Rlc3QkIGNkIC90bXAvdGVzdA0KPiAvdG1wL3Rlc3QkIHRvdWNo
IGZvbw0KPiAvdG1wL3Rlc3QkDQo+DQo+IFRoaXMgaXMgdW5yZWxhdGVkIGZyb20gR2l0LCBidXQg
bWF5YmUgeW91IGFza2VkIEdpdCB0byBkZWxldGUgYQ0KPiBkaXJlY3RvcnkgKGJ5IHN3aXRjaGlu
ZyB0byBhIGJyYW5jaCB3aGljaCBkb2Vzbid0IGNvbnRhaW4gYSBkaXJlY3RvcnkNCj4gZm9yIGV4
YW1wbGUpLg0KPg0KPj4gSWYgSSBkbzogY2QgLi4gJiYgY2QgLTsgYWxsIGlzIHdlbGwuDQo+IFRo
aXMgaXMgYSB0eXBpY2FsIHN5bXB0b20gb2YgdGhlIGlzc3VlIGFib3ZlLg0KPg0KVGhhbmsgeW91
IGZvciB0aGUgaW5zaWdodDogdmVyeSBpbnRlcmVzdGluZy4gIEFmdGVyIGFza2luZyBhbm90aGVy
IA0KY29sbGVhZ3VlIGhvdyBoZSBzb2x2ZWQgdGhpcyBpc3N1ZSwgSSd2ZSByZS13cml0dGVuIG15
IGluY3JlbG51bSBzY3JpcHQgDQp0bywgaW5zdGVhZCBvZiB3b3JraW5nIHdpdGhpbiBteSB3b3Jr
aW5nIHRyZWUsIGNsb25lIGEgdGVtcG9yYXJ5IG9mIHRoaXMgDQpvbmUgYnJhbmNoIG9ubHkuICBU
aGVuLCBpdCBpbmNyZW1lbnRzIHRoZSBudW1iZXIgYW5kIHB1c2hlcyBiYWNrIHRvIHRoZSANCm9y
aWdpbi4gIE9uY2UgY29tcGxldGVkLCB0aGUgdGVtcG9yYXJ5IGNsb25lIGlzIGRlbGV0ZWQuDQoN
ClRoZSBzdHJhbmdlIHRoaW5nIG5vdyBpcywgYWZ0ZXIgdGhlIHNjcmlwdCBleGl0cywgSSB0aGVu
IGNhbGwgImdpdCANCmZldGNoIiBpbiB0aGUgcmVjaXBlLiAgSSBjYW4gc2VlIGZyb20gdGhlIG91
dHB1dCBvZiBtYWtlIHRoYXQgdGhlIHJlbW90ZSANCmRiIGlzIGZldGNoZWQuICBIb3dldmVyLCB3
aGVuIEkgY2FsbCAiZ2l0IHNob3cgDQpvcmlnaW4vcnBtOnBhdGgvdG8vcnBtX2J1aWxkX251bSIg
ZnJvbSB0aGUgbWFrZWZpbGUgSSBnZXQgdGhlICpwcmV2aW91cyogDQpudW1iZXIuICBZZXQsIGFz
IHNvb24gYXMgdGhlIG1ha2UgcHJvY2VzcyBleGl0cywgSSBjYWxsICJnaXQgc2hvdyANCm9yaWdp
bi9ycG06cGF0aC90by9ycG1fYnVpbGRfbnVtIiBhbmQgaXQgc2hvd3MgdGhlIGNvcnJlY3QgbnVt
YmVyISAgV2hhdCANCmdpdmVzPyAgSXMgdGhlcmUgc29tZSBzb3J0IG9mIHN0cmFuZ2UgZmlsZSBj
YWNoaW5nIHRoYXQgaGFwcGVuaW5nIHdoZW4gDQptYWtlIHN0YXJ0cyB0aGF0LCBhbHRob3VnaCB0
aGUgbG9jYWwgZGIgaXMgdXBkYXRlZCwgSSBkb24ndCBnZXQgd2hhdCBJJ20gDQphZnRlcj8NCg0K
QW5keQ==
