From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [Bug] data loss with cyclic alternates
Date: Fri, 11 Jul 2014 18:01:46 +0000
Message-ID: <1405101705.22963.27.camel@jekeller-desk1.amr.corp.intel.com>
References: <53BFB055.206@gmail.com>
	 <xmqqy4vz51gb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "dr.khong@gmail.com" <dr.khong@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 20:01:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5f8q-0008Ko-7Z
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 20:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974AbaGKSBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 14:01:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:45693 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424AbaGKSBs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 14:01:48 -0400
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP; 11 Jul 2014 10:56:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,644,1400050800"; 
   d="scan'208";a="542141008"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga001.jf.intel.com with ESMTP; 11 Jul 2014 11:01:46 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.193]) by
 ORSMSX103.amr.corp.intel.com ([169.254.2.34]) with mapi id 14.03.0123.003;
 Fri, 11 Jul 2014 11:01:46 -0700
Thread-Topic: [Bug] data loss with cyclic alternates
Thread-Index: AQHPnOvPzy89dj/tTU+OVKdKD7By55ubCb3egACWHoA=
In-Reply-To: <xmqqy4vz51gb.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <20AD8FC8BE906D4EB3AC0528007848C9@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253305>

T24gRnJpLCAyMDE0LTA3LTExIGF0IDA5OjAxIC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gRXBocmltIEtob25nIDxkci5raG9uZ0BnbWFpbC5jb20+IHdyaXRlczoNCj4gDQo+ID4gZ2l0
IHNlZW1zIHRvIGhhdmUgaXNzdWVzIHdpdGggYWx0ZXJuYXRlcyB3aGVuIGN5Y2xlcyBhcmUgcHJl
c2VudCAocmVwbw0KPiA+IEEgaGFzIEIvb2JqZWN0cyBhcyBhbHRlcm5hdGVzLCBCIGhhcyBBL29i
amVjdHMgYXMgYWx0ZXJuYXRlcykuDQo+IA0KPiBZZWFoLCBkb24ndCBkbyB0aGF0LiAgQSB0aGlu
a3MgImVoLCB0aGUgb3RoZXIgZ3V5IG11c3QgaGF2ZSBpdCIgYW5kDQo+IEIgdGhpbmtzIHRoZSBz
YW1lLiAgSW4gZ2VuZXJhbCwgZG8gbm90IHBydW5lIG9yIGdjIGEgcmVwb3NpdG9yeQ0KPiBvdGhl
ciByZXBvc2l0b3JpZXMgYm9ycm93IGZyb20sIGV2ZW4gaWYgdGhlcmUgaXMgbm8gY3ljbGUsIGJl
Y2F1c2UNCj4gdGhlIGJvcnJvd2VlIGRvZXMgbm90IGtub3cgYW55dGhuaW5nIGFib3V0IG9iamVj
dHMgdGhhdCBpdCBpdHNlbGYgbm8NCj4gbG9uZ2VyIG5lZWRzIGJ1dCBhcmUgc3RpbGwgbmVlZGVk
IGJ5IGl0cyBib3Jyb3dlcnMuDQo+IA0KDQpEb2Vzbid0IGdjIGdldCBydW4gYXV0b21hdGljYWxs
eSBhdCBzb21lIHBvaW50cz8gSXMgdGhlIGF1dG9tYXRpYyBnYyBydW4NCnNldHVwIHRvIGF2b2lk
IHRoaXMgcHJvYmxlbT8gDQoNClRoYW5rcywNCkpha2UNCg0KPiAtLQ0KPiBUbyB1bnN1YnNjcmli
ZSBmcm9tIHRoaXMgbGlzdDogc2VuZCB0aGUgbGluZSAidW5zdWJzY3JpYmUgZ2l0IiBpbg0KPiB0
aGUgYm9keSBvZiBhIG1lc3NhZ2UgdG8gbWFqb3Jkb21vQHZnZXIua2VybmVsLm9yZw0KPiBNb3Jl
IG1ham9yZG9tbyBpbmZvIGF0ICBodHRwOi8vdmdlci5rZXJuZWwub3JnL21ham9yZG9tby1pbmZv
Lmh0bWwNCg0KDQo=
