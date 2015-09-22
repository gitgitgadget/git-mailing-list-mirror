From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH] notes: document behavior of --ref and --notes DWIMery
Date: Tue, 22 Sep 2015 21:03:31 +0000
Message-ID: <1442955811.26280.50.camel@intel.com>
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
X-From: git-owner@vger.kernel.org Tue Sep 22 23:03:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeUj9-0006sp-4U
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 23:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934728AbbIVVDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 17:03:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:21071 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934700AbbIVVDp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 17:03:45 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP; 22 Sep 2015 14:03:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,574,1437462000"; 
   d="scan'208";a="810703397"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga002.fm.intel.com with ESMTP; 22 Sep 2015 14:03:32 -0700
Received: from orsmsx159.amr.corp.intel.com (10.22.240.24) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.248.2; Tue, 22 Sep 2015 14:03:31 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.164]) by
 ORSMSX159.amr.corp.intel.com ([169.254.11.248]) with mapi id 14.03.0248.002;
 Tue, 22 Sep 2015 14:03:31 -0700
Thread-Topic: [PATCH] notes: document behavior of --ref and --notes DWIMery
Thread-Index: AQHQ9XS8Z8FXH0i62UahhqGPzDSB+Z5JAvi8gAB7vIA=
In-Reply-To: <xmqq8u7y2nnq.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.3.123]
Content-ID: <69DA3272E355FE4CAF547235ADACD599@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278437>

T24gVHVlLCAyMDE1LTA5LTIyIGF0IDEzOjQwIC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gSG93IGFib3V0IHBocmFzaW5nIGl0IHRvdGFsbHkgZGlmZmVyZW50bHk/DQo+IA0KPiAJVGhl
IHJlZiBzcGVjaWZpZXMgdGhlIGZ1bGwgcmVmbmFtZSB3aGVuIGl0IGJlZ2lucyB3aXRoDQo+IAlg
cmVmcy9ub3Rlcy9gOyBvdGhlcndpc2UgYHJlZi9ub3Rlcy9gIGlzIHByZWZpeGVkIHRvIGZvcm0g
YQ0KPiAJZnVsbCBuYW1lIG9mIHRoZSByZWYuDQo+IA0KPiBJIHRoaW5rIHRoYXQgd291bGQgcmVt
b3ZlIHRoZSBuZWVkIHRvIGlsbHVzdHJhdGUgd2l0aCBjb25jcmV0ZQ0KPiBleGFtcGxlcyBsaWtl
IHJlZnMvaGVhZHMvYmxhaC4NCj4gDQoNCldhaXQsIHdoYXQgYWJvdXQgdGhlIERXSU0gb2Ygbm90
ZXMvPG5hbWU+IGdvZXMgdG8gcmVmcy9ub3Rlcy88bmFtZT4uLg0KZG8gd2UgbmVlZCB0byBleHBs
YWluIHRoYXQgaGVyZT8gaXQgbWlnaHQgc2VlbSB0aGF0ICJub3Rlcy9mb28iIGVuZHMgdXANCmFz
ICJyZWZzL25vdGVzL25vdGVzL2ZvbyIgd2hpY2ggaXMgbm90IHJlYWxseSB3aGF0IHdlIG1lYW4u
DQoNClJlZ2FyZHMsDQpKYWtl
