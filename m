Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6839F207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 21:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbcJCVyX (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 17:54:23 -0400
Received: from mxo2.dft.dmz.twosigma.com ([208.77.212.182]:52844 "EHLO
        mxo2.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbcJCVyV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 17:54:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTP id 10067100056;
        Mon,  3 Oct 2016 21:54:20 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8IF9ZBwrQSwo; Mon,  3 Oct 2016 21:54:20 +0000 (GMT)
Received: from exmbdft6.ad.twosigma.com (exmbdft6.ad.twosigma.com [172.22.1.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTPS id F3F218002E;
        Mon,  3 Oct 2016 21:54:19 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft6.ad.twosigma.com (172.22.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1156.6; Mon, 3 Oct 2016 21:54:19 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef]) by
 exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef%17]) with mapi id
 15.00.1156.000; Mon, 3 Oct 2016 21:54:19 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Jeff King' <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>
Subject: RE: [PATCH] http: http.emptyauth should allow empty (not just NULL)
 usernames
Thread-Topic: [PATCH] http: http.emptyauth should allow empty (not just NULL)
 usernames
Thread-Index: AQHSHboz9HLWCmVnh0+2auL984A8LaCXQqwg
Date:   Mon, 3 Oct 2016 21:54:19 +0000
Message-ID: <335996ca2642478386e94d9f3dc43223@exmbdft7.ad.twosigma.com>
References: <1475515168-29679-1-git-send-email-dturner@twosigma.com>
 <20161003210100.t5nqknwfotag3lmj@sigill.intra.peff.net>
In-Reply-To: <20161003210100.t5nqknwfotag3lmj@sigill.intra.peff.net>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVmZiBLaW5nIFttYWls
dG86cGVmZkBwZWZmLm5ldF0NCj4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDAzLCAyMDE2IDU6MDEg
UE0NCj4gVG86IERhdmlkIFR1cm5lcg0KPiBDYzogZ2l0QHZnZXIua2VybmVsLm9yZzsgc2FuZGFs
c0BjcnVzdHl0b290aHBhc3RlLm5ldA0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBodHRwOiBodHRw
LmVtcHR5YXV0aCBzaG91bGQgYWxsb3cgZW1wdHkgKG5vdCBqdXN0DQo+IE5VTEwpIHVzZXJuYW1l
cw0KPiANCj4gT24gTW9uLCBPY3QgMDMsIDIwMTYgYXQgMDE6MTk6MjhQTSAtMDQwMCwgRGF2aWQg
VHVybmVyIHdyb3RlOg0KPiANCj4gPiBXaGVuIHVzaW5nIGtlcmJlcm9zIGF1dGhlbnRpY2F0aW9u
LCBvbmUgVVJMIHBhdHRlcm4gd2hpY2ggaXMgYWxsb3dlZA0KPiA+IGlzIGh0dHA6Ly9AZ2l0c2Vy
dmVyLmV4YW1wbGUuY29tLiAgVGhpcyBsZWFkcyB0byBhIHVzZXJuYW1lIG9mDQo+ID4gemVyby1s
ZW5ndGgsIHJhdGhlciB0aGFuIGEgTlVMTCB1c2VybmFtZS4gIEJ1dCB0aGUgdHdvIGNhc2VzIHNo
b3VsZCBiZQ0KPiA+IHRyZWF0ZWQgdGhlIHNhbWUgYnkgaHR0cC5lbXB0eWF1dGguDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBUdXJuZXIgPGR0dXJuZXJAdHdvc2lnbWEuY29tPg0KPiA+
IC0tLQ0KPiA+ICBodHRwLmMgfCAyICstDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h0dHAuYyBiL2h0dHAu
Yw0KPiA+IGluZGV4IDgyZWQ1NDIuLmJkMGRiYTIgMTAwNjQ0DQo+ID4gLS0tIGEvaHR0cC5jDQo+
ID4gKysrIGIvaHR0cC5jDQo+ID4gQEAgLTM1MSw3ICszNTEsNyBAQCBzdGF0aWMgaW50IGh0dHBf
b3B0aW9ucyhjb25zdCBjaGFyICp2YXIsIGNvbnN0DQo+ID4gY2hhciAqdmFsdWUsIHZvaWQgKmNi
KQ0KPiA+DQo+ID4gIHN0YXRpYyB2b2lkIGluaXRfY3VybF9odHRwX2F1dGgoQ1VSTCAqcmVzdWx0
KSAgew0KPiA+IC0JaWYgKCFodHRwX2F1dGgudXNlcm5hbWUpIHsNCj4gPiArCWlmICghaHR0cF9h
dXRoLnVzZXJuYW1lIHx8ICEqaHR0cF9hdXRoLnVzZXJuYW1lKSB7DQo+IA0KPiBIbW0uIFRoaXMg
Zml4ZXMgdGhpcyBjYWxsZXIsIGJ1dCB3aGF0IGFib3V0IG90aGVyIHVzZXJzIG9mIHRoZSBjcmVk
ZW50aWFsDQo+IHN0cnVjdD8gSSB3b25kZXIgaWYgdGhlIGNvcnJlY3QgZml4IGlzIGluIGNyZWRl
bnRpYWxfZnJvbV91cmwoKSwgd2hpY2gNCj4gc2hvdWxkIGF2b2lkIHdyaXRpbmcgYW4gZW1wdHkg
ZmllbGQuDQo+IA0KPiBPVE9ILCBJIGNhbiBpbWFnaW5lIHRoYXQgImh0dHA6Ly91c2VyOkBleGFt
cGxlLmNvbSIgd291bGQgYmUgYSB3YXkgdG8gc2F5DQo+ICJJIGhhdmUgYSB1c2VybmFtZSBhbmQg
dGhlIHBhc3N3b3JkIGlzIGJsYW5rIiB3aXRob3V0IGdldHRpbmcgcHJvbXB0ZWQuDQo+IFdoaWNo
IG1ha2VzIG1lIHdvbmRlciBpZiBpdCBpcyB1c2VmdWwgdG8gc2F5ICJteSB1c2VybmFtZSBpcyBi
bGFuayIgaW4gdGhlDQo+IHNhbWUgd2F5Lg0KDQpZZXMsIHRoYXQgd2FzIG15IHRob3VnaHQgcHJv
Y2Vzcy4NCg0KPiBJIGR1bm5vLiBUaGUgY29kZSBwYXRoIHlvdSBhcmUgY2hhbmdpbmcgX29ubHlf
IGFmZmVjdHMgYW55dGhpbmcgaWYgdGhlDQo+IGh0dHAuZW1wdHlhdXRoIGNvbmZpZyBpcyBzZXQu
IEJ1dCBJIGd1ZXNzIEkganVzdCBkb24ndCB1bmRlcnN0YW5kIHdoeSB5b3UNCj4gd291bGQgc2F5
ICJodHRwOi8vQGdpdHNlcnZlciIgaW4gdGhlIGZpcnN0IHBsYWNlLiBJcyB0aGF0IGEgY29tbW9u
IHRoaW5nPw0KPiANCj4gLVBlZmYNCg0KSSBoYXZlIG5vIGlkZWEgaWYgaXQgaXMgY29tbW9uLiAg
SSBrbm93IHRoYXQgd2UgZG8gaXQuDQoNCkl0IHVzZWQgdG8gYmUgdGhhdCBnaXQgMi44L2xpYmN1
cmwgd291bGQgaGFuZGxlIEBnaXRzZXJ2ZXIgYXMgaWYgdGhlIHVzZXJuYW1lIHdlcmUgYmxhbmss
IGJ1dCB0aGVuIHdlIHVwZ3JhZGVkIG91ciBjb21wYW55J3MgbGliY3VybCBhbmQgaXQgYnJva2Ug
KGdpdCBzdGFydGVkIHByb21wdGluZyBmb3IgYSBwYXNzd29yZCkuIEkgZG8gbm90IGtub3cgd2hh
dCB0aGUgcHJldmlvdXMgdmVyc2lvbiBvZiBsaWJjdXJsIHdhcy4NCg0KVGhlIHJlYXNvbiB3ZSBo
YXZlIGEgcmVxdWlyZWQtdG8tYmUtYmxhbmsgdXNlcm5hbWUvcGFzc3dvcmQgaXMgYXBwYXJlbnRs
eSBLZXJiZXJvcyAob3Igc29tZXRoaW5nIGFib3V0IG91ciBwYXJ0aWN1bGFyIEtlcmJlcm9zIGNv
bmZpZ3VyYXRpb24pLCB3aGljaCBJIHRyZWF0IGFzIGluc2NydXRhYmxlIGJsYWNrIG1hZ2ljLg0K
