From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH 3/3] tag: support configuring --sort via .gitconfig
Date: Tue, 15 Jul 2014 21:31:09 +0000
Message-ID: <1405459868.2577.9.camel@jekeller-desk1.amr.corp.intel.com>
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
X-From: git-owner@vger.kernel.org Wed Jul 16 00:30:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7BEp-0007oj-Dg
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 00:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760309AbaGOW1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 18:27:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:55708 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758205AbaGOVb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 17:31:28 -0400
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP; 15 Jul 2014 14:31:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,668,1400050800"; 
   d="scan'208";a="543831859"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga001.jf.intel.com with ESMTP; 15 Jul 2014 14:31:09 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.59]) by
 ORSMSX105.amr.corp.intel.com ([169.254.4.21]) with mapi id 14.03.0123.003;
 Tue, 15 Jul 2014 14:31:08 -0700
Thread-Topic: [PATCH 3/3] tag: support configuring --sort via .gitconfig
Thread-Index: AQHPoGC840BrU7LSLEikGiD9Y5cKsJuiHMUA
In-Reply-To: <xmqqha2iv3kr.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <D3EB51392929AD4D8906395396541CE2@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253609>

T24gVHVlLCAyMDE0LTA3LTE1IGF0IDEyOjEyIC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gIktlbGxlciwgSmFjb2IgRSIgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4gd3JpdGVzOg0K
PiANCj4gPiBJIGFtIGdvaW5nIHRvIHJlLXN1Ym1pdCB0aGlzIHdpdGggYW4gZW51bS1zdHlsZSBy
ZXR1cm4uIEkgYW0gYWxzbw0KPiA+IGNoYW5naW5nIGhvdyB3ZSBwYXJzZSBzbyB0aGF0IHdlIGNh
biBjb3JyZWN0bHkgcmVwb3J0IHdoZXRoZXIgdGhlIHNvcnQNCj4gPiBmdW5jdGlvbiBvciBzb3J0
IGF0b20gaXMgaW5jb3JyZWN0Lg0KPiANCj4gT2gsIG91ciBtYWlscyBjcm9zc2VkLCBJIGd1ZXNz
LiAgQXMgbG9uZyBhcyBpdCB3aWxsIGxlYXZlIHRoZSBkb29yDQo+IG9wZW4gZm9yIGxhdGVyIGVu
aGFuY2VtZW50cyBmb3IgbW9yZSBjb250ZXh0IHNlbnNpdGl2ZSBlcnJvcg0KPiBkaWFnbm9zaXMs
IEkgZG8gbm90IHBhcnRpY3VsYXJseSBtaW5kIGEgc29sdXRpb24gYXJvdW5kIGVudW0uDQoNCkkg
anVzdCBzZW50IGEgdjggb2YgdGhlIHNlcmllcy4gSSB0aGluayBJIG1vc3RseSBmb2xsb3dlZCBQ
ZWZmJ3MgaWRlYSBvZg0KdXNpbmcgYSBwb3BfZXJyb3Jfcm91dGluZSBmdW5jdGlvbiwgYnV0IG5v
dCBhcyBjb21wbGV4IGFzIGhpcyB3YXMuIFRoaXMNCm92ZXJhbGwgcmVzdWx0cyBpbiBtb3JlIGFj
Y3VyYXRlIGVycm9ycywgYW5kIGRvZXNuJ3QgY2x1dHRlciB0aGUNCm9yaWdpbmFsIHBhcnNlX3Nv
cnRfc3RyaW5nIHdpdGggdG9vIG11Y2gga25vd2xlZGdlIGFib3V0IHdoYXQgcGFydGljdWxhcg0K
dmFsdWUgaXMgYmVpbmcgcGFyc2VkLiBIb3BlZnVsbHkgd2UgY2FuIGZpbmFsbHkgY29udmVyZ2Ug
b24gYSBnb29kIHNldA0Kb2YgcGF0Y2hlcy4NCg0KVGhhbmtzLA0KSmFrZQ0K
