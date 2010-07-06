From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: global hooks - once again
Date: Tue, 6 Jul 2010 16:55:57 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC744940F7000@xmail3.se.axis.com>
References: <AANLkTikXJS5QCXMXgsOfkYn9cMBQV6o23tds5YG3A_OI@mail.gmail.com>
	<7v630x1yl8.fsf@alter.siamese.dyndns.org>
	<AANLkTikMEDUI7d5Mzwm8r43zCYTqefyI06PHOMvT1iLz@mail.gmail.com>
	<A612847CFE53224C91B23E3A5B48BAC744940F6E57@xmail3.se.axis.com>
	<AANLkTimSvwo50Q9jsbKkzvplSPE82fNJJDSFmZVw3r5o@mail.gmail.com>
 <AANLkTilZcuYxb6ASgJq82JVdgcRcuak5PvYXZF6fcojm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Eugene Sajine <euguess@gmail.com>, Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 16:56:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW9ZF-0003PS-O2
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 16:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618Ab0GFO4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 10:56:07 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:33049 "EHLO
	miranda.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147Ab0GFO4G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 10:56:06 -0400
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by miranda.se.axis.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id o66Eu0wI016943;
	Tue, 6 Jul 2010 16:56:00 +0200
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Tue, 6 Jul 2010 16:56:00 +0200
Thread-Topic: global hooks - once again
Thread-Index: AcsdBkRWtwObOffISXm6jg8xg/7vJgAEydLg
In-Reply-To: <AANLkTilZcuYxb6ASgJq82JVdgcRcuak5PvYXZF6fcojm@mail.gmail.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150359>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBnaXQtb3duZXJAdmdlci5rZXJu
ZWwub3JnIFttYWlsdG86Z2l0LW93bmVyQHZnZXIua2VybmVsLm9yZ10gT24NCj4gQmVoYWxmIE9m
IEV1Z2VuZSBTYWppbmUNCj4gU2VudDogZGVuIDYganVsaSAyMDEwIDE0OjIzDQo+IFRvOiBBbGV4
IFJpZXNlbg0KPiBDYzogZ2l0QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogZ2xvYmFs
IGhvb2tzIC0gb25jZSBhZ2Fpbg0KPiANCj4gPiBIb3cgZG8geW91ciB1c2VycyBkaXNhYmxlIGV4
ZWN1dGlvbiBvZiBnbG9iYWwgaG9va3MgaW4gdGhpcyBzY2hlbWU/DQo+ID4gKHRvIHByb3RlY3Qg
dGhlbXNlbHZlcyBmcm9tIGFuIGV2aWwgc3lzdGVtIGFkbWluaXN0cmF0b3IpDQoNClllYWgsIEkg
bWlzc2VkIHRoYXQgY2FzZS4gV2hhdCBJIGhhdmUgaXMgYW5vdGhlciBjb25maWd1cmF0aW9uIA0K
dmFyaWFibGUgKGUuZy4sIGNvcmUuaG9va3NBY3RpdmVMZXZlbHMpIHdoaWNoIGlzIHNldCB0byBh
IHN0cmluZyBvZiANCmRpZmZlcmVudCBjb25maWd1cmF0aW9uIGxldmVscyAoZGVmYXVsdGluZyB0
byAnc3lzdGVtIGdsb2JhbCBsb2NhbCcpLg0KT25seSB0aGUgaG9vayBkaXJlY3RvcmllcyBzcGVj
aWZpZWQgb24gYW4gYWN0aXZlIGxldmVsIGFyZQ0Kc2Nhbm5lZCBmb3IgaG9va3MuIFNvIGJ5IHNl
dHRpbmcgaXQgdG8ganVzdCAnbG9jYWwnIGFueSBzeXN0ZW0NCmFuZCBnbG9iYWwgaG9vayBkaXJl
Y3RvcmllcyBhcmUgaWdub3JlZC4NCg0KVGhpcyBpcyBub3Qgb3B0aW1hbCwgYnV0IHdhcyB0aGUg
YmVzdCBJIGNvdWxkIGNvbWUgdXAgd2l0aC4NCkkgcmVhbGx5IGRvIG5vdCB3YW50IHRvIGZvcmNl
IHRoZSB1c2VycyB0byBleHBsaWNpdGx5IHNwZWNpZnkNCnRoZSBob29rIGRpcmVjdG9yaWVzIGZv
ciBlYWNoIHJlcG9zaXRvcnksIGJ1dCByYXRoZXIgYmUgYWJsZSANCnRvIHNldCBpdCBvbiBhIGds
b2JhbCBsZXZlbCwgYW5kIHRoZW4gdXNlIGV4Y2VwdGlvbnMgZm9yIHRoZSANCmZldyBjYXNlcyB3
aGVyZSB0aGUgZ2xvYmFsIGhvb2tzIHNob3VsZCBub3QgYmUgYWN0aXZlLg0KDQo+IEluIGEgY29y
cG9yYXRlIGVudmlyb25tZW50IGl0IGlzIG5vdCB0aGUgY2FzZSwgaSBiZWxpZXZlLiBJZiBzeXNh
ZG1pbg0KPiBtYWRlIGEgbWlzdGFrZSBhIHdpdGggaG9va3MsIGhlIHdpbGwgaGF2ZSB0byBmaXgg
aXQsIGJ1dCB0aGVyZSBpcyBubw0KPiBwb2ludCBpbiBvdmVycmlkaW5nIG9uIHVzZXIgbGV2ZWwg
YXMgaG9va3MgaW4gdGhpcyBjYXNlIHdpbGwgYmUNCj4gc29tZXRoaW5nIGFib3V0IGNvbXBhbnkg
cG9saWN5LCBhcmVuJ3QgdGhleT8NCg0KV2VsbCwgYWN0dWFsbHkgaXQgaXMgbmVlZGVkIHRoZXJl
IHRvby4gRXZlbiB0aG91Z2ggdGhlIHZhc3QgDQptYWpvcml0eSBvZiByZXBvc2l0b3JpZXMgdGhl
IHVzZXIgY2xvbmVzIGFyZSBjb21wYW55IHJlcG9zaXRvcmllcw0KdGhhdCBzaG91bGQgdXNlIHRo
ZSBjb21wYW55J3MgcnVsZXMsIGhlIG1heSBjbG9uZSBzb21lIG9jY2FzaW9uYWwNCnJlcG9zaXRv
cmllcyBmcm9tIHRoZSBvdXRzaWRlIChlLmcuLCBMaW51eCBvciBnaXQpIGluIHdoaWNoIGNhc2UN
CmhlIHByb2JhYmx5IHdhbnRzIHRvIGRpc2FibGUgdGhlIGdsb2JhbCBjb21wYW55IGhvb2tzLg0K
DQo+IFRoYW5rcywNCj4gRXVnZW5lDQoNCi8vUGV0ZXINCg0K
