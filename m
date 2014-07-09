From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH] remote-curl: do not complain on EOF from parent git
Date: Wed, 9 Jul 2014 21:25:18 +0000
Message-ID: <1404941118.23510.34.camel@jekeller-desk1.amr.corp.intel.com>
References: <787461404891471@web12h.yandex.ru>
	 <20140709205902.GB25854@sigill.intra.peff.net>
	 <20140709212043.GC25854@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"wipedout@yandex.ru" <wipedout@yandex.ru>
To: "peff@peff.net" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 09 23:25:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4zMm-0001nM-Un
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 23:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755448AbaGIVZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 17:25:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:3121 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754469AbaGIVZY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 17:25:24 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP; 09 Jul 2014 14:25:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,633,1400050800"; 
   d="scan'208";a="567568709"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jul 2014 14:25:20 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.123.3; Wed, 9 Jul 2014 14:25:19 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.193]) by
 ORSMSX116.amr.corp.intel.com ([10.22.240.14]) with mapi id 14.03.0123.003;
 Wed, 9 Jul 2014 14:25:19 -0700
Thread-Topic: [PATCH] remote-curl: do not complain on EOF from parent git
Thread-Index: AQHPm7uzNu2lzVZonkm0OdReun9a65uYtnEA
In-Reply-To: <20140709212043.GC25854@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <8C70513EB30ECC45A027E20EC0FF7423@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253154>

T24gV2VkLCAyMDE0LTA3LTA5IGF0IDE3OjIwIC0wNDAwLCBKZWZmIEtpbmcgd3JvdGU6DQo+IFRo
ZSBwYXJlbnQgZ2l0IHByb2Nlc3MgaXMgc3VwcG9zZWQgdG8gc2VuZCB1cyBhbiBlbXB0eSBsaW5l
DQo+IHRvIGluZGljYXRlIHRoYXQgdGhlIGNvbnZlcnNhdGlvbiBpcyBvdmVyLiBIb3dldmVyLCB0
aGUNCj4gcGFyZW50IHByb2Nlc3MgbWF5IGRpZSgpIGlmIHRoZXJlIGlzIGEgcHJvYmxlbSB3aXRo
IHRoZQ0KPiBvcGVyYWl0b24gKGUuZy4sIHdlIHRyeSB0byBmZXRjaCBhIHJlZiB0aGF0IGRvZXMg
bm90IGV4aXN0KS4gDQoNCk5pdHBpY2ssIGJ1dCB5b3UgcHJvYmFibHkgbWVhbnQgb3BlcmF0aW9u
IGhlcmUuDQoNClRoYW5rcywNCkpha2UNCg0KPiBJbiB0aGlzIGNhc2UsIGl0IHByb2R1Y2VzIGEg
dXNlZnVsIG1lc3NhZ2UsIGJ1dCB0aGVuDQo+IHJlbW90ZS1jdXJsIF9hbHNvXyBwcm9kdWNlcyBh
biB1bmhlbHBmdWwgbWVzc2FnZToNCj4gDQo+ICAgJCBnaXQgcHVsbCBvcmlnaW4gbWF0c2VyDQo+
ICAgZmF0YWw6IGNvdWxkbid0IGZpbmQgcmVtb3RlIHJlZiBtYXRzZXINCj4gICBVbmV4cGVjdGVk
IGVuZCBvZiBjb21tYW5kIHN0cmVhbQ0KPiANCj4gVGhlICJyaWdodCIgd2F5IHRvIGZpeCB0aGlz
IGlzIHRvIHRlYWNoIHRoZSBwYXJlbnQgZ2l0IHRvDQo+IGFsd2F5cyBjbGVhbmx5IGNsb3NlIHRo
ZSBjb25uZWN0aW9uIHRvIHRoZSBoZWxwZXIsIGxldHRpbmcNCj4gaXQga25vdyB0aGF0IHdlIGFy
ZSBkb25lLiBJbXBsZW1lbnRpbmcgdGhhdCBpcyByYXRoZXINCj4gY2x1bmt5LCB0aG91Z2gsIGFz
IGl0IHdvdWxkIGludm9sdmUgZWl0aGVyIHJlcGxhY2luZyBkaWUoKQ0KPiBvcGVyYXRpb25zIHdp
dGggcmV0dXJuaW5nIGVycm9ycyB1cCB0aGUgc3RhY2sgKHVudGlsIHdlDQo+IGRpc2Nvbm5lY3Qg
dGhlIHRyYW5zcG9ydCksIG9yIGFkZGluZyBhbiBhdGV4aXQgaGFuZGxlciB0bw0KPiBjbGVhbiB1
cCBhbnkgdHJhbnNwb3J0IGhlbHBlcnMgbGVmdCBvcGVuLg0KPiANCj4gSXQncyBtdWNoIHNpbXBs
ZXIgdG8ganVzdCBzdXBwcmVzcyB0aGUgRU9GIG1lc3NhZ2UgaW4NCj4gcmVtb3RlLWN1cmwuIEl0
IHdhcyBub3QgYWRkZWQgdG8gYWRkcmVzcyBhbnkgcmVhbC13b3JsZA0KPiBzaXR1YXRpb24gaW4g
dGhlIGZpcnN0IHBsYWNlLCBidXQgcmF0aGVyIGEgIndlIHNob3VsZA0KPiBwcm9iYWJseSByZXBv
cnQgdW5leHBlY3RlZCB0aGluZ3MiIHN1Z2dlc3Rpb25bMV0uDQo+IA0KPiBJdCBpcyB0aGUgcGFy
ZW50IGdpdCB3aGljaCBkcml2ZXMgdGhlIG9wZXJhdGlvbiwgYW5kIHdob3NlDQo+IGV4aXQgdmFs
dWUgYWN0dWFsbHkgbWF0dGVycy4gSWYgdGhlIHBhcmVudCBkaWVzLCB0aGVuIHRoZQ0KPiBoZWxw
ZXIgaGFzIG5vIG5lZWQgdG8gY29tcGxhaW4gKGV4Y2VwdCBhcyBhIGRlYnVnZ2luZyBhaWQpLg0K
PiBJbiB0aGUgb2ZmIGNoYW5jZSB0aGF0IHRoZSBwaXBlIGlzIGNsb3NlZCB3aXRob3V0IHRoZSBw
YXJlbnQNCj4gZHlpbmcsIHRoZSBwYXJlbnQgY2FuIHN0aWxsIG5vdGljZSB0aGUgbm9uLXplcm8g
ZXhpdCBjb2RlLg0KPiANCj4gWzFdIGh0dHA6Ly9hcnRpY2xlLmdtYW5lLm9yZy9nbWFuZS5jb21w
LnZlcnNpb24tY29udHJvbC5naXQvMTc2MDM2DQo+IA0KPiBSZXBvcnRlZC1ieTogRG1pdHJ5IDx3
aXBlZG91dEB5YW5kZXgucnU+DQo+IFNpZ25lZC1vZmYtYnk6IEplZmYgS2luZyA8cGVmZkBwZWZm
Lm5ldD4NCj4gLS0tDQo+IFRoZSBvcmlnaW5hbCBkaXNjdXNzaW9uIHRoYXQgbGVkIHRvIHRoaXMg
Y29kZSBiZWluZyBpbXBsZW1lbnRlZCB3YXMgZHVlDQo+IHRvIHVzIGNoZWNraW5nIHRoZSBoZWxw
ZXIncyBleGl0IGNvZGUgaW4gdGhlIGZpcnN0IHBsYWNlLiBIb3dldmVyLCB3ZQ0KPiBzZWVtIHRv
IGJlIGluY29uc2lzdGVudCBhYm91dCBkb2luZyBzby4gSSdtIG5vdCBpbmNsaW5lZCB0byBwdXJz
dWUgaXQNCj4gZnVydGhlciwgdGhvdWdoLCBhcyB0aGVzZSBzdWJ0bGUgZGV0YWlscyBvZiB0aGUg
dHJhbnNwb3J0IGhlbHBlciBjb2RlDQo+IHVzdWFsbHkgdHVybiBpbnRvIGEgY2FuIG9mIHdvcm1z
LCBhbmQgbW9yZSBpbXBvcnRhbnRseSwgSSBkb24ndCB0aGluayBpdA0KPiBodXJ0cyBhbnl0aGlu
ZyBpbiB0aGUgcmVhbCB3b3JsZC4gRWl0aGVyIHRoZSBwYXJlbnQgZ2l0IGdldHMgdGhlDQo+IGV4
cGVjdGVkIHByb3RvY29sIG91dHB1dCBmcm9tIHRoZSBoZWxwZXIgb3IgaXQgZG9lc24ndCwgYW5k
IHdlIHJlcG9ydA0KPiBlcnJvcnMgb24gdGhhdC4gQW4gZXJyb3IgZnJvbSBhIGhlbHBlciBhZnRl
ciB0aGUgb3BlcmF0aW9uIGNvbXBsZXRlcyBpcw0KPiBub3QgcmVhbGx5IGltcG9ydGFudCB0byB0
aGUgcGFyZW50IGdpdCBlaXRoZXIgd2F5Lg0KPiANCj4gIHJlbW90ZS1jdXJsLmMgfCAyIC0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9yZW1v
dGUtY3VybC5jIGIvcmVtb3RlLWN1cmwuYw0KPiBpbmRleCA0NDkzYjM4Li4wNDU0ZmZjIDEwMDY0
NA0KPiAtLS0gYS9yZW1vdGUtY3VybC5jDQo+ICsrKyBiL3JlbW90ZS1jdXJsLmMNCj4gQEAgLTk3
MSw4ICs5NzEsNiBAQCBpbnQgbWFpbihpbnQgYXJnYywgY29uc3QgY2hhciAqKmFyZ3YpDQo+ICAJ
CWlmIChzdHJidWZfZ2V0bGluZSgmYnVmLCBzdGRpbiwgJ1xuJykgPT0gRU9GKSB7DQo+ICAJCQlp
ZiAoZmVycm9yKHN0ZGluKSkNCj4gIAkJCQlmcHJpbnRmKHN0ZGVyciwgIkVycm9yIHJlYWRpbmcg
Y29tbWFuZCBzdHJlYW1cbiIpOw0KPiAtCQkJZWxzZQ0KPiAtCQkJCWZwcmludGYoc3RkZXJyLCAi
VW5leHBlY3RlZCBlbmQgb2YgY29tbWFuZCBzdHJlYW1cbiIpOw0KPiAgCQkJcmV0dXJuIDE7DQo+
ICAJCX0NCj4gIAkJaWYgKGJ1Zi5sZW4gPT0gMCkNCg0KDQo=
