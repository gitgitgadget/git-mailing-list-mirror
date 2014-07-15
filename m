From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH v8 1/4] usage: make error functions a stack
Date: Tue, 15 Jul 2014 23:24:32 +0000
Message-ID: <1405466672.2577.14.camel@jekeller-desk1.amr.corp.intel.com>
References: <1405459754-4220-1-git-send-email-jacob.e.keller@intel.com>
	 <1405459754-4220-2-git-send-email-jacob.e.keller@intel.com>
	 <xmqq7g3etf1o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 01:24:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7C5V-0008Os-Pk
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965250AbaGOXYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:24:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:5992 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934155AbaGOXYe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:24:34 -0400
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP; 15 Jul 2014 16:24:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,668,1400050800"; 
   d="scan'208";a="543898627"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga001.jf.intel.com with ESMTP; 15 Jul 2014 16:24:33 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.59]) by
 ORSMSX103.amr.corp.intel.com ([169.254.2.34]) with mapi id 14.03.0123.003;
 Tue, 15 Jul 2014 16:24:33 -0700
Thread-Topic: [PATCH v8 1/4] usage: make error functions a stack
Thread-Index: AQHPoH7MecXJzaW2eE+GxUkwp9ZNCpuiPDgA
In-Reply-To: <xmqq7g3etf1o.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <466DA04261F8EB4FA2BAB153E876A721@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253619>

T24gVHVlLCAyMDE0LTA3LTE1IGF0IDE1OjQ3IC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+IHdyaXRlczoNCj4gDQo+
ID4gIGV4dGVybiB2b2lkIHNldF9lcnJvcl9yb3V0aW5lKHZvaWQgKCpyb3V0aW5lKShjb25zdCBj
aGFyICplcnIsIHZhX2xpc3QgcGFyYW1zKSk7DQo+ID4gK2V4dGVybiB2b2lkIHBvcF9lcnJvcl9y
b3V0aW5lKHZvaWQpOw0KPiANCj4gcG9wIHRoYXQgdW5kb2VzIHNldCBzbWVsbHMgc29tZXdoYXQg
d2VpcmQuICBQZXJoYXBzIHdlIHNob3VsZCByZW5hbWUNCj4gc2V0IHRvIHB1c2g/ICBUaGF0IHdv
dWxkIGFsbG93IHVzIGNhdGNoIHBvc3NpYmxlIHRvcGljcyB0aGF0IGFkZCBuZXcNCj4gY2FsbHMg
dG8gc2V0X2Vycm9yX3JvdXRpbmUoKSBhcyB3ZWxsIGJ5IGZvcmNpbmcgdGhlIHN5c3RlbSBub3Qg
dG8NCj4gbGluayB3aGVuIHRoZXkgYXJlIG1lcmdlZCB3aXRob3V0IG5lY2Vzc2FyeSBmaXhlcy4N
Cj4gDQoNCkkgdGhvdWdodCBhYm91dCBjaGFuZ2luZyBzZXQgdG9vLCBidXQgd2Fzbid0IHN1cmUg
dGhhdCBtYWRlIHNlbnNlLi4/DQpUaGF0IGRvZXMgbWFrZSBtb3JlIHNlbnNlIG5vdyB0aG91Z2gu
IFRoZXJlICphcmUqIHZhbGlkIHVzZSBjYXNlcyB3aGVyZQ0KYSBzZXRfZXJyb3Jfcm91dGluZSBp
cyB1c2VkIHdpdGhvdXQgYSBwb3AsICh0aGUgb25lIGN1cnJlbnQgdXNlLCBJDQp0aGluaykuDQoN
CkknbGwgdXBkYXRlIHRoaXMgcGF0Y2ggd2l0aCB0aGF0IGNoYW5nZS4NCg0KPiA+ICsvKiBwdXNo
IGVycm9yIHJvdXRpbmUgb250byB0aGUgZXJyb3IgZnVuY3Rpb24gc3RhY2sgKi8NCj4gPiAgdm9p
ZCBzZXRfZXJyb3Jfcm91dGluZSh2b2lkICgqcm91dGluZSkoY29uc3QgY2hhciAqZXJyLCB2YV9s
aXN0IHBhcmFtcykpDQo+ID4gIHsNCj4gPiAtCWVycm9yX3JvdXRpbmUgPSByb3V0aW5lOw0KPiA+
ICsJc3RydWN0IGVycm9yX2Z1bmNfbGlzdCAqZWZsID0geG1hbGxvYyhzaXplb2YoKmVmbCkpOw0K
PiA+ICsJZWZsLT5mdW5jID0gcm91dGluZTsNCj4gPiArCWVmbC0+bmV4dCA9IGVycm9yX2Z1bmNz
Ow0KPiA+ICsJZXJyb3JfZnVuY3MgPSBlZmw7DQo+ID4gK30NCj4gPiArDQo+ID4gKy8qIHBvcCBh
IHNpbmdsZSBlcnJvciByb3V0aW5lIG9mZiBvZiB0aGUgZXJyb3IgZnVuY3Rpb24gc3RhY2ssIHRo
dXMgcmV2ZXJ0aW5nDQo+ID4gKyAqIHRvIHByZXZpb3VzIGVycm9yLiBTaG91bGQgYWx3YXlzIGJl
IHBhaXJlZCB3aXRoIGEgc2V0X2Vycm9yX3JvdXRpbmUgKi8NCj4gPiArdm9pZCBwb3BfZXJyb3Jf
cm91dGluZSh2b2lkKQ0KPiA+ICt7DQo+ID4gKwlhc3NlcnQoZXJyb3JfZnVuY3MgIT0gJmRlZmF1
bHRfZXJyb3JfZnVuYyk7DQo+ID4gKw0KPiA+ICsJc3RydWN0IGVycm9yX2Z1bmNfbGlzdCAqZWZs
ID0gZXJyb3JfZnVuY3M7DQo+IA0KPiBkZWNsLWFmdGVyLXN0bXQuICBDYW4gYmUgZml4ZWQgZWFz
aWx5IGJ5IGZsaXBwaW5nIHRoZSBhYm92ZSB0d28NCj4gbGluZXMuDQoNCk9oLCByaWdodCB5ZXMu
IEknbGwgZml4IHRoYXQgaW4gYSByZXNlbmQgYXMgd2VsbC4NCg0KVGhhbmtzLA0KSmFrZQ0KDQoN
Cg==
