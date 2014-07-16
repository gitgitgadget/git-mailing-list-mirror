From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH v9 4/4] tag: support configuring --sort via .gitconfig
Date: Wed, 16 Jul 2014 19:51:33 +0000
Message-ID: <1405540292.15392.4.camel@jekeller-desk1.amr.corp.intel.com>
References: <1405467179-16064-1-git-send-email-jacob.e.keller@intel.com>
	 <1405467179-16064-4-git-send-email-jacob.e.keller@intel.com>
	 <20140715234240.GB5572@peff.net>
	 <1405467974.2577.21.camel@jekeller-desk1.amr.corp.intel.com>
	 <xmqqiomxrxq2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"peff@peff.net" <peff@peff.net>
To: "gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 21:51:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7VEp-0002qN-2U
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 21:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbaGPTvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 15:51:36 -0400
Received: from mga03.intel.com ([143.182.124.21]:22596 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbaGPTve (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 15:51:34 -0400
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 16 Jul 2014 12:51:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,673,1400050800"; 
   d="scan'208";a="457820702"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by azsmga001.ch.intel.com with ESMTP; 16 Jul 2014 12:51:33 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.59]) by
 ORSMSX101.amr.corp.intel.com ([169.254.8.157]) with mapi id 14.03.0123.003;
 Wed, 16 Jul 2014 12:51:32 -0700
Thread-Topic: [PATCH v9 4/4] tag: support configuring --sort via .gitconfig
Thread-Index: AQHPoR+ykg748ikfdUyLGGIZHkvA75ujkcgA
In-Reply-To: <xmqqiomxrxq2.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <903C1B75BBB9A043A395D918D614B571@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253688>

T24gV2VkLCAyMDE0LTA3LTE2IGF0IDEwOjU5IC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gIktlbGxlciwgSmFjb2IgRSIgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4gd3JpdGVzOg0K
PiANCj4gPiBPbiBUdWUsIDIwMTQtMDctMTUgYXQgMTk6NDIgLTA0MDAsIEplZmYgS2luZyB3cm90
ZToNCj4gPj4gT24gVHVlLCBKdWwgMTUsIDIwMTQgYXQgMDQ6MzI6NTlQTSAtMDcwMCwgSmFjb2Ig
S2VsbGVyIHdyb3RlOg0KPiA+PiANCj4gPj4gPiArc3RhdGljIHZvaWQgZXJyb3JfYmFkX3NvcnRf
Y29uZmlnKGNvbnN0IGNoYXIgKmVyciwgdmFfbGlzdCBwYXJhbXMpDQo+ID4+ID4gK3sNCj4gPj4g
PiArCXZyZXBvcnRmKCJ3YXJuaW5nOiB0YWcuc29ydCBoYXMgIiwgZXJyLCBwYXJhbXMpOw0KPiA+
PiA+ICt9DQo+ID4+IA0KPiA+PiBUaGlzIGZlZWxzIGEgbGl0dGxlIGxpa2UgYW4gYWJ1c2Ugb2Yg
dGhlICJwcmVmaXgiIGZpZWxkIG9mIHZyZXBvcnRmLCBidXQNCj4gPj4gYXMgeW91IHByb2JhYmx5
IHNhdyBpbiBteSAiZm9yIGZ1biIgcGF0Y2gsIGRvaW5nIGl0IHJpZ2h0IG1lYW5zDQo+ID4+IGZv
cm1hdHRpbmcgaW50byBhIGJ1ZmZlciBhbmQgdGhlbiByZWZvcm1hdHRpbmcgdGhhdCAod2hpY2gg
d2UncmUNCj4gPj4gYWxyZWFkeSBkb2luZyBhZ2FpbiBpbiB2cmVwb3J0ZiwgYnV0IGxlc3MgZmxl
eGlibHkpLiBJIGR1bm5vLg0KPiA+PiANCj4gPj4gQXQgYW55IHJhdGUsIHRoaXMgc2hvdWxkIGJl
IG1hcmtlZCBmb3IgdHJhbnNsYXRpb24sIG5vPw0KPiA+PiANCj4gPj4gLVBlZmYNCj4gPg0KPiA+
IE9oLCB5ZXMgaXQgcHJvYmFibHkgc2hvdWxkLiBJdCdzIGRlZmluaXRlbHkgYSBsaXR0bGUgYml0
IGFidXNpdmUgb2YgdGhlDQo+ID4gcHJlZml4IGZpZWxkLCBidXQgdGhhdCBzZWVtZWQgZWFzaWVy
Lg0KPiANCj4gQW5kIGkxOG4gd291bGQgYXV0b21hdGljYWxseSBtZWFuIHRoaXMgd2lsbCBub3Qg
d29yaywgbm8/ICBUaGVyZSBpcw0KPiBubyBndWFyYW50ZWUgdGhhdCB0aGUgdHJhbnNsYXRpb24g
b2YgIndhcm5pbmc6ICIgd2lsbCBiZSBmb2xsb3dlZA0KPiBkaXJlY3RseSBieSB0aGUgdHJhbnNs
YXRpb24gb2YgInRhZy5zb3J0IGhhcyIgd2l0aG91dCBhbnkgd29yZHMgZnJvbQ0KPiB2YXJpYWJs
ZSBwYXJ0IGluIGFsbCBsYW5ndWFnZXMuDQo+IA0KPiBBZnRlciBhbGwsIGl0IHNlZW1zIHRvIG1l
IHRoYXQgdGhlIG9uZSBpbg0KPiANCj4gICAgIGh0dHA6Ly90aHJlYWQuZ21hbmUub3JnL2dtYW5l
LmNvbXAudmVyc2lvbi1jb250cm9sLmdpdC8yNTMzNDYNCj4gDQo+IHN0cnVjayB0aGUgcmlnaHQg
YmFsYW5jZSBhbW9uZyB2YXJpb3VzIGFidXNlczsgbGV0J3MgdXNlIHRoZSBlcnJvcg0KPiByZXBv
cnRlciBmcm9tIHRoYXQgdmVyc2lvbiwgaW5zdGVhZCBvZiBnb2luZyBkb3duIHRoaXMgcmFiYml0
IGhvbGUuDQo+IA0KPiBUaGFua3MuDQo+IA0KPiANCj4gDQoNClRoaXMgaXMgZmluZSB3aXRoIG1l
IDopDQoNClRoYW5rcywNCkpha2UNCg==
