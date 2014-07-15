From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH v9 4/4] tag: support configuring --sort via .gitconfig
Date: Tue, 15 Jul 2014 23:46:14 +0000
Message-ID: <1405467974.2577.21.camel@jekeller-desk1.amr.corp.intel.com>
References: <1405467179-16064-1-git-send-email-jacob.e.keller@intel.com>
	 <1405467179-16064-4-git-send-email-jacob.e.keller@intel.com>
	 <20140715234240.GB5572@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "peff@peff.net" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 16 01:46:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7CQt-0007X1-Ma
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbaGOXqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:46:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:7701 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753304AbaGOXqR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:46:17 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 15 Jul 2014 16:46:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,668,1400050800"; 
   d="scan'208";a="562345735"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jul 2014 16:46:15 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.123.3; Tue, 15 Jul 2014 16:46:15 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.59]) by
 ORSMSX116.amr.corp.intel.com ([10.22.240.14]) with mapi id 14.03.0123.003;
 Tue, 15 Jul 2014 16:46:14 -0700
Thread-Topic: [PATCH v9 4/4] tag: support configuring --sort via .gitconfig
Thread-Index: AQHPoIUokg748ikfdUyLGGIZHkvA75uiQTwAgAAA/wA=
In-Reply-To: <20140715234240.GB5572@peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <3E4066FD5C537845A862F4A9BC52C177@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253650>

T24gVHVlLCAyMDE0LTA3LTE1IGF0IDE5OjQyIC0wNDAwLCBKZWZmIEtpbmcgd3JvdGU6DQo+IE9u
IFR1ZSwgSnVsIDE1LCAyMDE0IGF0IDA0OjMyOjU5UE0gLTA3MDAsIEphY29iIEtlbGxlciB3cm90
ZToNCj4gDQo+ID4gK3N0YXRpYyB2b2lkIGVycm9yX2JhZF9zb3J0X2NvbmZpZyhjb25zdCBjaGFy
ICplcnIsIHZhX2xpc3QgcGFyYW1zKQ0KPiA+ICt7DQo+ID4gKwl2cmVwb3J0Zigid2FybmluZzog
dGFnLnNvcnQgaGFzICIsIGVyciwgcGFyYW1zKTsNCj4gPiArfQ0KPiANCj4gVGhpcyBmZWVscyBh
IGxpdHRsZSBsaWtlIGFuIGFidXNlIG9mIHRoZSAicHJlZml4IiBmaWVsZCBvZiB2cmVwb3J0Ziwg
YnV0DQo+IGFzIHlvdSBwcm9iYWJseSBzYXcgaW4gbXkgImZvciBmdW4iIHBhdGNoLCBkb2luZyBp
dCByaWdodCBtZWFucw0KPiBmb3JtYXR0aW5nIGludG8gYSBidWZmZXIgYW5kIHRoZW4gcmVmb3Jt
YXR0aW5nIHRoYXQgKHdoaWNoIHdlJ3JlDQo+IGFscmVhZHkgZG9pbmcgYWdhaW4gaW4gdnJlcG9y
dGYsIGJ1dCBsZXNzIGZsZXhpYmx5KS4gSSBkdW5uby4NCj4gDQo+IEF0IGFueSByYXRlLCB0aGlz
IHNob3VsZCBiZSBtYXJrZWQgZm9yIHRyYW5zbGF0aW9uLCBubz8NCj4gDQo+IC1QZWZmDQoNCk9o
LCB5ZXMgaXQgcHJvYmFibHkgc2hvdWxkLiBJdCdzIGRlZmluaXRlbHkgYSBsaXR0bGUgYml0IGFi
dXNpdmUgb2YgdGhlDQpwcmVmaXggZmllbGQsIGJ1dCB0aGF0IHNlZW1lZCBlYXNpZXIuDQoNClRo
YW5rcywNCkpha2UNCg==
