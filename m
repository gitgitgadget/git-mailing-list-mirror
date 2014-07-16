From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH v9 4/4] tag: support configuring --sort via .gitconfig
Date: Wed, 16 Jul 2014 21:42:13 +0000
Message-ID: <1405546933.15392.18.camel@jekeller-desk1.amr.corp.intel.com>
References: <1405467179-16064-1-git-send-email-jacob.e.keller@intel.com>
	 <1405467179-16064-4-git-send-email-jacob.e.keller@intel.com>
	 <20140715234240.GB5572@peff.net>
	 <1405467974.2577.21.camel@jekeller-desk1.amr.corp.intel.com>
	 <xmqqiomxrxq2.fsf@gitster.dls.corp.google.com>
	 <1405545219.15392.17.camel@jekeller-desk1.amr.corp.intel.com>
	 <xmqq1ttlrnh5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"peff@peff.net" <peff@peff.net>
To: "gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 23:42:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7Wxw-0005pT-0Z
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 23:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbaGPVmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 17:42:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:36330 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751943AbaGPVmP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 17:42:15 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP; 16 Jul 2014 14:35:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,673,1400050800"; 
   d="scan'208";a="562876682"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jul 2014 14:42:14 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.59]) by
 ORSMSX109.amr.corp.intel.com ([169.254.2.21]) with mapi id 14.03.0123.003;
 Wed, 16 Jul 2014 14:42:13 -0700
Thread-Topic: [PATCH v9 4/4] tag: support configuring --sort via .gitconfig
Thread-Index: AQHPoT6ekg748ikfdUyLGGIZHkvA75ujsHeA
In-Reply-To: <xmqq1ttlrnh5.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <842A59152FB21642B853203A61D04CA9@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253694>

T24gV2VkLCAyMDE0LTA3LTE2IGF0IDE0OjQwIC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gIktlbGxlciwgSmFjb2IgRSIgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4gd3JpdGVzOg0K
PiANCj4gPj4gQWZ0ZXIgYWxsLCBpdCBzZWVtcyB0byBtZSB0aGF0IHRoZSBvbmUgaW4NCj4gPj4g
DQo+ID4+ICAgICBodHRwOi8vdGhyZWFkLmdtYW5lLm9yZy9nbWFuZS5jb21wLnZlcnNpb24tY29u
dHJvbC5naXQvMjUzMzQ2DQo+ID4+IA0KPiA+PiBzdHJ1Y2sgdGhlIHJpZ2h0IGJhbGFuY2UgYW1v
bmcgdmFyaW91cyBhYnVzZXM7IGxldCdzIHVzZSB0aGUgZXJyb3INCj4gPj4gcmVwb3J0ZXIgZnJv
bSB0aGF0IHZlcnNpb24sIGluc3RlYWQgb2YgZ29pbmcgZG93biB0aGlzIHJhYmJpdCBob2xlLg0K
PiA+PiANCj4gPj4gVGhhbmtzLg0KPiA+DQo+ID4gU28gaXMgdGhhdCBwYXRjaCBzZXJpZXMgdmVy
c2lvbiBhY2NlcHRhYmxlIHRoZW4/IE9yIHNob3VsZCBJIHNwaW4gb25lDQo+ID4gYWdhaW4gdGhh
dCBpcyBpbiB0aGF0IHZlaW4/DQo+IA0KPiBJIGRvIG5vdCBvZmZoYW5kIGtub3cgd2hhdCBvdGhl
ciBjaGFuZ2VzIHlvdSBoYWQgaW4gdjkgc2luY2UNCj4gJGdtYW5lLzI1MzM0Niwgc28gSSdsbCBs
ZWF2ZSBpdCB1cCB0byB5b3UuICBJZiB0aGUgb25seSBkaWZmZXJlbmNlDQo+IGlzIHRoZSBlcnJv
ciByZXBvcnRpbmcgY29kZXBhdGgsIGFuZCB5b3UgYXJlIGhhcHB5IHdpdGggd2hhdCBJIGhhdmUN
Cj4gaW4gbXkgdHJlZQ0KPiANCj4gICAgICQgZ2l0IGxvZyAtcCAtLXJldmVyc2UgLTMgYTkzZDg4
NmI5DQo+IA0KPiB0aGVuIHdlIGNhbiBwcm9jZWVkIHdpdGggdGhhdCB2ZXJzaW9uLiAgSGF2ZSB0
aGVyZSBiZWVuIGFueSBpc3N1ZXMNCj4gcmFpc2VkIG9uIHRoYXQgb2xkZXIgdmVyc2lvbiBvdGhl
ciB0aGFuIGVycm9yIHJlcG9ydGluZz8NCj4gDQo+IA0KPiANCj4gDQoNCkknbGwgZG91YmxlIGNo
ZWNrLg0KDQpUaGFua3MsDQpKYWtlDQo=
