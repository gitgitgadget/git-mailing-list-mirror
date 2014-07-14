From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [Bug] data loss with cyclic alternates
Date: Mon, 14 Jul 2014 22:05:25 +0000
Message-ID: <02874ECE860811409154E81DA85FBB585719878B@ORSMSX115.amr.corp.intel.com>
References: <53BFB055.206@gmail.com>
 <xmqqy4vz51gb.fsf@gitster.dls.corp.google.com>
 <1405101705.22963.27.camel@jekeller-desk1.amr.corp.intel.com>
 <20140712055703.GA9655@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "gitster@pobox.com" <gitster@pobox.com>,
	"dr.khong@gmail.com" <dr.khong@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 15 00:05:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6oNI-0003D3-0p
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 00:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756976AbaGNWF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 18:05:29 -0400
Received: from mga03.intel.com ([143.182.124.21]:11278 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756749AbaGNWF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 18:05:27 -0400
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 14 Jul 2014 15:05:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,661,1400050800"; 
   d="scan'208";a="456910797"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by azsmga001.ch.intel.com with ESMTP; 14 Jul 2014 15:05:26 -0700
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.123.3; Mon, 14 Jul 2014 15:05:25 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.59]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.200]) with mapi id 14.03.0123.003;
 Mon, 14 Jul 2014 15:05:25 -0700
Thread-Topic: [Bug] data loss with cyclic alternates
Thread-Index: AQHPnOvPzy89dj/tTU+OVKdKD7By55ubCb3egACWHoCAAMfagIADvbRg
In-Reply-To: <20140712055703.GA9655@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.138]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253540>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVmZiBLaW5nIFttYWls
dG86cGVmZkBwZWZmLm5ldF0NCj4gU2VudDogRnJpZGF5LCBKdWx5IDExLCAyMDE0IDEwOjU3IFBN
DQo+IFRvOiBLZWxsZXIsIEphY29iIEUNCj4gQ2M6IGdpdHN0ZXJAcG9ib3guY29tOyBkci5raG9u
Z0BnbWFpbC5jb207IGdpdEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtCdWddIGRh
dGEgbG9zcyB3aXRoIGN5Y2xpYyBhbHRlcm5hdGVzDQo+IA0KPiBPbiBGcmksIEp1bCAxMSwgMjAx
NCBhdCAwNjowMTo0NlBNICswMDAwLCBLZWxsZXIsIEphY29iIEUgd3JvdGU6DQo+IA0KPiA+ID4g
WWVhaCwgZG9uJ3QgZG8gdGhhdC4gIEEgdGhpbmtzICJlaCwgdGhlIG90aGVyIGd1eSBtdXN0IGhh
dmUgaXQiIGFuZA0KPiA+ID4gQiB0aGlua3MgdGhlIHNhbWUuICBJbiBnZW5lcmFsLCBkbyBub3Qg
cHJ1bmUgb3IgZ2MgYSByZXBvc2l0b3J5DQo+ID4gPiBvdGhlciByZXBvc2l0b3JpZXMgYm9ycm93
IGZyb20sIGV2ZW4gaWYgdGhlcmUgaXMgbm8gY3ljbGUsIGJlY2F1c2UNCj4gPiA+IHRoZSBib3Jy
b3dlZSBkb2VzIG5vdCBrbm93IGFueXRobmluZyBhYm91dCBvYmplY3RzIHRoYXQgaXQgaXRzZWxm
IG5vDQo+ID4gPiBsb25nZXIgbmVlZHMgYnV0IGFyZSBzdGlsbCBuZWVkZWQgYnkgaXRzIGJvcnJv
d2Vycy4NCj4gPiA+DQo+ID4NCj4gPiBEb2Vzbid0IGdjIGdldCBydW4gYXV0b21hdGljYWxseSBh
dCBzb21lIHBvaW50cz8gSXMgdGhlIGF1dG9tYXRpYyBnYyBydW4NCj4gPiBzZXR1cCB0byBhdm9p
ZCB0aGlzIHByb2JsZW0/DQo+IA0KPiBObywgdGhlIGF1dG9tYXRpYyBnYyBkb2Vzbid0IGF2b2lk
IHRoaXMuIEl0IGNhbid0IGluIHRoZSBnZW5lcmFsIGNhc2UsDQo+IGFzIHRoZSBwYXJlbnQgcmVw
b3NpdG9yeSBkb2VzIG5vdCBrbm93IGhvdyBtYW55IG9yIHdoaWNoIGNoaWxkcmVuIGFyZQ0KPiBw
b2ludGVkIHRvIGl0IGFzIGFuIGFsdGVybmF0ZS4gQW5kIHRoZSBib3Jyb3dpbmcgcmVwb3NpdG9y
eSBkb2VzIG5vdA0KPiBldmVuIG5lZWQgdG8gaGF2ZSB3cml0ZSBwZXJtaXNzaW9uIHRvIHRoZSBw
YXJlbnQsIHNvIGl0IGNhbm5vdCB3cml0ZSBhDQo+IGJhY2twb2ludGVyLg0KPiANCj4gSWYgcGVv
cGxlIGFyZSB1c2luZyBhbHRlcm5hdGVzLCB0aGV5IHNob3VsZCBwcm9iYWJseSB0dXJuIG9mZiBn
Yy5hdXRvIGluDQo+IHRoZSBib3Jyb3dlZSAoaXQgZG9lc24ndCBzZWVtIHVucmVhc29uYWJsZSB0
byBtZSB0byBkbyBzbyBhdXRvbWF0aWNhbGx5DQo+IHZpYSAiY2xvbmUgLXMiIGluIGNhc2VzIHdo
ZXJlIHdlIGNhbiB3cml0ZSB0byB0aGUgYWx0ZXJuYXRlcyByZXBvLCBhbmQNCj4gdG8gaXNzdWUg
YSB3YXJuaW5nIG90aGVyd2lzZSkuDQo+IA0KPiAtUGVmZg0KDQpZZXMsIGlmIHRoaXMgaXMgYSBr
bm93biBwcm9ibGVtIGFuZCB3ZSBjYW4gYXZvaWQgaXQgYnkgZGlzYWJsaW5nIGdhcmJhZ2UgY29s
bGVjdGlvbiwgdGhhdCBtYWtlcyBzZW5zZSB0byBtZSB0byBkbyBzby4uDQoNClRoYW5rcywNCkph
a2UNCg==
