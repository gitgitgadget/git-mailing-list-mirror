From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH 3/3] tag: support configuring --sort via .gitconfig
Date: Fri, 11 Jul 2014 22:30:18 +0000
Message-ID: <1405117818.22963.54.camel@jekeller-desk1.amr.corp.intel.com>
References: <1405111895-17451-1-git-send-email-jacob.e.keller@intel.com>
	 <1405111895-17451-3-git-send-email-jacob.e.keller@intel.com>
	 <20140711210633.GA12546@sigill.intra.peff.net>
	 <xmqqha2n35hq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"peff@peff.net" <peff@peff.net>
To: "gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 00:30:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5jKh-0000xa-Fe
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 00:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226AbaGKWaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 18:30:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:5018 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318AbaGKWaT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 18:30:19 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP; 11 Jul 2014 15:30:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,645,1400050800"; 
   d="scan'208";a="568696376"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jul 2014 15:30:18 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.193]) by
 ORSMSX104.amr.corp.intel.com ([169.254.3.57]) with mapi id 14.03.0123.003;
 Fri, 11 Jul 2014 15:30:17 -0700
Thread-Topic: [PATCH 3/3] tag: support configuring --sort via .gitconfig
Thread-Index: AQHPnVXixsbR8A2dgEOXgE7LAeOTh5ub6g8A
In-Reply-To: <xmqqha2n35hq.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <B46E69E43FD5214AAA989DBFA8FB5718@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253339>

T24gRnJpLCAyMDE0LTA3LTExIGF0IDE1OjE3IC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gSmVmZiBLaW5nIDxwZWZmQHBlZmYubmV0PiB3cml0ZXM6DQo+IA0KPiA+IE9uIEZyaSwgSnVs
IDExLCAyMDE0IGF0IDAxOjUxOjM1UE0gLTA3MDAsIEphY29iIEtlbGxlciB3cm90ZToNCj4gPg0K
PiA+PiArCWlmICghc3RyY21wKHZhciwgInRhZy5zb3J0IikpIHsNCj4gPj4gKwkJaWYgKCF2YWx1
ZSkNCj4gPj4gKwkJCXJldHVybiBjb25maWdfZXJyb3Jfbm9uYm9vbCh2YXIpOw0KPiA+PiArCQlz
dGF0dXMgPSBwYXJzZV9zb3J0X3N0cmluZyh2YWx1ZSwgJnRhZ19zb3J0KTsNCj4gPj4gKwkJaWYg
KHN0YXR1cykgew0KPiA+PiArCQkJd2FybmluZygidXNpbmcgZGVmYXVsdCBsZXhpY29ncmFwaGlj
IHNvcnQgb3JkZXIiKTsNCj4gPj4gKwkJCXRhZ19zb3J0ID0gU1RSQ01QX1NPUlQ7DQo+ID4+ICsJ
CX0NCj4gPg0KPiA+IEkgdGhpbmsgdGhpcyBpcyBhIGdvb2QgY29tcHJvbWlzZSBvZiB0aGUgaXNz
dWVzIHdlIGRpc2N1c3NlZCBlYXJsaWVyLiBBcw0KPiA+IHlvdSBub3RlZCwgaXQgc2hvdWxkIHBy
b2JhYmx5IGJlIG1hcmtlZCBmb3IgdHJhbnNsYXRpb24uIEknbSBhbHNvIG5vdA0KPiA+IHN1cmUg
dGhlIG1lc3NhZ2UgY29udGVudCBpcyBjbGVhciBpbiBhbGwgc2l0dWF0aW9ucy4gSWYgSSBoYXZl
IGEgYnJva2VuDQo+ID4gdGFnLnNvcnQsIEkgZ2V0Og0KPiA+DQo+ID4gICAkIGdpdCBjb25maWcg
dGFnLnNvcnQgYm9ndXMNCj4gPiAgICQgZ2l0IHRhZyA+L2Rldi9udWxsDQo+ID4gICBlcnJvcjog
dW5zdXBwb3J0ZWQgc29ydCBzcGVjaWZpY2F0aW9uIGJvZ3VzDQo+ID4gICB3YXJuaW5nOiB1c2lu
ZyBkZWZhdWx0IGxleGljb2dyYXBoaWMgc29ydCBvcmRlcg0KPiA+DQo+ID4gTm90IHRvbyBiYWQs
IHRob3VnaCByZW1pbmRpbmcgbWUgdGhhdCB0aGUgdmFsdWUgImJvZ3VzIiBjYW1lIGZyb20NCj4g
PiB0YWcuc29ydCB3b3VsZCBiZSBuaWNlLiBCdXQgd2hhdCBpZiBJIG92ZXJyaWRlIGl0Og0KPiA+
DQo+ID4gICAkIGdpdCB0YWcgLS1zb3J0PXY6cmVmbmFtZSA+L2Rldi9udWxsDQo+ID4gICBlcnJv
cjogdW5zdXBwb3J0ZWQgc29ydCBzcGVjaWZpY2F0aW9uIGJvZ3VzDQo+ID4gICB3YXJuaW5nOiB1
c2luZyBkZWZhdWx0IGxleGljb2dyYXBoaWMgc29ydCBvcmRlcg0KPiA+DQo+ID4gVGhhdCdzIGFj
dGl2ZWx5IHdyb25nLCBiZWNhdXNlIHdlIGFyZSB1c2luZyB2OnJlZm5hbWUgZnJvbSB0aGUNCj4g
PiBjb21tYW5kLWxpbmUuICBQZXJoYXBzIHdlIGNvdWxkIHBocmFzZSBpdCBsaWtlOg0KPiA+DQo+
ID4gICB3YXJuaW5nOiBpZ25vcmluZyBpbnZhbGlkIGNvbmZpZyBvcHRpb24gdGFnLnNvcnQNCj4g
Pg0KPiA+IG9yIHNpbWlsYXIsIHdoaWNoIGhlbHBzIGJvdGggY2FzZXMuDQo+IA0KPiBIbXBoLiAg
TG9va3MgbGlrZSBhIG1pbGQtZW5vdWdoIG1pZGRsZSBncm91bmQsIEkgZ3Vlc3MuICBBcw0KPiBw
YXJzZV9zb3J0X3N0cmluZygpIGlzIHByaXZhdGUgZm9yICJnaXQgdGFnIiBpbXBsZW1lbnRhdGlv
biwgSQ0KPiBhY3R1YWxseSB3b3VsZCBub3QgbWluZCBpZiB3ZSB0YXVnaHQgYSBiaXQgbW9yZSBj
b250ZXh0IHRvIGl0IGFuZA0KPiBwaHJhc2UgaXRzIG1lc3NhZ2VzIGRpZmZlcmVudGx5LiAgUGVy
aGFwcyBzb21ldGhpbmcgbGlrZSB0aGlzLCB3aGVyZQ0KPiB0aGUgY29uZmlnIHBhcnNlciB3aWxs
IHRlbGwgd2hhdCB2YXJpYWJsZSBpdCBjYW1lIGZyb20gd2l0aCAidmFyIg0KPiBhbmQgdGhlIGNv
bW1hbmQgbGluZSBwYXJzZXIgd2lsbCBwYXNzIE5VTEwgdGhlcmUuDQo+IA0KPiBzdGF0aWMgaW50
IHBhcnNlX3NvcnRfc3RyaW5nKGNvbnN0IGNoYXIgKnZhciwgY29uc3QgY2hhciAqdmFsdWUsIGlu
dCAqc29ydCkNCj4gew0KPiAJLi4uDQo+IAlpZiAoc3RyY21wKHZhbHVlLCAicmVmbmFtZSIpKSB7
DQo+IAkJaWYgKCF2YXIpDQo+ICAgICAgICAgICAgICAgICAJcmV0dXJuIGVycm9yKF8oInVuc3Vw
cG9ydGVkIHNvcnQgc3BlY2lmaWNhdGlvbiAnJXMnIiksIHZhbHVlKTsNCj4gCQllbHNlIHsNCj4g
ICAgICAgICAgICAgICAgIAl3YXJuaW5nKF8oInVuc3VwcG9ydGVkIHNvcnQgc3BlY2lmaWNhdGlv
biAnJXMnIGluIHZhcmlhYmxlICclcyciKSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgCXZh
ciwgdmFsdWUpOw0KPiAJCQlyZXR1cm4gLTE7DQo+IAkJfQ0KPiAJfQ0KPiANCj4gCSpzb3J0ID0g
KHR5cGUgfCBmbGFncyk7DQo+IA0KPiAJcmV0dXJuIDA7DQo+IH0NCj4gDQoNCk9rLi4gIEkgc3Vw
cG9zZSB0aGF0IGNvdWxkIGJlIGRvbmUuDQoNClRoYW5rcywNCkpha2UNCg0KPiA+IEFzIGFuIGFz
aWRlLCBJIGFsc28gdGhpbmsgdGhlIGVycm9yIGxpbmUgY291bGQgbW9yZSBjbGVhcmx5IG1hcmsg
dGhlDQo+ID4gbGl0ZXJhbCBjb250ZW50cyBvZiB0aGUgdmFyaWFibGUuIEUuZy4sIG9uZSBvZjoN
Cj4gPg0KPiA+ICAgZXJyb3I6IHVuc3VwcG9ydGVkIHNvcnQgc3BlY2lmaWNhdGlvbjogYm9ndXMN
Cj4gPg0KPiA+IG9yDQo+ID4NCj4gPiAgIGVycm9yOiB1bnN1cHBvcnRlZCBzb3J0IHNwZWNpZmlj
YXRpb24gJ2JvZ3VzJw0KPiANCj4gWXVwLg0KDQoNCg==
