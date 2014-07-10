From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH] makefile: add ability to run specific test files
Date: Thu, 10 Jul 2014 22:31:27 +0000
Message-ID: <1405031487.4925.43.camel@jekeller-desk1.amr.corp.intel.com>
References: <1404945412-10197-2-git-send-email-jacob.e.keller@intel.com>
	 <xmqq61j69m0m.fsf@gitster.dls.corp.google.com>
	 <1404949763.23510.42.camel@jekeller-desk1.amr.corp.intel.com>
	 <CAPc5daWNB0m23tPdYxWmQEpu8PshFWwwZ3n_bSxF6evwM7-61g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:31:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5MsH-0003ph-7a
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 00:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbaGJWb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 18:31:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:20570 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751361AbaGJWb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 18:31:29 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 10 Jul 2014 15:25:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,640,1400050800"; 
   d="scan'208";a="571388986"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2014 15:31:27 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.193]) by
 ORSMSX109.amr.corp.intel.com ([169.254.2.243]) with mapi id 14.03.0123.003;
 Thu, 10 Jul 2014 15:31:27 -0700
Thread-Topic: [PATCH] makefile: add ability to run specific test files
Thread-Index: AQHPm8ZLdNa2z5Fi2Um4FWbUI/IL6JuYW1xVgACDQYCAAEoVAIABMnqA
In-Reply-To: <CAPc5daWNB0m23tPdYxWmQEpu8PshFWwwZ3n_bSxF6evwM7-61g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <5F03583D437E17469D06385968F9BEAC@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253225>

T24gVGh1LCAyMDE0LTA3LTEwIGF0IDA0OjE0ICswMDAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gT24gV2VkLCBKdWwgOSwgMjAxNCBhdCA0OjQ5IFBNLCBLZWxsZXIsIEphY29iIEUNCj4gPGph
Y29iLmUua2VsbGVyQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gT24gV2VkLCAyMDE0LTA3LTA5IGF0
IDE1OjU5IC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToNCj4gPj4NCj4gPj4gV2hhdCBraW5k
IG9mIHRoaW5ncyBhcmUgbWlzc2luZywgZXhhY3RseT8gIFBlcmhhcHMgdGhhdCBpcyBzb21ldGhp
bmcNCj4gPj4geW91IG5lZWQgdG8gZml4LCBpbnN0ZWFkIG9mIG11Y2tpbmcgd2l0aCB0aGUgdG9w
LWxldmVsIE1ha2VmaWxlLg0KPiA+DQo+ID4gSXQgdXNlcyB0aGUgZ2l0IGZyb20gbXkgZW52aXJv
bm1lbnQgaW5zdGVhZCBvZiB0aGUgZ2l0IEkgaGF2ZSBidWlsdCwNCj4gPiB3aGljaCBpcyBiYWQg
c2luY2UgSSBkb24ndCByZWFsbHkgd2FudCB0byBydW4gbWFrZSBpbnN0YWxsLg0KPiANCj4gQXJl
IHlvdSBzdXJlIGFib3V0IHRoYXQ/ICBUcnkgYWRkaW5nIHNvbWV0aGluZyBsaWtlDQo+IA0KPiAg
IGRpZSgiSSBhbSBicm9rZW4iKTsNCj4gDQo+IGF0IHRoZSB2ZXJ5IGJlZ2lubmluZyBvZiBtYWlu
KCkgaW4gZ2l0LmMsIHJlYnVpbGQgeW91ciBnaXQgKGkuZS4NCj4gIm1ha2UiLCBub3QgIm1ha2Ug
aW5zdGFsbCIpDQo+IGFuZCB0aGVuDQo+IA0KPiAgICQgY2QgdA0KPiAgICQgc2ggLi90MTIzNC10
ZXN0LnNoIC12DQo+IA0KPiBmb3IgYW55IG9mIHRoZSB0ZXN0IHNjcmlwdHMuIFlvdSBzaG91bGQg
c2VlIGFueSB0ZXN0IHBpZWNlIHRoYXQgcnVucyAiZ2l0IiBzZWVzDQo+ICJnaXQiIGR5aW5nIHdp
dGggdGhhdCBtZXNzYWdlLg0KPiANCj4gT3RoZXJ3aXNlLCB0aGVyZSBpcyBzb21ldGhpbmcgd3Jv
bmcgd2l0aCBnaXQgeW91IGFyZSBidWlsZGluZy4gVW5sZXNzIHlvdSBoYXZlDQo+IGEgcGF0Y2gg
b3IgdHdvIHRvIHQvdGVzdC1saWIuc2ggb3Igc29tZXRoaW5nIHRoYXQgYnJlYWtzIHRoZSB0ZXN0
IGZyYW1ld29yaywgeW91DQo+IHNob3VsZCBiZSBhYmxlIHRvIHRlc3Qgd2hhdCB5b3UganVzdCBo
YXZlIGJ1aWx0IHdpdGhvdXQgZ2V0dGluZyBhZmZlY3RlZCBieSB3aGF0DQo+IGlzIGluc3RhbGxl
ZCBpbiB5b3VyICRQQVRILiBBZnRlciBhbGwsIHRoYXQgaXMgaG93IHdlIGJvb3RzdHJhcCBnaXQN
Cj4gZnJvbSBhIHRhcmJhbGwNCj4gd2l0aG91dCBhbnkgaW5zdGFsbGVkIHZlcnNpb24sIGFuZCBm
cmllbmRzIGRvIG5vdCBmb3JjZSBmcmllbmRzIGluc3RhbGwgd2l0aG91dA0KPiB0ZXN0aW5nIGZp
cnN0IDstKQ0KDQpUaGlzIGlzIGV2ZW4gbW9yZSBpbnRlcmVzdGluZy4gSSB0cmllZCB5b3VyIGRp
ZSBjaGVjaywgYW5kIGl0IGRlZmluaXRlbHkNCnJ1bnMgdGhlIGNvcnJlY3QgdmVyc2lvbiBvZiBn
aXQuDQoNCkhvd2V2ZXIsIGlmIEkgcnVuIHRoZSB0ZXN0IGRpcmVjdGx5Og0KDQpjZCB0IDsgc2gg
dDMyMDAtYnJhbmNoLnNoIC12DQoNCml0IHBhc3Nlcy4NCg0KaWYgSSBydW46DQoNCm1ha2UgdGVz
dA0KDQp0aGF0IHBhcnRpY3VsYXIgdGVzdCBmYWlscy4gSWYgSSBoYXZlIHRoaXMgcGF0Y2ggYXBw
bGllZCwgYW5kIEkgcnVuDQoNCm1ha2UgdC90MzIwMC1icmFuY2guc2gNCg0KaXQgYWxzbyBmYWls
cy4NCg0KSSBoYXZlIGRvbmUgdGhpcyBkaXJlY3RseSBvbiBjdXJyZW50IG1hc3RlciBicmFuY2gu
IFNvIHNvbWV0aGluZyBpcw0KZGlmZmVyaW5nIGJldHdlZW4gdGhlIHR3byB0ZXN0IHJ1bnMuDQoN
CkFsc28sIGlmIEkgcnVuOg0KDQptYWtlIC1DIHQgdDMyMDAtYnJhbmNoLnNoDQoNCnRoYXQgcGFz
c2VzLCBzbyBpdCByZWFsbHkgKmlzKiBzb21ldGhpbmcgc2V0dXAgYnkgdGhlIG1haW4gbWFrZWZp
bGUuDQoNCkFueSBtb3JlIHN1Z2dlc3Rpb25zPw0KDQpUaGFua3MsDQpKYWtlDQo=
