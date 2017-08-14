Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DEFD20899
	for <e@80x24.org>; Mon, 14 Aug 2017 16:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753312AbdHNQFK (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 12:05:10 -0400
Received: from mxo2.nje.dmz.twosigma.com ([208.77.214.162]:53441 "EHLO
        mxo2.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752629AbdHNQFH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 12:05:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTP id 5FEB110004C;
        Mon, 14 Aug 2017 16:05:06 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id khaNFi910ohp; Mon, 14 Aug 2017 16:05:06 +0000 (GMT)
Received: from exmbdft6.ad.twosigma.com (exmbdft6.ad.twosigma.com [172.22.1.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTPS id 4E68E8002E;
        Mon, 14 Aug 2017 16:05:06 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft6.ad.twosigma.com (172.22.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Mon, 14 Aug 2017 16:05:06 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Mon, 14 Aug 2017 16:05:05 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Howard Chu' <hyc@symas.com>,
        "spearce@spearce.org" <spearce@spearce.org>
CC:     "avarab@gmail.com" <avarab@gmail.com>,
        "ben.alex@acegi.com.au" <ben.alex@acegi.com.au>,
        "dborowitz@google.com" <dborowitz@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "mhagger@alum.mit.edu" <mhagger@alum.mit.edu>,
        "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "stoffe@gmail.com" <stoffe@gmail.com>
Subject: RE: reftable [v5]: new ref storage format
Thread-Topic: reftable [v5]: new ref storage format
Thread-Index: AQHTDtTwr9VfHt00/0GyzPPbJU6DJaJ38O4AgAALW4CAAPyfgIAC6/WAgAfvwYCAADqpgA==
Date:   Mon, 14 Aug 2017 16:05:05 +0000
Message-ID: <4c1c1fc9904f4678823b6c3054c02b4d@exmbdft7.ad.twosigma.com>
References: <CAJo=hJsEaKH40WnhxqvkASpiXnV8ipc+b1zrZ9VEjqRjpJ17Qg@mail.gmail.com>
 <ee8f70bd-6f9e-3fb6-67be-ba26b6d5bf16@symas.com>
 <576a2361-1a3d-4bb2-1d31-f095f9e3c708@symas.com>
In-Reply-To: <576a2361-1a3d-4bb2-1d31-f095f9e3c708@symas.com>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIb3dhcmQgQ2h1IFttYWlsdG86
aHljQHN5bWFzLmNvbV0NCj4gU2VudDogTW9uZGF5LCBBdWd1c3QgMTQsIDIwMTcgODozMSBBTQ0K
PiBUbzogc3BlYXJjZUBzcGVhcmNlLm9yZw0KPiBDYzogRGF2aWQgVHVybmVyIDxEYXZpZC5UdXJu
ZXJAdHdvc2lnbWEuY29tPjsgYXZhcmFiQGdtYWlsLmNvbTsNCj4gYmVuLmFsZXhAYWNlZ2kuY29t
LmF1OyBkYm9yb3dpdHpAZ29vZ2xlLmNvbTsgZ2l0QHZnZXIua2VybmVsLm9yZzsNCj4gZ2l0c3Rl
ckBwb2JveC5jb207IG1oYWdnZXJAYWx1bS5taXQuZWR1OyBwZWZmQHBlZmYubmV0Ow0KPiBzYmVs
bGVyQGdvb2dsZS5jb207IHN0b2ZmZUBnbWFpbC5jb20NCj4gU3ViamVjdDogUmU6IHJlZnRhYmxl
IFt2NV06IG5ldyByZWYgc3RvcmFnZSBmb3JtYXQNCj4gDQo+IEhvd2FyZCBDaHUgd3JvdGU6DQo+
ID4gVGhlIHByaW1hcnkgaXNzdWUgd2l0aCB1c2luZyBMTURCIG92ZXIgTkZTIGlzIHdpdGggcGVy
Zm9ybWFuY2UuIEFsbA0KPiA+IHJlYWRzIGFyZSBwZXJmb3JtZWQgdGhydSBhY2Nlc3NlcyBvZiBt
YXBwZWQgbWVtb3J5LCBhbmQgaW4gZ2VuZXJhbCwNCj4gPiBORlMgaW1wbGVtZW50YXRpb25zIGRv
bid0IGNhY2hlIG1tYXAnZCBwYWdlcy4gSSBiZWxpZXZlIHRoaXMgaXMgYQ0KPiA+IGNvbnNlcXVl
bmNlIG9mIHRoZSBmYWN0IHRoYXQgdGhleSBhbHNvIGNhbid0IGd1YXJhbnRlZSBjYWNoZQ0KPiA+
IGNvaGVyZW5jZSwgc28gdGhlIG9ubHkgd2F5IGZvciBhbiBORlMgY2xpZW50IHRvIHNlZSBhIHdy
aXRlIGZyb20NCj4gPiBhbm90aGVyIE5GUyBjbGllbnQgaXMgYnkgYWx3YXlzIHJlZmV0Y2hpbmcg
cGFnZXMgd2hlbmV2ZXIgdGhleSdyZSBhY2Nlc3NlZC4NCj4gDQo+ID4gTE1EQidzIHJlYWQgbG9j
ayBtYW5hZ2VtZW50IGFsc28gd291bGRuJ3QgcGVyZm9ybSB3ZWxsIG92ZXIgTkZTOyBpdA0KPiA+
IGFsc28gdXNlcyBhbiBtbWFwJ2QgZmlsZS4gT24gYSBsb2NhbCBmaWxlc3lzdGVtIExNREIgcmVh
ZCBsb2NrcyBhcmUNCj4gPiB6ZXJvIGNvc3Qgc2luY2UgdGhleSBqdXN0IGF0b21pY2FsbHkgdXBk
YXRlIGEgd29yZCBpbiB0aGUgbW1hcC4gT3Zlcg0KPiA+IE5GUywgZWFjaCB1cGRhdGUgdG8gdGhl
IG1tYXAgd291bGQgYWxzbyByZXF1aXJlIGFuIG1zeW5jKCkgdG8NCj4gPiBwcm9wYWdhdGUgdGhl
IGNoYW5nZSBiYWNrIHRvIHRoZSBzZXJ2ZXIuIFRoaXMgd291bGQgc2VyaW91c2x5IGxpbWl0DQo+
ID4gdGhlIHNwZWVkIHdpdGggd2hpY2ggcmVhZCB0cmFuc2FjdGlvbnMgbWF5IGJlIG9wZW5lZCBh
bmQgY2xvc2VkLg0KPiA+IChPcmRpbmFyaWx5IG9wZW5pbmcgYW5kIGNsb3NpbmcgYSByZWFkIHR4
biBjYW4gYmUgZG9uZSB3aXRoIHplcm8NCj4gPiBzeXN0ZW0gY2FsbHMuKQ0KPiANCj4gQWxsIHRo
YXQgYXNpZGUsIHdlIGNvdWxkIHNpbXBseSBhZGQgYW4gRVhDTFVTSVZFIG9wZW4tZmxhZyB0byBM
TURCLCBhbmQNCj4gcHJldmVudCBtdWx0aXBsZSBwcm9jZXNzZXMgZnJvbSB1c2luZyB0aGUgREIg
Y29uY3VycmVudGx5LiBJbiB0aGF0IGNhc2UsDQo+IG1haW50YWluaW5nIGNvaGVyZW5jZSB3aXRo
IG90aGVyIE5GUyBjbGllbnRzIGlzIGEgbm9uLWlzc3VlLiBJdCBzdHJpa2VzIG1lIHRoYXQgZ2l0
DQo+IGRvZXNuJ3QgcmVxdWlyZSBjb25jdXJyZW50IG11bHRpLXByb2Nlc3MgYWNjZXNzIGFueXdh
eSwgYW5kIGFueSBwYXJ0aWN1bGFyDQo+IHByb2Nlc3Mgd291bGQgb25seSB1c2UgdGhlIERCIGZv
ciBhIHNob3J0IHRpbWUgYmVmb3JlIGNsb3NpbmcgaXQgYW5kIGdvaW5nIGF3YXkuDQoNCkdpdCwg
aW4gZ2VuZXJhbCwgZG9lcyByZXF1aXJlIGNvbmN1cnJlbnQgbXVsdGktcHJvY2VzcyBhY2Nlc3Ms
IGRlcGVuZGluZyBvbiB3aGF0IA0KdGhhdCBtZWFucy4NCg0KRm9yIGV4YW1wbGUsIGEgcG9zdC1y
ZWNlaXZlIGhvb2sgbWlnaHQgY2FsbCBzb21lIGdpdCBjb21tYW5kIHdoaWNoIG9wZW5zIHRoZSAN
CnJlZiBkYXRhYmFzZS4gIFRoaXMgbWVhbnMgdGhhdCBnaXQgcmVjZWl2ZS1wYWNrIHdvdWxkIGhh
dmUgdG8gY2xvc2UgYW5kIA0KcmUtb3BlbiB0aGUgcmVmIGRhdGFiYXNlLiAgTW9yZSBnZW5lcmFs
bHksIGEgZmFpciBudW1iZXIgb2YgZ2l0IGNvbW1hbmRzIGFyZQ0KaW1wbGVtZW50ZWQgaW4gdGVy
bXMgb2Ygb3RoZXIgZ2l0IGNvbW1hbmRzLCBhbmQgbWlnaHQgbmVlZCB0aGUgc2FtZSB0cmVhdG1l
bnQuDQpXZSBjb3VsZCwgaW4gZ2VuZXJhbCwgY2xvc2UgYW5kIHJlLW9wZW4gdGhlIGRhdGFiYXNl
IGFyb3VuZCBmb3JrL2V4ZWMsIGJ1dCBJIGFtDQpub3Qgc3VyZSB0aGF0IHRoaXMgc29sdmVzIHRo
ZSBnZW5lcmFsIHByb2JsZW0gLS0gYnkgbWVyZSBoYXBwZW5zdGFuY2UsIG9uZSBtaWdodA0KYmUg
ZS5nLiBwdXNoaW5nIGluIG9uZSB0ZXJtaW5hbCB3aGlsZSBydW5uaW5nIGdpdCBjaGVja291dCBp
biBhbm90aGVyLiAgVGhpcyBpcyANCmVzcGVjaWFsbHkgdHJ1ZSB3aXRoIGdpdCB3b3JrdHJlZXMs
IHdoaWNoIHNoYXJlIG9uZSByZWYgZGF0YWJhc2UgYWNyb3NzIG11bHRpcGxlDQp3b3JraW5nIGRp
cmVjdG9yaWVzLg0KDQo=
