From: "McHenry, Matt" <mmchenry@carnegielearning.com>
Subject: RE: recovering from "unordered stage entries in index" error
Date: Thu, 21 May 2015 09:19:11 -0400
Message-ID: <D377A9280DB18546A2471214D5CBB0E908599F7E02@exchdb01>
References: <D377A9280DB18546A2471214D5CBB0E908599428C7@exchdb01>
 <CACsJy8AS-9Cv6V=OKTckpnqd6OGsmvRy17TLoikT4QkA0sRofg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 15:19:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvQNh-0004yr-1e
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 15:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137AbbEUNTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 09:19:15 -0400
Received: from mail3.carnegielearning.com ([204.80.87.3]:53345 "EHLO
	mail3.carnegielearning.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753908AbbEUNTO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 May 2015 09:19:14 -0400
X-ASG-Debug-ID: 1432214352-07bc7c14083d84e30001-QuoKaX
Received: from webmail.carnegielearning.com ([10.1.10.4]) by mail3.carnegielearning.com with ESMTP id sDGEDtHapdIkg5Gu (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO); Thu, 21 May 2015 09:19:12 -0400 (EDT)
X-Barracuda-Envelope-From: mmchenry@carnegielearning.com
X-Barracuda-RBL-Trusted-Forwarder: 10.1.10.4
Received: from exchdb01.carnegielearning.com ([127.0.0.1]) by exchdb01
 ([127.0.0.1]) with mapi; Thu, 21 May 2015 09:19:12 -0400
Thread-Topic: recovering from "unordered stage entries in index" error
X-ASG-Orig-Subj: RE: recovering from "unordered stage entries in index" error
Thread-Index: AdCTrIVIek4UbbUnR0ad3hufiuU+WQAG2kGw
In-Reply-To: <CACsJy8AS-9Cv6V=OKTckpnqd6OGsmvRy17TLoikT4QkA0sRofg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
x-exclaimer-md-config: 4a2a7f2a-5ce0-45d8-a978-59e527d0c9d2
X-Barracuda-Connect: UNKNOWN[10.1.10.4]
X-Barracuda-Start-Time: 1432214352
X-Barracuda-Encrypted: AES128-SHA
X-Barracuda-URL: https://10.1.10.16:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at carnegielearning.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5000 1.0000 0.0100
X-Barracuda-Spam-Score: 0.51
X-Barracuda-Spam-Status: No, SCORE=0.51 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.19166
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.50 BSF_RULE7568M          Custom Rule 7568M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269590>

PiBUaGlzIG1lc3NhZ2UgY2FuIGJlIGltcHJvdmVkIHRvIHNob3cgd2hhdCBlbnRyaWVzIGhhdmUg
dGhpcyBwcm9ibGVtLg0KDQoJWWVzLCB0aGF0IHdvdWxkIGRlZmluaXRlbHkgYmUgYSBzdGFydC4g
IDopDQoNCj4gQnV0IHRoZW4gSSBkb24ndCBzZWUgYW55IHdheSB0byByZWNvdmVyIHRoZSBpbmRl
eCBtYW51YWxseS4gbHMtZmlsZXMNCj4gd2lsbCBkaWUgdG9vLiBQZXJoYXBzIHdlIHNob3VsZCBi
ZSBnZW50bGUgaW4gdGhpcyBjYXNlOiBzaG93IHdhcm5pbmdzDQoNCglBY3R1YWxseSwgbHMtZmls
ZXMgc3VjY2VlZHMgb24gbXkgYnJva2VuIGluZGV4Og0KDQokIGdpdCBscy1maWxlcyA+IC9kZXYv
bnVsbA0KJCBlY2hvICQ/DQowDQoNCglDb3VsZCBJIGRvIHNvbWV0aGluZyB3aXRoICdnaXQgcmVh
ZC10cmVlJyB0byBmb3JjZSBjcmVhdGlvbiBvZiBhIG5ldyB2YWxpZCBpbmRleD8gIEkgZ3Vlc3Mg
J2dpdCBjbG9uZScgd291bGQgd29yayB0b28sIGV4Y2VwdCB0aGF0IEkgaGF2ZSAnZ2l0IHN2bicg
bWV0YWRhdGEgdGhhdCBJJ2QgbmVlZCB0byBwcmVzZXJ2ZS4NCg0KPiBpbnN0ZWFkIG9mIGFib3J0
aW5nIHRoZSBwcm9ncmFtIGFuZCBpbnRlcm5hbGx5IHJlb3JkZXIgdGhlIGluZGV4LiBJDQo+IHRo
aW5rLCB1bmxlc3MgeW91IGhhdmUgbXVsdGlwbGUgZW50cmllcyB3aXRoIHRoZSBzYW1lIHN0YWdl
LCB0aGUNCj4gcmVjb3ZlcmVkIGluZGV4IHNob3VsZCBydW4gd2VsbC4gVGhlIGJyb2tlbiBpbmRl
eCBjb3VsZCBiZSByZW5hbWVkIHRvDQo+IGluZGV4LmJyb2tlbiBvciBzb21ldGhpbmcgZm9yIGxh
dGVyIGFuYWx5c2lzLCBvciB3ZSBmb3JiaWQgd3JpdGluZyB0aGUNCj4gcmVvcmRlcmVkIGluZGV4
IHRvIGRpc2suDQo+IA0KPiBIbW0/DQo+IA0KPiA+IHdyaXRlLXRyZWU6IGNvbW1hbmQgcmV0dXJu
ZWQgZXJyb3I6IDEyOA0KPiA+DQo+ID4gICAgICAgICAnZ2l0IHN0YXR1cycgc2hvd3MgYSBmZXcg
dW50cmFja2VkIGZpbGVzIGJ1dCBpcyBvdGhlcndpc2UgY2xlYW4uDQo+ID4NCj4gPiAgICAgICAg
IEl0IGxvb2tzIGxpa2UgdGhpcyBjaGVjayB3YXMgaW50cm9kdWNlZCBpbg0KPiAxNTk5OWQwYmU4
MTc5ZmI3YTJlNmVhZmI5MzFkMjVlZDY1ZGY1MGFhLCB3aXRoIHRoZSBzdW1tYXJ5DQo+ICJyZWFk
X2luZGV4X2Zyb20oKTogY2F0Y2ggb3V0IG9mIG9yZGVyIGVudHJpZXMgd2hlbiByZWFkaW5nIGFu
IGluZGV4IGZpbGUiDQo+IChmaXJzdCBhcHBlYXJpbmcgaW4gMi4yLjApLg0KPiA+DQo+ID4gICAg
ICAgICBNYWlsaW5nIGxpc3QgZGlzY3Vzc2lvbiBsb29rZWQgbGlrZSBpdCBpbXBsaWNhdGVkIHRo
aXJkLXBhcnR5DQo+IHRvb2xzLiAgSSBkb24ndCByZWNhbGwgcnVubmluZyBhbnkgb3RoZXIgdG9v
bHMgb24gdGhpcyByZXBvOyBpdCBkb2Vzbid0IGRvDQo+IG11Y2ggZGF5LXRvLWRheSBvdGhlciB0
aGFuIGEgbG9uZyBzZXJpZXMgb2YgJ2dpdCBzdm4gZmV0Y2gnZXMuICAoQnV0IGl0J3MNCj4gYmVl
biBhcm91bmQgZm9yIGEgY291cGxlIG9mIHllYXJzLCBzbyB3aG8ga25vd3MuKQ0KPiA+DQo+ID4g
ICAgICAgICBBdCBhbnkgcmF0ZSwgd2hhdCBjYW4gSSBkbyB0byByZWNvdmVyIGZyb20gdGhpcyBz
aXR1YXRpb24/ICBJDQo+IHRyaWVkIHRvIGxvY2F0ZSBhIHBhdGggd2l0aCBtdWx0aXBsZSBpbmRl
eCBlbnRyaWVzIGxpa2UgdGhpcywgYnV0IGdvdCBubw0KPiByZXN1bHRzOg0KPiA+DQo+ID4gJCBn
aXQgbHMtZmlsZXMgLXMgfCBjdXQgLWYgMi0xMDAgfCBzb3J0IHwgdW5pcSAtYyB8IGdyZXAgLXYg
J15bIFx0XSoxICcNCj4gPg0KPiA+ICAgICAgICAgKEkgb3JpZ2luYWxseSBwb3N0ZWQgb24gU08g
YXQNCj4gaHR0cDovL3N0YWNrb3ZlcmZsb3cuY29tL3F1ZXN0aW9ucy8zMDI2NDgyNi87IEknbGwg
dXBkYXRlIHRoYXQgd2l0aCBhbnkNCj4gc29sdXRpb25zIHRoYXQgY29tZSB1cCBoZXJlLCB0byBl
YXNlIGZ1dHVyZSBnb29nbGluZy4pDQo+ID4gLS0NCj4gPiBUbyB1bnN1YnNjcmliZSBmcm9tIHRo
aXMgbGlzdDogc2VuZCB0aGUgbGluZSAidW5zdWJzY3JpYmUgZ2l0IiBpbg0KPiA+IHRoZSBib2R5
IG9mIGEgbWVzc2FnZSB0byBtYWpvcmRvbW9Admdlci5rZXJuZWwub3JnDQo+ID4gTW9yZSBtYWpv
cmRvbW8gaW5mbyBhdCAgaHR0cDovL3ZnZXIua2VybmVsLm9yZy9tYWpvcmRvbW8taW5mby5odG1s
DQo+IA0KPiANCj4gDQo+IA0KPiAtLQ0KPiBEdXkNCg==
