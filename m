From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2] tag: support configuring --sort via .gitconfig
Date: Thu, 10 Jul 2014 21:50:29 +0000
Message-ID: <1405029028.4925.32.camel@jekeller-desk1.amr.corp.intel.com>
References: <1404945412-10197-1-git-send-email-jacob.e.keller@intel.com>
	 <20140710040731.GD28401@sigill.intra.peff.net>
	 <xmqqa98h8587.fsf@gitster.dls.corp.google.com>
	 <20140710193404.GA15615@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>
To: "peff@peff.net" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 10 23:50:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5MEj-0005NH-EB
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 23:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbaGJVuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 17:50:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:52468 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750889AbaGJVuh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 17:50:37 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 10 Jul 2014 14:50:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,639,1400050800"; 
   d="scan'208";a="571374732"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2014 14:50:32 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.123.3; Thu, 10 Jul 2014 14:50:29 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.193]) by
 ORSMSX111.amr.corp.intel.com ([169.254.11.92]) with mapi id 14.03.0123.003;
 Thu, 10 Jul 2014 14:50:29 -0700
Thread-Topic: [PATCH v2] tag: support configuring --sort via .gitconfig
Thread-Index: AQHPnGi1HKkkgvPtB0G2Yr5/1ypgMZuaKFcAgAAmHQA=
In-Reply-To: <20140710193404.GA15615@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <97FEA49B1E279E42954DA7B77FC9C41E@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253221>

T24gVGh1LCAyMDE0LTA3LTEwIGF0IDE1OjM0IC0wNDAwLCBKZWZmIEtpbmcgd3JvdGU6DQo+IE9u
IFRodSwgSnVsIDEwLCAyMDE0IGF0IDEwOjU5OjM2QU0gLTA3MDAsIEp1bmlvIEMgSGFtYW5vIHdy
b3RlOg0KPiANCj4gPiBKZWZmIEtpbmcgPHBlZmZAcGVmZi5uZXQ+IHdyaXRlczoNCj4gPiANCj4g
PiA+IEkga25vdyB0aGlzIGlzIGV4aXN0aW5nIGNvZGUgeW91IGFyZSBtb3ZpbmcsIGJ1dCBJIG5v
dGljZWQgaXQgbG9va3MgcmlwZQ0KPiA+ID4gZm9yIHVzaW5nIHNraXBfcHJlZml4LiBQZXJoYXBz
IHdoaWxlIHdlIGFyZSBpbiB0aGUgYXJlYSB3ZSBzaG91bGQgZG8gdGhlDQo+ID4gPiBmb2xsb3dp
bmcgb24gdG9wIG9mIHlvdXIgcGF0Y2ggKEknZCBhbHNvIGJlIGhhcHB5IGZvciBpdCBiZSBzcXVh
c2hlZA0KPiA+ID4gaW4sIGJ1dCB0aGF0IG1heSBiZSB0b28gbXVjaCBpbiBvbmUgcGF0Y2gpLg0K
PiA+IA0KPiA+IEkgYW0gdGVtcHRlZCB0byBzdWdnZXN0IGdvaW5nIHRoZSBvdGhlciB3YXkgYXJv
dW5kLCBpLmUuIHF1ZXVlIChhbg0KPiA+IGVxdWl2YWxlbnQgb2YpIHRoaXMgb24gamsvc2tpcC1w
cmVmaXggYW5kIG1lcmdlIGl0IHRvICduZXh0JyBhbmQNCj4gPiB0aGVuICdtYXN0ZXInIHF1aWNr
bHkuDQo+ID4gDQo+ID4gSSBjYW4gZ28gZWl0aGVyIHdheSwgYnV0IEkgdGVuZCB0byBwcmVmZXIg
YnVpbGRpbmcgbmV3IHRoaW5ncyBvbiB0b3ANCj4gPiBvZiBvYnZpb3VzbHkgY29ycmVjdCBjbGVh
bi11cCwgbm90IHRoZSBvdGhlciB3YXkgYXJvdW5kLg0KPiANCj4gTWUgdG9vLiBJIGp1c3QgZGlk
bid0IHdhbnQgdG8gbWFrZSBtb3JlIHdvcmsgZm9yIEphY29iIChpbiBoYXZpbmcgdG8NCj4gcmVi
YXNlIG9uIHRvcCBvZiBtaW5lKSBvciBmb3IgeW91IChpbiBoYXZpbmcgdG8gZG8gYSBub24tb2J2
aW91cyBtZXJnZSBhDQo+IGZldyBkYXlzIGZyb20gbm93KS4NCj4gDQo+IC1QZWZmDQoNCkknbSBw
ZXJmZWN0bHkgZmluZSByZWJhc2luZy4gOikNCg0KVGhhbmtzLA0KSmFrZQ0K
