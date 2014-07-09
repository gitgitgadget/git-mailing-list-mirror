From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: t3200-branch.sh number 102 fails when run under make test
Date: Wed, 9 Jul 2014 21:17:32 +0000
Message-ID: <1404940652.23510.32.camel@jekeller-desk1.amr.corp.intel.com>
References: <1404938270.23510.13.camel@jekeller-desk1.amr.corp.intel.com>
	 <20140709205407.GA25854@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "peff@peff.net" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 09 23:17:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4zFT-0004Iq-6s
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 23:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753045AbaGIVRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 17:17:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:28494 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896AbaGIVRv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 17:17:51 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 09 Jul 2014 14:17:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,633,1400050800"; 
   d="scan'208";a="559602497"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jul 2014 14:17:33 -0700
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.123.3; Wed, 9 Jul 2014 14:17:33 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.193]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.200]) with mapi id 14.03.0123.003;
 Wed, 9 Jul 2014 14:17:33 -0700
Thread-Topic: t3200-branch.sh number 102 fails when run under make test
Thread-Index: AQHPm7WmAVMLR9iWJU2r1zgPpMn+VJuYrcaAgAAGiwA=
In-Reply-To: <20140709205407.GA25854@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <7A13C842E5067549BD2ADE577865C9C2@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253151>

T24gV2VkLCAyMDE0LTA3LTA5IGF0IDE2OjU0IC0wNDAwLCBKZWZmIEtpbmcgd3JvdGU6DQo+IE9u
IFdlZCwgSnVsIDA5LCAyMDE0IGF0IDA4OjM3OjUxUE0gKzAwMDAsIEtlbGxlciwgSmFjb2IgRSB3
cm90ZToNCj4gDQo+ID4gSSByZWNlbnRseSBjbG9uZWQgdGhlIG1hc3RlciBicmFuY2ggb2YgdGhl
IGdpdCByZXBvLCBhbmQgd2hlbiBJIHJhbiBtYWtlDQo+ID4gdGVzdCwgaXQgZmFpbHMgb24gdGVz
dCAxMDIgb2YgdGhlIHQzMjAwLWJyYW5jaC5zaCB0ZXN0IGNhc2VzLg0KPiANCj4gSnVzdCBhIGd1
ZXNzLCBidXQgdHJ5IHJldmVydGluZyA3NDUyMjRlIChyZWZzLmM6IFNTRTIgb3B0aW1pemF0aW9u
cyBmb3INCj4gY2hlY2tfcmVmbmFtZV9jb21wb25lbnQsIDIwMTQtMDYtMTgpLg0KPiANCj4gVGhh
dCBjb21taXQgY2F1c2VzIHNvbWUgd2VpcmQgbWVtb3J5IGFjY2Vzc2VzIHRoYXQgb25seSBzaG93
IHVwIHVuZGVyDQo+IGNlcnRhaW4gY29uZGl0aW9uc1sxXS4gVGhlcmUncyBhIHBvc3NpYmxlIGZp
eCB0aGF0IGlzIG5vdCB5ZXQgYXBwbGllZCwNCj4gYnV0IHJldmVydGluZyBzaG91bGQgYmUgYW4g
ZWFzeSB3YXkgdG8gdGVzdC4NCj4gDQo+IC1QZWZmDQo+IA0KPiBbMV0gaHR0cDovL3RocmVhZC5n
bWFuZS5vcmcvZ21hbmUuY29tcC52ZXJzaW9uLWNvbnRyb2wuZ2l0LzI1Mjg4MQ0KPiAtLQ0KPiBU
byB1bnN1YnNjcmliZSBmcm9tIHRoaXMgbGlzdDogc2VuZCB0aGUgbGluZSAidW5zdWJzY3JpYmUg
Z2l0IiBpbg0KPiB0aGUgYm9keSBvZiBhIG1lc3NhZ2UgdG8gbWFqb3Jkb21vQHZnZXIua2VybmVs
Lm9yZw0KPiBNb3JlIG1ham9yZG9tbyBpbmZvIGF0ICBodHRwOi8vdmdlci5rZXJuZWwub3JnL21h
am9yZG9tby1pbmZvLmh0bWwNCg0KWWVzLCBwZXJmb3JtaW5nIHRoZSByZXZlcnQgYXBwZWFycyB0
byBmaXggdGhlIGlzc3VlLiBIb3BlZnVsbHkgdGhlDQpwcm9wb3NlZCBmaXggYWxzbyB3b3Jrcy4N
Cg0KVGhhbmtzLA0KSmFrZQ0K
