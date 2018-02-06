Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D5F11F404
	for <e@80x24.org>; Tue,  6 Feb 2018 14:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbeBFOau (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 09:30:50 -0500
Received: from rhcavuit03.kulnet.kuleuven.be ([134.58.240.136]:59862 "EHLO
        rhcavuit03.kulnet.kuleuven.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752020AbeBFOat (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 6 Feb 2018 09:30:49 -0500
X-KULeuven-Envelope-From: filip.jorissen@kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 1151E12033A.A7A68
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-smtps-2.cc.kuleuven.be (icts-p-smtps-2e.kulnet.kuleuven.be [134.58.240.34])
        by rhcavuit03.kulnet.kuleuven.be (Postfix) with ESMTP id 1151E12033A
        for <git@vger.kernel.org>; Tue,  6 Feb 2018 15:30:42 +0100 (CET)
Received: from ICTS-S-EXMBX23.luna.kuleuven.be (icts-s-exmbx23.luna.kuleuven.be [10.112.11.58])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by icts-p-smtps-2.cc.kuleuven.be (Postfix) with ESMTPS id 0C9552003B;
        Tue,  6 Feb 2018 15:30:42 +0100 (CET)
Received: from ICTS-S-EXMBX21.luna.kuleuven.be (10.112.11.56) by
 ICTS-S-EXMBX23.luna.kuleuven.be (10.112.11.58) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Tue, 6 Feb 2018 15:30:41 +0100
Received: from ICTS-S-EXMBX21.luna.kuleuven.be ([fe80::40ed:b1c6:4ef8:3c88])
 by ICTS-S-EXMBX21.luna.kuleuven.be ([fe80::40ed:b1c6:4ef8:3c88%23]) with mapi
 id 15.00.1320.000; Tue, 6 Feb 2018 15:30:41 +0100
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Filip Jorissen <filip.jorissen@kuleuven.be>
To:     Jeff King <peff@peff.net>
CC:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?utf-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Cloned repository has file changes -> bug?
Thread-Topic: Cloned repository has file changes -> bug?
Thread-Index: AQHTl6YICpRIXjWJ3kyLd7lXxhw5laOIErcAgADIhYCADnwVAIAABDyAgAAN9oCAAASHgA==
Date:   Tue, 6 Feb 2018 14:30:41 +0000
Message-ID: <5C27A062-A03B-4A4B-978E-40CFD78FC1AB@kuleuven.be>
References: <BCFDB3A3-B515-4932-AC67-F720AEB4B0BE@kuleuven.be>
 <87607nvzrd.fsf@evledraar.gmail.com> <20180128075731.GA17412@tor.lan>
 <CD3563ED-5E0D-4238-A664-4F2335598FE2@kuleuven.be>
 <87lgg6l08m.fsf@evledraar.gmail.com>
 <20180206141423.GA28721@sigill.intra.peff.net>
In-Reply-To: <20180206141423.GA28721@sigill.intra.peff.net>
Accept-Language: nl-NL, nl-BE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.5.20)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.112.50.1]
Content-Type: text/plain; charset="utf-8"
Content-ID: <535A2B777C00EE4B91204879B9FC7EAD@luna.kuleuven.be>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SeKAmW0gbm90IGdpdCBleHBlcnQgYnV0LCBmcm9tIGEgdXNlciBwb2ludCBvZiB2aWV3LCB0aGUg
Zm9sbG93aW5nIHdvdWxkIG1ha2Ugc2Vuc2UuIFdoZW4gYWRkaW5nIGEgZmlsZSwgZ2l0IGNvdWxk
IGNoZWNrIHdoZXRoZXIgYSBkaWZmZXJlbnQgZmlsZSBpcyBhbHJlYWR5IGluIHRoZSByZXBvc2l0
b3J5IHdpdGggdGhlIHNhbWUgbmFtZSAoY2FzZS1pbnNlbnNpdGl2ZSBjaGVjaykuIFRoZW4gc2lt
cGx5IHJlcG9ydCB0aGF0IHRoaXMgbWF5IGJlIGEgbWlzdGFrZSBhbmQgcmVxdWVzdCB0byB1c2Ug
4oCYZ2l0IGFkZCAtZuKAmSB0byBmb3JjZSB0aGUg4oCYYWRk4oCZLiBQZXJoYXBzIHRoaXMgY29p
bmNpZGVzIHdpdGggd2hhdCB3YXMgc3VnZ2VzdGVkIGluIGVhcmxpZXIgcmVwbGllcy4gRnJvbSBt
eSBwb2ludCBvZiB2aWV3IHRoZSBjaGVjayBzaG91bGQgYmUgZW5hYmxlZCBieSBkZWZhdWx0LCBi
dXQgaXQgY291bGQgYmUgb3B0aW9uYWwgdG9vLiANCg0KRmlsaXANCg0KDQoNCj4gT3AgNiBmZWIu
IDIwMTgsIG9tIDE1OjE0IGhlZWZ0IEplZmYgS2luZyA8cGVmZkBwZWZmLm5ldD4gaGV0IHZvbGdl
bmRlIGdlc2NocmV2ZW46DQo+IA0KPiBPbiBUdWUsIEZlYiAwNiwgMjAxOCBhdCAwMjoyNDoyNVBN
ICswMTAwLCDDhnZhciBBcm5masO2csOwIEJqYXJtYXNvbiB3cm90ZToNCj4gDQo+PiAzKSBTdWNo
IGhvb2tzIHNsb3cgZG93biBwdXNoZXMsIGVzcGVjaWFsbHkgb24gYmlnIHJlcG9zLCB5b3UgY2Fu
DQo+PiAgICBvcHRpbWl6ZSB0aGluZ3MgYSBiaXQgKGUuZy4gb25seSBsb29rIGluIHRoZSBzYW1l
IGRpcmVjdG9yaWVzKSwgYnV0DQo+PiAgICBwYXRob2xvZ2ljYWxseSB5b3UgZW5kIHVwIG5lZWRp
bmcgdG8gY29tcGFyZSB0aGUgY3Jvc3MtcHJvZHVjdCBvZg0KPj4gICAgY2hhbmdlZCBmaWxlcyB2
LnMuIGFsbCBleGlzdGluZyBmaWxlcyBmb3IgZWFjaCBjaGFuZ2VkIGZpbGUuDQo+IA0KPiBJIHRo
aW5rIHlvdSBjb3VsZCBqdXN0IGNvbXBsYWluIGFib3V0IGFueSB0cmVlIHRoYXQgY29udGFpbnMg
ZW50cmllcw0KPiB0aGF0IGhhdmUgZHVwbGljYXRlIGVudHJpZXMgYWZ0ZXIgbm9ybWFsaXphdGlv
bi4gSS5lLjoNCj4gDQo+ICBnaXQgcmV2LWxpc3QgLS1vYmplY3RzICRuZXcgLS1ub3QgJG9sZCB8
DQo+ICBhd2sgJ3twcmludCAkMX0nIHwNCj4gIGdpdCBjYXQtZmlsZSAtLWJhdGNoLWNoZWNrPScl
KG9iamVjdHR5cGUpICUob2JqZWN0bmFtZSknIHwNCj4gIGF3ayAnL150cmVlLyB7cHJpbnQgJDJ9
J3wNCj4gIHdoaWxlIHJlYWQgdHJlZTsgZG8NCj4gCWR1cHM9JChnaXQgbHMtdHJlZSAkdHJlZSB8
IGN1dCAtZiAyLSB8IHRyIEEtWiBhLXogfCBzb3J0IHwgdW5pcSAtZCkNCj4gCXRlc3QgLXogIiRk
dXBzIiB8fCBlY2hvICIkdHJlZSBoYXMgZHVwbGljYXRlczogJGR1cHMiDQo+ICBkb25lDQo+IA0K
PiBUaGF0IGdpdmVzIHJlYXNvbmFibGUgYWxnb3JpdGhtaWMgY29tcGxleGl0eSwgYnV0IG9mIGNv
dXJzZSB0aGUgc2hlbGwNCj4gaW1wbGVtZW50YXRpb24gaXMgaG9ycmlmaWMuIE9uZSBjb3VsZCBp
bWFnaW5lIHRoYXQgdGhpcyBjb3VsZCBiZQ0KPiBpbXBsZW1lbnRlZCBhcyBwYXJ0IG9mIGZzY2tf
dHJlZSgpLCB0aG91Z2gsIHdoaWNoIGlzIGFscmVhZHkgcmVhZGluZw0KPiB0aHJvdWdoIGFsbCB0
aGUgZW50cmllcyAodW5mb3J0dW5hdGVseSBpdCByZXF1aXJlcyBhdXhpbGlhcnkgc3RvcmFnZQ0K
PiBsaW5lYXIgd2l0aCB0aGUgc2l6ZSBvZiBhIGdpdmVuIHRyZWUgb2JqZWN0LCBidXQgdGhhdCdz
IG5vdCB0b28gYmFkKS4NCj4gDQo+IEJ1dCBpdCB3b3VsZCBwcm9iYWJseSBuZWVkOg0KPiANCj4g
IDEuIFRvIGJlIGVuYWJsZWQgYXMgYW4gb3B0aW9uYWwgZnNjayB3YXJuaW5nLCBwb3NzaWJseSBl
dmVuIGRlZmF1bHRpbmcNCj4gICAgIHRvICJpZ25vcmUiLg0KPiANCj4gIDIuIFRoYXQgInRyIiBj
b3VsZCBiZSBhbnkgYXJiaXRyYXJ5IHRyYW5zZm9ybWF0aW9uLiBDYXNlLWZvbGRpbmcgaXMNCj4g
ICAgIHRoZSBvYnZpb3VzIG9uZSwgYnV0IGluIHRoZW9yeSB5b3UgY291bGQgbWF0Y2ggdGhlIG5v
cm1hbGl6YXRpb24NCj4gICAgIGJlaGF2aW9yIG9mIGNlcnRhaW4gcG9wdWxhciBmaWxlc3lzdGVt
cy4NCj4gDQo+IEknbSBub3QgZW50aXJlbHkgY29udmluY2VkIGl0J3Mgd29ydGggYWxsIG9mIHRo
aXMgZWZmb3J0LCBidXQgSSB0aGluayBpdA0KPiB3b3VsZCBiZSBfcG9zc2libGVfIGF0IGxlYXN0
Lg0KPiANCj4gLVBlZmYNCg0K
