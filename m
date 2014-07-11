From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH 3/3] tag: support configuring --sort via .gitconfig
Date: Fri, 11 Jul 2014 21:08:28 +0000
Message-ID: <1405112907.22963.48.camel@jekeller-desk1.amr.corp.intel.com>
References: <1405111895-17451-1-git-send-email-jacob.e.keller@intel.com>
	 <1405111895-17451-3-git-send-email-jacob.e.keller@intel.com>
	 <20140711210633.GA12546@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "peff@peff.net" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 11 23:08:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5i3V-0004mD-W2
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 23:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbaGKVIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 17:08:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:59366 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800AbaGKVI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 17:08:29 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP; 11 Jul 2014 14:08:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,645,1400050800"; 
   d="scan'208";a="568667733"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jul 2014 14:08:28 -0700
Received: from orsmsx152.amr.corp.intel.com (10.22.226.39) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.123.3; Fri, 11 Jul 2014 14:08:28 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.193]) by
 ORSMSX152.amr.corp.intel.com ([169.254.8.128]) with mapi id 14.03.0123.003;
 Fri, 11 Jul 2014 14:08:28 -0700
Thread-Topic: [PATCH 3/3] tag: support configuring --sort via .gitconfig
Thread-Index: AQHPnUnvxsbR8A2dgEOXgE7LAeOTh5ub0sGAgAAAiIA=
In-Reply-To: <20140711210633.GA12546@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <C052423AEA863B4CB546B9BB3E1BBF10@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253327>

T24gRnJpLCAyMDE0LTA3LTExIGF0IDE3OjA2IC0wNDAwLCBKZWZmIEtpbmcgd3JvdGU6DQo+IE9u
IEZyaSwgSnVsIDExLCAyMDE0IGF0IDAxOjUxOjM1UE0gLTA3MDAsIEphY29iIEtlbGxlciB3cm90
ZToNCj4gDQo+ID4gKwlpZiAoIXN0cmNtcCh2YXIsICJ0YWcuc29ydCIpKSB7DQo+ID4gKwkJaWYg
KCF2YWx1ZSkNCj4gPiArCQkJcmV0dXJuIGNvbmZpZ19lcnJvcl9ub25ib29sKHZhcik7DQo+ID4g
KwkJc3RhdHVzID0gcGFyc2Vfc29ydF9zdHJpbmcodmFsdWUsICZ0YWdfc29ydCk7DQo+ID4gKwkJ
aWYgKHN0YXR1cykgew0KPiA+ICsJCQl3YXJuaW5nKCJ1c2luZyBkZWZhdWx0IGxleGljb2dyYXBo
aWMgc29ydCBvcmRlciIpOw0KPiA+ICsJCQl0YWdfc29ydCA9IFNUUkNNUF9TT1JUOw0KPiA+ICsJ
CX0NCj4gDQo+IEkgdGhpbmsgdGhpcyBpcyBhIGdvb2QgY29tcHJvbWlzZSBvZiB0aGUgaXNzdWVz
IHdlIGRpc2N1c3NlZCBlYXJsaWVyLiBBcw0KPiB5b3Ugbm90ZWQsIGl0IHNob3VsZCBwcm9iYWJs
eSBiZSBtYXJrZWQgZm9yIHRyYW5zbGF0aW9uLiBJJ20gYWxzbyBub3QNCj4gc3VyZSB0aGUgbWVz
c2FnZSBjb250ZW50IGlzIGNsZWFyIGluIGFsbCBzaXR1YXRpb25zLiBJZiBJIGhhdmUgYSBicm9r
ZW4NCj4gdGFnLnNvcnQsIEkgZ2V0Og0KPiANCj4gICAkIGdpdCBjb25maWcgdGFnLnNvcnQgYm9n
dXMNCj4gICAkIGdpdCB0YWcgPi9kZXYvbnVsbA0KPiAgIGVycm9yOiB1bnN1cHBvcnRlZCBzb3J0
IHNwZWNpZmljYXRpb24gYm9ndXMNCj4gICB3YXJuaW5nOiB1c2luZyBkZWZhdWx0IGxleGljb2dy
YXBoaWMgc29ydCBvcmRlcg0KPiANCj4gTm90IHRvbyBiYWQsIHRob3VnaCByZW1pbmRpbmcgbWUg
dGhhdCB0aGUgdmFsdWUgImJvZ3VzIiBjYW1lIGZyb20NCj4gdGFnLnNvcnQgd291bGQgYmUgbmlj
ZS4gQnV0IHdoYXQgaWYgSSBvdmVycmlkZSBpdDoNCj4gDQo+ICAgJCBnaXQgdGFnIC0tc29ydD12
OnJlZm5hbWUgPi9kZXYvbnVsbA0KPiAgIGVycm9yOiB1bnN1cHBvcnRlZCBzb3J0IHNwZWNpZmlj
YXRpb24gYm9ndXMNCj4gICB3YXJuaW5nOiB1c2luZyBkZWZhdWx0IGxleGljb2dyYXBoaWMgc29y
dCBvcmRlcg0KPiANCj4gVGhhdCdzIGFjdGl2ZWx5IHdyb25nLCBiZWNhdXNlIHdlIGFyZSB1c2lu
ZyB2OnJlZm5hbWUgZnJvbSB0aGUNCj4gY29tbWFuZC1saW5lLiBQZXJoYXBzIHdlIGNvdWxkIHBo
cmFzZSBpdCBsaWtlOg0KPiANCj4gICB3YXJuaW5nOiBpZ25vcmluZyBpbnZhbGlkIGNvbmZpZyBv
cHRpb24gdGFnLnNvcnQNCj4gDQoNCm9rIHRoYXQgbWFrZXMgbW9yZSBzZW5zZS4gSSBjYW4ndCBy
ZWFsbHkgYXZvaWQgcHJpbnRpbmcgdGhlIHdhcm5pbmcgYXQNCmFsbCBzaW5jZSBjb25maWcgcGFy
c2luZyBoYXBwZW5zIGJlZm9yZSB0aGUgb3B0aW9uIHBhcnNpbmcuDQoNCkkgbGlrZSB0aGlzIHdv
cmRpbmcuIEkgd2lsbCByZXNwaW4gYWdhaW4gOkQNCg0KVGhhbmtzLA0KSmFrZQ0KDQo+IG9yIHNp
bWlsYXIsIHdoaWNoIGhlbHBzIGJvdGggY2FzZXMuDQo+IA0KPiBBcyBhbiBhc2lkZSwgSSBhbHNv
IHRoaW5rIHRoZSBlcnJvciBsaW5lIGNvdWxkIG1vcmUgY2xlYXJseSBtYXJrIHRoZQ0KPiBsaXRl
cmFsIGNvbnRlbnRzIG9mIHRoZSB2YXJpYWJsZS4gRS5nLiwgb25lIG9mOg0KPiANCj4gICBlcnJv
cjogdW5zdXBwb3J0ZWQgc29ydCBzcGVjaWZpY2F0aW9uOiBib2d1cw0KPiANCj4gb3INCj4gDQo+
ICAgZXJyb3I6IHVuc3VwcG9ydGVkIHNvcnQgc3BlY2lmaWNhdGlvbiAnYm9ndXMnDQo+IA0KPiAt
UGVmZg0KDQoNCg==
