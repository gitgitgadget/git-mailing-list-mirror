From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH v8 1/4] usage: make error functions a stack
Date: Wed, 16 Jul 2014 19:50:01 +0000
Message-ID: <1405540201.15392.3.camel@jekeller-desk1.amr.corp.intel.com>
References: <1405459754-4220-1-git-send-email-jacob.e.keller@intel.com>
	 <1405459754-4220-2-git-send-email-jacob.e.keller@intel.com>
	 <xmqq7g3etf1o.fsf@gitster.dls.corp.google.com>
	 <1405466783.2577.15.camel@jekeller-desk1.amr.corp.intel.com>
	 <CAPc5daUhmeucDOakXpR_ViS0cfFDEyXUD_xoeP6qeCg33dW+1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 21:50:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7VDe-0002Jq-Uh
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 21:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbaGPTuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 15:50:24 -0400
Received: from mga03.intel.com ([143.182.124.21]:18640 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750732AbaGPTuW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 15:50:22 -0400
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 16 Jul 2014 12:50:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,673,1400050800"; 
   d="scan'208";a="457820178"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by azsmga001.ch.intel.com with ESMTP; 16 Jul 2014 12:50:02 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.123.3; Wed, 16 Jul 2014 12:50:01 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.59]) by
 ORSMSX111.amr.corp.intel.com ([169.254.11.231]) with mapi id 14.03.0123.003;
 Wed, 16 Jul 2014 12:50:01 -0700
Thread-Topic: [PATCH v8 1/4] usage: make error functions a stack
Thread-Index: AQHPoH7MecXJzaW2eE+GxUkwp9ZNCpuiPLyAgAAXOQCAAT6ogA==
In-Reply-To: <CAPc5daUhmeucDOakXpR_ViS0cfFDEyXUD_xoeP6qeCg33dW+1A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <804C9212BE4FB041A129AFB4A1681DA6@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253687>

VGhlcmUgd2FzIG5vIHdheSB0byBnZXQgdGhlIGN1cnJlbnQgZXJyb3Igcm91dGluZSBub3csIGFu
ZCBJIGZpZ3VyZWQNCnRoYXQgYSBzdGFjayB3YXMgYSBzaW1wbGUgd2F5IG9mIHNhdmluZyB0aGUg
b2xkIHJvdXRpbmUuDQoNCkVzc2VudGlhbGx5IHRoZXNlIHR3byBwYXRocyB3b3VsZCBiZSB0aGUg
c2FtZSBhcyBhICJzYXZlL3Jlc3RvcmUiIGV4Y2VwdA0Kd2UgbWFuYWdlIGl0IHZpYSBhIHN0YWNr
LiBJIGRvbid0IHJlYWxseSBzZWUgaG93IHRoYXQgd291bGQgZW5kIHVwIGFueQ0KZGlmZmVyZW50
LiBJIG1lYW4gSSBkb24ndCBtaW5kIGVpdGhlciBhcHByb2FjaC4NCg0KVGhhbmtzLA0KSmFrZQ0K
DQpPbiBUdWUsIDIwMTQtMDctMTUgYXQgMTc6NDkgLTA3MDAsIEp1bmlvIEMgSGFtYW5vIHdyb3Rl
Og0KPiBJIGFjdHVhbGx5IGFtIG5vdCBhIGJpZyBmYW4gb2YgInN0YWNrIiBmb3IgYSB0aGluZyBs
aWtlIHRoaXMsIHRvIGJlIGhvbmVzdC4NCj4gV291bGRuJ3QgaXQgYmUgc3VmZmljaWVudCBmb3Ig
dGhlIGNhbGxlcnMgd2hvIHdhbnQgc3BlY2lmaWMgYmVoYXZpb3VyIGZyb20NCj4gaXRzIGNhbGxl
ZXMgdG8NCj4gDQo+ICAtIHNhdmUgYXdheSB0aGUgY3VycmVudCBlcnJvci93YXJuaW5nIHJvdXRp
bmVzOw0KPiAgLSBzZXQgZXJyb3Ivd2FybmluZyByb3V0aW5lcyB0byBpdHMgb3duIGN1c3RvbSB2
ZXJzaW9uczsNCj4gIC0gY2FsbCB0aGUgY2FsbGVlczsNCj4gIC0gc2V0IGVycm9yL3dhcm5pbmcg
cm91dGluZXMgYmFjayB0byB0aGVpciBvcmlnaW5hbDsgYW5kDQo+ICAtIHJldHVybiBmcm9tIGl0
DQo+IA0KPiBhdCBsZWFzdCBpbiB0aGUgY29kZSBwYXRocyB1bmRlciBkaXNjdXNzaW9uPw0KPiAN
Cj4gDQo+IE9uIFR1ZSwgSnVsIDE1LCAyMDE0IGF0IDQ6MjYgUE0sIEtlbGxlciwgSmFjb2IgRQ0K
PiA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPiB3cm90ZToNCj4gPiBPbiBUdWUsIDIwMTQtMDct
MTUgYXQgMTU6NDcgLTA3MDAsIEp1bmlvIEMgSGFtYW5vIHdyb3RlOg0KPiA+PiBKYWNvYiBLZWxs
ZXIgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4gd3JpdGVzOg0KPiA+Pg0KPiA+PiA+ICBleHRl
cm4gdm9pZCBzZXRfZXJyb3Jfcm91dGluZSh2b2lkICgqcm91dGluZSkoY29uc3QgY2hhciAqZXJy
LCB2YV9saXN0IHBhcmFtcykpOw0KPiA+PiA+ICtleHRlcm4gdm9pZCBwb3BfZXJyb3Jfcm91dGlu
ZSh2b2lkKTsNCj4gPj4NCj4gPj4gcG9wIHRoYXQgdW5kb2VzIHNldCBzbWVsbHMgc29tZXdoYXQg
d2VpcmQuICBQZXJoYXBzIHdlIHNob3VsZCByZW5hbWUNCj4gPj4gc2V0IHRvIHB1c2g/ICBUaGF0
IHdvdWxkIGFsbG93IHVzIGNhdGNoIHBvc3NpYmxlIHRvcGljcyB0aGF0IGFkZCBuZXcNCj4gPj4g
Y2FsbHMgdG8gc2V0X2Vycm9yX3JvdXRpbmUoKSBhcyB3ZWxsIGJ5IGZvcmNpbmcgdGhlIHN5c3Rl
bSBub3QgdG8NCj4gPj4gbGluayB3aGVuIHRoZXkgYXJlIG1lcmdlZCB3aXRob3V0IG5lY2Vzc2Fy
eSBmaXhlcy4NCj4gPj4NCj4gPg0KPiA+IEFsc28gY3VyaW91cyB3aGF0IHlvdXIgdGhvdWdodHMg
b24gbWFraW5nIGV2ZXJ5IHNldF8qX3JvdXRpbmUgdG8gYmUgYQ0KPiA+IHN0YWNrPyBGb3Igbm93
IEkgd2FzIG9ubHkgcGxhbm5pbmcgb24gZXJyb3IgYnV0IGl0IG1heWJlIG1ha2VzIHNlbnNlIHRv
DQo+ID4gY2hhbmdlIHRoZW0gYWxsPw0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IEpha2UNCj4gPg0K
DQoNCg==
