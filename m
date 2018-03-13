Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D92261F404
	for <e@80x24.org>; Tue, 13 Mar 2018 23:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932330AbeCMXMZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 19:12:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:64753 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932240AbeCMXMY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 19:12:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2018 16:12:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,466,1515484800"; 
   d="scan'208";a="33608191"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Mar 2018 16:12:24 -0700
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 13 Mar 2018 16:12:24 -0700
Received: from fmsmsx103.amr.corp.intel.com ([169.254.2.34]) by
 fmsmsx111.amr.corp.intel.com ([169.254.12.79]) with mapi id 14.03.0319.002;
 Tue, 13 Mar 2018 16:12:23 -0700
From:   "Carsey, Jaben" <jaben.carsey@intel.com>
To:     'Laszlo Ersek' <lersek@redhat.com>,
        Jonathan Nieder <jrnieder@gmail.com>
CC:     public git mailing list <git@vger.kernel.org>,
        "git-for-windows@googlegroups.com" <git-for-windows@googlegroups.com>
Subject: RE: recent glob expansion breakage on Windows?
Thread-Topic: recent glob expansion breakage on Windows?
Thread-Index: AQHTtyC/LRKOILKPS0CC9kg/0xzujqPHao8AgADC/gCABH1AUA==
Date:   Tue, 13 Mar 2018 23:12:22 +0000
Message-ID: <CB6E33457884FA40993F35157061515CA3C8FC64@FMSMSX103.amr.corp.intel.com>
References: <e0ba9fb9-056e-4979-415b-f8eca47e2490@redhat.com>
 <20180308220356.GA171451@aiede.svl.corp.google.com>
 <3f8076fa-ead3-4034-2d41-364b72169873@redhat.com>
In-Reply-To: <3f8076fa-ead3-4034-2d41-364b72169873@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjg5ODhjN2MtMzc5Yy00NzZhLThmNDgtYmExZWNjYjAyMTI2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6ImxZcnFEN0txSWYxQUo1elAyU011aklXeFVzSlZkZng2OUZWQVY5WlJ4bkE9In0=
x-ctpclassification: CTP_NT
x-originating-ip: [10.1.200.106]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SSBkbyBub3QgcmVtZW1iZXIgd2hhdCB2ZXJzaW9uIEkgd2FzIHVzaW5nIGJlZm9yZS4gIEkgYW0g
c3VkZGVubHkgd29uZGVyaW5nIGlmIEkgcHJldmlvdXNseSBzZW50IHNpbmdsZSBwYXRjaGVzIGlu
c3RlYWQgb2YgdXNpbmcgd2lsZGNhcmQgKHdoaWNoIHdvcmtzIGZpbmUpLiAgVGhlIG9ubHkgcGVy
c29uIEkgaGF2ZSBmb3VuZCBkb2luZyBwYXRjaCBzZXJpZXMgaGVyZSBvbiB3aW5kb3dzIHVzZXMg
dGhlIGRpcmVjdG9yeSBtZXRob2QgKHB1dCBwYXRjaCBmaWxlcyB0aGVyZSwgbGlzdCBkaXJlY3Rv
cnkgbmFtZSBvbiBzZW5kLWVtYWlsIGNvbW1hbmQgbGluZSkuDQoNCkkgaGF2ZSB1cGRhdGVkIHRv
IHRoZSAyLjE2LjIgdmVyc2lvbiBhbmQgSSBzZWUgdGhlIHNhbWUgaXNzdWVzLg0KDQotSmFiZW4N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXN6bG8gRXJzZWsgW21h
aWx0bzpsZXJzZWtAcmVkaGF0LmNvbV0NCj4gU2VudDogRnJpZGF5LCBNYXJjaCAwOSwgMjAxOCAx
OjQyIEFNDQo+IFRvOiBKb25hdGhhbiBOaWVkZXIgPGpybmllZGVyQGdtYWlsLmNvbT4NCj4gQ2M6
IHB1YmxpYyBnaXQgbWFpbGluZyBsaXN0IDxnaXRAdmdlci5rZXJuZWwub3JnPjsgQ2Fyc2V5LCBK
YWJlbg0KPiA8amFiZW4uY2Fyc2V5QGludGVsLmNvbT47IGdpdC1mb3Itd2luZG93c0Bnb29nbGVn
cm91cHMuY29tDQo+IFN1YmplY3Q6IFJlOiByZWNlbnQgZ2xvYiBleHBhbnNpb24gYnJlYWthZ2Ug
b24gV2luZG93cz8NCj4gSW1wb3J0YW5jZTogSGlnaA0KPiANCj4gT24gMDMvMDgvMTggMjM6MDMs
IEpvbmF0aGFuIE5pZWRlciB3cm90ZToNCj4gPiArZ2l0LWZvci13aW5kb3dzDQo+ID4gSGksDQo+
ID4NCj4gPiBMYXN6bG8gRXJzZWsgd3JvdGU6DQo+ID4NCj4gPj4gSmFiZW4gcmVwb3J0cyB0aGF0
IGdpdC1zZW5kLWVtYWlsIGlzIHN1ZGRlbmx5IGZhaWxpbmcgdG8gZXhwYW5kIHRoZQ0KPiA+PiAi
Ki5wYXRjaCIgZ2xvYiBmb3IgaGltLCBhdCB0aGUgV2luZG93cyBDTUQgcHJvbXB0Og0KPiA+Pg0K
PiA+PiAtLS0tLS0tLS0NCj4gPj4gRTpcLi4uPmdpdCBzZW5kLWVtYWlsIC0tc3VwcHJlc3MtY2M9
YXV0aG9yIC0tc3VwcHJlc3MtY2M9c2VsZiAtLXN1cHByZXNzLQ0KPiBjYz1jYyAtLXN1cHByZXNz
LWNjPXNvYiAtLWRyeS1ydW4gKi5wYXRjaA0KPiA+Pg0KPiA+PiBObyBwYXRjaCBmaWxlcyBzcGVj
aWZpZWQhDQo+ID4+IC0tLS0tLS0tLQ0KPiA+Pg0KPiA+PiBXaGVyZWFzLCBtb3ZpbmcgdGhlIHNh
bWUgcGF0Y2ggZmlsZXMgdG8gYW5vdGhlciBzdWJkaXIsIGFuZCB0aGVuIHBhc3NpbmcNCj4gPj4g
dGhlIHN1YmRpciB0byBnaXQtc2VuZC1lbWFpbCwgd29ya3MgZmluZS4NCj4gPj4NCj4gPj4gSSBz
ZWVtIHRvIGhhdmUgZm91bmQgc29tZSAkXk8gYmFzZWQgcGVybCBjb2RlIGluIHRoZSBnaXQgdHJl
ZSB0aGF0DQo+ID4+IGV4cGFuZHMgdGhlIGdsb2IgbWFudWFsbHkgKGluIHBsYWNlIG9mIHRoZSBz
aGVsbCkgb24gV2luZG93cyAtLSBob3dldmVyLA0KPiA+PiB0aGF0IGNvZGUgbG9va3MgYW5jaWVu
dCBeVyB2ZXJ5IHN0YWJsZSwgYW5kIGRvZXNuJ3Qgc2VlbSB0byBleHBsYWluIHRoZQ0KPiA+PiBz
dWRkZW4gYnJlYWthZ2UuDQo+ID4+DQo+ID4+IElzIGl0IHBvc3NpYmxlIHRoYXQgYSBzZXBhcmF0
ZSBwZXJsIHVwZGF0ZSBvbiBKYWJlbidzIFdpbmRvd3MgYm94IGlzDQo+ID4+IGNhdXNpbmcgdGhp
cz8gT3IgZG9lcyB0aGUgYnJlYWthZ2UgbG9vayBjb25zaXN0ZW50IHdpdGggYSByZWNlbnQgZ2l0
DQo+IGNoYW5nZT8NCj4gPj4NCj4gPj4gSGFzIGFueW9uZSBlbHNlIHJlcG9ydGVkIHNvbWV0aGlu
ZyBzaW1pbGFyIHJlY2VudGx5Pw0KPiA+DQo+ID4gVGhpcyByZW1pbmRzIG1lIG9mIGh0dHBzOi8v
Z2l0aHViLmNvbS9naXQtZm9yLXdpbmRvd3MvZ2l0L2lzc3Vlcy8zMzkuDQo+ID4gVGhlcmUsIEpv
aGFubmVzIFNjaGluZGVsaW4gd3JpdGVzIChhYm91dCBhIGRpZmZlcmVudCBjb21tYW5kKToNCj4g
Pg0KPiA+IHwgVGhpcyBpcyBleHBlY3RlZCBiZWNhdXNlIG5laXRoZXIgUG93ZXJTaGVsbCBub3Ig
Y21kLmV4ZSBub3IgZ2l0LmV4ZQ0KPiA+IHwgZXhwYW5kIHdpbGRjYXJkcy4gVGhvc2UgZXhhbXBs
ZXMgeW91IGZvdW5kIHdlcmUgd3JpdHRlbiB3aXRoIGEgc2hlbGwNCj4gPiB8IGluIG1pbmQsIGFu
ZCB0aGUgc2hlbGwgZXhwYW5kcyB3aWxkY2FyZHMgKGhlbmNlIEdpdCBkb2VzIG5vdCB0aGluaw0K
PiA+IHwgaXQgbmVlZHMgdG8pLg0KPiA+DQo+ID4gVGhhdCBtYXkgb3IgbWF5IG5vdCBhbHNvIGFw
cGx5IHRvIHNlbmQtZW1haWwuDQo+IA0KPiBUaGFuayB5b3UgZm9yIHRoZSByZWZlcmVuY2UgLS0g
SSBjYW4ndCBzYXkgd2hldGhlciBjbG9zaW5nIGlzc3VlICMzMzkgYXMNCj4gV09OVEZJWCB3YXMg
anVzdGlmaWVkIG9yIG5vdCwgYnV0IGl0IGNlcnRhaW5seSBzZWVtcyBpbmNvbnNpc3RlbnQgd2l0
aA0KPiBKYWJlbidzIGVhcmxpZXIgZXhwZXJpZW5jZSAodG8gbXkgdW5kZXJzdGFuZGluZyksIGku
ZS4gdGhhdCBnaXQgZGlkDQo+IGV4cGFuZCB0aGUgZ2xvYi4NCj4gDQo+ID4gSW4gd2hhdCB2ZXJz
aW9uIGRpZCBpdCB3b3JrPw0KPiANCj4gSmFiZW4sIGNhbiB5b3UgcGxlYXNlIGFuc3dlciB0aGF0
PyAoT25lIHZlcnNpb24gaW4gd2hpY2ggaXQgaXMgYnJva2VuIGlzDQo+IDIuMTQuMS53aW5kb3dz
LjEuKSBDYW4geW91IHBlcmhhcHMgYXNrIHlvdXIgdGVhbW1hdGVzIGFib3V0IHRoZWlyDQo+IGdp
dC93aW5kb3dzIHZlcnNpb25zIChhc3N1bWluZyB0aGUgKi5wYXRjaCBnbG9iIGlzIGV4cGFuZGVk
IGNvcnJlY3RseQ0KPiBmb3IgdGhlbSk/DQo+IA0KPiBUaGFuayB5b3UsIEpvbmF0aGFuLA0KPiBM
YXN6bG8NCg==
