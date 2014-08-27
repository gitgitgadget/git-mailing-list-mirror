From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: Improving the git remote command
Date: Wed, 27 Aug 2014 21:22:40 +0000
Message-ID: <1409174560.2715.15.camel@jekeller-desk1.amr.corp.intel.com>
References: <53FC537C.4080206@gmail.com> <20140826124027.GE29180@peff.net>
	 <CAGK7Mr7BPvV6oO_t4x_1m9sDtWBgPWUqDq+3kZx6rVYAhY+wqA@mail.gmail.com>
	 <20140826163741.GA14983@peff.net>
	 <xmqq7g1vjh9o.fsf@gitster.dls.corp.google.com>
	 <20140826173312.GB16394@peff.net> <20140827163617.GA66615@gmail.com>
	 <xmqqegw1d61r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"davvid@gmail.com" <davvid@gmail.com>,
	"peff@peff.net" <peff@peff.net>,
	"philippe.vaucher@gmail.com" <philippe.vaucher@gmail.com>,
	"hubscher.remy@gmail.com" <hubscher.remy@gmail.com>
To: "gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 23:22:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMkg2-0007CG-MV
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 23:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935907AbaH0VWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 17:22:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:43028 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932146AbaH0VWm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 17:22:42 -0400
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP; 27 Aug 2014 14:22:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,862,1389772800"; 
   d="scan'208";a="377847538"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Aug 2014 14:18:27 -0700
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.195.1; Wed, 27 Aug 2014 14:22:40 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.235]) by
 ORSMSX155.amr.corp.intel.com ([169.254.7.35]) with mapi id 14.03.0195.001;
 Wed, 27 Aug 2014 14:22:40 -0700
Thread-Topic: Improving the git remote command
Thread-Index: AQHPwRCzUVGQMaVfyU2h5vH8JE7G8JvjIzjngAB3nQCAAYJvAP//zavvgACCWAA=
In-Reply-To: <xmqqegw1d61r.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <6A5B9A1CCCED5D48A78D39C5BA11F8B9@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256046>

T24gV2VkLCAyMDE0LTA4LTI3IGF0IDEzOjM1IC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gRGF2aWQgQWd1aWxhciA8ZGF2dmlkQGdtYWlsLmNvbT4gd3JpdGVzOg0KPiANCj4gPiBXZSBo
YXZlIHNvbWUgaW50ZXJuYWwgc2NyaXB0cyBhdCBEaXNuZXkgQW5pbWF0aW9uIHRoYXQgcmVseSBv
biAiZ2l0IHJlbW90ZSINCj4gPiBvdXRwdXQgc28gSSB3b3VsZCB2b3RlIGZvciAjMyBwZXJzb25h
bGx5IGFzIHdlbGwuDQo+IA0KPiBJIHRha2UgaXQgdGhhdCB5b3UgbWVhbiB5b3Ugd291bGQgdm90
ZSBfYWdhaW5zdF8gIzMgd2hpY2ggd2lsbCBicmVhaw0KPiB0aGUgZXhwZWN0YXRpb24uDQo+IA0K
PiA+IEkga25vdyB0aGF0ICJnaXQgY29uZmlnIiBpcyBwb3JjZWxhaW4sIGFuZCBJIGNhbiBnZXQg
cmVtb3RlLiguKikudXJsLA0KPiA+IGJ1dCB0aGF0J3Mgbm90IG9idmlvdXMgYW5kIEkgaGlnaGx5
IGRvdWJ0IHRoYXQgYW55b25lIGRvZXMgdGhhdC4NCj4gDQo+IFBlcmhhcHMgdGhhdCBpcyBzb21l
dGhpbmcgd29ydGggZml4aW5nLg0KPiANCj4gPiBXaGF0IGlmIHdlIHNhaWQgdGhhdCAiZ2l0IHJl
bW90ZSBsaXN0IC0tcG9yY2VsYWluIiA9PSAiZ2l0IHJlbW90ZSINCj4gPiBhbmQgdGhlbiBqdXN0
IGxlYXZlICJnaXQgcmVtb3RlIiBvdXRwdXQgYXMtaXMgc28gdGhhdCB3ZSBkb24ndCBoYXZlIHRv
DQo+ID4gaGF2ZSBhIGZsYWcgZGF5IHdoZW4gd2UgYnJlYWsgcGVvcGxlJ3Mgc2NyaXB0cz8NCj4g
DQo+IEkgc3VzcGVjdCB0aGF0IGl0IGlzIG5vdCBsaWtlbHkgYSB3b3JrYWJsZSBzb2x1dGlvbi4g
IFRoZSBjb21tYW5kcw0KPiBiZWluZyBQb3JjZWxhaW4gYnkgZGVmaW5pdGlvbiBtZWFucyB0aGF0
IHBlb3BsZSBhaW1lZCB0byBtYWtlIHRoZWlyDQo+IG91dHB1dCBjb25zdW1hYmxlIGJ5IGh1bWFu
cywgYW5kIHRoZSBjdXJyZW50ICJnaXQgcmVtb3RlIiwgd2hpY2ggbWF5DQo+IGJlIHdoYXQgeW91
ciBzY3JpcHQgaGFwcGVucyB0byB1c2UsIGlzIG5vdCBieSBkZXNpZ24gdGhlIGJlc3QNCj4gcmVw
cmVzZW50YXRpb24gb2YgdGhlIGluZm9ybWF0aW9uIGZvciBhbGwgdGhlIHNjcmlwdCB3cml0ZXJz
IHRvDQo+IHdhbnQgdG8gY2FsbCBfZ29vZF8uDQo+IA0KPiBJZiB3ZSB3ZXJlIHRvIGRvICJnaXQg
cmVtb3RlIGxpc3QiLCBJJ2QgaW1hZ2luZSBpdCB3b3VsZCBiZSBmYXIgbW9yZQ0KPiB1c2VmdWwg
dG8gaGF2ZSAtLWZvcm1hdD0iPGZvcm1hdCBzcGVjaWZpZXJzPiIgb3B0aW9uIHNvIHRoYXQgeW91
IGNhbg0KPiBkbyBzb21ldGhpbmcgbGlrZQ0KPiANCj4gCWdpdCByZW1vdGUgbGlzdCAtLWZvcm1h
dD0iJShuYW1lKSAlKHVybCkgKCUoZGlyZWN0aW9uKSkiDQo+IA0KPiBUaGVuIHNjcmlwdHMgY2Fu
IGV4cGxpY2l0bHkgYXNrIGZvciB3aGF0IHRoZXkgd2FudCBhbmQgaGF2ZSBsZXNzDQo+IGNoYW5j
ZSBvZiBnZXR0aW5nIGJyb2tlbiAoSSBzYXkgImxlc3MiIGJlY2F1c2Ugd2hhdCAlKHNwZWNpZmll
cikNCj4gc3RhbmRzIGZvciBjb3VsZCBiZSBjaGFuZ2VkIGVpdGhlciB0byBmaXggbWlzdGFrZXMg
b3IgYnkgbWlzdGFrZSkuDQo+IA0KPiA+PiA+IEhhdmluZyBzYWlkIHRoYXQsIG15IHByZWZlcmVu
Y2UgaXMgDQo+ID4+ID4gDQo+ID4+ID4gICAgIDAuIERvIG5vdGhpbmcsIGJ1dCBkb2N1bWVudCB0
aGUgImRlZmF1bHQgdG8gbGlzdGluZyIgYmV0dGVyIGlmDQo+ID4+ID4gICAgICAgIG5lZWRlZC4N
Cj4gPj4gPiANCj4gPj4gPiBhbmQgdGhlbiAyLiBhYm92ZSwgYW5kIHRoZW4gMS4NCj4gPj4gDQo+
ID4+IFllYWgsIEknZCBhZ3JlZSB3aXRoIHRoYXQuDQo+ID4NCg0KUGVyc29uYWxseSwgSSBoYXZl
IGFsd2F5cyBkaXNsaWtlZCB0aGF0ICJnaXQgcmVtb3RlIiBvbmx5IHNob3dzIHJlbW90ZQ0KbmFt
ZXMsIHdoaWNoIGlzIGFsbW9zdCBlbnRpcmVseSB1c2VsZXNzIHRvIG1lIGFzIGEgaHVtYW4uIE9i
dmlvdXNseSBpdA0KaXMgZWFzaWVzdCB3YXkgdG8gYWN0dWFsbHkgZ2V0IHRoZSByZW1vdGUgbmFt
ZXMgb3V0Lg0KDQpJIHdvdWxkIG11Y2ggcHJlZmVyIGNoYW5naW5nIHRoZSBvdXRwdXQgc28gdGhh
dCBnaXQgcmVtb3RlIHNob3dzIGFsbCB0aGUNCm91dHB1dC4uIEJ1dCB5ZXMsIHRoaXMgZG9lcyBw
b3RlbnRpYWxseSBicmVhayBleHBlY3RlZCBvdXRwdXQgZnJvbSBhIGdpdA0KY29tbWFuZCB0aGF0
IG1pZ2h0IGJlIHVzZWQgYnkgc2NyaXB0cy4NCg0KSSBlbmQgdXAgdHlwaW5nIGdpdCByZW1vdGUg
YW5kIGZvcmdldHRpbmcgdGhlIC12IGEgbG90IG9mIHRoZSB0aW1lLCBzbyBJDQpoYXZlIHRvIHJl
LXJ1biB0aGUgY29tbWFuZC4gSXQgaGFzIGFsc28gY29uZnVzZWQgbWFueSBuZXcgcGVvcGxlIEkn
dmUNCmhhZCB0byB0ZWFjaCBnaXQuDQoNClJlZ2FyZHMsDQpKYWtlDQo=
