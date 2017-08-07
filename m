Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57C472047F
	for <e@80x24.org>; Mon,  7 Aug 2017 15:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751541AbdHGPqs (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 11:46:48 -0400
Received: from mxo2.dft.dmz.twosigma.com ([208.77.212.182]:50833 "EHLO
        mxo2.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751398AbdHGPqs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 11:46:48 -0400
X-Greylist: delayed 358 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Aug 2017 11:46:47 EDT
Received: from localhost (localhost [127.0.0.1])
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTP id EE0C810002E;
        Mon,  7 Aug 2017 15:40:48 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9nSZat9AJujt; Mon,  7 Aug 2017 15:40:48 +0000 (GMT)
Received: from exmbdft6.ad.twosigma.com (exmbdft6.ad.twosigma.com [172.22.1.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTPS id DD57B8002E;
        Mon,  7 Aug 2017 15:40:48 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft6.ad.twosigma.com (172.22.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Mon, 7 Aug 2017 15:40:48 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Mon, 7 Aug 2017 15:40:48 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Shawn Pearce' <spearce@spearce.org>,
        Ben Alex <ben.alex@acegi.com.au>
CC:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>,
        Stefan Beller <sbeller@google.com>,
        "Kristoffer Sjogren" <stoffe@gmail.com>
Subject: RE: reftable [v5]: new ref storage format
Thread-Topic: reftable [v5]: new ref storage format
Thread-Index: AQHTDtTwr9VfHt00/0GyzPPbJU6DJaJ38O4AgAALW4CAAPyfgIAAD8dw
Date:   Mon, 7 Aug 2017 15:40:48 +0000
Message-ID: <833bc420609e452e8837862eb90f6a43@exmbdft7.ad.twosigma.com>
References: <CAJo=hJsOHF0KVmXvbSBiBgxq4zRdt7v7sj_GuKvcpbu8tkujFA@mail.gmail.com>
 <874ltkzlcf.fsf@gmail.com>
 <CAJo=hJuPwEWJEWOUpJ_T-=j0NxnzjOLy_=-qG51_zuYhKbBvrw@mail.gmail.com>
 <CAOhB0ruYhGAyNn84ZjS7TH7QdwxNi2bPN8KFxEEBd58B9qVrmg@mail.gmail.com>
 <CAJo=hJsEaKH40WnhxqvkASpiXnV8ipc+b1zrZ9VEjqRjpJ17Qg@mail.gmail.com>
In-Reply-To: <CAJo=hJsEaKH40WnhxqvkASpiXnV8ipc+b1zrZ9VEjqRjpJ17Qg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.9]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGF3biBQZWFyY2UgW21haWx0
bzpzcGVhcmNlQHNwZWFyY2Uub3JnXQ0KPiBJbiBnaXQtY29yZSwgSSdtIHdvcnJpZWQgYWJvdXQg
dGhlIGNhdmVhdHMgcmVsYXRlZCB0byBsb2NraW5nLiBHaXQgdHJpZXMgdG8gd29yaw0KPiBuaWNl
bHkgb24gTkZTLCBhbmQgaXQgc2VlbXMgTE1EQiB3b3VsZG4ndC4gR2l0IGFsc28gcnVucyBmaW5l
IG9uIGEgcmVhZC1vbmx5DQo+IGZpbGVzeXN0ZW0sIGFuZCBMTURCIGdldHMgYSBsaXR0bGUgd2Vp
cmQgYWJvdXQgdGhhdC4gRmluYWxseSwgR2l0IGRvZXNuJ3QgaGF2ZQ0KPiBuZWFybHkgdGhlIHJp
c2tzIExNREIgaGFzIGFib3V0IGEgY3Jhc2hlZCByZWFkZXIgb3Igd3JpdGVyIGxvY2tpbmcgb3V0
IGZ1dHVyZQ0KPiBvcGVyYXRpb25zIHVudGlsIHRoZSBsb2NrcyBoYXZlIGJlZW4gcmVzb2x2ZWQu
IFRoaXMgaXMgZXNwZWNpYWxseSB0cnVlIHdpdGggc2hhcmVkDQo+IHVzZXIgcmVwb3NpdG9yaWVz
LCB3aGVyZSBhbm90aGVyIHVzZXIgbWlnaHQgc2V0dXAgYW5kIG93biB0aGUgc2VtYXBob3JlLg0K
DQpGV0lXLCBnaXQgaGFzIHByb2JsZW1zIHdpdGggc3RhbGUgbG9jayBmaWxlIGluIHRoZSBldmVu
dCBvZiBhIGNyYXNoIChyZWZzL2Zvby5sb2NrIA0KbWlnaHQgc3RpbGwgZXhpc3QsIGFuZCBnaXQg
ZG9lcyBub3RoaW5nIHRvIGNsZWFuIGl0IHVwKS4NCg0KSW4gbXkgdGVzdGluZyAod2hpY2ggaW52
b2x2ZWQgYSAqbG90KiBvZiBjcmFzaGluZyksIEkgbmV2ZXIgb25jZSBoYWQgdG8gY2xlYW4gdXAg
YQ0Kc3RhbGUgTE1EQiBsb2NrLiAgVGhhdCBzYWlkLCBJIGRpZG4ndCB0ZXN0IG9uIGEgUk8gZmls
ZXN5c3RlbS4NCg==
