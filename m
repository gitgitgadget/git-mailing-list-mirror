From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH 8/9] autoconf: Check for timer_settime
Date: Fri, 29 Aug 2014 15:23:31 +0000
Message-ID: <1409325810.18778.6.camel@jekeller-desk1.amr.corp.intel.com>
References: <1409187862-21257-1-git-send-email-sortie@maxsi.org>
	 <1409187862-21257-9-git-send-email-sortie@maxsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "sortie@maxsi.org" <sortie@maxsi.org>
X-From: git-owner@vger.kernel.org Fri Aug 29 17:24:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNO29-0006OU-P9
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 17:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302AbaH2PYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 11:24:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:53366 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752962AbaH2PYH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 11:24:07 -0400
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by orsmga101.jf.intel.com with ESMTP; 29 Aug 2014 08:23:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.04,424,1406617200"; 
   d="scan'208";a="473834483"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by azsmga001.ch.intel.com with ESMTP; 29 Aug 2014 08:23:31 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.235]) by
 ORSMSX101.amr.corp.intel.com ([169.254.8.102]) with mapi id 14.03.0195.001;
 Fri, 29 Aug 2014 08:23:31 -0700
Thread-Topic: [PATCH 8/9] autoconf: Check for timer_settime
Thread-Index: AQHPwl3FgRTCdlz78EaZvQVC0QR/1JvoKv0A
In-Reply-To: <1409187862-21257-9-git-send-email-sortie@maxsi.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <C16389670CECCA4589A50FDC48D28BFE@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256148>

T24gVGh1LCAyMDE0LTA4LTI4IGF0IDAzOjA0ICswMjAwLCBKb25hcyAnU29ydGllJyBUZXJtYW5z
ZW4gd3JvdGU6DQo+IFRoaXMgZnVuY3Rpb24gd2lsbCBiZSB1c2VkIGluIGEgZm9sbG93aW5nIGNv
bW1pdC4NCj4gDQo+IFRoZSB0aW1lcl9zZXR0aW1lIGZ1bmN0aW9uIGlzIHByb3ZpZGVkIGluIGxp
YnJ0IG9uIHNvbWUgc3lzdGVtcy4gV2UNCj4gYWxyZWFkeSB1c2UgdGhpcyBsaWJyYXJ5IHNvbWV0
aW1lcyB0byBnZXQgY2xvY2tfZ2V0dGltZSwgc28gcmV3b3JrIHRoZQ0KPiBsb2dpYyBzbyB3ZSBk
b24ndCBsaW5rIHdpdGggaXQgdHdpY2UuDQo+IA0KPiBUaGlzIGZ1bmN0aW9uIHdhcyBub3QgcHJl
dmlvdXNseSB1c2VkIGJ5IGdpdC4gVGhpcyBjYW4gY2F1c2UgdHJvdWJsZSBmb3INCj4gcGVvcGxl
IG9uIHN5c3RlbXMgd2l0aG91dCB0aW1lcl9zZXR0aW1lIGlmIHRoZXkgb25seSByZWx5IG9uDQo+
IGNvbmZpZy5tYWsudW5hbWUuIFRoZXkgd2lsbCBuZWVkIHRvIHNldCBOT19USU1FUl9TRVRUSU1F
IG1hbnVhbGx5Lg0KPiANCj4gQWRkIHByb3BlciByZXBsYWNlbWVudCBmdW5jdGlvbiBtYWNyb3Mg
Zm9yIHNldGl0aW1lciBhbmQgdGltZXJfc2V0dGltZQ0KPiB0aGF0IGV2YWx1YXRlcyB0aGUgYXJn
dW1lbnRzIGFuZCBmYWlscyB3aXRoIEVOT1NZUyB0byBzaW11bGF0ZSBzdHViDQo+IGltcGxlbWVu
dGF0aW9ucy4gVGhpcyB3aWxsIGJlIHVzZWZ1bCBpbiBhIGZvbGxvd2luZyBjb21taXQuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBKb25hcyAnU29ydGllJyBUZXJtYW5zZW4gPHNvcnRpZUBtYXhzaS5v
cmc+DQo+IA0KPiAtLS0NCj4gDQo+IFRoaXMgcGF0Y2ggY2FuIGJlIGltcHJvdmVkIGJ5IGZpbmRp
bmcgb3V0IHdoaWNoIHN5c3RlbXMgZG9lc24ndCBoYXZlDQo+IHRpbWVyX3NldHRpbWUgYW5kIGFk
ZGluZyBlbnRyaWVzIGZvciB0aGVtIHRvIGNvbmZpZy5tYWsudW5hbWUuDQo+IA0KPiAgTWFrZWZp
bGUgICAgICAgICAgfCAyMSArKysrKysrKysrKysrKysrKysrKysNCj4gIGNvbmZpZy5tYWsudW5h
bWUgIHwgIDMgKysrDQo+ICBjb25maWd1cmUuYWMgICAgICB8ICA4ICsrKysrKysrDQo+ICBnaXQt
Y29tcGF0LXV0aWwuaCB8ICA4ICsrKysrKystDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDM5IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9NYWtlZmlsZSBiL01h
a2VmaWxlDQo+IGluZGV4IDY2MzI5ZTQuLjU2MDllNDQgMTAwNjQ0DQo+IC0tLSBhL01ha2VmaWxl
DQo+ICsrKyBiL01ha2VmaWxlDQo+IEBAIC0xODIsMTYgKzE4MiwyMiBAQCBhbGw6Og0KPiAgIw0K
PiAgIyBEZWZpbmUgTk9fU0VUSVRJTUVSIGlmIHlvdSBkb24ndCBoYXZlIHNldGl0aW1lcigpDQo+
ICAjDQo+ICsjIERlZmluZSBOT19USU1FUl9TRVRUSU1FIGlmIHlvdSBkb24ndCBoYXZlIHRpbWVy
X3NldHRpbWUoKQ0KPiArIw0KPiAgIyBEZWZpbmUgTk9fVElNRVJfVCBpZiB5b3UgZG9uJ3QgaGF2
ZSB0aW1lcl90Lg0KPiArIyBUaGlzIGFsc28gaW1wbGllcyBOT19TRVRJVElNRVINCg0KRG9uJ3Qg
eW91IG1lYW4gaXQgaW1wbGllcyBOT19USU1FUl9TRVRUSU1FPw0KDQpJdCBzZWVtcyB0byBtZSB0
aGF0IHRoZXNlIHdlcmUgYWxsIGFkZGVkIGZvciBUSU1FUl9TRVRUSU1FLCBhbmQgbm90DQpOT19T
RVRUSU1FUj8gT3IgYW0gSSBqdXN0IHRob3JvdWdobHkgY29uZnVzZWQ/DQoNClJlZ2FyZHMsDQpK
YWtlDQo=
