From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2] tag: support configuring --sort via .gitconfig
Date: Thu, 10 Jul 2014 20:38:38 +0000
Message-ID: <1405024718.4925.0.camel@jekeller-desk1.amr.corp.intel.com>
References: <1404945412-10197-1-git-send-email-jacob.e.keller@intel.com>
	 <20140710040731.GD28401@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "peff@peff.net" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 10 22:39:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5L7d-0007GB-PO
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 22:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357AbaGJUjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 16:39:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:5972 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752007AbaGJUjN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 16:39:13 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 10 Jul 2014 13:39:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,639,1400050800"; 
   d="scan'208";a="571343430"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2014 13:38:39 -0700
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.123.3; Thu, 10 Jul 2014 13:38:38 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.193]) by
 ORSMSX156.amr.corp.intel.com ([169.254.8.193]) with mapi id 14.03.0123.003;
 Thu, 10 Jul 2014 13:38:39 -0700
Thread-Topic: [PATCH v2] tag: support configuring --sort via .gitconfig
Thread-Index: AQHPm8ZIHKkkgvPtB0G2Yr5/1ypgMZuZJr4AgAEU6QA=
In-Reply-To: <20140710040731.GD28401@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <DD0DEB35D1459045AEE95705D5871C13@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253210>

T24gVGh1LCAyMDE0LTA3LTEwIGF0IDAwOjA3IC0wNDAwLCBKZWZmIEtpbmcgd3JvdGU6DQo+IE9u
IFdlZCwgSnVsIDA5LCAyMDE0IGF0IDAzOjM2OjUxUE0gLTA3MDAsIEphY29iIEtlbGxlciB3cm90
ZToNCj4gDQo+ID4gK3N0YXRpYyBpbnQgcGFyc2Vfc29ydF9zdHJpbmcoY29uc3QgY2hhciAqYXJn
KQ0KPiA+ICt7DQo+ID4gKwlpbnQgc29ydCA9IDA7DQo+ID4gKwlpbnQgZmxhZ3MgPSAwOw0KPiA+
ICsNCj4gPiArCWlmICgqYXJnID09ICctJykgew0KPiA+ICsJCWZsYWdzIHw9IFJFVkVSU0VfU09S
VDsNCj4gPiArCQlhcmcrKzsNCj4gPiArCX0NCj4gPiArCWlmIChzdGFydHNfd2l0aChhcmcsICJ2
ZXJzaW9uOiIpKSB7DQo+ID4gKwkJc29ydCA9IFZFUkNNUF9TT1JUOw0KPiA+ICsJCWFyZyArPSA4
Ow0KPiA+ICsJfSBlbHNlIGlmIChzdGFydHNfd2l0aChhcmcsICJ2OiIpKSB7DQo+ID4gKwkJc29y
dCA9IFZFUkNNUF9TT1JUOw0KPiA+ICsJCWFyZyArPSAyOw0KPiA+ICsJfSBlbHNlDQo+ID4gKwkJ
c29ydCA9IFNUUkNNUF9TT1JUOw0KPiA+ICsJaWYgKHN0cmNtcChhcmcsICJyZWZuYW1lIikpDQo+
ID4gKwkJZGllKF8oInVuc3VwcG9ydGVkIHNvcnQgc3BlY2lmaWNhdGlvbiAlcyIpLCBhcmcpOw0K
PiA+ICsJc29ydCB8PSBmbGFnczsNCj4gPiArDQo+ID4gKwlyZXR1cm4gc29ydDsNCj4gPiArfQ0K
PiANCj4gSSBrbm93IHRoaXMgaXMgZXhpc3RpbmcgY29kZSB5b3UgYXJlIG1vdmluZywgYnV0IEkg
bm90aWNlZCBpdCBsb29rcyByaXBlDQo+IGZvciB1c2luZyBza2lwX3ByZWZpeC4gUGVyaGFwcyB3
aGlsZSB3ZSBhcmUgaW4gdGhlIGFyZWEgd2Ugc2hvdWxkIGRvIHRoZQ0KPiBmb2xsb3dpbmcgb24g
dG9wIG9mIHlvdXIgcGF0Y2ggKEknZCBhbHNvIGJlIGhhcHB5IGZvciBpdCBiZSBzcXVhc2hlZA0K
PiBpbiwgYnV0IHRoYXQgbWF5IGJlIHRvbyBtdWNoIGluIG9uZSBwYXRjaCkuDQo+IA0KDQpJIGFt
IGZpbmUgd2l0aCB0aGlzIGJlaW5nIGFub3RoZXIgcGF0Y2ggb3Igc3F1YXNoZWQgaW4uIEkgZGlk
bid0IGV2ZW4NCmtub3cgdGhhdCB3YXMgYXZhaWxhYmxlIDopIEkgYWxzbyBsaWtlIHB1dHRpbmcg
dGhlIHR3byBlcXVpdmFsZW50DQpjb25kaXRpb25hbHMgaW50byB0aGUgc2FtZSBpZiBibG9jay4N
Cg0KVGhhbmtzLA0KSmFrZQ0KDQo+IC0tID44IC0tDQo+IFN1YmplY3Q6IFtQQVRDSF0gdGFnOiB1
c2Ugc2tpcF9wcmVmaXggaW5zdGVhZCBvZiBtYWdpYyBudW1iZXJzDQo+IA0KPiBXZSBjYW4gbWFr
ZSB0aGUgcGFyc2luZyBvZiB0aGUgLS1zb3J0IHBhcmFtZXRlciBhIGJpdCBtb3JlDQo+IHJlYWRh
YmxlIGJ5IGhhdmluZyBza2lwX3ByZWZpeCBrZWVwIG91ciBwb2ludGVyIHVwIHRvIGRhdGUuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBKZWZmIEtpbmcgPHBlZmZAcGVmZi5uZXQ+DQo+IC0tLQ0KPiAg
YnVpbHRpbi90YWcuYyB8IDE0ICsrKysrLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2J1aWx0aW4v
dGFnLmMgYi9idWlsdGluL3RhZy5jDQo+IGluZGV4IGE2NzllMzIuLjAxNmRmOTggMTAwNjQ0DQo+
IC0tLSBhL2J1aWx0aW4vdGFnLmMNCj4gKysrIGIvYnVpbHRpbi90YWcuYw0KPiBAQCAtMzUzLDE4
ICszNTMsMTQgQEAgc3RhdGljIGludCBwYXJzZV9zb3J0X3N0cmluZyhjb25zdCBjaGFyICphcmcp
DQo+ICAJaW50IHNvcnQgPSAwOw0KPiAgCWludCBmbGFncyA9IDA7DQo+ICANCj4gLQlpZiAoKmFy
ZyA9PSAnLScpIHsNCj4gKwlpZiAoc2tpcF9wcmVmaXgoYXJnLCAiLSIsICZhcmcpKQ0KPiAgCQlm
bGFncyB8PSBSRVZFUlNFX1NPUlQ7DQo+IC0JCWFyZysrOw0KPiAtCX0NCj4gLQlpZiAoc3RhcnRz
X3dpdGgoYXJnLCAidmVyc2lvbjoiKSkgew0KPiAtCQlzb3J0ID0gVkVSQ01QX1NPUlQ7DQo+IC0J
CWFyZyArPSA4Ow0KPiAtCX0gZWxzZSBpZiAoc3RhcnRzX3dpdGgoYXJnLCAidjoiKSkgew0KPiAr
DQo+ICsJaWYgKHNraXBfcHJlZml4KGFyZywgInZlcnNpb246IiwgJmFyZykgfHwgc2tpcF9wcmVm
aXgoYXJnLCAidjoiLCAmYXJnKSkNCj4gIAkJc29ydCA9IFZFUkNNUF9TT1JUOw0KPiAtCQlhcmcg
Kz0gMjsNCj4gLQl9IGVsc2UNCj4gKwllbHNlDQo+ICAJCXNvcnQgPSBTVFJDTVBfU09SVDsNCj4g
Kw0KPiAgCWlmIChzdHJjbXAoYXJnLCAicmVmbmFtZSIpKQ0KPiAgCQlkaWUoXygidW5zdXBwb3J0
ZWQgc29ydCBzcGVjaWZpY2F0aW9uICVzIiksIGFyZyk7DQo+ICAJc29ydCB8PSBmbGFnczsNCg0K
DQo=
