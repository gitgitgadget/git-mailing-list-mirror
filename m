From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH 3/3] tag: support configuring --sort via .gitconfig
Date: Tue, 15 Jul 2014 17:27:14 +0000
Message-ID: <1405445234.2577.0.camel@jekeller-desk1.amr.corp.intel.com>
References: <1405119347-3308-1-git-send-email-jacob.e.keller@intel.com>
	 <1405119347-3308-3-git-send-email-jacob.e.keller@intel.com>
	 <CAPig+cR9VCtNhk-FbqDM1LTCa8VeUTYXU4XEX36Rb5CxPFfLWQ@mail.gmail.com>
	 <xmqqfvi518xo.fsf@gitster.dls.corp.google.com>
	 <20140713173356.GA8406@sigill.intra.peff.net>
	 <20140713183629.GA19293@sigill.intra.peff.net>
	 <xmqqfvi3zwp7.fsf@gitster.dls.corp.google.com>
	 <1405435933.9147.1.camel@jekeller-desk1.amr.corp.intel.com>
	 <xmqqfvi2wqvq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"peff@peff.net" <peff@peff.net>,
	"sunshine@sunshineco.com" <sunshine@sunshineco.com>
To: "gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 19:27:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X76Vs-0005LA-1R
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 19:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758696AbaGOR1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 13:27:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:18238 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758539AbaGOR1a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 13:27:30 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP; 15 Jul 2014 10:27:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,666,1400050800"; 
   d="scan'208";a="570212147"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jul 2014 10:27:28 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.123.3; Tue, 15 Jul 2014 10:27:27 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.59]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.189]) with mapi id 14.03.0123.003;
 Tue, 15 Jul 2014 10:27:15 -0700
Thread-Topic: [PATCH 3/3] tag: support configuring --sort via .gitconfig
Thread-Index: AQHPoEZf40BrU7LSLEikGiD9Y5cKsJuh2NQA
In-Reply-To: <xmqqfvi2wqvq.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <B6859C1E596AE445A5252191C3AD6A4F@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253575>

T24gVHVlLCAyMDE0LTA3LTE1IGF0IDA5OjAzIC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gIktlbGxlciwgSmFjb2IgRSIgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4gd3JpdGVzOg0K
PiANCj4gPiBPbiBNb24sIDIwMTQtMDctMTQgYXQgMTA6MTcgLTA3MDAsIEp1bmlvIEMgSGFtYW5v
IHdyb3RlOg0KPiA+PiBKZWZmIEtpbmcgPHBlZmZAcGVmZi5uZXQ+IHdyaXRlczoNCj4gPj4gDQo+
ID4+ID4gT24gU3VuLCBKdWwgMTMsIDIwMTQgYXQgMDE6MzM6NTZQTSAtMDQwMCwgSmVmZiBLaW5n
IHdyb3RlOg0KPiA+PiA+DQo+ID4+ID4+IEkgcmVhbGl6ZSB0aGF0IEkgYW0gcmVpbnZlbnRpbmcg
dGhlIGVycm9yLXJlcG9ydGluZyB3aGVlbCBvbiBhIHNsZWVweQ0KPiA+PiA+PiBTdW5kYXkgYWZ0
ZXJub29uIHdpdGhvdXQgaGF2aW5nIHRob3VnaHQgYWJvdXQgaXQgbXVjaCwgc28gdGhlcmUgaXMN
Cj4gPj4gPj4gcHJvYmFibHkgc29tZSBnb3RjaGEgb3IgY2FzZSB0aGF0IG1ha2VzIHRoaXMgdWds
eSwgb3IgcGVyaGFwcyBpdCBqdXN0DQo+ID4+ID4+IGVuZHMgdXAgdmVyYm9zZSBpbiBwcmFjdGlj
ZS4gQnV0IG9uZSBjYW4gZHJlYW0uDQo+ID4+ID4NCj4gPj4gPiBKdXN0IGZvciBmdW4uLi4NCj4g
Pj4gDQo+ID4+IFllcywgdGhhdCBpcyBmdW4uDQo+ID4+IA0KPiA+PiBJIGFjdHVhbGx5IHRoaW5r
IHlvdXIgIkluICd2ZXJzaW9uOnBlZm5hbWUnIGFuZCAnd2Vyc2lvbjpyZWZuYW1lJywNCj4gPj4g
d2Ugd2FudCBiZSBhYmxlIHRvIHJlcG9ydCAncGVmbmFtZScgYW5kICd3ZXJzaW9uJyBhcmUgbWlz
c3BlbGxlZCwNCj4gPj4gYW5kIHJldHVybmluZyAtMSBvciBlbnVtIHdvdWxkIG5vdCBjdXQgaXQi
IGlzIGEgZ29vZCBhcmd1bWVudC4gIFRoZQ0KPiA+PiBjYWxsZWUgd2FudHMgdG8gaGF2ZSBmbGV4
aWJpbGl0eSBvbiBfd2hhdF8gdG8gcmVwb3J0LCBqdXN0IGFzIHRoZQ0KPiA+PiBjYWxsZXIgd2Fu
dHMgdG8gaGF2ZSBmbGV4aWJpbGl0eSBvbiBfaG93Xy4gIEluIHRoaXMgcGFydGljdWxhciBjb2Rl
DQo+ID4+IHBhdGgsIEkgdGhpbmsgdGhlIGZvcm1lciBmYXIgb3V0d2VpZ2hzIHRoZSBsYXR0ZXIs
IGFuZCBteSBzdWdnZXN0aW9uDQo+ID4+IEkgY2FsbGVkICJzaWxseSIgbWlnaHQgbm90IGJlIHNv
IHNpbGx5IGJ1dCBtYXkgaGF2ZSBzdHJ1Y2sgdGhlIHJpZ2h0DQo+ID4+IGJhbGFuY2UuICBJIGR1
bm5vLg0KPiA+PiANCj4gPj4gSWYgeW91IGFic29sdXRlbHkgbmVlZCB0byBoYXZlIGJvdGgsIHlv
dSB3b3VsZCBuZWVkIHNvbWV0aGluZyBsaWtlDQo+ID4+IHlvdXIgYXBwcm9hY2gsIG9mIGNvdXJz
ZSwgYnV0IEkgYW0gbm90IHN1cmUgaWYgaXQgaXMgd29ydGggaXQuDQo+ID4+IA0KPiA+PiBJIGFt
IG5vdCBzdXJlIGhvdyB3ZWxsIHRoaXMgbWVzaGVzIHdpdGggaTE4biAoSSBrbm93IHRoZSAiZm9y
IGZ1biINCj4gPj4gZG9lcyBub3QgZXZlbiBhdHRlbXB0IHRvLCBidXQgaWYgd2UgdHJpZWQgdG8s
IEkgc3VzcGVjdCBpdCBtYXkNCj4gPj4gYmVjb21lIGV2ZW4gdWdsaWVyKS4gIFdlIHdvdWxkIGFs
c28gbmVlZCB0byBvdmVycmlkZSBib3RoIGVycm9yIGFuZA0KPiA+PiB3YXJuaW5nIHJvdXRpbmVz
IGFuZCBoYXZlIHRoZSByZXBvcnRlciB0YWcgdGhlIGVycm9ycyBpbiB0aGVzZSB0d28NCj4gPj4g
Y2F0ZWdvcmllcywgbm8/DQo+ID4NCj4gPiBEbyB3ZSB3YW50IHRvIGdvIHRoaXMgd2F5Pw0KPiAN
Cj4gSSBkbyBub3Qgc3BlYWsgZm9yIFBlZmYsIGJ1dCBJIHBlcnNvbmFsbHkgdGhpbmsgdGhpcyBp
cyBqdXN0IGEgImZ1biINCj4gZGVtb25zdHJhdGlvbiwgbm90aGluZyBtb3JlLCBhbmQgbXkgZ3V0
IGZlZWxpbmcgaXMgdGhhdCBpdCB3b3VsZA0KPiBtYWtlIHRoaW5ncyB1bm5lY2Vzc2FyeSBjb21w
bGV4IHdpdGhvdXQgbXVjaCByZWFsIGdhaW4gdG8gcHVyc3VlIGl0DQo+IGZ1cnRoZXIuDQoNCkkg
YWdyZWUuIEJ1dCB3aGF0IGFib3V0IGdvaW5nIGJhY2sgdG8gdGhlIG9sZGVyIHNldHVwIHdoZXJl
IHRoZSBjYWxsZXINCmNhbiBvdXRwdXQgY29ycmVjdCBlcnJvciBtZXNzYWdlPyBJJ20gb2sgd2l0
aCB1c2luZyBhbiBlbnVtIHN0eWxlDQpyZXR1cm4sIHRvIGJlIGNvbXBsZXRlbHkgaG9uZXN0LiBJ
IHdvdWxkIHByZWZlciB0aGlzLCBhY3R1YWxseS4NCg0KVGhhbmtzLA0KSmFrZQ0KDQo=
