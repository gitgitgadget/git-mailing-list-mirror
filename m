From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH] notes: document behavior of --ref and --notes DWIMery
Date: Tue, 22 Sep 2015 21:02:42 +0000
Message-ID: <1442955762.26280.49.camel@intel.com>
References: <1442953476-24537-1-git-send-email-jacob.e.keller@intel.com>
	 <xmqq8u7y2nnq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"mh@glandium.org" <mh@glandium.org>,
	"mhagger@alum.mit.edu" <mhagger@alum.mit.edu>,
	"johan@herland.net" <johan@herland.net>,
	"jacob.keller@gmail.com" <jacob.keller@gmail.com>
To: "gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 23:02:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeUiF-0005nq-9t
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 23:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759178AbbIVVCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 17:02:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:31631 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758263AbbIVVCp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 17:02:45 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP; 22 Sep 2015 14:02:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,574,1437462000"; 
   d="scan'208";a="795076185"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga001.fm.intel.com with ESMTP; 22 Sep 2015 14:02:44 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.248.2; Tue, 22 Sep 2015 14:02:43 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.164]) by
 ORSMSX151.amr.corp.intel.com ([169.254.7.168]) with mapi id 14.03.0248.002;
 Tue, 22 Sep 2015 14:02:43 -0700
Thread-Topic: [PATCH] notes: document behavior of --ref and --notes DWIMery
Thread-Index: AQHQ9XS8Z8FXH0i62UahhqGPzDSB+Z5JAvi8gAB7ggA=
In-Reply-To: <xmqq8u7y2nnq.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.3.123]
Content-ID: <2831933E3D8D4741AE6F4064D0CA4749@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278436>

T24gVHVlLCAyMDE1LTA5LTIyIGF0IDEzOjQwIC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+IHdyaXRlczoNCj4gDQo+
ID4gRnJvbTogSmFjb2IgS2VsbGVyIDxqYWNvYi5rZWxsZXJAZ21haWwuY29tPg0KPiA+IA0KPiA+
IFRoZSAtLW5vdGVzIGFuZCAtLXJlZiBwYXJhbWV0ZXIgZm9yIHNlbGVjdGluZyB3aGljaCBub3Rl
cyByZWYgdG8NCj4gPiBvcGVyYXRlDQo+ID4gb24gYXJlIGJhc2VkIG9mZiBvZiBleHBhbmRfbm90
ZXNfcmVmIGZ1bmN0aW9uYWxpdHkuIFRoZQ0KPiA+IGRvY3VtZW50YXRpb24NCj4gPiBtZW50aW9u
ZWQgdGhhdCBhbiB1bnF1YWxpZmllZCByZWYgYXJndW1lbnQgd291bGQgYmUgdGFrZW4gYXMgdW5k
ZXINCj4gPiBgcmVmcy9ub3Rlcy9gLiBIb3dldmVyLCB0aGlzIGRvZXMgbm90IGNsZWFybHkgaW5k
aWNhdGUgdGhhdA0KPiA+IGByZWZzL2hlYWRzL21hc3RlcmAgd2lsbCBleHBhbmQgdG8gYHJlZnMv
bm90ZXMvcmVmcy9oZWFkcy9tYXN0ZXJgLA0KPiA+IHNvDQo+ID4gZG9jdW1lbnQgdGhpcyBiZWhh
dmlvci4NCj4gPiANCj4gPiBBZGQgYSBmdXJ0aGVyIHRlc3QgZm9yIHRoZSBleHBlY3RlZCBiZWhh
dmlvciBvZiBnaXQgbm90ZXMgLS1yZWYNCj4gPiByZWZzL2hlYWRzL21hc3RlciBnZXQtcmVmIGFz
IHdlbGwsIHRvIGVuc3VyZSBmdXR1cmUgcGF0Y2hlcyBkbyBub3QNCj4gPiBicmVhaw0KPiA+IHRo
aXMgYXNzdW1wdGlvbi4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYWNvYiBLZWxsZXIgPGph
Y29iLmtlbGxlckBnbWFpbC5jb20+DQo+ID4gLS0tDQo+IA0KPiBMb29rcyBPSyB0byBhIGN1cnNv
cnkgcmVhZCwgYnV0IEkgZmluZCAiZXZlbiBpZiBpdCBpcyBxdWFsaWZpZWQNCj4gdW5kZXIgc29t
ZSBvdGhlciBsb2NhdGlvbiIgYSBiaXQgdGlyaW5nIHRvIHJlYWQgd2l0aG91dCBhZGRpbmcgbXVj
aA0KPiB2YWx1ZS4gIFRvIHJlYWRlcnMgd2hvIGNvbnNpZGVyICJvdGhlciIgaW4gdGhhdCBwaHJh
c2UgdG8gYmUgY2xlYXINCj4gZW5vdWdoIChpLmUuICJsb2NhdGlvbiBvdGhlciB0aGFuIHJlZnMv
bm90ZXMiKSwgaXQgaXMgdG90YWxseQ0KPiByZWR1bmRhbnQuICBUbyBvdGhlciByZWFkZXJzIHdo
byBmZWVsICJvdGhlciIgaW4gdGhhdCBwaHJhc2UgdG8gYmUNCj4gdW5kZXIgcXVhbGlmaWVkIChp
LmUuICJsb2NhdGlvbiBvdGhlciB0aGFuIHdoYXQ/Pz8iKSwgaXQgaXMgbm90DQo+IGluZm9ybWF0
aXZlIGVub3VnaC4gIE1pZGRsZS1ncm91bmQgcmVhZGVycyB3aG8gd291bGQgbm90IGtub3cgaWYN
Cj4gInJlZnMvYSIgaXMgaW5zaWRlIG9yIG91dHNpZGUgc29tZSAib3RoZXIiIGxvY2F0aW9uLCBp
dCBpcyBjb25mdXNpbmcuDQo+IA0KPiBBZnRlciBhbGwsICJhL2IiIGlzIHF1YWxpZmllZCB1bmRl
ciBzb21lIGxvY2F0aW9uIChpLmUuIGEvKSBvdGhlcg0KPiB0aGFuICJyZWZzL25vdGVzLyIsIGFu
ZCBpdCBkb2VzIG1lYW4gInJlZnMvbm90ZXMvYS9iIi4NCj4gDQo+IEhvdyBhYm91dCBwaHJhc2lu
ZyBpdCB0b3RhbGx5IGRpZmZlcmVudGx5Pw0KPiANCj4gCVRoZSByZWYgc3BlY2lmaWVzIHRoZSBm
dWxsIHJlZm5hbWUgd2hlbiBpdCBiZWdpbnMgd2l0aA0KPiAJYHJlZnMvbm90ZXMvYDsgb3RoZXJ3
aXNlIGByZWYvbm90ZXMvYCBpcyBwcmVmaXhlZCB0byBmb3JtIGENCj4gCWZ1bGwgbmFtZSBvZiB0
aGUgcmVmLg0KPiANCj4gSSB0aGluayB0aGF0IHdvdWxkIHJlbW92ZSB0aGUgbmVlZCB0byBpbGx1
c3RyYXRlIHdpdGggY29uY3JldGUNCj4gZXhhbXBsZXMgbGlrZSByZWZzL2hlYWRzL2JsYWguDQo+
IA0KDQpZZXMsIGxldCdzIGdvIHdpdGggdGhhdC4NCg0KUmVnYXJkcywNCkpha2U=
