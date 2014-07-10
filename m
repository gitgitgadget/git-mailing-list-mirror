From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH] makefile: add ability to run specific test files
Date: Thu, 10 Jul 2014 20:39:57 +0000
Message-ID: <1405024797.4925.1.camel@jekeller-desk1.amr.corp.intel.com>
References: <1404945412-10197-2-git-send-email-jacob.e.keller@intel.com>
	 <xmqq61j69m0m.fsf@gitster.dls.corp.google.com>
	 <1404949763.23510.42.camel@jekeller-desk1.amr.corp.intel.com>
	 <CAPc5daWNB0m23tPdYxWmQEpu8PshFWwwZ3n_bSxF6evwM7-61g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 22:40:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5L8t-0000BV-Bw
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 22:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366AbaGJUkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 16:40:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:49342 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751985AbaGJUkb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 16:40:31 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP; 10 Jul 2014 13:40:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,639,1400050800"; 
   d="scan'208";a="560119799"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2014 13:39:58 -0700
Received: from orsmsx159.amr.corp.intel.com (10.22.240.24) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.123.3; Thu, 10 Jul 2014 13:39:58 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.193]) by
 ORSMSX159.amr.corp.intel.com ([169.254.11.98]) with mapi id 14.03.0123.003;
 Thu, 10 Jul 2014 13:39:57 -0700
Thread-Topic: [PATCH] makefile: add ability to run specific test files
Thread-Index: AQHPm8ZLdNa2z5Fi2Um4FWbUI/IL6JuYW1xVgACDQYCAAEoVAIABE1OA
In-Reply-To: <CAPc5daWNB0m23tPdYxWmQEpu8PshFWwwZ3n_bSxF6evwM7-61g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <3527BBD99E24D54A80343406733719F1@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253211>

T24gV2VkLCAyMDE0LTA3LTA5IGF0IDIxOjE0IC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
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
cnN0IDstKQ0KDQpPaywgSSdsbCBnaXZlIGl0IGEgc2hvdC4gQWxsIEkga25vdyBmb3Igc3VyZSBy
aWdodCBub3cgaXMgcnVubmluZyB0aGUNCnRlc3QgZGlyZWN0bHkgcGFzc2VkIGFuZCBydW5uaW5n
IGZyb20gIm1ha2UgdGVzdCIgaXQgZmFpbGVkLg0KDQpJJ2xsIHNlZSBpZiB0aGF0IG1ha2VzIGFu
eSBkaWZmZXJlbmNlLg0KDQpUaGFua3MsDQpKYWtlDQo=
