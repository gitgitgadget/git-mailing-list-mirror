From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH 2/2] refs: loosen restriction on wildcard "*" refspecs
Date: Fri, 24 Jul 2015 00:45:06 +0000
Message-ID: <1437698706.22096.5.camel@intel.com>
References: <1437599133-13012-1-git-send-email-jacob.e.keller@intel.com>
	 <1437599133-13012-3-git-send-email-jacob.e.keller@intel.com>
	 <CAPig+cRS0NcNcw-0wG4mThN_PW0RoN3b09Yu2GzCr=UFPLYd6A@mail.gmail.com>
	 <xmqqvbdao762.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"barkalow@iabervon.iabervon.org" <barkalow@iabervon.iabervon.org>,
	"jacob.keller@gmail.com" <jacob.keller@gmail.com>
To: "gitster@pobox.com" <gitster@pobox.com>,
	"sunshine@sunshineco.com" <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 02:45:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIR6w-0006Ut-49
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 02:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851AbbGXApK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 20:45:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:3219 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752196AbbGXApI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 20:45:08 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP; 23 Jul 2015 17:45:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,534,1432623600"; 
   d="scan'208";a="770193730"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga002.jf.intel.com with ESMTP; 23 Jul 2015 17:45:07 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.224.2; Thu, 23 Jul 2015 17:45:07 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.230]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.146]) with mapi id 14.03.0224.002;
 Thu, 23 Jul 2015 17:45:07 -0700
Thread-Topic: [PATCH 2/2] refs: loosen restriction on wildcard "*" refspecs
Thread-Index: AQHQxZSbevvTPZoDV0uB8VF4Y7ntjJ3qPicA
In-Reply-To: <xmqqvbdao762.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.3.85]
Content-ID: <8179605DD5E56345BCB2FE42E5187F5C@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274533>

T24gVGh1LCAyMDE1LTA3LTIzIGF0IDE1OjEyIC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gRXJpYyBTdW5zaGluZSA8c3Vuc2hpbmVAc3Vuc2hpbmVjby5jb20+IHdyaXRlczoNCj4gDQo+
ID4gT24gV2VkLCBKdWwgMjIsIDIwMTUgYXQgNTowNSBQTSwgSmFjb2IgS2VsbGVyIDwNCj4gPiBq
YWNvYi5lLmtlbGxlckBpbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4gRnJvbTogSmFjb2IgS2VsbGVy
IDxqYWNvYi5rZWxsZXJAZ21haWwuY29tPg0KPiA+ID4gDQo+ID4gPiBNb2RpZnkgbG9naWMgb2Yg
Y2hlY2tfcmVmbmFtZV9jb21wb25lbnQgYW5kIGFkZCBhIG5ldyBkaXNwb3NpdGlvbg0KPiA+ID4g
cmVnYXJkaW5nICIqIi4gQWxsb3cgcmVmc3BlY3MgdGhhdCBjb250YWluIGEgc2luZ2xlICIqIiBp
Zg0KPiA+ID4gUkVGTkFNRV9SRUZTUEVDX1BBVFRFUk4gaXMgc2V0LiBDaGFuZ2UgdGhlIGZ1bmN0
aW9uIHRvIHBhc3MgdGhlIA0KPiA+ID4gZmxhZ3MgYXMNCj4gPiA+IGEgcG9pbnRlciwgYW5kIGNs
ZWFyIFJFRk5BTUVfUkVGU1BFQ19QQVRURVJOIGFmdGVyIHRoZSBmaXJzdCAiKiIgDQo+ID4gPiBz
byB0aGF0DQo+ID4gPiBvbmx5IGEgc2luZ2xlICIqIiBpcyBhY2NlcHRlZC4NCj4gPiA+IA0KPiA+
ID4gVGhpcyBsb29zZW5zIHJlc3RyaWN0aW9ucyBvbiByZWZzcGVjcyBieSBhbGxvd2luZyBwYXR0
ZXJucyB0aGF0IA0KPiA+ID4gaGF2ZQ0KPiA+ID4gYSAiKiIgd2l0aGluIGEgY29tcG9uZW50IGlu
c3RlYWQgb2Ygb25seSBhcyB0aGUgd2hvbGUgY29tcG9uZW50LiANCj4gPiA+IEFsc28NCj4gPiA+
IHJlbW92ZSB0aGUgY29kZSB0aGF0IGhhbmdsZWQgcmVmc3BlYyBwYXR0ZXJucyBpbiANCj4gPiA+
IGNoZWNrX3JlZm5hbWVfZm9ybWF0DQo+ID4gDQo+ID4gcy9oYW5nbGVkL2hhbmRsZWQvDQo+ID4g
Li4uDQo+IA0KPiBUaGFua3M7IGhlcmUgaXMgd2hhdCBJIHF1ZXVlZCB5ZXN0ZXJkYXkuDQo+IA0K
DQpXb2FoLiBJIGJvdyB0byB5b3VyIGltcGVyYXRpdmUgY29tbWl0IG1lc3NhZ2UgYWJpbGl0aWVz
LiBUaGUgbmV3IGNvbW1pdA0KbWVzc2FnZSBpcyB2ZXJ5IG5pY2VseSB3b3JkZWQuIFRoYW5rcyBm
b3IgdGFraW5nIHRoZSB0aW1lIHRvIHJld29yZCBteQ0KanVtYmxlIGNvcnJlY3RseS4NCg0KRXZl
cnl0aGluZyBsb29rZWQgZ3JlYXQgdG8gbWUuDQoNClJlZ2FyZHMsDQpKYWtl
