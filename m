From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH 3/3] tag: support configuring --sort via .gitconfig
Date: Tue, 15 Jul 2014 14:52:13 +0000
Message-ID: <1405435933.9147.1.camel@jekeller-desk1.amr.corp.intel.com>
References: <1405119347-3308-1-git-send-email-jacob.e.keller@intel.com>
	 <1405119347-3308-3-git-send-email-jacob.e.keller@intel.com>
	 <CAPig+cR9VCtNhk-FbqDM1LTCa8VeUTYXU4XEX36Rb5CxPFfLWQ@mail.gmail.com>
	 <xmqqfvi518xo.fsf@gitster.dls.corp.google.com>
	 <20140713173356.GA8406@sigill.intra.peff.net>
	 <20140713183629.GA19293@sigill.intra.peff.net>
	 <xmqqfvi3zwp7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"peff@peff.net" <peff@peff.net>,
	"sunshine@sunshineco.com" <sunshine@sunshineco.com>
To: "gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 16:52:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X745r-0001Ub-E2
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 16:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbaGOOwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 10:52:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:46853 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756AbaGOOwa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 10:52:30 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 15 Jul 2014 07:46:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,665,1400050800"; 
   d="scan'208";a="573464981"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga002.jf.intel.com with ESMTP; 15 Jul 2014 07:52:14 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.123.3; Tue, 15 Jul 2014 07:52:13 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.59]) by
 ORSMSX111.amr.corp.intel.com ([169.254.11.92]) with mapi id 14.03.0123.003;
 Tue, 15 Jul 2014 07:52:13 -0700
Thread-Topic: [PATCH 3/3] tag: support configuring --sort via .gitconfig
Thread-Index: AQHPn4eD40BrU7LSLEikGiD9Y5cKsJuhrwOA
In-Reply-To: <xmqqfvi3zwp7.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <704554E3D9F68E4EB377C37DA66E8E80@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253565>

T24gTW9uLCAyMDE0LTA3LTE0IGF0IDEwOjE3IC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gSmVmZiBLaW5nIDxwZWZmQHBlZmYubmV0PiB3cml0ZXM6DQo+IA0KPiA+IE9uIFN1biwgSnVs
IDEzLCAyMDE0IGF0IDAxOjMzOjU2UE0gLTA0MDAsIEplZmYgS2luZyB3cm90ZToNCj4gPg0KPiA+
PiBJIHJlYWxpemUgdGhhdCBJIGFtIHJlaW52ZW50aW5nIHRoZSBlcnJvci1yZXBvcnRpbmcgd2hl
ZWwgb24gYSBzbGVlcHkNCj4gPj4gU3VuZGF5IGFmdGVybm9vbiB3aXRob3V0IGhhdmluZyB0aG91
Z2h0IGFib3V0IGl0IG11Y2gsIHNvIHRoZXJlIGlzDQo+ID4+IHByb2JhYmx5IHNvbWUgZ290Y2hh
IG9yIGNhc2UgdGhhdCBtYWtlcyB0aGlzIHVnbHksIG9yIHBlcmhhcHMgaXQganVzdA0KPiA+PiBl
bmRzIHVwIHZlcmJvc2UgaW4gcHJhY3RpY2UuIEJ1dCBvbmUgY2FuIGRyZWFtLg0KPiA+DQo+ID4g
SnVzdCBmb3IgZnVuLi4uDQo+IA0KPiBZZXMsIHRoYXQgaXMgZnVuLg0KPiANCj4gSSBhY3R1YWxs
eSB0aGluayB5b3VyICJJbiAndmVyc2lvbjpwZWZuYW1lJyBhbmQgJ3dlcnNpb246cmVmbmFtZScs
DQo+IHdlIHdhbnQgYmUgYWJsZSB0byByZXBvcnQgJ3BlZm5hbWUnIGFuZCAnd2Vyc2lvbicgYXJl
IG1pc3NwZWxsZWQsDQo+IGFuZCByZXR1cm5pbmcgLTEgb3IgZW51bSB3b3VsZCBub3QgY3V0IGl0
IiBpcyBhIGdvb2QgYXJndW1lbnQuICBUaGUNCj4gY2FsbGVlIHdhbnRzIHRvIGhhdmUgZmxleGli
aWxpdHkgb24gX3doYXRfIHRvIHJlcG9ydCwganVzdCBhcyB0aGUNCj4gY2FsbGVyIHdhbnRzIHRv
IGhhdmUgZmxleGliaWxpdHkgb24gX2hvd18uICBJbiB0aGlzIHBhcnRpY3VsYXIgY29kZQ0KPiBw
YXRoLCBJIHRoaW5rIHRoZSBmb3JtZXIgZmFyIG91dHdlaWdocyB0aGUgbGF0dGVyLCBhbmQgbXkg
c3VnZ2VzdGlvbg0KPiBJIGNhbGxlZCAic2lsbHkiIG1pZ2h0IG5vdCBiZSBzbyBzaWxseSBidXQg
bWF5IGhhdmUgc3RydWNrIHRoZSByaWdodA0KPiBiYWxhbmNlLiAgSSBkdW5uby4NCj4gDQo+IElm
IHlvdSBhYnNvbHV0ZWx5IG5lZWQgdG8gaGF2ZSBib3RoLCB5b3Ugd291bGQgbmVlZCBzb21ldGhp
bmcgbGlrZQ0KPiB5b3VyIGFwcHJvYWNoLCBvZiBjb3Vyc2UsIGJ1dCBJIGFtIG5vdCBzdXJlIGlm
IGl0IGlzIHdvcnRoIGl0Lg0KPiANCj4gSSBhbSBub3Qgc3VyZSBob3cgd2VsbCB0aGlzIG1lc2hl
cyB3aXRoIGkxOG4gKEkga25vdyB0aGUgImZvciBmdW4iDQo+IGRvZXMgbm90IGV2ZW4gYXR0ZW1w
dCB0bywgYnV0IGlmIHdlIHRyaWVkIHRvLCBJIHN1c3BlY3QgaXQgbWF5DQo+IGJlY29tZSBldmVu
IHVnbGllcikuICBXZSB3b3VsZCBhbHNvIG5lZWQgdG8gb3ZlcnJpZGUgYm90aCBlcnJvciBhbmQN
Cj4gd2FybmluZyByb3V0aW5lcyBhbmQgaGF2ZSB0aGUgcmVwb3J0ZXIgdGFnIHRoZSBlcnJvcnMg
aW4gdGhlc2UgdHdvDQo+IGNhdGVnb3JpZXMsIG5vPw0KPiANCg0KRG8gd2Ugd2FudCB0byBnbyB0
aGlzIHdheT8gU2hvdWxkIEkgcmVzcGluIG15IHBhdGNoIChhZ2Fpbik/IEknbSBub3QNCnN1cmUg
d2UgcmVhbGx5IG5lZWQgdG8gZ2V0IHRoYXQgY29tcGxleC4uIEkgZG8gbGlrZSBwYXJzaW5nIGVy
cm9ycyBhIGJpdA0KY2xlYW5lciBhbmQgaW5kaWNhdGluZyB3aGF0IHBhcnQgaXMgYmFkLi4gTm90
ZSB0aGF0IG91ciBjdXJyZW50IHBhcnNpbmcNCm1ldGhvZCBkb2VzIG5vdCBtYWtlIGl0IHJlYWxs
eSBwb3NzaWJsZSB0byBpbmRpY2F0ZSB3aGljaCBwYXJ0IGlzIHdyb25nLg0KDQpUaGFua3MsDQpK
YWtlDQo=
