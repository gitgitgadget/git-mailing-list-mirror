From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 5/6] stash: default listing to "--cc
 --simplify-combined-diff"
Date: Tue, 12 Aug 2014 23:30:56 +0000
Message-ID: <1407886257.22389.13.camel@jekeller-desk1.amr.corp.intel.com>
References: <20140729175300.GA21536@peff.net>
	 <20140729175725.GE31181@peff.net>
	 <xmqqppgo2dqr.fsf@gitster.dls.corp.google.com>
	 <xmqqtx5yy6nm.fsf@gitster.dls.corp.google.com>
	 <20140731000907.GA22297@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>
To: "peff@peff.net" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 13 01:31:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHLXA-0002eA-Nk
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 01:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbaHLXbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 19:31:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:22072 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793AbaHLXbL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 19:31:11 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 12 Aug 2014 16:31:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,852,1400050800"; 
   d="scan'208";a="575843195"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga001.fm.intel.com with ESMTP; 12 Aug 2014 16:31:01 -0700
Received: from orsmsx159.amr.corp.intel.com (10.22.240.24) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.195.1; Tue, 12 Aug 2014 16:30:57 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.205]) by
 ORSMSX159.amr.corp.intel.com ([169.254.11.127]) with mapi id 14.03.0195.001;
 Tue, 12 Aug 2014 16:30:57 -0700
Thread-Topic: [PATCH v2 5/6] stash: default listing to "--cc
 --simplify-combined-diff"
Thread-Index: AQHPrC5920eCipduckuPz4+EhaPovpu5xEaAgBRjpIA=
In-Reply-To: <20140731000907.GA22297@peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <48FF7E3DC1EE974B9C82BB0956C6298E@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255175>

T24gV2VkLCAyMDE0LTA3LTMwIGF0IDIwOjA5IC0wNDAwLCBKZWZmIEtpbmcgd3JvdGU6DQo+IE9u
IFdlZCwgSnVsIDMwLCAyMDE0IGF0IDEyOjQzOjA5UE0gLTA3MDAsIEp1bmlvIEMgSGFtYW5vIHdy
b3RlOg0KPiANCj4gPiA+ICJnaXQgbG9nIC0tY2MiIGlzIG9uZSBvZiB0aGUgdGhpbmdzIEkgd2Fu
dGVkIGZvciBhIGxvbmcgdGltZSB0byBmaXguDQo+ID4gPiBXaGVuIHRoZSB1c2VyIGV4cGxpY2l0
bHkgYXNrcyAiLS1jYyIsIHdlIGN1cnJlbnRseSBpZ25vcmUgaXQsIGJ1dA0KPiA+ID4gYmVjYXVz
ZSB3ZSBrbm93IHRoZSB1c2VyIHdhbnRzIHRvIHZpZXcgY29tYmluZWQgZGlmZiwgd2Ugc2hvdWxk
IHR1cm4NCj4gPiA+ICItcCIgb24gYXV0b21hdGljYWxseS4gIEFuZCB0aGUgY2hhbmdlIHRoaXMg
cGF0Y2ggaW50cm9kdWNlcyB3aWxsIGJlDQo+ID4gPiBicm9rZW4gd2hlbiB3ZSBmaXggImxvZyAt
LWNjIiAoInN0YXNoIGxpc3QiIHdpbGwgZW5kIHVwIGFsd2F5cw0KPiA+ID4gc2hvd2luZyB0aGUg
cGF0Y2gsIHdpdGhvdXQgYSB3YXkgdG8gZGlzYWJsZSBpdCkuDQo+ID4gPg0KPiA+ID4gQ2FuIHlv
dSBtYWtlIHRoaXMgY29uZGl0aW9uYWw/ICBEbyB0aGlzIG9ubHkgd2hlbiA8b3B0aW9ucz4gYXJl
DQo+ID4gPiBnaXZlbiB0byAiZ2l0IHN0YXNoIGxpc3QiIGNvbW1hbmQgYW5kIHRoYXQgaW5jbHVk
ZXMgIi1wIiBvcg0KPiA+ID4gc29tZXRoaW5nPw0KPiANCj4gSSdtIGRlZmluaXRlbHkgc3ltcGF0
aGV0aWMuIFVzaW5nICItLWNjIiB3aXRoIHRoZSBkaWZmIGZhbWlseSBfZG9lc18NCj4gaW1wbHkg
Ii1wIiBhbHJlYWR5LCBzbyBpdCB3b3VsZCBiZSBuaWNlIHRvIGRvIHRoZSBzYW1lIGZvciB0aGUg
bG9nDQo+IGZhbWlseS4NCj4gDQo+ID4gUGVyaGFwcyBzb21ldGhpbmcgYWxvbmcgdGhpcyBsaW5l
Pw0KPiA+IA0KPiA+ICBnaXQtc3Rhc2guc2ggfCAxMSArKysrKysrKystLQ0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYg
LS1naXQgYS9naXQtc3Rhc2guc2ggYi9naXQtc3Rhc2guc2gNCj4gPiBpbmRleCBhZTczYmE0Li4w
ZGIxYjE5IDEwMDc1NQ0KPiA+IC0tLSBhL2dpdC1zdGFzaC5zaA0KPiA+ICsrKyBiL2dpdC1zdGFz
aC5zaA0KPiA+IEBAIC0yOTcsOCArMjk3LDE1IEBAIGhhdmVfc3Rhc2ggKCkgew0KPiA+ICANCj4g
PiAgbGlzdF9zdGFzaCAoKSB7DQo+ID4gIAloYXZlX3N0YXNoIHx8IHJldHVybiAwDQo+ID4gLQln
aXQgbG9nIC0tZm9ybWF0PSIlZ2Q6ICVncyIgLWcgLS1jYyAtLXNpbXBsaWZ5LWNvbWJpbmVkLWRp
ZmYgXA0KPiA+IC0JCSIkQCIgJHJlZl9zdGFzaCAtLQ0KPiA+ICsJY2FzZSAiICQqICIgaW4NCj4g
PiArCSonIC0tY2MgJyopDQo+ID4gKwkJOzsgIyB0aGUgdXNlciBrbm93cyB3aGF0IHNoZSBpcyBk
b2luZw0KPiA+ICsJKicgLXAgJyogfCAqJyAtVScqKQ0KPiA+ICsJCXNldCB4ICItLWNjIiAiLS1z
aW1wbGlmeS1jb21iaW5lZC1kaWZmIiAiJEAiDQo+ID4gKwkJc2hpZnQNCj4gPiArCQk7Ow0KPiA+
ICsJZXNhYw0KPiA+ICsJZ2l0IGxvZyAtLWZvcm1hdD0iJWdkOiAlZ3MiIC1nICIkQCIgJHJlZl9z
dGFzaCAtLQ0KPiANCj4gVWdoLiBJJ2QgZ2VuZXJhbGx5IGxpa2UgdG8gYXZvaWQgdGhpcyBzb3J0
IG9mIGFkLWhvYyBjb21tYW5kIGxpbmUNCj4gcGFyc2luZywgYXMgaXQgaXMgZWFzeSB0byBnZXQg
Y29uZnVzZWQgYnkgb3B0aW9uIGFyZ3VtZW50cyBvcg0KPiBldmVuIG5vbi1vcHRpb25zLiBBdCBs
ZWFzdCB3ZSBkbyBub3QgaGF2ZSB0byB3b3JyeSBhYm91dCBwYXRoc3BlY3MgaGVyZSwNCj4gYXMg
d2UgYWxyZWFkeSBkbyBhbiBleHBsaWNpdCAiLS0iIChzbyB3ZSBtaWdodCBiZSBjb25mdXNlZCBi
eSB0aGVtLCBidXQNCj4gdGhleSBhcmUgYnJva2VuIGFueXdheSkuDQo+IA0KPiBTdGlsbCwgSSB3
b25kZXIgaWYgYSBjbGVhbmVyIHNvbHV0aW9uIGlzIHRvIHByb3ZpZGUgYWx0ZXJuYXRlICJkZWZh
dWx0DQo+IHRvIHRoaXMiIG9wdGlvbnMgZm9yIHRoZSByZXZpc2lvbi5jIG9wdGlvbiBwYXJzZXIu
IFdlIGFscmVhZHkgaGF2ZQ0KPiAiLS1kZWZhdWx0IiB0byBwaWNrIHRoZSBkZWZhdWx0IHN0YXJ0
aW5nIHBvaW50LiBDb3VsZCB3ZSBkbyBzb21ldGhpbmcNCj4gbGlrZSAiLS1kZWZhdWx0LW1lcmdl
LWhhbmRsaW5nPWNjIiBvciBzb21ldGhpbmc/DQo+IA0KPiBUaGVyZSdzIGEgc2ltaWxhciBhZC1o
b2MgcGFyc2luZyBjYXNlIGluICJzdGFzaCBzaG93Iiwgd2hlcmUgd2UgYWRkDQo+ICItLXN0YXQi
IGlmIG5vIGFyZ3VtZW50cyBhcmUgZ2l2ZW4sIGJ1dCB3ZSBoYXZlIG5vIGNsdWUgaWYgYSBkaWZm
IGZvcm1hdA0KPiB3YXMgZ2l2ZW4gKHNvICJnaXQgc3Rhc2ggc2hvdyAtLWNvbG9yIiBhY2NpZGVu
dGFsbHkgdHVybnMgb24gcGF0Y2gNCj4gZm9ybWF0ISkuIFNvbWV0aGluZyBsaWtlICItLWRlZmF1
bHQtZGlmZi1mb3JtYXQ9c3RhdCIgd291bGQgYmUgbW9yZQ0KPiByb2J1c3QuDQo+IA0KPiBJIGR1
bm5vLiBNYXliZSBpdCBpcyBvdmVyLWVuZ2luZWVyaW5nLiBJIGp1c3QgaGF0ZSB0byBzZWUgc29s
dXRpb25zIHRoYXQNCj4gd29yayBtb3N0IG9mIHRoZSB0aW1lIGFuZCBjcnVtYmxlIGluIHdlaXJk
IGNvcm5lciBjYXNlcywgZXZlbiBpZiBwZW9wbGUNCj4gZG9uJ3QgaGl0IHRob3NlIGNvcm5lciBj
YXNlcyB2ZXJ5IG9mdGVuLg0KPiANCj4gLVBlZmYNCg0KSSBhZ3JlZSB3aXRoIHlvdSBvbiB0aGlz
IG9uZS4gVGhvc2UgY29ybmVyIGNhc2VzIHRlbmQgdG8gYml0ZSB0aGUgd29yc3QuDQoNClRoYW5r
cywNCkpha2UNCg0KPiAtLQ0KPiBUbyB1bnN1YnNjcmliZSBmcm9tIHRoaXMgbGlzdDogc2VuZCB0
aGUgbGluZSAidW5zdWJzY3JpYmUgZ2l0IiBpbg0KPiB0aGUgYm9keSBvZiBhIG1lc3NhZ2UgdG8g
bWFqb3Jkb21vQHZnZXIua2VybmVsLm9yZw0KPiBNb3JlIG1ham9yZG9tbyBpbmZvIGF0ICBodHRw
Oi8vdmdlci5rZXJuZWwub3JnL21ham9yZG9tby1pbmZvLmh0bWwNCg0KDQo=
