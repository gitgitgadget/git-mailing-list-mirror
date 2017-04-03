Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E2B01FAFB
	for <e@80x24.org>; Mon,  3 Apr 2017 23:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbdDCXsy (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 19:48:54 -0400
Received: from mxo2.dft.dmz.twosigma.com ([208.77.212.182]:46560 "EHLO
        mxo2.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbdDCXsx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 19:48:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTP id 5DCAF100059;
        Mon,  3 Apr 2017 23:48:52 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2Fe1XTuVR39D; Mon,  3 Apr 2017 23:48:52 +0000 (GMT)
Received: from exmbdft6.ad.twosigma.com (exmbdft6.ad.twosigma.com [172.22.1.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTPS id 4B8D08002E;
        Mon,  3 Apr 2017 23:48:52 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft6.ad.twosigma.com (172.22.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Mon, 3 Apr 2017 23:48:51 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Mon, 3 Apr 2017 23:48:51 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH v4] http.postbuffer: allow full range of ssize_t values
Thread-Topic: [PATCH v4] http.postbuffer: allow full range of ssize_t values
Thread-Index: AQHSrMj/3qhUScNNY0SCYXn8xNDKBqG0TxUQ
Date:   Mon, 3 Apr 2017 23:48:51 +0000
Message-ID: <fab6b6b8380a410fad0edb4d30b697b6@exmbdft7.ad.twosigma.com>
References: <20170403173015.15327-1-dturner@twosigma.com>
 <233d3799-2d24-1d7e-c97f-bc41abb1411a@ramsayjones.plus.com>
In-Reply-To: <233d3799-2d24-1d7e-c97f-bc41abb1411a@ramsayjones.plus.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFtc2F5IEpvbmVzIFtt
YWlsdG86cmFtc2F5QHJhbXNheWpvbmVzLnBsdXMuY29tXQ0KPiBTZW50OiBNb25kYXksIEFwcmls
IDMsIDIwMTcgNjoyNCBQTQ0KPiBUbzogRGF2aWQgVHVybmVyIDxEYXZpZC5UdXJuZXJAdHdvc2ln
bWEuY29tPjsgZ2l0QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0XSBo
dHRwLnBvc3RidWZmZXI6IGFsbG93IGZ1bGwgcmFuZ2Ugb2Ygc3NpemVfdCB2YWx1ZXMNCj4gDQo+
IA0KPiANCj4gT24gMDMvMDQvMTcgMTg6MzAsIERhdmlkIFR1cm5lciB3cm90ZToNCj4gPiBVbmZv
cnR1bmF0ZWx5LCBpbiBvcmRlciB0byBwdXNoIHNvbWUgbGFyZ2UgcmVwb3MsIHRoZSBodHRwIHBv
c3RidWZmZXINCj4gPiBtdXN0IHNvbWV0aW1lcyBleGNlZWQgdHdvIGdpZ2FieXRlcy4gIE9uIGEg
NjQtYml0IHN5c3RlbSwgdGhpcyBpcyBPSzoNCj4gPiB3ZSBqdXN0IG1hbGxvYyBhIGxhcmdlciBi
dWZmZXIuDQo+ID4NCj4gPiBUaGlzIG1lYW5zIHRoYXQgd2UgbmVlZCB0byB1c2UgQ1VSTE9QVF9Q
T1NURklFTERTSVpFX0xBUkdFIHRvIHNldA0KPiB0aGUNCj4gPiBidWZmZXIgc2l6ZS4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IERhdmlkIFR1cm5lciA8ZHR1cm5lckB0d29zaWdtYS5jb20+DQo+
ID4gLS0tDQo+ID4gIGNhY2hlLmggICAgICAgfCAgMSArDQo+ID4gIGNvbmZpZy5jICAgICAgfCAx
NyArKysrKysrKysrKysrKysrKw0KPiA+ICBodHRwLmMgICAgICAgIHwgIDQgKystLQ0KPiA+ICBo
dHRwLmggICAgICAgIHwgIDIgKy0NCj4gPiAgcmVtb3RlLWN1cmwuYyB8ICA2ICsrKy0tLQ0KPiA+
ICA1IGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvY2FjaGUuaCBiL2NhY2hlLmgNCj4gPiBpbmRleCBmYmRmN2E4MTVh
Li41ZTY3NDdkYmI0IDEwMDY0NA0KPiA+IC0tLSBhL2NhY2hlLmgNCj4gPiArKysgYi9jYWNoZS5o
DQo+ID4gQEAgLTE5MDAsNiArMTkwMCw3IEBAIGV4dGVybiBpbnQgZ2l0X3BhcnNlX21heWJlX2Jv
b2woY29uc3QgY2hhciAqKTsNCj4gPiBleHRlcm4gaW50IGdpdF9jb25maWdfaW50KGNvbnN0IGNo
YXIgKiwgY29uc3QgY2hhciAqKTsgIGV4dGVybiBpbnQ2NF90DQo+ID4gZ2l0X2NvbmZpZ19pbnQ2
NChjb25zdCBjaGFyICosIGNvbnN0IGNoYXIgKik7ICBleHRlcm4gdW5zaWduZWQgbG9uZw0KPiA+
IGdpdF9jb25maWdfdWxvbmcoY29uc3QgY2hhciAqLCBjb25zdCBjaGFyICopOw0KPiA+ICtleHRl
cm4gc3NpemVfdCBnaXRfY29uZmlnX3NzaXplX3QoY29uc3QgY2hhciAqLCBjb25zdCBjaGFyICop
Ow0KPiA+ICBleHRlcm4gaW50IGdpdF9jb25maWdfYm9vbF9vcl9pbnQoY29uc3QgY2hhciAqLCBj
b25zdCBjaGFyICosIGludCAqKTsNCj4gPiBleHRlcm4gaW50IGdpdF9jb25maWdfYm9vbChjb25z
dCBjaGFyICosIGNvbnN0IGNoYXIgKik7ICBleHRlcm4gaW50DQo+ID4gZ2l0X2NvbmZpZ19tYXli
ZV9ib29sKGNvbnN0IGNoYXIgKiwgY29uc3QgY2hhciAqKTsgZGlmZiAtLWdpdA0KPiA+IGEvY29u
ZmlnLmMgYi9jb25maWcuYyBpbmRleCAxYTRkODU1MzdiLi5kZTViMTU1YTRlIDEwMDY0NA0KPiA+
IC0tLSBhL2NvbmZpZy5jDQo+ID4gKysrIGIvY29uZmlnLmMNCj4gPiBAQCAtODM0LDYgKzgzNCwx
NSBAQCBpbnQgZ2l0X3BhcnNlX3Vsb25nKGNvbnN0IGNoYXIgKnZhbHVlLCB1bnNpZ25lZA0KPiBs
b25nICpyZXQpDQo+ID4gIAlyZXR1cm4gMTsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQg
Z2l0X3BhcnNlX3NzaXplX3QoY29uc3QgY2hhciAqdmFsdWUsIHNzaXplX3QgKnJldCkgew0KPiA+
ICsJc3NpemVfdCB0bXA7DQo+ID4gKwlpZiAoIWdpdF9wYXJzZV9zaWduZWQodmFsdWUsICZ0bXAs
DQo+IG1heGltdW1fc2lnbmVkX3ZhbHVlX29mX3R5cGUoc3NpemVfdCkpKQ0KPiA+ICsJCXJldHVy
biAwOw0KPiA+ICsJKnJldCA9IHRtcDsNCj4gPiArCXJldHVybiAxOw0KPiA+ICt9DQo+ID4gKw0K
PiANCj4gVGhlIHByZXZpb3VzIHZlcnNpb24gb2YgdGhpcyBwYXRjaCBjYXVzZXMgZ2NjIHRvIGNv
bXBsYWluIG9uIGEgTGludXggMzJiaXQNCj4gYnVpbGQsIGxpa2Ugc286DQo+IA0KPiAgICAgQ0Mg
Y29uZmlnLm8NCj4gY29uZmlnLmM6IEluIGZ1bmN0aW9uIOKAmGdpdF9wYXJzZV9zc2l6ZV904oCZ
Og0KPiBjb25maWcuYzo4NDA6MzE6IHdhcm5pbmc6IHBhc3NpbmcgYXJndW1lbnQgMiBvZiDigJhn
aXRfcGFyc2Vfc2lnbmVk4oCZIGZyb20NCj4gaW5jb21wYXRpYmxlIHBvaW50ZXIgdHlwZSBbLVdp
bmNvbXBhdGlibGUtcG9pbnRlci10eXBlc10NCj4gICBpZiAoIWdpdF9wYXJzZV9zaWduZWQodmFs
dWUsICZ0bXAsDQo+IG1heGltdW1fc2lnbmVkX3ZhbHVlX29mX3R5cGUoc3NpemVfdCkpKQ0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiBjb25maWcuYzo3NTM6MTI6IG5vdGU6
IGV4cGVjdGVkIOKAmGludG1heF90ICoge2FrYSBsb25nIGxvbmcgaW50ICp94oCZIGJ1dA0KPiBh
cmd1bWVudCBpcyBvZiB0eXBlIOKAmHNzaXplX3QgKiB7YWthIGludCAqfeKAmQ0KPiAgc3RhdGlj
IGludCBnaXRfcGFyc2Vfc2lnbmVkKGNvbnN0IGNoYXIgKnZhbHVlLCBpbnRtYXhfdCAqcmV0LCBp
bnRtYXhfdCBtYXgpDQo+ICAgICAgICAgICAgIF4NCj4gDQo+IC4uLiBhbmQgSSBkb24ndCB0aGlu
ayB0aGlzIHZlcnNpb24gd291bGQgYmUgYW55IGRpZmZlcmVudCAodGhvdWdoIEkgaGF2ZW4ndA0K
PiB0cmllZCkuDQoNClNvIEkgZ3Vlc3MgdGhhdCBtZWFucyB0bXAgbmVlZHMgdG8gYmUgYW4gaW50
bWF4X3QuDQo=
