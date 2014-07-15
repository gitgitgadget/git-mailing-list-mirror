From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH 3/3] tag: support configuring --sort via .gitconfig
Date: Tue, 15 Jul 2014 18:31:16 +0000
Message-ID: <1405449076.2577.3.camel@jekeller-desk1.amr.corp.intel.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"peff@peff.net" <peff@peff.net>,
	"sunshine@sunshineco.com" <sunshine@sunshineco.com>
To: "gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 20:32:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X77W8-0005H8-Fq
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 20:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbaGOSbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 14:31:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:15360 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755810AbaGOSbv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 14:31:51 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP; 15 Jul 2014 11:31:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,667,1400050800"; 
   d="scan'208";a="570243379"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jul 2014 11:31:16 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.59]) by
 ORSMSX104.amr.corp.intel.com ([169.254.3.57]) with mapi id 14.03.0123.003;
 Tue, 15 Jul 2014 11:31:16 -0700
Thread-Topic: [PATCH 3/3] tag: support configuring --sort via .gitconfig
Thread-Index: AQHPoFkF40BrU7LSLEikGiD9Y5cKsJuh6pMA
In-Reply-To: <xmqq7g3ewkp8.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <40F18202FD51A4458105FBF84B75C019@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253581>

T24gVHVlLCAyMDE0LTA3LTE1IGF0IDExOjE3IC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gIktlbGxlciwgSmFjb2IgRSIgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4gd3JpdGVzOg0K
PiANCj4gPiBPbiBUdWUsIDIwMTQtMDctMTUgYXQgMDk6MDMgLTA3MDAsIEp1bmlvIEMgSGFtYW5v
IHdyb3RlOg0KPiA+IC4uLg0KPiA+PiA+PiBZZXMsIHRoYXQgaXMgZnVuLg0KPiA+PiA+PiANCj4g
Pj4gPj4gSSBhY3R1YWxseSB0aGluayB5b3VyICJJbiAndmVyc2lvbjpwZWZuYW1lJyBhbmQgJ3dl
cnNpb246cmVmbmFtZScsDQo+ID4+ID4+IHdlIHdhbnQgYmUgYWJsZSB0byByZXBvcnQgJ3BlZm5h
bWUnIGFuZCAnd2Vyc2lvbicgYXJlIG1pc3NwZWxsZWQsDQo+ID4+ID4+IGFuZCByZXR1cm5pbmcg
LTEgb3IgZW51bSB3b3VsZCBub3QgY3V0IGl0IiBpcyBhIGdvb2QgYXJndW1lbnQuICBUaGUNCj4g
Pj4gPj4gY2FsbGVlIHdhbnRzIHRvIGhhdmUgZmxleGliaWxpdHkgb24gX3doYXRfIHRvIHJlcG9y
dCwganVzdCBhcyB0aGUNCj4gPj4gPj4gY2FsbGVyIHdhbnRzIHRvIGhhdmUgZmxleGliaWxpdHkg
b24gX2hvd18uICBJbiB0aGlzIHBhcnRpY3VsYXIgY29kZQ0KPiA+PiA+PiBwYXRoLCBJIHRoaW5r
IHRoZSBmb3JtZXIgZmFyIG91dHdlaWdocyB0aGUgbGF0dGVyLCBhbmQgbXkgc3VnZ2VzdGlvbg0K
PiA+PiA+PiBJIGNhbGxlZCAic2lsbHkiIG1pZ2h0IG5vdCBiZSBzbyBzaWxseSBidXQgbWF5IGhh
dmUgc3RydWNrIHRoZSByaWdodA0KPiA+PiA+PiBiYWxhbmNlLiAgSSBkdW5uby4NCj4gPiAuLi4N
Cj4gPiBJIGFncmVlLiBCdXQgd2hhdCBhYm91dCBnb2luZyBiYWNrIHRvIHRoZSBvbGRlciBzZXR1
cCB3aGVyZSB0aGUgY2FsbGVyDQo+ID4gY2FuIG91dHB1dCBjb3JyZWN0IGVycm9yIG1lc3NhZ2U/
IEknbSBvayB3aXRoIHVzaW5nIGFuIGVudW0gc3R5bGUNCj4gPiByZXR1cm4sIHRvIGJlIGNvbXBs
ZXRlbHkgaG9uZXN0LiBJIHdvdWxkIHByZWZlciB0aGlzLCBhY3R1YWxseS4NCj4gDQo+IERlcGVu
ZHMgb24gd2hpY2ggb2xkZXIgc2V0dXAgeW91IG1lYW4sIEkgdGhpbmsuICBUaGUgb25lIHRoYXQg
ZG9lcw0KPiBub3QgbGV0IHVzIGVhc2lseSBnaXZlIG1vcmUgY29udGV4dCBkZXBlbmRlbnQgZGlh
Z25vc2VzIHRoYXQgbGV0cyB1cw0KPiBkaXN0aW5ndWlzaCBiZXR3ZWVuIHZlcnNpb246cGVmbmFt
ZSBhbmQgdmVyc2lvbjpyZWZuYW1lIGJ5IHJldHVybmluZw0KPiBvbmx5IC0xIG9yIGFuIGVudW0/
DQo+IA0KDQpJIGFtIGdvaW5nIHRvIHJlLXN1Ym1pdCB0aGlzIHdpdGggYW4gZW51bS1zdHlsZSBy
ZXR1cm4uIEkgYW0gYWxzbw0KY2hhbmdpbmcgaG93IHdlIHBhcnNlIHNvIHRoYXQgd2UgY2FuIGNv
cnJlY3RseSByZXBvcnQgd2hldGhlciB0aGUgc29ydA0KZnVuY3Rpb24gb3Igc29ydCBhdG9tIGlz
IGluY29ycmVjdC4NCg0KVGhhbmtzLA0KSmFrZQ0K
