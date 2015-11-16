From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 1/2] sendemail: teach git-send-email to list aliases
Date: Mon, 16 Nov 2015 23:40:27 +0000
Message-ID: <1447717227.23262.10.camel@intel.com>
References: <1447618940-27446-1-git-send-email-jacob.e.keller@intel.com>
	 <CAPig+cQ929oAZqQM+X68x3PVQ-opwdi3VzjcQTUsaCfVK3411g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"spearce@spearce.org" <spearce@spearce.org>,
	"felipe.contreras@gmail.com" <felipe.contreras@gmail.com>,
	"szeder@ira.uka.de" <szeder@ira.uka.de>,
	"jacob.keller@gmail.com" <jacob.keller@gmail.com>,
	"lee.marlow@gmail.com" <lee.marlow@gmail.com>
To: "sunshine@sunshineco.com" <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 00:40:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyTNy-00069M-V9
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 00:40:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbbKPXkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 18:40:31 -0500
Received: from mga01.intel.com ([192.55.52.88]:20437 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967AbbKPXk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 18:40:29 -0500
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP; 16 Nov 2015 15:40:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,304,1444719600"; 
   d="scan'208";a="687039642"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga003.jf.intel.com with ESMTP; 16 Nov 2015 15:40:29 -0800
Received: from orsmsx152.amr.corp.intel.com (10.22.226.39) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.248.2; Mon, 16 Nov 2015 15:40:28 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.96]) by
 ORSMSX152.amr.corp.intel.com ([169.254.8.204]) with mapi id 14.03.0248.002;
 Mon, 16 Nov 2015 15:40:27 -0800
Thread-Topic: [PATCH v2 1/2] sendemail: teach git-send-email to list aliases
Thread-Index: AQHRH+NeL2JBu1hRzUqsWBsvOxZ9JJ6f09QAgAAC2YA=
In-Reply-To: <CAPig+cQ929oAZqQM+X68x3PVQ-opwdi3VzjcQTUsaCfVK3411g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.3.123]
Content-ID: <F9C393CF979FCA44A0402E60AD497495@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281366>

T24gTW9uLCAyMDE1LTExLTE2IGF0IDE4OjMwIC0wNTAwLCBFcmljIFN1bnNoaW5lIHdyb3RlOg0K
PiBPbiBTdW4sIE5vdiAxNSwgMjAxNSBhdCAzOjIyIFBNLCBKYWNvYiBLZWxsZXIgPGphY29iLmUu
a2VsbGVyQGludGVsLmMNCj4gb20+IHdyb3RlOg0KPiA+IEFkZCBhbiBvcHRpb24gImxpc3QtYWxp
YXNlcyIgd2hpY2ggY2hhbmdlcyB0aGUgZGVmYXVsdCBiZWhhdmlvciBvZg0KPiA+IGdpdC1zZW5k
LWVtYWlsLiBUaGlzIG1vZGUgd2lsbCBzaW1wbHkgcmVhZCB0aGUgYWxpYXMgZmlsZXMNCj4gPiBj
b25maWd1cmVkIGJ5DQo+ID4gc2VuZGVtYWlsLmFsaWFzZXNmaWxlIGFuZCBzZW5kZW1haWwuYWxp
YXNmaWxldHlwZSBhbmQgcHJpbnQgYSBsaXN0DQo+ID4gb2YNCj4gPiBhbGwga25vd24gYWxpYXNl
cy4gVGhlIGludGVuZGVkIHVzZWNhc2UgZm9yIHRoaXMgb3B0aW9uIGlzIHRoZQ0KPiA+IGJhc2gt
Y29tcGxldGlvbiBzY3JpcHQgd2hpY2ggd2lsbCB1c2UgaXQgdG8gYXV0b2NvbXBsZXRlIGFsaWFz
ZXMgb24NCj4gPiB0aGUNCj4gPiBvcHRpb25zIHdoaWNoIHRha2UgYWRkcmVzc2VzLg0KPiANCj4g
QXMgdGhpcyBpcyBwcmltYXJpbHkgYSBwbHVtYmluZyBvcHRpb24sIEkgd29uZGVyIGlmIC0tZHVt
cC1hbGlhc2VzDQo+IG1pZ2h0IGJlIGEgbW9yZSBzdWl0YWJsZSBuYW1lLg0KPiANCg0KU3VyZSB0
aGF0IHdvdWxkIGJlIHJlYXNvbmFibGUuDQoNCj4gQWxzbywgaXMgaXQgcG9zc2libGUgdGhhdCBz
b21lIGNvbnN1bWVyIGRvd24gdGhlIHJvYWQgbWlnaHQgd2FudA0KPiByaWNoZXIgb3V0cHV0IHdo
aWNoIGluY2x1ZGVzIHRoZSBleHBhbnNpb24gb2YgZWFjaCBhbGlhcz8gRm9yDQo+IGluc3RhbmNl
LCBpdCBjb3VsZCBlbWl0IHRoZSBhbGlhcyBuYW1lIGFzIHRoZSBmaXJzdCB0b2tlbiBvbiBlYWNo
DQo+IGxpbmUNCj4gYW5kIHRoZSBleHBhbnNpb24gYXMgdGhlIHJlbWFpbmRlci4gQ29uc3VtZXJz
IGludGVyZXN0ZWQgaW4gb25seSB0aGUNCj4gYWxpYXMgbmFtZSB3b3VsZCBncmFiIHRoZSBmaXJz
dCB0b2tlbiBvbiB0aGUgbGluZSBhbmQgaWdub3JlDQo+IGV2ZXJ5dGhpbmcgZWxzZS4NCj4gDQoN
Ck1heWJlPyBUaGUgcHJvYmxlbSB3aXRoIHByaW50aW5nIHRoZSBmdWxsIGFkZHJlc3MgaXMgdGhh
dCBpdCBtYXkgbm90IGJlDQpxdW90ZWQgb3Igc2ltaWxhciwgYW5kIGl0IG1ha2VzIHRoZSBiYXNo
IGNvbXBsZXRpb24gcmVxdWlyZSBhbiBleHRyYQ0KcGFyYW1ldGVyLi4gSSBhbSBub3Qgc3VyZSBo
b3cgdmFsdWFibGUgdGhlIGFsaWFzIGV4cGFuc2lvbiB3b3VsZCBiZSBmb3INCnVzZT8gVGhlIG1h
aW4gY29uY2VybiBJIGhhdmUgaXMgd2UnZCBuZWVkIHRvIHVzZSBhbm90aGVyIHByb2Nlc3Mgb24g
dG9wDQp0byBleHRyYWN0IG9ubHkgYWxpYXMgbmFtZXMuDQoNCj4gPiBTaWduZWQtb2ZmLWJ5OiBK
YWNvYiBLZWxsZXIgPGphY29iLmtlbGxlckBnbWFpbC5jb20+DQo+ID4gLS0tDQo+ID4gZGlmZiAt
LWdpdCBhL2dpdC1zZW5kLWVtYWlsLnBlcmwgYi9naXQtc2VuZC1lbWFpbC5wZXJsDQo+ID4gQEAg
LTEwMSw2ICsxMDIsOSBAQCBnaXQgc2VuZC1lbWFpbCBbb3B0aW9uc10gPGZpbGUgfCBkaXJlY3Rv
cnkgfA0KPiA+IHJldi1saXN0IG9wdGlvbnMgPg0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBgZ2l0
IGZvcm1hdC1wYXRjaGAgb25lcy4NCj4gPiDCoMKgwqDCoMKgLS1mb3JjZcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCogU2VuZCBldmVuIGlmIHNhZmV0eSBj
aGVja3MNCj4gPiB3b3VsZCBwcmV2ZW50IGl0Lg0KPiA+IA0KPiA+ICvCoMKgSW5mb3JtYXRpb246
DQo+ID4gK8KgwqDCoMKgLS1saXN0LWFsaWFzZXPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgKiByZWFkIHRoZSBhbGlhc2VzIGZyb20NCj4gPiBjb25maWd1cmVkIGFsaWFzIGZpbGVz
DQo+IA0KPiBUaGlzIGRlc2NyaXB0aW9uIGlzIG9kZC4gSXQgc2VlbXMgdG8gaW1wbHkgdGhhdCBh
bGlhc2VzIHdpbGwgYmUNCj4gbG9hZGVkDQo+IChhbmQgdXNlZCkgb25seSBpZiB0aGlzIG9wdGlv
biBpcyBnaXZlbiwgYW5kIHNheXMgbm90aGluZyBhYm91dCBpdHMNCj4gYWN0dWFsIHB1cnBvc2Ug
b2YgZHVtcGluZyB0aGUgYWxpYXNlcy4NCj4gDQoNCkkgY2FuIHJlLXdvcmQgdGhpcy4NCg0KPiBB
bHNvLCB3aXRoIG9uZSBleGNlcHRpb24sIGFsbCB0aGUgb3RoZXIgb3B0aW9uIGRlc2NyaXB0aW9u
cyBhcmUNCj4gY2FwaXRhbGl6ZWQuIFRoaXMgcHJvYmFibHkgb3VnaHQgdG8gZm9sbG93IHN1aXQu
DQo+IA0KPiA+ICtpZiAoJGxpc3RfYWxpYXNlcykgew0KPiA+ICvCoMKgwqDCoHByaW50ICRfLCJc
biIgZm9yIChrZXlzICVhbGlhc2VzKTsNCj4gPiArwqDCoMKgwqBleGl0KDApOw0KPiA+ICt9DQo+
IA0KPiBOZXcgdGVzdChzKSBzZWVtIHRvIGJlIG1pc3NpbmcuDQo+IA0KDQpJIGhhZCByZW1vdmVk
IHRoZSB0ZXN0cyBmcm9tIHRoZSBvbGQgdmVyc2lvbiBiZWNhdXNlIHRoZXkgd2VyZW4ndA0KbmVj
ZXNzYXJ5IGFueW1vcmUuIE5ldyBvbmVzIHdvdWxkbid0IGh1cnQgaGVyZSBlaXRoZXIsIHRob3Vn
aC4uIEknbGwNCndvcmsgb24gdGhhdC4NCg0KUmVnYXJkcywNCkpha2UNCg0KPiAtLQ0KPiBUbyB1
bnN1YnNjcmliZSBmcm9tIHRoaXMgbGlzdDogc2VuZCB0aGUgbGluZSAidW5zdWJzY3JpYmUgZ2l0
IiBpbg0KPiB0aGUgYm9keSBvZiBhIG1lc3NhZ2UgdG8gbWFqb3Jkb21vQHZnZXIua2VybmVsLm9y
Zw0KPiBNb3JlIG1ham9yZG9tbyBpbmZvIGF0wqDCoGh0dHA6Ly92Z2VyLmtlcm5lbC5vcmcvbWFq
b3Jkb21vLWluZm8uaHRtbA==
