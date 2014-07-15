From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH 3/3] tag: support configuring --sort via .gitconfig
Date: Tue, 15 Jul 2014 20:29:12 +0000
Message-ID: <1405456151.2577.7.camel@jekeller-desk1.amr.corp.intel.com>
References: <1405119347-3308-1-git-send-email-jacob.e.keller@intel.com>
	 <1405119347-3308-3-git-send-email-jacob.e.keller@intel.com>
	 <CAPig+cR9VCtNhk-FbqDM1LTCa8VeUTYXU4XEX36Rb5CxPFfLWQ@mail.gmail.com>
	 <xmqqfvi518xo.fsf@gitster.dls.corp.google.com>
	 <20140713173356.GA8406@sigill.intra.peff.net>
	 <20140713183629.GA19293@sigill.intra.peff.net>
	 <xmqqfvi3zwp7.fsf@gitster.dls.corp.google.com>
	 <1405435933.9147.1.camel@jekeller-desk1.amr.corp.intel.com>
	 <xmqqfvi2wqvq.fsf@gitster.dls.corp.google.com>
	 <1405445234.2577.0.camel@jekeller-desk1.amr.corp.intel.com>
	 <xmqq7g3ewkp8.fsf@gitster.dls.corp.google.com>
	 <1405449076.2577.3.camel@jekeller-desk1.amr.corp.intel.com>
	 <xmqqha2iv3kr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"peff@peff.net" <peff@peff.net>,
	"sunshine@sunshineco.com" <sunshine@sunshineco.com>
To: "gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 22:29:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X79Li-0005XI-BI
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 22:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933075AbaGOU3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 16:29:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:5930 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932940AbaGOU3N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 16:29:13 -0400
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP; 15 Jul 2014 13:29:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,668,1400050800"; 
   d="scan'208";a="543800167"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga001.jf.intel.com with ESMTP; 15 Jul 2014 13:29:12 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.123.3; Tue, 15 Jul 2014 13:29:12 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.59]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.189]) with mapi id 14.03.0123.003;
 Tue, 15 Jul 2014 13:29:12 -0700
Thread-Topic: [PATCH 3/3] tag: support configuring --sort via .gitconfig
Thread-Index: AQHPoGC840BrU7LSLEikGiD9Y5cKsJuiC3aA
In-Reply-To: <xmqqha2iv3kr.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <C75B415DC5F622428409832BE65604DD@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253600>

T24gVHVlLCAyMDE0LTA3LTE1IGF0IDEyOjEyIC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gIktlbGxlciwgSmFjb2IgRSIgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4gd3JpdGVzOg0K
PiANCj4gPiBJIGFtIGdvaW5nIHRvIHJlLXN1Ym1pdCB0aGlzIHdpdGggYW4gZW51bS1zdHlsZSBy
ZXR1cm4uIEkgYW0gYWxzbw0KPiA+IGNoYW5naW5nIGhvdyB3ZSBwYXJzZSBzbyB0aGF0IHdlIGNh
biBjb3JyZWN0bHkgcmVwb3J0IHdoZXRoZXIgdGhlIHNvcnQNCj4gPiBmdW5jdGlvbiBvciBzb3J0
IGF0b20gaXMgaW5jb3JyZWN0Lg0KPiANCj4gT2gsIG91ciBtYWlscyBjcm9zc2VkLCBJIGd1ZXNz
LiAgQXMgbG9uZyBhcyBpdCB3aWxsIGxlYXZlIHRoZSBkb29yDQo+IG9wZW4gZm9yIGxhdGVyIGVu
aGFuY2VtZW50cyBmb3IgbW9yZSBjb250ZXh0IHNlbnNpdGl2ZSBlcnJvcg0KPiBkaWFnbm9zaXMs
IEkgZG8gbm90IHBhcnRpY3VsYXJseSBtaW5kIGEgc29sdXRpb24gYXJvdW5kIGVudW0uDQoNCkht
bS4gSSBsb29rZWQgYXQgY29kaW5nIGl0IHRoaXMgd2F5LCBhbmQgaXQgYWN0dWFsbHkgbWFrZXMg
aXQgbGVzcw0Kc2Vuc2l0aXZlIHRoYW4gSSB3b3VsZCBsaWtlLiBJJ20gbm90IGEgZmFuIG9mIHRo
ZSBleHRyYSAidmFsdWUiDQpwYXJhbWV0ZXIsIGJ1dCBJIGRvIGxpa2UgYSBtb3JlIHByb3BlciBl
cnJvciBkaXNwbGF5LCBhbmQgaW5kZWVkIG9uZQ0KdGhhdCBpcyBtb3JlIHByZWNpc2UuDQoNCkkn
bGwgdHJ5IHRvIGhhdmUgYSBuZXcgc2VyaWVzIHBvc3RlZCBzb29uIHdoaWNoIHRha2VzIHRoZXNl
IGludG8NCmFjY291bnQuDQoNClJlZ2FyZHMsDQpKYWtlDQo=
