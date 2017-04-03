Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06E111FAFB
	for <e@80x24.org>; Mon,  3 Apr 2017 17:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751841AbdDCRDv (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 13:03:51 -0400
Received: from mxo2.dft.dmz.twosigma.com ([208.77.212.182]:59756 "EHLO
        mxo2.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751732AbdDCRDu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 13:03:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTP id 965EB10005A;
        Mon,  3 Apr 2017 17:03:49 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8-XqrKFNkhBE; Mon,  3 Apr 2017 17:03:49 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (msx.twosigma.com [172.22.2.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTPS id 862538002E;
        Mon,  3 Apr 2017 17:03:49 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft7.ad.twosigma.com (172.22.2.43) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Mon, 3 Apr 2017 17:03:49 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Mon, 3 Apr 2017 17:03:49 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH v3] http.postbuffer: allow full range of ssize_t values
Thread-Topic: [PATCH v3] http.postbuffer: allow full range of ssize_t values
Thread-Index: AQHSqq1fnHwnr8jQhkWPeA0pi1V3iaGz0fcw
Date:   Mon, 3 Apr 2017 17:03:49 +0000
Message-ID: <34d444b673c64310baa275f821037b3e@exmbdft7.ad.twosigma.com>
References: <20170331172631.12024-1-dturner@twosigma.com>
 <20170401060116.b2v7tyoi7fcxwbvo@sigill.intra.peff.net>
In-Reply-To: <20170401060116.b2v7tyoi7fcxwbvo@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.14]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVmZiBLaW5nIFttYWls
dG86cGVmZkBwZWZmLm5ldF0NCj4gU2VudDogU2F0dXJkYXksIEFwcmlsIDEsIDIwMTcgMjowMSBB
TQ0KPiBUbzogRGF2aWQgVHVybmVyIDxEYXZpZC5UdXJuZXJAdHdvc2lnbWEuY29tPg0KPiBDYzog
Z2l0QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzXSBodHRwLnBvc3Ri
dWZmZXI6IGFsbG93IGZ1bGwgcmFuZ2Ugb2Ygc3NpemVfdCB2YWx1ZXMNCj4gDQo+IE9uIEZyaSwg
TWFyIDMxLCAyMDE3IGF0IDAxOjI2OjMxUE0gLTA0MDAsIERhdmlkIFR1cm5lciB3cm90ZToNCj4g
DQo+ID4gVW5mb3J0dW5hdGVseSwgaW4gb3JkZXIgdG8gcHVzaCBzb21lIGxhcmdlIHJlcG9zLCB0
aGUgaHR0cCBwb3N0YnVmZmVyDQo+ID4gbXVzdCBzb21ldGltZXMgZXhjZWVkIHR3byBnaWdhYnl0
ZXMuICBPbiBhIDY0LWJpdCBzeXN0ZW0sIHRoaXMgaXMgT0s6DQo+ID4gd2UganVzdCBtYWxsb2Mg
YSBsYXJnZXIgYnVmZmVyLg0KPiANCj4gSSdtIHN0aWxsIG5vdCBzdXJlIHdoeSBhIDJHQiBwb3N0
LWJ1ZmZlciBpcyBuZWNlc3NhcnkuIEl0IHNvdW5kcyBsaWtlIHNvbWV0aGluZw0KPiBpcyBicm9r
ZW4gaW4geW91ciBzZXR1cC4gTGFyZ2UgcHVzaGVzIHNob3VsZCBiZSBzZW50IGNodW5rZWQuDQo+
IA0KPiBJIGtub3cgYnJva2VuIHNldHVwcyBhcmUgYSBmYWN0IG9mIGxpZmUsIGJ1dCB0aGlzIGZl
ZWxzIGxpa2UgYSByZWFsbHkgaGFja3kgd29yay0NCj4gYXJvdW5kLg0KDQpJJ20gbm90IHN1cmUg
d2hhdCBvdGhlciB3b3JrYXJvdW5kIEkgc2hvdWxkIHVzZS4gIEkgZ3Vlc3MgSSBjb3VsZCBkbyBt
dWx0aXBsZSBwdXNoZXMsIGJ1dCBvbmx5IGlmIGluZGl2aWR1YWwgb2JqZWN0cyBhcmUgdW5kZXIg
dGhlIHNpemUgbGltaXQsIGFuZCBJJ20gbm90IHN1cmUgYWxsIG9mIG1pbmUgYXJlIChtYXliZSBJ
J2xsIGdldCBsdWNreSB0aG8pLiAgSSBrbm93IHRoYXQgdGhpcyBpcyBhIGNvbmZpZ3VyYXRpb24g
aXNzdWUgd2l0aCBnaXRsYWI6IGh0dHBzOi8vZ2l0bGFiLmNvbS9naXRsYWItb3JnL2dpdGxhYi1j
ZS9pc3N1ZXMvMzAzMTUgYnV0IEkgZG9uJ3Qga25vdyB3aGVuIHRoYXQgd2lsbCBnZXQgZml4ZWQu
ICBJIGNvdWxkIG1hbnVhbGx5IGNvcHkgdGhlIHJlcG8gdG8gdGhlIHNlcnZlciBhbmQgZG8gYSBs
b2NhbCBwdXNoLCBidXQgSSBkb24ndCBrbm93IHRoYXQgSSBoYXZlIHRoZSBuZWNlc3NhcnkgcGVy
bWlzc2lvbnMgdG8gZG8gdGhhdC4gT3IgSSBjb3VsZCBkbyB0aGlzLCB3aGljaCB3b3VsZCBob3Bl
ZnVsbHkgYWN0dWFsbHkgc29sdmUgdGhlIHByb2JsZW0uDQoNCj4gPiBkaWZmIC0tZ2l0IGEvY2Fj
aGUuaCBiL2NhY2hlLmgNCj4gPiBpbmRleCBmYmRmN2E4MTVhLi41ZTY3NDdkYmI0IDEwMDY0NA0K
PiA+IC0tLSBhL2NhY2hlLmgNCj4gPiArKysgYi9jYWNoZS5oDQo+ID4gQEAgLTE5MDAsNiArMTkw
MCw3IEBAIGV4dGVybiBpbnQgZ2l0X3BhcnNlX21heWJlX2Jvb2woY29uc3QgY2hhciAqKTsNCj4g
PiBleHRlcm4gaW50IGdpdF9jb25maWdfaW50KGNvbnN0IGNoYXIgKiwgY29uc3QgY2hhciAqKTsg
IGV4dGVybiBpbnQ2NF90DQo+ID4gZ2l0X2NvbmZpZ19pbnQ2NChjb25zdCBjaGFyICosIGNvbnN0
IGNoYXIgKik7ICBleHRlcm4gdW5zaWduZWQgbG9uZw0KPiA+IGdpdF9jb25maWdfdWxvbmcoY29u
c3QgY2hhciAqLCBjb25zdCBjaGFyICopOw0KPiA+ICtleHRlcm4gc3NpemVfdCBnaXRfY29uZmln
X3NzaXplX3QoY29uc3QgY2hhciAqLCBjb25zdCBjaGFyICopOw0KPiANCj4gRm9yIG1vc3Qgb2Yg
b3VyIG90aGVyICJiaWciIHZhbHVlcyB3ZSB1c2UgZ2l0X2NvbmZpZ191bG9uZygpLiBFLmcuLA0K
PiBjb3JlLmJpZ2ZpbGV0aHJlc2hvbGQuIEkgc3VzcGVjdCB0aGF0IHdvdWxkIGJlIGZpbmUgZm9y
IHlvdXIgcHVycG9zZXMgaGVyZSwNCj4gdGhvdWdoIHVzaW5nIHNpemVfdCBpcyBtb3JlIGNvcnJl
Y3QgKG9uIFdpbmRvd3MgInVuc2lnbmVkIGxvbmciIGlzIHN0aWxsIG9ubHkNCj4gMzIgYml0cywg
ZXZlbiBvbiA2NC1iaXQgc3lzdGVtcykuDQo+IA0KPiBUaGUgdWx0aW1hdGUgZmF0ZSBvZiB0aGlz
IG51bWJlciwgdGhvdWdoLCBpcyB0byBiZSBoYW5kZWQgdG86DQo+IA0KPiAgIGN1cmxfZWFzeV9z
ZXRvcHQoc2xvdC0+Y3VybCwgQ1VSTE9QVF9QT1NURklFTERTSVpFLCBycGMtPmxlbik7DQo+IA0K
PiB3aGVyZSB0aGUgZmluYWwgYXJndW1lbnQgaXMgaW50ZXJwcmV0ZWQgYXMgYSBsb25nLiBTbyBJ
IHN1c3BlY3QgdGhhdCBvbiA2NC1iaXQNCj4gV2luZG93cywgc2V0dGluZyBodHRwLnBvc3RidWZm
ZXIgdG8gIjNHIiB3b3VsZCBjYXVzZSBzb21lIGtpbmQgb2Ygd2VpcmQNCj4gZXJyb3IgKGVpdGhl
ciBhIHRydW5jYXRlZCBwb3N0IG9yIHNvbWUgaW50ZXJuYWwgY3VybCBlcnJvciBkdWUgdG8gdGhl
IG5lZ2F0aXZlDQo+IHNpemUsIGRlcGVuZGluZyBvbiBob3cgY3VybCBoYW5kbGVzIGl0KS4NCg0K
QWgsIHNvIHdlIHdvdWxkIG5lZWQgdG8gdXNlIENVUkxPUFRfUE9TVEZJRUxEU0laRV9MQVJHRS4g
IFdpbGwgcmUtcm9sbC4NCg0KPiANCj4gSSB0aGluayBhICJnaXRfY29uZmlnX2xvbmcoKSIgd291
bGQgcHJvYmFibHkgZG8gZXZlcnl0aGluZyBjb3JyZWN0bHkuDQo+IA0KPiA+ICtzdGF0aWMgaW50
IGdpdF9wYXJzZV9zc2l6ZV90KGNvbnN0IGNoYXIgKnZhbHVlLCBzc2l6ZV90ICpyZXQpIHsNCj4g
PiArCXNzaXplX3QgdG1wOw0KPiA+ICsJaWYgKCFnaXRfcGFyc2Vfc2lnbmVkKHZhbHVlLCAmdG1w
LA0KPiBtYXhpbXVtX3NpZ25lZF92YWx1ZV9vZl90eXBlKHNzaXplX3QpKSkNCj4gPiArCQlyZXR1
cm4gMDsNCj4gPiArCSpyZXQgPSB0bXA7DQo+ID4gKwlyZXR1cm4gMTsNCj4gPiArfQ0KPiANCj4g
SSBzYXcgdGhlIGVhcmxpZXIgaXRlcmF0aW9uIHVzZWQgYSBzaXplX3QsIGJ1dCB5b3Ugc3dpdGNo
ZWQgaXQgYWZ0ZXIgdGhlIGNvbXBpbGVyDQo+IChyaWdodGZ1bGx5KSBjb21wbGFpbmVkIGFib3V0
IHRoZSBzaWduZWRuZXNzLiBCdXQgSSdtIG5vdCBzdXJlIHdoeSB3ZSB3b3VsZA0KPiB3YW50IHNz
aXplX3QgaGVyZSBpbnN0ZWFkIG9mIGp1c3QgdXNpbmcgZ2l0X3BhcnNlX3Vuc2lnbmVkKCkuDQoN
Ckl0IHdhcyBvcmlnaW5hbGx5IHNpZ25lZC4gIEknbSBub3Qgc3VyZSB3aHkgdGhhdCB3YXMsIGJ1
dCBJIGZpZ3VyZWQgaXQgd291bGQgYmUgc2ltcGxlciB0byBzYXZlIHRoZSBleHRyYSBiaXQganVz
dCBpbiBjYXNlLg0K
