From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH 3/3 v5] tag: support configuring --sort via .gitconfig
Date: Fri, 11 Jul 2014 22:12:48 +0000
Message-ID: <1405116767.22963.53.camel@jekeller-desk1.amr.corp.intel.com>
References: <1405099447-27555-1-git-send-email-jacob.e.keller@intel.com>
	 <1405099447-27555-3-git-send-email-jacob.e.keller@intel.com>
	 <20140711174628.GC7856@sigill.intra.peff.net>
	 <xmqqmwcf36jy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"peff@peff.net" <peff@peff.net>
To: "gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 00:13:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5j3q-0007y3-V3
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 00:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753967AbaGKWMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 18:12:54 -0400
Received: from mga03.intel.com ([143.182.124.21]:49248 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552AbaGKWMx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 18:12:53 -0400
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 11 Jul 2014 15:12:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,645,1400050800"; 
   d="scan'208";a="456075498"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by azsmga001.ch.intel.com with ESMTP; 11 Jul 2014 15:12:48 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.193]) by
 ORSMSX104.amr.corp.intel.com ([169.254.3.57]) with mapi id 14.03.0123.003;
 Fri, 11 Jul 2014 15:12:48 -0700
Thread-Topic: [PATCH 3/3 v5] tag: support configuring --sort via .gitconfig
Thread-Index: AQHPnVKutKQEouEPQUqhaN0T4H7NY5ub5TGA
In-Reply-To: <xmqqmwcf36jy.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <96880807E9DFB846A1C5A2567761B171@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253333>

T24gRnJpLCAyMDE0LTA3LTExIGF0IDE0OjU0IC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gSmVmZiBLaW5nIDxwZWZmQHBlZmYubmV0PiB3cml0ZXM6DQo+IA0KPiA+IE9uIEZyaSwgSnVs
IDExLCAyMDE0IGF0IDEwOjI0OjA3QU0gLTA3MDAsIEphY29iIEtlbGxlciB3cm90ZToNCj4gPg0K
PiA+PiBVcGRhdGVkIHRvIGluY2x1ZGUgY2hhbmdlcyBkdWUgdG8gSnVuaW8ncyBmZWVkYmFjay4g
VGhpcyBoYXMgbm90IHJlc29sdmVkDQo+ID4+IHdoZXRoZXIgd2Ugc2hvdWxkIGZhaWwgb24gYSBj
b25maWd1cmF0aW9uIGVycm9yIG9yIHNpbXBseSB3YXJuLiBJdCBhcHBlYXJzIHRoYXQNCj4gPj4g
d2UgYWN0dWFsbHkgc2VlbSB0byBlcnJvciBvdXQgbW9yZSB0aGFuIHdhcm4sIHNvIEkgYW0gdW5z
dXJlIHdoYXQgdGhlIGNvcnJlY3QNCj4gPj4gYWN0aW9uIGlzIGhlcmUuDQo+ID4NCj4gPiBZZWFo
LCB3ZSdyZSBxdWl0ZSBpbmNvbnNpc3RlbnQgdGhlcmUuIEluIHNvbWUgY2FzZXMgd2Ugc2lsZW50
bHkgaWdub3JlDQo+ID4gc29tZXRoaW5nIHVua25vd24gKGUuZy4sIGEgY29sb3IuZGlmZi4qIHNs
b3QgdGhhdCB3ZSBkbyBub3QgdW5kZXJzdGFuZCksDQo+ID4gYnV0IGluIG1vc3QgY2FzZXMgaWYg
aXQgaXMgYSBjb25maWcga2V5IHdlIHVuZGVyc3RhbmQgYnV0IGEgdmFsdWUgd2UgZG8NCj4gPiBu
b3QsIHdlIGNvbXBsYWluIGFuZCBkaWUuDQo+IA0KPiBIbSwgdGhhdCdzIGJhZC0tLXdlJ3ZlIGJl
Y29tZSBsZXNzIGFuZCBsZXNzIGNhcmVmdWwgb3ZlciB0aW1lLA0KPiBwZXJoYXBzPw0KPiANCj4g
QXMgd2Ugd2FudCB0byBiZSBhYmxlIHRvIGVuaGFuY2Ugc2VtYW50aWNzIG9mIGV4aXN0aW5nIGNv
bmZpZ3VyYXRpb24NCj4gdmFyaWFibGVzIHdpdGhvdXQgaGF2aW5nIHRvIGludHJvZHVjZSBuZXcg
YnV0IHNpbWlsYXIgb25lcywgd2Ugd291bGQNCj4gcmVhbGx5IHdhbnQgdG8gbWFrZSBzdXJlIHRo
YXQgdGhvc2Ugd2hvIHNoYXJlIHRoZSBzYW1lIC5naXQvY29uZmlnDQo+IG9yICRIT01FLy5naXRj
b25maWcgYWNyb3NzIGRpZmZlcmVudCB2ZXJzaW9ucyBvZiBHaXQgd291bGQgbm90IGhhdmUNCj4g
dG8gc3VmZmVyIHRvbyBtdWNoIChpLmUuIGZvcmNpbmcgdGhlbSB0byAiY29uZmlnIC0tdW5zZXQi
IHdoZW4gdXNpbmcNCj4gdGhlaXIgb2xkZXIgR2l0IGlzIG5vdCBuaWNlKS4NCj4gDQo+ID4gSXQn
cyBwcm9iYWJseSB1c2VyLXVuZnJpZW5kbHkgdG8gYmUgc2lsZW50IGZvciB0aG9zZSBjYXNlcywg
dGhvdWdoLiBUaGUNCj4gPiB1c2VyIGdldHMgbm8gZmVlZGJhY2sgb24gd2h5IHRoZWlyIGNvbmZp
ZyB2YWx1ZSBpcyBkb2luZyBub3RoaW5nLg0KPiA+DQo+ID4gSSB0ZW5kIHRvIHRoaW5rIHRoYXQg
d2FybmluZyBpcyBub3QgbXVjaCBiZXR0ZXIgdGhhbiBlcnJvcmluZyBvdXQuIEl0IGlzDQo+ID4g
aGVscGZ1bCBpZiB5b3UgYXJlIHJ1bm5pbmcgYSBzaW5nbGUtc2hvdCBvZiBhbiBvbGQgdmVyc2lv
biAod2hpY2ggaXMNCj4gPiBzb21ldGhpbmcgdGhhdCBJIGRvIGEgbG90IHdoZW4gdGVzdGluZyBv
bGQgdmVyc2lvbnMpLCBidXQgd291bGQgcXVpY2tseQ0KPiA+IGJlY29tZSBpcnJpdGF0aW5nIGlm
IHlvdSB3ZXJlIGFjdHVhbGx5IHVzaW5nIGFuIG9sZCB2ZXJzaW9uIG9mIGdpdA0KPiA+IGRheS10
by1kYXkuDQo+ID4NCj4gPiBJIGR1bm5vLiBNYXliZSBpdCBpcyB3b3J0aCBtYWtpbmcgbGlmZSBl
YXNpZXIgZm9yIHBlb3BsZSBpbiB0aGUgZm9ybWVyDQo+ID4gY2F0ZWdvcnkuDQo+IA0KPiAuLi4g
ImZvcm1lciBjYXQiIG1lYW5pbmcgImxlc3MgaXJyaXRhdGluZyBmb3Igc2luZ2xlLXNob3QgdXNl
Ij8gIEkNCj4gZHVubm8uLi4NCj4gDQo+ID4+ICtzdGF0aWMgaW50IHBhcnNlX3NvcnRfc3RyaW5n
KGNvbnN0IGNoYXIgKmFyZywgaW50ICpzb3J0KQ0KPiA+PiArew0KPiA+PiArCWludCB0eXBlID0g
MCwgZmxhZ3MgPSAwOw0KPiA+PiArDQo+ID4+ICsJaWYgKHNraXBfcHJlZml4KGFyZywgIi0iLCAm
YXJnKSkNCj4gPj4gKwkJZmxhZ3MgfD0gUkVWRVJTRV9TT1JUOw0KPiA+PiArDQo+ID4+ICsJaWYg
KHNraXBfcHJlZml4KGFyZywgInZlcnNpb246IiwgJmFyZykgfHwgc2tpcF9wcmVmaXgoYXJnLCAi
djoiLCAmYXJnKSkNCj4gPj4gKwkJdHlwZSA9IFZFUkNNUF9TT1JUOw0KPiA+PiArCWVsc2UNCj4g
Pj4gKwkJdHlwZSA9IFNUUkNNUF9TT1JUOw0KPiA+PiArDQo+ID4+ICsJaWYgKHN0cmNtcChhcmcs
ICJyZWZuYW1lIikpDQo+ID4+ICsJCXJldHVybiBlcnJvcihfKCJ1bnN1cHBvcnRlZCBzb3J0IHNw
ZWNpZmljYXRpb24gJXMiKSwgYXJnKTsNCj4gPj4gKw0KPiA+PiArCSpzb3J0ID0gKHR5cGUgfCBm
bGFncyk7DQo+ID4+ICsNCj4gPj4gKwlyZXR1cm4gMDsNCj4gPj4gK30NCj4gPg0KPiA+IFJlZ2Fy
ZGxlc3Mgb2YgaG93IHdlIGhhbmRsZSB0aGUgZXJyb3IsIEkgdGhpbmsgdGhpcyB2ZXJzaW9uIHRo
YXQNCj4gPiBhc3NlbWJsZXMgdGhlIGZpbmFsIGJpdGZpZWxkIGF0IHRoZSBlbmQgaXMgZWFzaWVy
IHRvIHJlYWQgdGhhbiB0aGUNCj4gPiBvcmlnaW5hbC4NCj4gDQo+IFllcywgdGhpcyBwYXJ0IHJl
YWxseSBpcyBuaWNlbHkgZG9uZSwgSSBhZ3JlZS4NCg0KVGhlIGN1cnJlbnQgcmV2aXNpb24gb2Yg
dGhlIHBhdGNoIHByaW50cyBhbiBlcnJvciBhbmQgd2FybmluZyBhYm91dCBub3QNCnVzaW5nIHRo
ZSBjb25maWd1cmVkIHRhZyB2YWx1ZS4gSXQgZG9lcyBzdGlsbCBydW4uIEkgYWRkZWQgYSB0ZXN0
IHRvDQplbnN1cmUgdGhpcyBhcyB3ZWxsLg0KDQpUaGUgZWFzaWVzdCB3YXkgdG8gY2hhbmdlIG92
ZXJhbGwgYmVoYXZpb3IgaXMgdG8gY2hhbmdlIHRoZSBnaXQtY29uZmlnJ3MNCiJkaWVfb25fZXJy
b3IiIHRvIGJlIGZhbHNlLCBzbyB0aGF0IHdlIG5vIGxvbmdlciBkaWUgb24gY29uZmlndXJhdGlv
bg0KZXJyb3JzLg0KDQpJdCBhcHBlYXJzIHRoaXMgd291bGQgcmVzb2x2ZSB0aGUgaXNzdWUgZm9y
IG1hbnkgY29uZmlndXJhdGlvbiBvcHRpb25zDQoobm90IGFsbCwgYXMgSSB0aGluayBhIGZldyBh
cmUgc3RpbGwgaGFyZCBjb2RlZCB0byBkaWUpIGJ1dCBpdCB3b3VsZCBiZQ0KYSBjaGFuZ2UgdGhh
dCBpcyB3ZWxsIG91dHNpZGUgdGhlIHNjb3BlIG9mIHRoaXMgcGF0Y2guDQoNCkkgdGhpbmsgdGhh
dCBmb3Igbm93IGJlaGF2aW9yIEkgYWRkZWQgaXMgZ29vZCwgYXMgd2UgKmtub3cqIHRoYXQNCnRh
Zy5zb3J0IHdpbGwgYWRkIG5ldyBwYXJhbWV0ZXJzIGluIHRoZSBuZWFyIGZ1dHVyZSwgc28gaXQg
bWFrZXMgbm8NCnNlbnNlIHRvIGhhdmUgaXQgZGllIG9uIGEgY29uZmlnIHRoYXQgaXMgb25seSBz
bGlnaHRseSBuZXdlciB0aGFuIHRoZQ0KZ2l0IHZlcnNpb24uDQoNCkdsYWQgSSBjb3VsZCBoZWxw
LiBKdW5pbyBpZiB5b3UgY291bGQgcmV2aWV3IHRoZSB2NyBJIHNlbnQgYSBiaXQgYWdvIGZvcg0K
YW55IHBvc3NpYmxlIG1pc3Rha2VzIHRoYXQgSSBmb3Jnb3QgdG8gY2xlYW4gdXAgdGhhdCB3b3Vs
ZCBiZSBncmVhdC4NCg0KVGhhbmtzLA0KSmFrZQ0K
