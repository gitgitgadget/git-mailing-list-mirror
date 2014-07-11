From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: pitfall with empty commits during git rebase
Date: Fri, 11 Jul 2014 17:58:48 +0000
Message-ID: <1405101528.22963.26.camel@jekeller-desk1.amr.corp.intel.com>
References: <20140711101547.GA26050@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "olaf@aepfle.de" <olaf@aepfle.de>
X-From: git-owner@vger.kernel.org Fri Jul 11 20:00:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5f7Y-0006xT-Qw
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 20:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbaGKSA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 14:00:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:25507 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751661AbaGKSA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 14:00:28 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 11 Jul 2014 11:00:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,644,1400050800"; 
   d="scan'208";a="571844398"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga002.jf.intel.com with ESMTP; 11 Jul 2014 10:58:49 -0700
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.123.3; Fri, 11 Jul 2014 10:58:49 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.193]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.95]) with mapi id 14.03.0123.003;
 Fri, 11 Jul 2014 10:58:49 -0700
Thread-Topic: pitfall with empty commits during git rebase
Thread-Index: AQHPnPE5npch4IJVvkacMnd7euVnu5ubnv0A
In-Reply-To: <20140711101547.GA26050@aepfle.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <B9E976A158FEA949A9AEB3A873F6F0D5@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253304>

T24gRnJpLCAyMDE0LTA3LTExIGF0IDEyOjE1ICswMjAwLCBPbGFmIEhlcmluZyB3cm90ZToNCj4g
VGhlcmUgaXMgYW4gaW5jb3JyZWN0IG1lc3NhZ2Ugd2hlbiBkb2luZyAiZ2l0IHJlYmFzZSAtaSBy
ZW1vdGUvYnJhbmNoIi4NCj4gSSBoYXZlIGl0IG9ubHkgaW4gZ2VybWFuLCBzZWUgYmVsb3cuIHdo
YXQgaGFwcGVuZCBpczoNCj4gDQo+ICMwMSBtYWtlIGNoYW5nZXMgb24gYW5vdGhlciBob3N0DQo+
ICMwMiBjb3B5IHBhdGNoZmlsZSB0byBsb2NhbGhvc3QNCj4gIzAzIGFwcGx5IHBhdGNoZmlsZQ0K
PiAjMDQgZ2l0IGNvbW1pdCAtYXZzICMgY3JlYXRlIGNvbW1pdCMxDQo+ICMwNSBzbGVlcCAxMjM0
NTYNCj4gIzA2IG1ha2UgZGlmZmVyZW50IGNoYW5nZXMgb24gYW5vdGhlciBob3N0DQo+ICMwNyBj
b3B5IHBhdGNoZmlsZSB0byBsb2NhbGhvc3QNCj4gIzA4IGdpdCBzaG93IHwgcGF0Y2ggLVJwMQ0K
PiAjMDkgZ2l0IGNvbW1pdCAtYXZzICMgY3JlYXRlIGNvbW1pdCMyDQo+ICMxMCBhcHBseSBwYXRj
aGZpbGUNCj4gIzExIGdpdCBjb21taXQgLWF2cyAjIGNyZWF0ZSBjb21taXQjMw0KPiAjMTIgZ2l0
IHJlYmFzZSAtaSByZW1vdGUvYnJhbmNoDQo+ICAgICAgcGljayBjb21taXQjMSBtc2cNCj4gICAg
ICBmICAgIGNvbW1pdCMyIG1zZw0KPiAgICAgIGYgICAgY29tbWl0IzMgbXNnDQo+IA0KPiAuLi4u
DQo+ICIuZ2l0L3JlYmFzZS1tZXJnZS9naXQtcmViYXNlLXRvZG8iIDIxTCwgNzA3QyBnZXNjaHJp
ZWJlbg0KPiBTaWUgZnJhZ3RlbiBkZW4gasO8bmdzdGVuIENvbW1pdCBuYWNoenViZXNzZXJuLCBh
YmVyIGRhcyB3w7xyZGUgZGllc2VuIGxlZXINCj4gbWFjaGVuLiBTaWUga8O2bm5lbiBJaHIgS29t
bWFuZG8gbWl0IC0tYWxsb3ctZW1wdHkgd2llZGVyaG9sZW4sIG9kZXIgZGllc2VuDQo+IENvbW1p
dCBtaXQgImdpdCByZXNldCBIRUFEXiIgdm9sbHN0w6RuZGlnIGVudGZlcm5lbi4NCj4gUmViYXNl
IGltIEdhbmdlOyBhdWYgYzEwNTU4OQ0KPiBTaWUgc2luZCBnZXJhZGUgYmVpbSBSZWJhc2Ugdm9u
IEJyYW5jaCAnbXlicmFuY2gnIGF1ZiAnYzEwNTU4OScuDQo+IA0KPiBLZWluZSDDhG5kZXJ1bmdl
bg0KPiANCj4gQ291bGQgbm90IGFwcGx5IDZjNTg0MjMyMGFjYzc5N2QzOTVhZmI1Y2RmMzczYzJi
ZmFlYmZhMzQuLi4gcmV2ZXJ0DQo+IC4uLi4NCj4gDQo+IEl0cyBub3QgY2xlYXIgd2hhdCAnLS1h
bGxvdy1lbXB0eScgcmVmZXJzIHRvLCBnaXQgcmViYXNlIGRvZXMgbm90IHNlZW0gdG8NCj4gdW5k
ZXJzdGFuZCB0aGlzIG9wdGlvbi4NCj4gDQoNCllvdSBzaG91bGQgYmUgYWJsZSB0byBmaXggdGhp
cyB3aXRoDQoNCmdpdCBjb21taXQgLS1hbGxvdy1lbXB0eQ0KZ2l0IHJlYmFzZSAtLWNvbnRpbnVl
DQoNCkJ1dCB5ZXMgdGhlIG1lc3NhZ2UgY291bGQgcG9zc2libHkgYmUgbWFkZSBhIGxpdHRsZSBj
bGVhcmVyLg0KDQpUaGFua3MsDQpKYWtlDQoNCj4gSSBzaG91bGQgaGF2ZSBza2lwcGVkIHN0ZXAg
IzA5IHRvIGF2b2lkIHRoZSB0cm91YmxlLg0KPiBnaXQgdmVyc2lvbiBpcyAyLjAuMS4gUGxlYXNl
IGFkanVzdCB0aGUgZXJyb3IgbXNnIGFib3ZlLg0KPiANCj4gDQo+IE9sYWYNCj4gLS0NCj4gVG8g
dW5zdWJzY3JpYmUgZnJvbSB0aGlzIGxpc3Q6IHNlbmQgdGhlIGxpbmUgInVuc3Vic2NyaWJlIGdp
dCIgaW4NCj4gdGhlIGJvZHkgb2YgYSBtZXNzYWdlIHRvIG1ham9yZG9tb0B2Z2VyLmtlcm5lbC5v
cmcNCj4gTW9yZSBtYWpvcmRvbW8gaW5mbyBhdCAgaHR0cDovL3ZnZXIua2VybmVsLm9yZy9tYWpv
cmRvbW8taW5mby5odG1sDQoNCg0K
