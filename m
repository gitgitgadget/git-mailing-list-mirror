From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: t3200-branch.sh number 102 fails when run under make test
Date: Wed, 9 Jul 2014 20:37:51 +0000
Message-ID: <1404938270.23510.13.camel@jekeller-desk1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 09 22:38:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4yd7-0006kU-BJ
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 22:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945AbaGIUiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 16:38:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:63254 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751861AbaGIUiM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 16:38:12 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 09 Jul 2014 13:37:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,633,1400050800"; 
   d="scan'208";a="570786985"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga002.jf.intel.com with ESMTP; 09 Jul 2014 13:37:51 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.123.3; Wed, 9 Jul 2014 13:37:51 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.193]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.189]) with mapi id 14.03.0123.003;
 Wed, 9 Jul 2014 13:37:52 -0700
Thread-Topic: t3200-branch.sh number 102 fails when run under make test
Thread-Index: AQHPm7WmQWyw1iDMP0uNV7p2+a3o/w==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <4566879402F80741BB5942089F6B1C5A@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253147>

SGVsbG8sDQoNCkkgcmVjZW50bHkgY2xvbmVkIHRoZSBtYXN0ZXIgYnJhbmNoIG9mIHRoZSBnaXQg
cmVwbywgYW5kIHdoZW4gSSByYW4gbWFrZQ0KdGVzdCwgaXQgZmFpbHMgb24gdGVzdCAxMDIgb2Yg
dGhlIHQzMjAwLWJyYW5jaC5zaCB0ZXN0IGNhc2VzLg0KDQpub3Qgb2sgMTAyIC0gdHJhY2tpbmcg
d2l0aCB1bmV4cGVjdGVkIC5mZXRjaCByZWZzcGVjDQojDQojICAgICAgICAgICAgICAgcm0gLXJm
IGEgYiBjIGQgJiYNCiMgICAgICAgICAgICAgICBnaXQgaW5pdCBhICYmDQojICAgICAgICAgICAg
ICAgKA0KIyAgICAgICAgICAgICAgICAgICAgICAgY2QgYSAmJg0KIyAgICAgICAgICAgICAgICAg
ICAgICAgdGVzdF9jb21taXQgYQ0KIyAgICAgICAgICAgICAgICkgJiYNCiMgICAgICAgICAgICAg
ICBnaXQgaW5pdCBiICYmDQojICAgICAgICAgICAgICAgKA0KIyAgICAgICAgICAgICAgICAgICAg
ICAgY2QgYiAmJg0KIyAgICAgICAgICAgICAgICAgICAgICAgdGVzdF9jb21taXQgYg0KIyAgICAg
ICAgICAgICAgICkgJiYNCiMgICAgICAgICAgICAgICBnaXQgaW5pdCBjICYmDQojICAgICAgICAg
ICAgICAgKA0KIyAgICAgICAgICAgICAgICAgICAgICAgY2QgYyAmJg0KIyAgICAgICAgICAgICAg
ICAgICAgICAgdGVzdF9jb21taXQgYyAmJg0KIyAgICAgICAgICAgICAgICAgICAgICAgZ2l0IHJl
bW90ZSBhZGQgYSAuLi9hICYmDQojICAgICAgICAgICAgICAgICAgICAgICBnaXQgcmVtb3RlIGFk
ZCBiIC4uL2IgJiYNCiMgICAgICAgICAgICAgICAgICAgICAgIGdpdCBmZXRjaCAtLWFsbA0KIyAg
ICAgICAgICAgICAgICkgJiYNCiMgICAgICAgICAgICAgICBnaXQgaW5pdCBkICYmDQojICAgICAg
ICAgICAgICAgKA0KIyAgICAgICAgICAgICAgICAgICAgICAgY2QgZCAmJg0KIyAgICAgICAgICAg
ICAgICAgICAgICAgZ2l0IHJlbW90ZSBhZGQgYyAuLi9jICYmDQojICAgICAgICAgICAgICAgICAg
ICAgICBnaXQgY29uZmlnIHJlbW90ZS5jLmZldGNoICIrcmVmcy9yZW1vdGVzLyo6cmVmcy9yZW1v
dGVzLyoiICYmDQojICAgICAgICAgICAgICAgICAgICAgICBnaXQgZmV0Y2ggYyAmJg0KIyAgICAg
ICAgICAgICAgICAgICAgICAgZ2l0IGJyYW5jaCAtLXRyYWNrIGxvY2FsL2EvbWFzdGVyIHJlbW90
ZXMvYS9tYXN0ZXIgJiYNCiMgICAgICAgICAgICAgICAgICAgICAgIHRlc3QgIiQoZ2l0IGNvbmZp
ZyBicmFuY2gubG9jYWwvYS9tYXN0ZXIucmVtb3RlKSIgPSAiYyIgJiYNCiMgICAgICAgICAgICAg
ICAgICAgICAgIHRlc3QgIiQoZ2l0IGNvbmZpZyBicmFuY2gubG9jYWwvYS9tYXN0ZXIubWVyZ2Up
IiA9ICJyZWZzL3JlbW90ZXMvYS9tYXN0ZXIiICYmDQojICAgICAgICAgICAgICAgICAgICAgICBn
aXQgcmV2LXBhcnNlIC0tdmVyaWZ5IGEgPmV4cGVjdCAmJg0KIyAgICAgICAgICAgICAgICAgICAg
ICAgZ2l0IHJldi1wYXJzZSAtLXZlcmlmeSBsb2NhbC9hL21hc3RlciA+YWN0dWFsICYmDQojICAg
ICAgICAgICAgICAgICAgICAgICB0ZXN0X2NtcCBleHBlY3QgYWN0dWFsDQojICAgICAgICAgICAg
ICAgKQ0KIw0KIyBmYWlsZWQgMSBhbW9uZyAxMDIgdGVzdChzKQ0KMS4uMTAyDQoNCkhvd2V2ZXIs
IHdoZW4gSSBydW4gdGhlIHRlc3QgZmlsZSBtYW51YWxseSBpdCBwYXNzZXMuIEkgYW0gY3VycmVu
dGx5DQpydW5uaW5nIHRocm91Z2ggYSB2ZXJib3NlIG91dHB1dCB0ZXN0IHJ1biB0byBzZWUgaWYg
SSBjYW4gZmluZCBtb3JlDQp1c2VmdWwgb3V0cHV0Li4NCg0KRm9yIHJlZmVyZW5jZSwgdGhlIGNv
bW1pdCBJIGFtIHRlc3RpbmcgYWdhaW5zdCBpczoNCg0KNzJjNzc5NDU3Y2Q3ICgibGluZS1sb2c6
IHVzZSBjb21taXRfbGlzdF9hcHBlbmQoKSBpbnN0ZWFkIG9mIGR1cGxpY2F0aW5nIGl0cyBjb2Rl
IikNCg0KVGhhbmtzLA0KSmFrZQ0K
