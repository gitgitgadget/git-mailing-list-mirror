From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH] tag: support configuring --sort via .gitconfig
Date: Wed, 9 Jul 2014 22:07:20 +0000
Message-ID: <1404943640.23510.40.camel@jekeller-desk1.amr.corp.intel.com>
References: <1404940860-4004-1-git-send-email-jacob.e.keller@intel.com>
	 <20140709215816.GE25854@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"pclouds@gmail.com" <pclouds@gmail.com>,
	"gitster@pobox.com" <gitster@pobox.com>
To: "peff@peff.net" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 10 00:07:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X501O-00018I-KL
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 00:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753045AbaGIWHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 18:07:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:26470 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424AbaGIWHW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 18:07:22 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP; 09 Jul 2014 15:07:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,634,1400050800"; 
   d="scan'208";a="567584613"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jul 2014 15:07:21 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.123.3; Wed, 9 Jul 2014 15:07:20 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.193]) by
 ORSMSX151.amr.corp.intel.com ([169.254.7.239]) with mapi id 14.03.0123.003;
 Wed, 9 Jul 2014 15:07:20 -0700
Thread-Topic: [PATCH] tag: support configuring --sort via .gitconfig
Thread-Index: AQHPm7vKiokz5vIiqk+2IlPvtei8V5uYv6YAgAACiQA=
In-Reply-To: <20140709215816.GE25854@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <D613A81CEBDA2C4C9DA4A8335EEDF426@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253163>

T24gV2VkLCAyMDE0LTA3LTA5IGF0IDE3OjU4IC0wNDAwLCBKZWZmIEtpbmcgd3JvdGU6DQo+IE9u
IFdlZCwgSnVsIDA5LCAyMDE0IGF0IDAyOjIxOjAwUE0gLTA3MDAsIEphY29iIEtlbGxlciB3cm90
ZToNCj4gDQo+ID4gQWRkIHN1cHBvcnQgZm9yIGNvbmZpZ3VyaW5nIGRlZmF1bHQgc29ydCBvcmRl
cmluZyBmb3IgZ2l0IHRhZ3MuIENvbW1hbmQNCj4gPiBsaW5lIG9wdGlvbiB3aWxsIG92ZXJyaWRl
IHRoaXMgY29uZmlndXJlZCB2YWx1ZSwgdXNpbmcgdGhlIGV4YWN0IHNhbWUNCj4gPiBzeW50YXgu
DQo+IA0KPiBUaGlzIG1ha2VzIHNlbnNlLCBhbmQgd2FzIHNvbWV0aGluZyBJIHdhcyBleHBlY3Rp
bmcgdG8gYWRkIG9uY2UgdGFnIGFuZA0KPiBicmFuY2ggYm90aCBsZWFybmVkIGZvci1lYWNoLXJl
ZidzIHNvcnRpbmcgY29kZS4gSSBkb24ndCB0aGluayB0aGVyZQ0KPiB3aWxsIGJlIGFueSBjb21w
YXRpYmlsaXR5IHByb2JsZW1zIGluIGFkZGluZyBpdCBub3csIHRob3VnaDsgdGhlDQo+IHVsdGlt
YXRlIGludGVyZmFjZSB3aWxsIGJlIHRoZSBzYW1lIChpdCB3aWxsIGp1c3Qga25vdyBhYm91dCBt
b3JlIHR5cGVzDQo+IG9mIHNvcnRpbmcpLg0KPiANCg0KSSBvbmx5IG5vdGljZWQgdGhlIHNvcnQg
cmVjZW50bHksIGFuZCBJIGZpcnN0IHRyaWVkIHRvIGFkZCBhbiBhbGlhcyBsaWtlDQoidGFnID0g
dGFnIC0tc29ydD12OnJlZm5hbWUiIGJ1dCBnaXQgZGlkbid0IHBpY2sgdXAgdGhlIGFsaWFzIG9m
IHRoZQ0KbmFtZSBhbHJlYWR5LiBJIHVzZSBhIGxvdCBvZiB2ZXJzaW9uLXN0eWxlIHRhZ3Mgc28g
SSB3YW50ZWQgdGhpcyB0byBiZQ0KZGVmYXVsdC4gSSBkaWQgbm90aWNlIHRoYXQgdGhlIGZvcm1h
dCBvZiB0aGUgc29ydCBwYXJhbWV0ZXIgd2FzIGFjdHVhbGx5DQpwcmV0dHkgY29tcGxleCwgc28g
aXQgc2VlbWVkIHRoYXQgbW9yZSB3YXMgaW50ZW5kZWQgdG8gYmUgYWRkZWQgdG8gaXQuDQoNClRo
ZSBvbmx5IG1haW4gaXNzdWUgd291bGQgYmUgdGhlIGxvY2F0aW9uIG9mIHRoZSBzb3J0LWNvbmZp
Z3VyZSBjb2RlLA0KYnV0IHRoYXQgaXMgYWN0dWFsbHkgZWFzeSB0byBtb3ZlIHNvIEkgZG9uJ3Qg
dGhpbmsgaXQncyBhIGJpZyBkZWFsLiBUaGUNCmNvbmZpZ3VyYXRpb24gaW50ZXJmYWNlIHNob3Vs
ZCByZW1haW4gc2ltaWxhci4NCg0KPiA+ICt0YWcuc29ydDo6DQo+ID4gKwlUaGlzIHZhcmlhYmxl
IGlzIHVzZWQgdG8gY29udHJvbCB0aGUgc29ydCBvcmRlcmluZyBvZiB0YWdzIHdoZW4NCj4gPiAr
CWRpc3BsYXllZCB2aWEgbGlua2dpdDpnaXQtdGFnWzVdLiBUaGUgY3VycmVudCBzdXBwb3J0ZWQg
dHlwZXMgYXJlDQo+ID4gKwkicmVmbmFtZSIgZm9yIGxleGljb2dyYXBoaWMgb3JkZXIgKGRlZmF1
bHQpIG9yICJ2ZXJzaW9uOnJlZm5hbWUiIG9yDQo+ID4gKwkidjpyZWZuYW1lIiBmb3IgdGFnIG5h
bWVzIHRyZWF0ZWQgYXMgdmVyc2lvbnMuIFlvdSBtYXkgcHJlcGVuZCBhICItIiB0bw0KPiA+ICsJ
cmV2ZXJzZSB0aGUgc29ydCBvcmRlcmluZy4NCj4gDQo+IFlvdXIgbGluayB0byBnaXQtdGFnWzVd
IHNob3VsZCBiZSB0byBnaXQtdGFnWzFdLCBJIHRoaW5rLiBUaGUgZmluYWwNCj4gbnVtYmVyIGlz
IHRoZSBtYW5wYWdlIHNlY3Rpb24uDQo+IA0KDQpXaGljaCBJIHRob3VnaHQgd2FzIDUgZm9yIHRo
ZSBjb21tYW5kcz8gT3IgaXMgaXQgYWx3YXlzIFsxXT8NCg0KPiBJIHdhcyBnb2luZyB0byBjb21w
bGFpbiB0aGF0IHRoaXMgaXMgZHVwbGljYXRpbmcgdGhlIHNvcnQgZG9jdW1lbnRhdGlvbg0KPiBm
cm9tIGdpdC10YWcsIGJ1dCBJIHNlZSB5b3UgYWN0dWFsbHkgbW92ZWQgaXQgZnJvbSB0aGUgLS1z
b3J0IG9wdGlvbiB0bw0KPiBoZXJlLCBhbmQgcmVmZXIgYmFjayBmcm9tIHRoZXJlIHRvIGhlcmUu
DQo+IA0KDQpJIGFjdHVhbGx5IGRpZG4ndCByZW1vdmUgYW55dGhpbmcgZnJvbSBnaXQtdGFnLCBJ
IG9ubHkgYWRkZWQgdGhlDQpyZWZlcmVuY2UgdG8gZ2l0LWNvbmZpZy4gQnV0IEkgY2FuIGtlZXAg
ZnJvbSBkdXBsaWNhdGluZyB0aGUNCmRvY3VtZW50YXRpb24gaW4gdGhlcmUuIEkgbGlrZSB0aGUg
aWRlYSBvZiB1c2luZyBhbiBpbmNsdWRlZCBmaWxlDQp0aG91Z2guDQoNCj4gSSB0aGluayBJJ2Qg
cHJlZmVyIGl0IHRoZSBvdGhlciB3YXkgYXJvdW5kIChhbmQgZXhwbGFpbiB0aGlzIGFzICJiZWhh
dmUNCj4gYXMgaWYgLS1zb3J0PTx2YWx1ZT4gaGFkIGJlZW4gZ2l2ZW4iKS4gQXMgdGhlIHNvcnQg
b3B0aW9ucyBncm93LCBpdA0KPiBzZWVtcyBsaWtlbHkgdGhhdCB3ZSB3aWxsIGdyb3cgYSBuZXcg
c2VjdGlvbiBpbiB0aGUgZ2l0LXRhZyBtYW5wYWdlIChhbmQNCj4gZXZlbnR1YWxseSBwcm9iYWJs
eSBmZWVkIHRoYXQgY29udGVudCBmcm9tIGFuIGluY2x1ZGUgdGhhdCB3b3JrcyBmb3IgYWxsDQo+
IG9mIGZvci1lYWNoLXJlZiwgYnJhbmNoLCBhbmQgdGFnKS4NCg0KeWVzLCBJIGFncmVlIHRoaXMg
bWFrZXMgbW9yZSBzZW5zZS4NCg0KPiANCj4gPiArc3RhdGljIGNoYXIgKmNvbmZpZ3VyZWRfdGFn
X3NvcnQ7DQo+IA0KPiBXaGVuIGRlYWxpbmcgd2l0aCBhIGNvbmZpZyBvcHRpb24gdGhhdCBhbHNv
IGhhcyBhIGNvbW1hbmQtbGluZSB2ZXJzaW9uLA0KPiB3ZSB1c3VhbGx5IGZvcmdvIHRoaXMgc2Vw
YXJhdGUgc3RvcmFnZSBmb3IgdGhlIGNvbmZpZ3VyZWQgdmFsdWUuDQo+IEluc3RlYWQsIHdlIGp1
c3Qgc2V0ICJzb3J0IiBkaXJlY3RseSBmcm9tIHRoZSBjb25maWcgY2FsbGJhY2sgKHdoaWNoIG1h
eQ0KPiByZXF1aXJlIG1ha2luZyBpdCBhIGdsb2JhbCBzbyB0aGUgY2FsbGJhY2sgY2FuIGFjY2Vz
cyBpdCksIGFuZCB0aGVuIGxldA0KPiB0aGUgY29tbWFuZC1saW5lIHBhcnNlciBvdmVyd3JpdGUg
aXQuDQo+IA0KDQpBbHJpZ2h0IHRoYXQgbWFrZXMgc2Vuc2UuIEkgd2lsbCBzZW5kIGEgdjIgc29v
bi4gVGhhbmtzIGZvciB0aGUNCmNvbW1lbnRzLg0KDQo+IC1QZWZmDQoNClJlZ2FyZHMsDQpKYWtl
DQo=
