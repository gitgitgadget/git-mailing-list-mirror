From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH 3/3 v5] tag: support configuring --sort via .gitconfig
Date: Fri, 11 Jul 2014 20:36:13 +0000
Message-ID: <1405110973.22963.43.camel@jekeller-desk1.amr.corp.intel.com>
References: <1405099447-27555-1-git-send-email-jacob.e.keller@intel.com>
	 <1405099447-27555-3-git-send-email-jacob.e.keller@intel.com>
	 <20140711174628.GC7856@sigill.intra.peff.net>
	 <1405102267.22963.35.camel@jekeller-desk1.amr.corp.intel.com>
	 <20140711182214.GF7856@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "peff@peff.net" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 11 22:36:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5hYw-0003J5-99
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 22:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063AbaGKUgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 16:36:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:11744 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752913AbaGKUgx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 16:36:53 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP; 11 Jul 2014 13:36:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,645,1400050800"; 
   d="scan'208";a="568656424"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jul 2014 13:36:14 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.193]) by
 ORSMSX105.amr.corp.intel.com ([169.254.4.21]) with mapi id 14.03.0123.003;
 Fri, 11 Jul 2014 13:36:14 -0700
Thread-Topic: [PATCH 3/3 v5] tag: support configuring --sort via .gitconfig
Thread-Index: AQHPnSzwtKQEouEPQUqhaN0T4H7NY5ubmxQAgAAG44CAAAMbAIAAJW+A
In-Reply-To: <20140711182214.GF7856@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <CFCD7DB5D3B35B4CA57FCAF46988F233@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253320>

T24gRnJpLCAyMDE0LTA3LTExIGF0IDE0OjIyIC0wNDAwLCBKZWZmIEtpbmcgd3JvdGU6DQo+IE9u
IEZyaSwgSnVsIDExLCAyMDE0IGF0IDA2OjExOjA4UE0gKzAwMDAsIEtlbGxlciwgSmFjb2IgRSB3
cm90ZToNCj4gDQo+ID4gSSBwZXJzb25hbGx5IHByZWZlciBlcnJvciBvdXQgb24gb3B0aW9ucywg
ZXZlbiB0aG91Z2ggaXQgY2FuIG1ha2UgaXQgYQ0KPiA+IGJpdCBtb3JlIGRpZmZpY3VsdCwgdGhv
dWdoIGFzIGZhciBhcyBJIGtub3cgdW5rbm93biBmaWVsZHMgc2ltcGx5IHdhcm4NCj4gPiBvciBh
cmUgaWdub3JlZC4gKGllOiBvbGQgdmVyc2lvbnMgb2YgZ2l0IGp1c3QgaWdub3JlIHVua25vd24g
ZmllbGRzIGluDQo+ID4gY29uZmlndXJhdGlvbikuDQo+IA0KPiBSaWdodCwgd2UgX2hhdmVfIHRv
IGlnbm9yZSB1bmtub3duIGNvbmZpZyBvcHRpb25zLCBiZWNhdXNlIHdlDQo+IHNwZWNpZmljYWxs
eSBhbGxvdyBvdGhlciBwcm9ncmFtcyBidWlsdCBvbiBnaXQgdG8gc3RvcmUgdGhlaXIgY29uZmln
DQo+IHdpdGggdXMgKGFuZCBhbnl3YXksIG91ciBjYWxsYmFjayBzdHlsZSBvZiBwYXJzaW5nIG1l
YW5zIHRoYXQgbm8gc2luZ2xlDQo+IGNhbGxiYWNrIGtub3dzIGFib3V0IGFsbCBvZiB0aGUga2V5
cykuDQo+IA0KPiBJbiB0aGUgcGFzdCB3ZSBoYXZlIHN0YWtlZCBvdXQgcGFydGljdWxhciBhcmVh
cyBvZiB0aGUgbmFtZXNwYWNlLA0KPiB0aG91Z2guIEUuZy4sIHRoZSBkaWZmIGNvZGUgc2FpZCAi
SSBvd24gYWxsIG9mIGNvbG9yLmRpZmYuKiwgYW5kIGlmIHlvdQ0KPiBwdXQgaW4gc29tZXRoaW5n
IEkgZG9uJ3QgdW5kZXJzdGFuZCwgSSdsbCBjb21wbGFpbiIuIFRoYXQgZW5kZWQgdXAgYmVpbmcN
Cj4gYW5ub3lpbmcsIGFuZCBub3cgd2UgaWdub3JlIHNsb3RzIHdlIGRvbid0IHVuZGVyc3RhbmQg
dGhlcmUuDQo+IA0KPiBTbyBvbGQgZ2l0cyB3aWxsIGFsd2F5cyBzaWxlbnRseSBpZ25vcmUgdGFn
LnNvcnQgaWYgdGhleSBkb24ndCBrbm93DQo+IGFib3V0IGl0LCBhbmQgd2UgY2FuJ3QgY2hhbmdl
IHRoYXQuIFRoZSBvbmx5IHRoaW5nIHdlIGNhbiBjaGFuZ2UgaXM6DQo+IA0KPiA+IEl0J3MgcG9z
c2libGUgd2Ugc2hvdWxkIHdhcm4gaW5zdGVhZCB0aG91Z2gsIHNvIHRoYXQgb2xkZXIgZ2l0cyB3
b3JrDQo+ID4gd2l0aCBuZXcgc29ydHMgdGhhdCB0aGV5IGRvbid0IHVuZGVyc3RhbmQuDQo+IA0K
PiBSaWdodC4gSSB0aGluayBvdGhlciBjb25maWcgdmFyaWFibGVzIGluIHNpbWlsYXIgc2l0dWF0
aW9ucyB3aWxsIGJhcmYuDQo+IFRoaXMgaXMgYmFja3dhcmRzLWNvbXBhdGlibGUgYXMgbG9uZyBh
cyB0aGUgbmV3IHZhcmlhYmxlcyBhcmUgYSBzdXBlcnNldA0KPiAoaS5lLiwgd2Ugb25seSBhZGQg
bmV3IHVuZGVyc3Rvb2QgdmFsdWVzLCBuZXZlciByZW1vdmUgb3IgY2hhbmdlIHRoZQ0KPiBtZWFu
aW5nIG9mIGV4aXN0aW5nIHZhbHVlcykuIEl0J3MganVzdCBub3QgZm9yd2FyZHMtY29tcGF0aWJs
ZS4NCj4gDQoNClNvIHNob3VsZCBJIHJlc3BpbiB0aGlzIHNvIHRoYXQgY29uZmlnIG9wdGlvbiBk
b2Vzbid0IGVycm9yIG91dD8NCg0KPiA+IEkgYW0gb2sgd2l0aCB3YXJuaW5nIGJ1dCBJIGRvbid0
IGtub3cgdGhlIGJlc3QgcHJhY3RpY2UgZm9yIGhvdyB0byB3YXJuDQo+ID4gaGVyZSBpbnN0ZWFk
IG9mIGZhaWxpbmcuIFJldHVybmluZyBlcnJvciBjYXVzZXMgYSBmYXRhbCAiYmFkIGNvbmZpZyIN
Cj4gPiBtZXNzYWdlLiBBbnkgdGhvdWdodHM/DQo+IA0KPiBUaGUgc2ltcGxlc3QgdGhpbmcgaXMg
aWdub3JpbmcgdGhlIHJldHVybiBmcm9tIHBhcnNlX3NvcnRfc3RyaW5nIGFuZA0KPiBqdXN0IGNh
bGxpbmcgInJldHVybiAwIi4gVGhhdCB3aWxsIHN0aWxsIHNheSAiZXJyb3I6IiwgYnV0IGNvbnRp
bnVlIG9uLg0KPiBJZiB5b3UgcmVhbGx5IHdhbnQgaXQgdG8gc2F5ICJ3YXJuaW5nOiIsIEkgdGhp
bmsgeW91J2xsIGhhdmUgdG8gcGFzcyBhDQo+IGZsYWcgaW50byBwYXJzZV9zb3J0X3N0cmluZy4g
SSdtIG5vdCBzdXJlIGlmIGl0J3Mgd29ydGggdGhlIGVmZm9ydC4NCj4gDQo+IC1QZWZmDQoNCk9r
IHRoaXMgbWFrZXMgc2Vuc2UsIEkgYW0gZmluZSBsZWF2aW5nIGl0IGFzIGVycm9yLiBTaG91bGQg
SSByZXNwaW4gdG8NCm1ha2UgaXQgbm90IGRpZSB0aG91Z2g/DQoNClRoYW5rcywNCkpha2UNCg==
