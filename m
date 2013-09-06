From: =?utf-8?B?SsO4cmdlbiBFZGVsYm8=?= <jed@napatech.com>
Subject: RE: [PATCH] git-gui: Modify push dialog to support Gerrit review
Date: Fri, 6 Sep 2013 08:17:57 +0000
Message-ID: <F8C23E99F5C6884EB99E2A1966D743637F361D2A@cph-gen-exch01.napatech.com>
References: <20130904150853.52EC4121B7E@jed-dev-01.labnet>
	<522827CE.5040303@viscovery.net>
	<F8C23E99F5C6884EB99E2A1966D743637F3619A6@cph-gen-exch01.napatech.com>
	<5228476A.2070505@viscovery.net>
	<F8C23E99F5C6884EB99E2A1966D743637F3619CB@cph-gen-exch01.napatech.com>
 <xmqqioyfjhok.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"spearce@spearce.org" <spearce@spearce.org>,
	Pat Thoyts <patthoyts@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	"hvoigt@hvoigt.net" <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Sep 06 10:28:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHrOc-0002HO-PD
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 10:28:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768Ab3IFI16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 04:27:58 -0400
Received: from mail01.napatech.com ([188.120.77.121]:31176 "EHLO
	mail01.napatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745Ab3IFI14 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 04:27:56 -0400
X-Greylist: delayed 596 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Sep 2013 04:27:56 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqMEAEiPKVIK8AFC/2dsb2JhbABbhA2DKr4oF4EhdIIkAQEBAQIBIxFFBQsCAQgaAgYgAgICMBUQAgQBDQUIE4dhqWuRb4EpjhgWGweCaTSBAAOse4Iq
X-IPAS-Result: AqMEAEiPKVIK8AFC/2dsb2JhbABbhA2DKr4oF4EhdIIkAQEBAQIBIxFFBQsCAQgaAgYgAgICMBUQAgQBDQUIE4dhqWuRb4EpjhgWGweCaTSBAAOse4Iq
Received: from CPH-GEN-EXCH01.napatech.com ([fe80::8914:d366:9916:d557]) by
 cph-gen-exch01.napatech.com ([fe80::8914:d366:9916:d557%11]) with mapi id
 14.01.0438.000; Fri, 6 Sep 2013 10:17:58 +0200
Thread-Topic: [PATCH] git-gui: Modify push dialog to support Gerrit review
Thread-Index: AQHOql4560IA2iFMmkuxOgaQ77X075m4WoXw
In-Reply-To: <xmqqioyfjhok.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US, da-DK
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.240.10.71]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234030>

SnVuaW8gQyBIYW1hbm8gPCBnaXRzdGVyQHBvYm94LmNvbT4gd3JpdGVzOg0KDQo+IElzbid0IHRo
ZSByaWdodCB3YXkgdG8gaW1wcm92ZSB0aGUgc2l0dWF0aW9uIHRvIGxldCB0aGUgY29tbWFuZCBs
aW5lIHRvb2xzDQo+IGtub3cgaG93IHRoZSB1c2VyIHdhbnRzIHRvIHB1c2ggdGhpbmdzIG91dCBh
bmQganVzdCBoYXZlIEdpdC1HVUkgZGVsZWdhdGUNCj4gdGhlIGNob2ljZSB0byB0aGUgdW5kZXJs
eWluZyAiZ2l0IHB1c2giPw0KDQpUaGFuayB5b3UgZm9yIGFsbCB0aGUgY29uc3RydWN0aXZlIGZl
ZWRiYWNrLiBJIHJlYWxpemUgdGhhdCBpdCBpcyBub3QgdGhlIHdheSBmb3J3YXJkIHRvIHJlbW92
ZSB0aGUgc2VsZWN0aW9uIG9mIGJyYW5jaGVzIHRvIHB1c2guDQoNCldoYXQgSSBjb25zaWRlciBu
b3csIGlzIHRvIHB1cnN1ZSB0aGUgaWRlYSB0aGF0IEp1bmlvIHByZXNlbnRzIGFib3ZlOiBqdXN0
IGxldCB0aGUgZ3VpIHRvb2wgdXNlIHdoYXRldmVyIGlzIGNvbmZpZ3VyZWQgZm9yIHRoZSBzZWxl
Y3RlZCByZW1vdGUuIEkgaGF2ZSwgaG93ZXZlciBub3QgYmVlbiBhYmxlIHRvIGNvbWUgdXAgd2l0
aCBhIHNvbHV0aW9uIHRoYXQgbG9va3MgbmljZS4gV2hhdCBJIGhhdmUgYmVlbiB0cnlpbmcgbm93
IGlzIHRoZSBmb2xsb3dpbmcgbGl0dGxlIG1vZGlmaWNhdGlvbjoNCg0KZGlmZiAtLWdpdCBhL2dp
dC1ndWkvbGliL3RyYW5zcG9ydC50Y2wgYi9naXQtZ3VpL2xpYi90cmFuc3BvcnQudGNsDQppbmRl
eCBlNWQyMTFlLi4xNzA5NDY0IDEwMDY0NA0KLS0tIGEvZ2l0LWd1aS9saWIvdHJhbnNwb3J0LnRj
bA0KKysrIGIvZ2l0LWd1aS9saWIvdHJhbnNwb3J0LnRjbA0KQEAgLTk1LDcgKzk1LDkgQEAgcHJv
YyBzdGFydF9wdXNoX2FueXdoZXJlX2FjdGlvbiB7d30gew0KICAgICAgICAgICAgICAgIHNldCBj
bnQgMA0KICAgICAgICAgICAgICAgIGZvcmVhY2ggaSBbJHcuc291cmNlLmwgY3Vyc2VsZWN0aW9u
XSB7DQogICAgICAgICAgICAgICAgICAgICAgICBzZXQgYiBbJHcuc291cmNlLmwgZ2V0ICRpXQ0K
LSAgICAgICAgICAgICAgICAgICAgICAgbGFwcGVuZCBjbWQgInJlZnMvaGVhZHMvJGI6cmVmcy9o
ZWFkcy8kYiINCisgICAgICAgICAgICAgICAgICAgICAgIGlmIHskYiBudyB7PGRlZmF1bHQ+fX17
DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxhcHBlbmQgY21kICJyZWZzL2hlYWRz
LyRiOnJlZnMvaGVhZHMvJGIiDQorICAgICAgICAgICAgICAgICAgICAgICB9DQogICAgICAgICAg
ICAgICAgICAgICAgICBpbmNyIGNudA0KICAgICAgICAgICAgICAgIH0NCiAgICAgICAgICAgICAg
ICBpZiB7JGNudCA9PSAwfSB7DQpAQCAtMTQ5LDYgKzE1MSw3IEBAIHByb2MgZG9fcHVzaF9hbnl3
aGVyZSB7fSB7DQogICAgICAgICAgICAgICAgLWhlaWdodCAxMCBcDQogICAgICAgICAgICAgICAg
LXdpZHRoIDcwIFwNCiAgICAgICAgICAgICAgICAtc2VsZWN0bW9kZSBleHRlbmRlZA0KKyAgICAg
ICAkdy5zb3VyY2UubCBpbnNlcnQgZW5kIDxkZWZhdWx0Pg0KICAgICAgICBmb3JlYWNoIGggW2xv
YWRfYWxsX2hlYWRzXSB7DQogICAgICAgICAgICAgICAgJHcuc291cmNlLmwgaW5zZXJ0IGVuZCAk
aA0KICAgICAgICAgICAgICAgIGlmIHskaCBlcSAkY3VycmVudF9icmFuY2h9IHsNCg0KVGhlIGlk
ZWEgaXMgdG8gaW5zZXJ0IGEgIjxkZWZhdWx0PiIgZW50cnkgaW4gdGhlIGJyYW5jaCBzZWxlY3Rp
b24gbGlzdCwgYW5kIHRoZW4gc2tpcCB0aGF0IHdoZW4gYnVpbGRpbmcgdGhlIGNvbW1hbmQuIFRo
ZW4geW91IGNhbiBhdm9pZCBoYXZpbmcgcmVmcyBvbiB0aGUgY29tbWFuZCBsaW5lIGFuZCBqdXN0
IGxldCBnaXQgYWN0IGFjY29yZGluZyB0byBjb25maWd1cmF0aW9uLg0KDQpIb3cgYWJvdXQgdGhh
dD8gQW55IHNtYXJ0ZXIgd2F5IHRvIGRvIGl0Pw0KDQpCUiBKw7hyZ2VuDQo=
