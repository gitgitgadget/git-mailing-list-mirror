From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH 1/3] tag: use skip_prefix instead of magic numbers
Date: Fri, 11 Jul 2014 18:04:43 +0000
Message-ID: <1405101883.22963.29.camel@jekeller-desk1.amr.corp.intel.com>
References: <1405099447-27555-1-git-send-email-jacob.e.keller@intel.com>
	 <20140711175056.GE7856@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "peff@peff.net" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 11 20:05:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5fBt-0003DS-AY
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 20:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998AbaGKSE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 14:04:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:37014 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424AbaGKSE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 14:04:57 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 11 Jul 2014 10:59:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,644,1400050800"; 
   d="scan'208";a="571847568"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga002.jf.intel.com with ESMTP; 11 Jul 2014 11:04:44 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.123.3; Fri, 11 Jul 2014 11:04:43 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.193]) by
 ORSMSX151.amr.corp.intel.com ([169.254.7.239]) with mapi id 14.03.0123.003;
 Fri, 11 Jul 2014 11:04:43 -0700
Thread-Topic: [PATCH 1/3] tag: use skip_prefix instead of magic numbers
Thread-Index: AQHPnSzwnkPxv54FukeFXROQJDGht5ubnFMAgAAD2oA=
In-Reply-To: <20140711175056.GE7856@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <B04FB1A82932864AB10DDFB4689B5B7F@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253306>

T24gRnJpLCAyMDE0LTA3LTExIGF0IDEzOjUwIC0wNDAwLCBKZWZmIEtpbmcgd3JvdGU6DQo+IE9u
IEZyaSwgSnVsIDExLCAyMDE0IGF0IDEwOjI0OjA1QU0gLTA3MDAsIEphY29iIEtlbGxlciB3cm90
ZToNCj4gDQo+ID4gTWFrZSB0aGUgcGFyc2luZyBvZiB0aGUgLS1zb3J0IHBhcmFtZXRlciBtb3Jl
IHJlYWRhYmxlIGJ5IGhhdmluZw0KPiA+IHNraXBfcHJlZml4IGtlZXAgb3VyIHBvaW50ZXIgdXAg
dG8gZGF0ZS4NCj4gPiANCj4gPiBBdXRob3JlZC1ieTogSmVmZiBLaW5nIDxwZWZmQHBlZmYubmV0
Pg0KPiANCj4gSSBzdXNwZWN0IEp1bmlvIG1heSBqdXN0IGFwcGx5IHRoaXMgb24gdGhlIHZlcnNp
b24gb2YgdGhlIGNvbW1pdCBoZSBoYXMNCj4gdXBzdHJlYW0sIHNvIHlvdSBtYXkgbm90IG5lZWQg
dGhpcyBhcyBwYXJ0IG9mIHlvdXIgc2VyaWVzLg0KPiANCj4gSG93ZXZlciwgZm9yIHJlZmVyZW5j
ZSwgdGhlIHJpZ2h0IHdheSB0byBoYW5kbGUgYXV0aG9yc2hpcCBpcyB3aXRoIGENCj4gDQo+ICAg
RnJvbTogSmVmZiBLaW5nIDxwZWZmQHBlZmYubmV0Pg0KPiANCj4gYXQgdGhlIHRvcCBvZiB5b3Vy
IG1lc3NhZ2UgYm9keS4gR2l0LWFtIHdpbGwgcGljayB0aGF0IHVwIGFuZCB0dXJuIGl0DQo+IGlu
dG8gdGhlIGF1dGhvciBmaWVsZCBvZiB0aGUgY29tbWl0Lg0KPiANCg0KQWxyaWdodCwgdGhhbmtz
Lg0KDQpSZWdhcmRzLA0KSmFrZQ0KDQo+IC1QZWZmDQo+IC0tDQo+IFRvIHVuc3Vic2NyaWJlIGZy
b20gdGhpcyBsaXN0OiBzZW5kIHRoZSBsaW5lICJ1bnN1YnNjcmliZSBnaXQiIGluDQo+IHRoZSBi
b2R5IG9mIGEgbWVzc2FnZSB0byBtYWpvcmRvbW9Admdlci5rZXJuZWwub3JnDQo+IE1vcmUgbWFq
b3Jkb21vIGluZm8gYXQgIGh0dHA6Ly92Z2VyLmtlcm5lbC5vcmcvbWFqb3Jkb21vLWluZm8uaHRt
bA0KDQoNCg==
