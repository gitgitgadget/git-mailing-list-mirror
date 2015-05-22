From: "McHenry, Matt" <mmchenry@carnegielearning.com>
Subject: RE: recovering from "unordered stage entries in index" error
Date: Fri, 22 May 2015 14:56:23 -0400
Message-ID: <D377A9280DB18546A2471214D5CBB0E9087568F47B@exchdb01>
References: <D377A9280DB18546A2471214D5CBB0E908599428C7@exchdb01>
 <CACsJy8AS-9Cv6V=OKTckpnqd6OGsmvRy17TLoikT4QkA0sRofg@mail.gmail.com>
 <xmqqwq01kh8r.fsf@gitster.dls.corp.google.com>
 <CACsJy8Bdx5tto0w1q7rZ1ORx8RmHZCEKPyBqYs37k=YvbO3kzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 22 20:58:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvs7S-0002Vr-RS
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 20:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757242AbbEVS40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 14:56:26 -0400
Received: from mail3.carnegielearning.com ([204.80.87.3]:27617 "EHLO
	mail3.carnegielearning.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757225AbbEVS4Z (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 May 2015 14:56:25 -0400
X-ASG-Debug-ID: 1432320984-0424f512db3e45d30001-QuoKaX
Received: from webmail.carnegielearning.com ([10.1.10.4]) by mail3.carnegielearning.com with ESMTP id VOj9c10VSk66CJam (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO); Fri, 22 May 2015 14:56:24 -0400 (EDT)
X-Barracuda-Envelope-From: mmchenry@carnegielearning.com
X-Barracuda-RBL-Trusted-Forwarder: 10.1.10.4
Received: from exchdb01.carnegielearning.com ([127.0.0.1]) by exchdb01
 ([127.0.0.1]) with mapi; Fri, 22 May 2015 14:56:23 -0400
Thread-Topic: recovering from "unordered stage entries in index" error
X-ASG-Orig-Subj: RE: recovering from "unordered stage entries in index" error
Thread-Index: AdCUJM+40SFZpJ+7TyiosuofsqgODgAmpVUA
In-Reply-To: <CACsJy8Bdx5tto0w1q7rZ1ORx8RmHZCEKPyBqYs37k=YvbO3kzA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
x-exclaimer-md-config: 4a2a7f2a-5ce0-45d8-a978-59e527d0c9d2
X-Barracuda-Connect: UNKNOWN[10.1.10.4]
X-Barracuda-Start-Time: 1432320984
X-Barracuda-Encrypted: AES128-SHA
X-Barracuda-URL: https://10.1.10.29:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at carnegielearning.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4987 1.0000 0.0000
X-Barracuda-Spam-Score: 0.50
X-Barracuda-Spam-Status: No, SCORE=0.50 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.19202
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.50 BSF_RULE7568M          Custom Rule 7568M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269748>

PiA+IElzbid0IHRoaXMgZmFpbHVyZSBjb21pbmcgZnJvbSBnaXQtc3ZuIHRoYXQgdHJpZXMgdG8g
d3JpdGUgb3V0IGENCj4gPiB0cmVlIGFmdGVyIGl0IHByZXBhcmVkIHdoYXRldmVyIGl0IHdhbnRz
IHRvIHJlY29yZCBpbiBpdHMgKHBvc3NpYmx5DQo+ID4gdGVtcG9yYXJ5KSBpbmRleD8gIEkgaGF2
ZSBhIGZlZWxpbmcgdGhhdCB0aGUgaW5kZXggaGVsZCBieSB0aGUgZW5kDQo+ID4gdXNlciBpcyBu
b3QgYnJva2VuLg0KPiANCj4gQWhoIHRoYXQgd291bGQgZXhwbGFpbiB3aHkgbHMtZmlsZXMgd29y
a3MuIFllcC4NCg0KCUkgY3JlYXRlZCBhIGNvcHkgb2YgdGhpcyByZXBvICsgd2MgdmlhIHJzeW5j
IGFuZCB0cmllZCBhIGNvdXBsZSBvZiB0aGluZ3MuICAnZ2l0IHN2biByZWJhc2UgLWwnIHdvcmtl
ZCBmaW5lLCBidXQgZGlkbid0IGZpeCB0aGUgZXJyb3IuICBOZXh0LCByZXNldDoNCg0KJCBnaXQg
c3ZuIGxvZyAtLWxpbWl0PTEgfCBncmVwIF5yDQpyMjMxNjU1IHwgYXZ1b25nIHwgMjAxNS0wNS0x
MCAxMDozMjoxNiAtMDQwMCAoU3VuLCAxMCBNYXkgMjAxNSkgfCAyIGxpbmVzDQoNCiQgZ2l0IHN2
biByZXNldCAtciAyMzE2NTUgLXANCnIyMzE2NTMgPSAxM2E3ZjZkNmEzZjNlNDRlZDFjODUyM2Ix
YTYzZDcyZmM0ZjBkZGI5IChyZWZzL3JlbW90ZXMvdHJ1bmspDQoNCiQgZ2l0IHN2biBmZXRjaA0K
ZmF0YWw6IHVub3JkZXJlZCBzdGFnZSBlbnRyaWVzIGluIGluZGV4DQp3cml0ZS10cmVlOiBjb21t
YW5kIHJldHVybmVkIGVycm9yOiAxMjgNCg0KCVNvIGl0IGRvZXNuJ3Qgc2VlbSB0byBiZSBzcGVj
aWZpYyB0byB0aGUgcmV2aXNpb24gYmVpbmcgZmV0Y2hlZC4gIEkgY291bGQgZG8gYSBtb3JlIGRy
YXN0aWMgJ2dpdCBzdm4gcmVzZXQnLCBidXQgYXMgeW91IGNhbiBzZWUgSSd2ZSBhbHJlYWR5IGZl
dGNoZWQgYSBsb3Qgb2YgcmV2cywgc28gSSdkIHJhdGhlciBhdm9pZCByZS1mZXRjaGluZyBpZiBw
b3NzaWJsZS4NCg0KCVRoYW5rcyBmb3IgeW91ciBoZWxwIHNvIGZhciAtLSBhbnkgb3RoZXIgaWRl
YXMgKG9yIHJlcXVlc3RzIGZvciBmdXJ0aGVyIGRlYnVnZ2luZyBpbmZvKSBhcmUgYXBwcmVjaWF0
ZWQhDQo=
