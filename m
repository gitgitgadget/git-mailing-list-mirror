From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: git clone silently aborts if stdout gets a broken pipe
Date: Thu, 19 Sep 2013 17:48:47 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC798CDF1DC31@xmail3.se.axis.com>
References: <A612847CFE53224C91B23E3A5B48BAC798CD91DB0B@xmail3.se.axis.com>
 <20130918184551.GC18821@sigill.intra.peff.net>
 <A612847CFE53224C91B23E3A5B48BAC798CD91DBA7@xmail3.se.axis.com>
 <20130919083530.GA12597@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 19 17:48:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMgTQ-0001K7-7W
	for gcvg-git-2@plane.gmane.org; Thu, 19 Sep 2013 17:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247Ab3ISPsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 11:48:52 -0400
Received: from anubis.se.axis.com ([195.60.68.12]:60860 "EHLO
	anubis.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780Ab3ISPsv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 11:48:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id 4B7BA19E31;
	Thu, 19 Sep 2013 17:48:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 5SWyF1zJsGZR; Thu, 19 Sep 2013 17:48:49 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by anubis.se.axis.com (Postfix) with ESMTP id CDFB919E09;
	Thu, 19 Sep 2013 17:48:48 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id B78169F4;
	Thu, 19 Sep 2013 17:48:48 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id AB5B9445;
	Thu, 19 Sep 2013 17:48:48 +0200 (CEST)
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by thoth.se.axis.com (Postfix) with ESMTP id A96BE3404E;
	Thu, 19 Sep 2013 17:48:48 +0200 (CEST)
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Thu, 19 Sep 2013 17:48:48 +0200
Thread-Topic: git clone silently aborts if stdout gets a broken pipe
Thread-Index: Ac61Ez9rizqwyfW6RlWj/Dk+EV6kgAAO1ZjQ
In-Reply-To: <20130919083530.GA12597@sigill.intra.peff.net>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235018>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBnaXQtb3duZXJAdmdlci5rZXJu
ZWwub3JnIFttYWlsdG86Z2l0LW93bmVyQHZnZXIua2VybmVsLm9yZ10gT24NCj4gQmVoYWxmIE9m
IEplZmYgS2luZw0KPiBTZW50OiBkZW4gMTkgc2VwdGVtYmVyIDIwMTMgMTA6MzYNCj4gVG86IFBl
dGVyIEtqZWxsZXJzdGVkdA0KPiBDYzogSnVuaW8gQyBIYW1hbm87IE5ndXllbiBUaGFpIE5nb2Mg
RHV5OyBnaXRAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBnaXQgY2xvbmUgc2lsZW50
bHkgYWJvcnRzIGlmIHN0ZG91dCBnZXRzIGEgYnJva2VuIHBpcGUNCj4gDQo+IE9uIFRodSwgU2Vw
IDE5LCAyMDEzIGF0IDA5OjU0OjM4QU0gKzAyMDAsIFBldGVyIEtqZWxsZXJzdGVkdCB3cm90ZToN
Cj4gDQo+ID4gPiBJIHRoaW5rIHlvdXIgcGVybCBzY3JpcHQgaXMgc29tZXdoYXQgcXVlc3Rpb25h
YmxlLCBhcyBpdCBpcyBtYWtpbmcNCj4gPiA+IGFzc3VtcHRpb25zIGFib3V0IHRoZSBvdXRwdXQg
b2YgZ2l0LWNsb25lLCBhbmQgeW91IHdvdWxkIGRvIGJldHRlcg0KPiB0bw0KPiA+ID4gYWNjZXB0
IGFyYml0cmFyeS1zaXplZCBvdXRwdXQNCj4gPg0KPiA+IFdlbGwsIHRoZSB3aG9sZSBpZGVhIG9m
IHVzaW5nIEdpdDo6Y29tbWFuZF9vbmVsaW5lKCkgaXMgdGhhdCB3ZQ0KPiA+IGFyZSBvbmx5IGlu
dGVyZXN0ZWQgaW4gdGhlIGZpcnN0IGxpbmUgb2Ygb3V0cHV0LCBzaW1pbGFyIHRvIHVzaW5nDQo+
ID4gInwgaGVhZCAtMSIuIElmIHdlIGhhZCB3YW50ZWQgYWxsIG9mIHRoZSBvdXRwdXQgd2Ugd291
bGQgaGF2ZSB1c2VkDQo+ID4gR2l0Ojpjb21tYW5kKCkgaW5zdGVhZC4gU2luY2UgdGhlIEdpdCBQ
ZXJsIG1vZHVsZSBpcyByZWxlYXNlZCBhcyBhDQo+ID4gcGFydCBvZiBHaXQsIEkgd291bGQgZXhw
ZWN0IGl0IHRvIHdvcmsgYXMgZG9jdW1lbnRlZCByZWdhcmRsZXNzIG9mDQo+ID4gd2hpY2ggR2l0
IGNvbW1hbmQgaXMgdXNlZCB3aXRoIEdpdDo6Y29tbWFuZF9vbmVsaW5lKCkuDQo+IA0KPiBJIHRo
aW5rIGNvbW1hbmRfb25lbGluZSBpcyBleGFjdGx5IGxpa2UgInwgaGVhZCAtMSIgaW4gdGhpcyBj
YXNlLiBEb2luZw0KPiAiZ2l0IGNsb25lIHwgaGVhZCAtMSIgd291bGQgYWxzbyBmYWlsLCBhbmQg
c2hvdWxkIG5vdCBiZSB1c2VkLiBJbg0KPiBnZW5lcmFsLCB5b3UgZG8gbm90IHdhbnQgdG8gcHV0
IGEgbGltaXRpbmcgcGlwZSBvbiBhIGNvbW1hbmQgd2l0aCBzaWRlDQo+IGVmZmVjdHMgYmV5b25k
IG91dHB1dC4gVGhlIGRlc2lnbiBvZiB1bml4IHBpcGVzIGFuZCBTSUdQSVBFIGlzIHN1Y2ggdGhh
dA0KPiB5b3UgY2FuIGRvICJnZW5lcmF0ZV9vdXRwdXQgfCBoZWFkIiwgYW5kICJnZW5lcmF0ZV9v
dXRwdXQiIHdpbGwgZ2V0DQo+IFNJR1BJUEUgYW5kIGRpZSBhZnRlciByZWFsaXppbmcgdGhhdCBp
dHMgd3JpdGVyIG5vIGxvbmdlciBjYXJlcyBhYm91dA0KPiB0aGUgb3V0cHV0LiBCdXQgaWYgeW91
ciBjb21tYW5kIGlzIGRvaW5nIHNvbWV0aGluZyBiZXNpZGVzIG91dHB1dCwgdGhhdA0KPiBhc3N1
bXB0aW9uIGRvZXNuJ3QgaG9sZC4NCg0KQSB2ZXJ5IHZhbGlkIHBvaW50Lg0KDQo+IEFyZ3VhYmx5
LCAiZ2l0IGNsb25lIiBzaG91bGQgYmUgdGFraW5nIHRoZSBpbml0aWF0aXZlIHRvIGlnbm9yZSBT
SUdQSVBFDQo+IGl0c2VsZi4gIEl0cyBwcmltYXJ5IGZ1bmN0aW9uIGlzIG5vdCBvdXRwdXQsIGJ1
dCBkb2luZyB0aGUgY2xvbmUuIElmDQo+IG91dHB1dCBmYWlscywgd2Ugd291bGQgd2FudCB0byBj
b250aW51ZSB0aGUgY2xvbmUsIG5vdCBkaWUuDQo+IA0KPiBCeSB0aGUgd2F5LCBkaWQgeW91IGFj
dHVhbGx5IHdhbnQgdG8gY2FwdHVyZSB0aGUgc3Rkb3V0IG9mIGdpdC1jbG9uZSwgb3INCj4gd2Vy
ZSB5b3UganVzdCB0cnlpbmcgdG8gc3VwcHJlc3MgaXQ/IEJlY2F1c2UgdGhlIGV2ZW50dWFsIHBh
dGNoIEkgcG9zdGVkDQo+IHNlbmRzIGl0IHRvIHN0ZGVyciwgdW5kZXIgdGhlIGFzc3VtcHRpb24g
dGhhdCB3aGF0IHVzZWQgdG8gZ28gdG8gc3Rkb3V0DQo+IHNob3VsZCBub3QgYmUgY2FwdHVyZWQg
YW5kIHBhcnNlZCAoYmVjYXVzZSBpdCBpcyBsb2NhbGl6ZWQgYW5kIHN1YmplY3QNCj4gdG8gY2hh
bmdlKS4NCg0KTm8sIHdlIHdlcmUgbm90IHJlYWxseSBpbnRlcmVzdGVkIGluIHRoZSBvdXRwdXQg
dG8gc3Rkb3V0ICh3aGljaCBpcyANCndoeSB0aGUgcmV0dXJuIHZhbHVlIGZyb20gR2l0Ojpjb21t
YW5kX29uZWxpbmUoKSB3YXMgaWdub3JlZCkuDQoNCj4gPiBIb3dldmVyLCB3aGF0IHN1cnByaXNl
ZCBtZSBtb3N0IHdhcyB0aGF0IGdpdCBjbG9uZSBmYWlsZWQgc2lsZW50bHkNCj4gPiB3aGVuIGl0
IGdvdCBhIGJyb2tlbiBwaXBlLg0KPiANCj4gSXQncyBub3QgImdpdCBjbG9uZSIgdGhhdCBpcyBk
b2luZyB0aGlzLCBJIHRoaW5rLCBidXQgcmF0aGVyIHRoZSBkZXNpZ24NCj4gb2YgY29tbWFuZF9v
bmVsaW5lLiBJZiBJIGRvOg0KPiANCj4gICAoc2xlZXAgMTsgZ2l0IGNsb25lIC4uLjsgZWNobyA+
JjIgZXhpdD0kPykgfCBmYWxzZQ0KPiANCj4gdGhlbiBJIHNlZToNCj4gDQo+ICAgZXhpdD0xNDEN
Cj4gDQo+IFRoYXQgaXMsIGNsb25lIGRpZXMgZnJvbSBTSUdQSVBFIHRyeWluZyB0byB3cml0ZSAi
Q2xvbmluZyBpbnRvLi4uIi4gQnV0DQo+IGNvbW1hbmRfb25lbGluZSBpcyBzcGVjaWZpY2FsbHkg
ZGVzaWduZWQgdG8gaWdub3JlIFNJR1BJUEUgZGVhdGgsDQo+IGJlY2F1c2UgeW91IHdvdWxkIHdh
bnQgc29tZXRoaW5nIGxpa2U6DQo+IA0KPiAgIGNvbW1hbmRfb25lbGluZSgiZ2l0IiwgInJldi1s
aXN0IiwgIiRBLi4kQiIpOw0KPiANCj4gdG8gZ2l2ZSB5b3UgdGhlIGZpcnN0IGxpbmUsIGFuZCB0
aGVuIHlvdSBkbyBub3QgY2FyZSBpZiB0aGUgcmVzdCBvZiB0aGUNCj4gcmV2LWxpc3QgZGllcyBk
dWUgdG8gU0lHUElQRSAoaXQgaXMgYSBnb29kIHRoaW5nLCBiZWNhdXNlIGJ5IGNsb3NpbmcgdGhl
DQo+IHBpcGUgeW91IGFyZSB0ZWxsaW5nIGl0IHRoYXQgaXRzIG91dHB1dCBpcyBub3QgbmVlZGVk
KS4gSXQgbWF5IGJlIHRoYXQNCj4gdGhlIGRvY3VtZW50YXRpb24gZm9yIGNvbW1hbmRfb25lbGlu
ZSBjYW4gYmUgaW1wcm92ZWQgdG8gbWVudGlvbiB0aGlzDQo+IHN1YnRsZXR5Lg0KDQpPaywgYWxs
IG9mIGl0IG1ha2VzIHNlbnNlIG5vdy4gVGhhbmsgeW91IGZvciB0aGUgZXhwbGFuYXRpb24uDQpJ
IGhhdmUgY29ycmVjdGVkIG91ciBzY3JpcHQgc28gaXQgbm93IHdvcmtzIGNvcnJlY3RseSB3aXRo
IA0KZ2l0IDEuOC40IGFzIHdlbGwuDQoNCj4gLVBlZmYNCj4gLS0NCj4gVG8gdW5zdWJzY3JpYmUg
ZnJvbSB0aGlzIGxpc3Q6IHNlbmQgdGhlIGxpbmUgInVuc3Vic2NyaWJlIGdpdCIgaW4NCj4gdGhl
IGJvZHkgb2YgYSBtZXNzYWdlIHRvIG1ham9yZG9tb0B2Z2VyLmtlcm5lbC5vcmcNCj4gTW9yZSBt
YWpvcmRvbW8gaW5mbyBhdCAgaHR0cDovL3ZnZXIua2VybmVsLm9yZy9tYWpvcmRvbW8taW5mby5o
dG1sDQoNCi8vUGV0ZXINCg0K
