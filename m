Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48297207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 22:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbcJCW0D (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 18:26:03 -0400
Received: from mxo2.dft.dmz.twosigma.com ([208.77.212.182]:47455 "EHLO
        mxo2.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751821AbcJCW0C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 18:26:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTP id D8DE410005A;
        Mon,  3 Oct 2016 22:26:00 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id p4Gx68fhOUlG; Mon,  3 Oct 2016 22:26:00 +0000 (GMT)
Received: from exmbdft6.ad.twosigma.com (exmbdft6.ad.twosigma.com [172.22.1.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTPS id C891180031;
        Mon,  3 Oct 2016 22:26:00 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft6.ad.twosigma.com (172.22.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1156.6; Mon, 3 Oct 2016 22:26:00 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef]) by
 exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef%17]) with mapi id
 15.00.1156.000; Mon, 3 Oct 2016 22:26:00 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Jeff King' <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>
Subject: RE: [PATCH] http: http.emptyauth should allow empty (not just NULL)
 usernames
Thread-Topic: [PATCH] http: http.emptyauth should allow empty (not just NULL)
 usernames
Thread-Index: AQHSHboz9HLWCmVnh0+2auL984A8LaCXQqwggAAEeQCAAAGpIA==
Date:   Mon, 3 Oct 2016 22:26:00 +0000
Message-ID: <b7e31e9b13494f94b5bd6fff5fc55af0@exmbdft7.ad.twosigma.com>
References: <1475515168-29679-1-git-send-email-dturner@twosigma.com>
 <20161003210100.t5nqknwfotag3lmj@sigill.intra.peff.net>
 <335996ca2642478386e94d9f3dc43223@exmbdft7.ad.twosigma.com>
 <20161003215840.6ihqjtplkcsporiw@sigill.intra.peff.net>
In-Reply-To: <20161003215840.6ihqjtplkcsporiw@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.13]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEplZmYgS2luZyBbbWFpbHRv
OnBlZmZAcGVmZi5uZXRdDQo+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAwMywgMjAxNiA1OjU5IFBN
DQo+IFRvOiBEYXZpZCBUdXJuZXINCj4gQ2M6IGdpdEB2Z2VyLmtlcm5lbC5vcmc7IHNhbmRhbHNA
Y3J1c3R5dG9vdGhwYXN0ZS5uZXQNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gaHR0cDogaHR0cC5l
bXB0eWF1dGggc2hvdWxkIGFsbG93IGVtcHR5IChub3QganVzdA0KPiBOVUxMKSB1c2VybmFtZXMN
Cj4gDQo+IE9uIE1vbiwgT2N0IDAzLCAyMDE2IGF0IDA5OjU0OjE5UE0gKzAwMDAsIERhdmlkIFR1
cm5lciB3cm90ZToNCj4gDQo+ID4gPiBJIGR1bm5vLiBUaGUgY29kZSBwYXRoIHlvdSBhcmUgY2hh
bmdpbmcgX29ubHlfIGFmZmVjdHMgYW55dGhpbmcgaWYNCj4gPiA+IHRoZSBodHRwLmVtcHR5YXV0
aCBjb25maWcgaXMgc2V0LiBCdXQgSSBndWVzcyBJIGp1c3QgZG9uJ3QNCj4gPiA+IHVuZGVyc3Rh
bmQgd2h5IHlvdSB3b3VsZCBzYXkgImh0dHA6Ly9AZ2l0c2VydmVyIiBpbiB0aGUgZmlyc3QgcGxh
Y2UuDQo+IElzIHRoYXQgYSBjb21tb24gdGhpbmc/DQo+ID4NCj4gPiBJIGhhdmUgbm8gaWRlYSBp
ZiBpdCBpcyBjb21tb24uICBJIGtub3cgdGhhdCB3ZSBkbyBpdC4NCj4gDQo+IEkgZ3Vlc3MgbXkg
cXVlc3Rpb24gaXM6IF93aHlfIGRvIHlvdSBkbyBpdD8gT3IgbW9yZSBzcGVjaWZpY2FsbHksIGRv
ZXMNCj4gaHR0cDovL2dpdHNlcnZlci5leGFtcGxlLmNvbSIgd2l0aCBodHRwLmVtcHR5YXV0aCBu
b3Qgd29yaywgYW5kIHdoeT8NCj4gDQo+IEZyb20geW91ciByZXNwb25zZSwgSSBfdGhpbmtfIHRo
ZSBhbnN3ZXIgaXMgIm5vLCBpdCBkb2Vzbid0LCBhbmQgSSBoYXZlIG5vDQo+IGNsdWUgd2h5Ii4N
Cg0KVGhhdCB3YXMgdHJ1ZSBoaXN0b3JpY2FsbHkuIA0KDQpJIGp1c3QgdHJpZWQgb3VyIG9sZCB2
ZXJzaW9uIG9mIGdpdCAyLjggKHRoYXQgaXMsIGJlZm9yZSB0aGlzIHBhdGNoLCBhbmQgYmVmb3Jl
IHRoZSBsaWJjdXJsIHVwZ3JhZGUpLCBhbmQgaHR0cDovL2dpdHNlcnZlci5leGFtcGxlLmNvbSAq
ZG9lcyogc2VlbSB0byB3b3JrIHdpdGggaHR0cC5lbXB0eWF1dGggKGFuZCBkb2VzIG5vdCB3b3Jr
IHdpdGhvdXQpLiAgSG93ZXZlciwgaHR0cDovL0BnaXRzZXJ2ZXIuZXhhbXBsZS5jb20gZG9lcyAq
bm90KiB3b3JrIHdpdGggaHR0cC5lbXB0eWF1dGgsIGFuZCAqZG9lcyogd29yayB3aXRob3V0Lg0K
DQpBZnRlciB0aGUgbGliY3VybCB1cGdyYWRlLCBidXQgYmVmb3JlIHRoaXMgcGF0Y2gsIGh0dHA6
Ly9AZ2l0c2VydmVyLmV4YW1wbGUuY29tIGRvZXMgKm5vdCogd29yayB3aXRoIGh0dHAuZW1wdHlh
dXRoLCB3aGlsZSBodHRwOi8vZ2l0c2VydmVyLmV4YW1wbGUuY29tIGRvZXMuDQoNCkFuZCBmaW5h
bGx5LCBhZnRlciB0aGUgdXBncmFkZSBhbmQgd2l0aCB0aGlzIHBhdGNoLCBib3RoIHVybHMgd29y
ay4NCg0KPiBTbyBJIGR1bm5vLiBJdCBpcyBhbm5veWluZyBub3QgdG8ga25vdyB3aGF0IGlzIGFj
dHVhbGx5IGdvaW5nIG9uLCBidXQgSSdtDQo+IE9LIHdpdGggaXQgaWYgd2UgZG9uJ3QgdGhpbmsg
dGhlcmUncyBhIGhpZ2ggY2hhbmNlIG9mIHJlZ3Jlc3NpbmcgYW55IG90aGVyDQo+IHdvcmtmbG93
cyAod2hpY2ggSSBndWVzcyBub3QsIGJlY2F1c2UgaHR0cC5lbXB0eWF1dGggc2VlbXMgdG8gYmUg
YQ0KPiBLZXJiZXJvcy1zcGVjaWZpYyBoYWNrIGluIHRoZSBmaXJzdCBwbGFjZSkuDQoNClllcywg
SSB0aGluayB0aGlzIGlzIGFsbCBLZXJiZXJvcy1vbmx5Lg0K
