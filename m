From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH 8/9] autoconf: Check for timer_settime
Date: Wed, 10 Sep 2014 21:13:21 +0000
Message-ID: <1410383601.2649.5.camel@jekeller-desk1.amr.corp.intel.com>
References: <1409330561-11806-1-git-send-email-jacob.e.keller@intel.com>
	 <1409330561-11806-8-git-send-email-jacob.e.keller@intel.com>
	 <5400B7C2.20603@kdbg.org>
	 <1409334052.18778.21.camel@jekeller-desk1.amr.corp.intel.com>
	 <54106F34.90505@gmail.com> <xmqq38bzgp4j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "karsten.blees@gmail.com" <karsten.blees@gmail.com>,
	"j6t@kdbg.org" <j6t@kdbg.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"sortie@maxsi.org" <sortie@maxsi.org>
To: "gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 23:13:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRpD9-0006SI-Bg
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 23:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337AbaIJVNv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 17:13:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:9517 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241AbaIJVNu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 17:13:50 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 10 Sep 2014 14:07:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.04,501,1406617200"; 
   d="scan'208";a="601077998"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga002.jf.intel.com with ESMTP; 10 Sep 2014 14:13:23 -0700
Received: from orsmsx153.amr.corp.intel.com (10.22.226.247) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.195.1; Wed, 10 Sep 2014 14:13:23 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.235]) by
 ORSMSX153.amr.corp.intel.com ([169.254.12.171]) with mapi id 14.03.0195.001;
 Wed, 10 Sep 2014 14:13:22 -0700
Thread-Topic: [PATCH 8/9] autoconf: Check for timer_settime
Thread-Index: AQHPzTtdsFTOIp6bmE2ya5OMQ2wrbZv7UvuA
In-Reply-To: <xmqq38bzgp4j.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <1A3BEFA6423F9F4399A7FD4717BD5023@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256768>

T24gV2VkLCAyMDE0LTA5LTEwIGF0IDE0OjA4IC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gS2Fyc3RlbiBCbGVlcyA8a2Fyc3Rlbi5ibGVlc0BnbWFpbC5jb20+IHdyaXRlczoNCj4gDQo+
ID4gV2hpbGUgdGhlIHRpbWVyIGV4dGVuc2lvbiAodGltZXJfc2V0dGltZSkgaGFzIGdyYWR1YXRl
ZCB0byBtYW5kYXRvcnkgaW4NCj4gPiB0aGUgY3VycmVudCBQT1NJWCBzcGVjLCB0aGUgbW9ub3Rv
bmljIGNsb2NrIGV4dGVuc2lvbiBpcyBzdGlsbCBvcHRpb25hbA0KPiA+IHRvZGF5IChpLmUuIG5v
dCBuZWNlc3NhcmlseSBzdXBwb3J0ZWQgZXZlbiBvbiBuZXdlciBVbmljZXMpLiBJbiBjb250cmFz
dA0KPiA+IHRvIHRoaXMsIHRoZSBYU0kgZXh0ZW5zaW9ucyBzZWVtIHRvIGJlIHdpZGVseSBzdXBw
b3J0ZWQuDQo+ID4NCj4gPiBJTU8gdGhlICdvYnNvbGVzY2VudCcgbWFya2VyIGluIHRoZSBjdXJy
ZW50IFBPU0lYIHNwZWMgaXMgbm8gcmVhc29uIHRvDQo+ID4gc3ByaW5nIGludG8gYWN0aW9uIChh
dCBsZWFzdCBub3QgeWV0KS4gRS5nLiB1dGltZXMgKGFsc28gaW4gPHN5cy90aW1lLmg+KQ0KPiA+
IGhhcyBiZWVuIG1hcmtlZCBMRUdBQ1kgaW4gdGhlIDIwMDQgdmVyc2lvbiBhbmQgaXMgbm8gbG9u
Z2VyIExFR0FDWSB0b2RheS4NCj4gPiBCdHcuLCB3ZSdkIGFsc28gaGF2ZSB0byBmaW5kIGEgcmVw
bGFjZW1lbnQgZm9yIGdldHRpbWVvZmRheSBhbmQgcHJvYmFibHkNCj4gPiBhIGxvdCBvZiBvdGhl
ciBzdHVmZi4uLg0KPiA+DQo+ID4gVGhlcmVmb3JlIEkgdGVuZCB0byBhZ3JlZSB3aXRoIEhhbm5l
cyB0aGF0IHdlIHNob3VsZCBzdGljayB3aXRoIHNldGl0aW1lcg0KPiA+IGFuZCBlbXVsYXRlIGl0
IG9uIHN5c3RlbXMgdGhhdCBkb24ndCBoYXZlIGl0IChhcyB3ZSBkbyBvbiBXaW5kb3dzKS4NCj4g
DQo+IFNvdW5kcyBzZW5zaWJsZSB0byBtZS4NCg0KWWEgdGhhdCBtYWtlcyBzZW5zZS4gV2FzIHRo
aW5raW5nIHRvbyBtdWNoIGFib3V0IGNvbXBhdGFiaWxpdHkgY29kZSBmb3INCkxpbnV4IGtlcm5l
bCBkcml2ZXJzLCB3aGljaCBpcyBhIGRpZmZlcmVudCBpc3N1ZS4NCg0KTGV0J3MgZ28gd2l0aCBy
ZS1pbXBsZW1lbnRpbmcgc2V0dGltZXIgaW4gdGVybXMgb2YgdGltZXJfc2V0dGltZSBvbiB0aGUN
Cm9uZSBzeXN0ZW0gd2UgaGF2ZSBpbmZvcm1hdGlvbiB0aGF0IGRvZXNuJ3Qgc3VwcG9ydCBzZXR0
aW1lci4NCg0KSSBjb3VsZCBzcGluIHRoYXQgcGF0Y2gsIGJ1dCBJIHRoaW5rIHRoZSBvcmlnaW5h
bCBhdXRob3Igc2hvdWxkLCBzaW5jZQ0KaGUncyB0aGUgb25lIHdobyBjb3VsZCBhY3R1YWxseSB0
ZXN0IGl0Lg0KDQpSZWdhcmRzLA0KSmFrZQ0KDQo+IC0tDQo+IFRvIHVuc3Vic2NyaWJlIGZyb20g
dGhpcyBsaXN0OiBzZW5kIHRoZSBsaW5lICJ1bnN1YnNjcmliZSBnaXQiIGluDQo+IHRoZSBib2R5
IG9mIGEgbWVzc2FnZSB0byBtYWpvcmRvbW9Admdlci5rZXJuZWwub3JnDQo+IE1vcmUgbWFqb3Jk
b21vIGluZm8gYXQgIGh0dHA6Ly92Z2VyLmtlcm5lbC5vcmcvbWFqb3Jkb21vLWluZm8uaHRtbA0K
DQoNCg==
