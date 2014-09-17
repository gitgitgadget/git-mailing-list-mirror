From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: git fetch specific ref fails when run against a remote where HEAD
 points to missing master branch
Date: Wed, 17 Sep 2014 17:40:04 +0000
Message-ID: <1410975603.23945.4.camel@jekeller-desk1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 17 19:40:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUJDJ-0003dA-Iw
	for gcvg-git-2@plane.gmane.org; Wed, 17 Sep 2014 19:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756311AbaIQRkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2014 13:40:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:52619 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755982AbaIQRkH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2014 13:40:07 -0400
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP; 17 Sep 2014 10:40:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,862,1389772800"; 
   d="scan'208";a="387546683"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Sep 2014 10:34:34 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.195.1; Wed, 17 Sep 2014 10:40:04 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.235]) by
 ORSMSX111.amr.corp.intel.com ([169.254.11.162]) with mapi id 14.03.0195.001;
 Wed, 17 Sep 2014 10:40:04 -0700
Thread-Topic: git fetch specific ref fails when run against a remote where
 HEAD points to missing master branch
Thread-Index: AQHP0p5pg/0diI6syk+v7dCCn6OtOw==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <0C7C530544BA87438C0F262978A2E55E@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257226>

SGksDQoNCkkgYW0gYXNzdW1pbmcgdGhpcyBpcyBzaW1wbHkgYSBjb25maWd1cmF0aW9uIGlzc3Vl
IG9uIG15IGVuZCBmb3IgdGhpcw0KcGFydGljdWxhciByZW1vdGUsIGJlY2F1c2UgSSBuZXZlciBw
dXNoZWQgdG8gdGhlIG1hc3RlciBicmFuY2gsIGFuZCBzbw0KdGhlIEhFQUQgb2YgdGhpcyByZW1v
dGUgZG9lc24ndCBleGlzdC4NCg0KSG93ZXZlciwgSSBhbSBhbHNvIHVzaW5nIGl0IHRvIGZldGNo
IHNwZWNpZmljIHJlZnMgSSBrbm93IHRoZSBuYW1lIG9mLA0Kc28gaXQgY29uZnVzZXMgbWUgd2hl
biBJIHRyeSB0byBmZXRjaCBhbmQgZ2V0IGJhY2sgYSBmYWlsdXJlLCBiZWNhdXNlDQp0aGUgcmVt
b3RlIEhFQUQgcmVmIGRvZXNuJ3QgZXhpc3QuLi4NCg0KQ29tbWFuZCAiZ2l0IGZldGNoIC0tdGFn
cyAtLXByb2dyZXNzIGdpdDovL2dpdGxhZC5qZi5pbnRlbC5jb20vZ2l0L2pla2VsbGVyL3Rlc3Rp
bmcvaXhnYmUgK3JlZnMvaGVhZHMvKjpyZWZzL3JlbW90ZXMvb3JpZ2luLyoiIHJldHVybmVkIHN0
YXR1cyBjb2RlIDE6DQpzdGRvdXQ6IEZldGNoaW5nIHN1Ym1vZHVsZSBzcmMvQ09NUEFUDQoNCnN0
ZGVycjogcmVtb3RlOiBDb3VudGluZyBvYmplY3RzOiA5LCBkb25lLiAgICAgICAgDQpyZW1vdGU6
IENvbXByZXNzaW5nIG9iamVjdHM6ICAzMyUgKDEvMykgICAgICAgICAgIA0KcmVtb3RlOiBDb21w
cmVzc2luZyBvYmplY3RzOiAgNjYlICgyLzMpICAgICAgICAgICANCnJlbW90ZTogQ29tcHJlc3Np
bmcgb2JqZWN0czogMTAwJSAoMy8zKSAgICAgICAgICAgDQpyZW1vdGU6IENvbXByZXNzaW5nIG9i
amVjdHM6IDEwMCUgKDMvMyksIGRvbmUuICAgICAgICANCnJlbW90ZTogVG90YWwgMyAoZGVsdGEg
MSksIHJldXNlZCAwIChkZWx0YSAwKSAgICAgICAgDQpGcm9tIGdpdDovL2dpdGxhZC5qZi5pbnRl
bC5jb20vZ2l0L2pla2VsbGVyL3Rlc3RpbmcvaXhnYmUNCiAqIFtuZXcgYnJhbmNoXSAgICAgIDIw
MTQtMDktMTctYjZjNmZmMmM3NmFlIC0+IG9yaWdpbi8yMDE0LTA5LTE3LWI2YzZmZjJjNzZhZQ0K
ZmF0YWw6IENvdWxkbid0IGZpbmQgcmVtb3RlIHJlZiBIRUFEDQoNClNvIGluIG9yZGVyIHRvIHVu
ZGVyc3RhbmQgd2hhdCBJIGFtIGRvaW5nOg0KDQpJIGhhdmUgYSBjb250aW51b3VzIGludGVncmF0
aW9uIGJ1aWxkLCB3aGljaCBJIGNhbiBwcmUtdGVzdCBhIHNlcmllcyBvZg0KY29tbWl0cyBiZWZv
cmUgcHVzaGluZyBpdCB0byB0aGUgcmVhbCByZW1vdGUsIGJ5IHB1c2hpbmcgdG8gYSByZWYgaW4N
CnRoaXMgcmVwb3NpdG9yeSwgYW5kIHRoZW4gaW5kaWNhdGluZyB0byBteSBjb250aW51b3VzIGJ1
aWxkIHNlcnZlciB0bw0KdGVzdCBhZ2FpbnN0IHRoYXQgcmVmLg0KDQpBcyBpdCB0dXJucyBvdXQs
IG15IHJlbW90ZSBkaWRuJ3QgaGF2ZSBhIG1hc3RlciBicmFuY2gsIChhcyBJIG5ldmVyDQpwdXNo
ZWQgYW55dGhpbmcgdGhlcmUhKSwgYW5kIHNvIGV2ZW4gdGhvdWdoIGl0IHdhcyBhIGJhcmUgcmVw
b3NpdG9yeSwNCkhFQUQgd2FzIHBvaW50aW5nIHN0aWxsIHRvIHJlZnMvaGVhZHMvbWFzdGVyDQoN
CkkgZml4ZWQgdGhpcyBpc3N1ZSBieSBhZGRpbmcgYSBtYXN0ZXIgYnJhbmNoIHRoYXQgd2FzIGVt
cHR5LiBJIGFsc28NCmFzc3VtZSBJIGNvdWxkIGhhdmUgdXBkYXRlZCBIRUFEIHRvIHBvaW50IHRv
IGEgZGlmZmVyZW50IGxvY2F0aW9uIGlmIEkNCndhbnRlZCBhbHNvLi4gYnV0IEknbSBub3Qgc3Vy
ZSB0aGlzIHNob3VsZCBiZSBhbiBlcnJvciBpbiB0aGUgY2FzZSB0aGF0DQpJIGZldGNoIGEgc3Bl
Y2lmaWMgcmVmIGJ5IGNvbW1hbmQgbGluZSBwYXJhbWV0ZXI/IEVzcGVjaWFsbHkgYXMgaXQNCm1h
bmFnZXMgdG8gZmV0Y2ggYWxsIHRoZSByZWZzIEkgYXNrZWQgZm9yIGNvcnJlY3RseSwgYnV0IHN0
aWxsIGZhaWxzDQp3aXRoIGEgbm9uLXplcm8gZXhpdCB2YWx1ZS4NCg0KUmVnYXJkcywNCkpha2UN
Cg==
