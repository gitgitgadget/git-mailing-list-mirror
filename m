Received: from mail02.ukr.de (mail02.ukr.de [193.175.194.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D78E3358DC
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.194.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905374; cv=none; b=CvYPw2n6HcvJHs39tXntoqUgfu+nb716Ye6ZuKQ6CyOpXzI4oCCyC/BXyAPj3xsyPH0OK3LYSylFKr1wkvBsS+2JnmR+KraSG5eJgJFfDkeTwCkPv843XEFW83szW4uJh6nLXeMLQEryiV9P7CIsos5iFCg9TwQvx3J/cbw8HTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905374; c=relaxed/simple;
	bh=LpKRKvTpBIuWTZNvSpRoXL18htJpdUoaSHDF62GZSmk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a6qaInjSYlHorIcMdMaZNx8mnngV/8B9sUqB+l7anZMc14l2GZnXTI4ndHv2VdTzVp0QKOblzKxpr4CwIG9kkY5D8PfaVB5pg2fp/NlsNod/qC/BcDob/lwDo/ZWeBdAImiL3l37VcpA7D5F9/CI15lz+eKXLwRyt42qmtQlG9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ukr.de; spf=pass smtp.mailfrom=ukr.de; arc=none smtp.client-ip=193.175.194.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ukr.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ukr.de
X-CSE-ConnectionGUID: 6IICeMr1RlWbFZYqCGExyg==
X-CSE-MsgGUID: lKSe0zqcS0C+6ZH5cNCKmw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="2191922"
X-IronPort-AV: E=Sophos;i="6.19,269,1754949600"; 
   d="scan'208";a="2191922"
Received: from unknown (HELO ukr-excmb05.ukr.local) ([172.24.2.105])
  by dmz-infcsg02.ukr.dmz with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 11:08:14 +0100
Received: from ukr-excmb07.ukr.local (172.24.2.107) by ukr-excmb05.ukr.local
 (172.24.2.105) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 31 Oct
 2025 11:08:14 +0100
Received: from ukr-excmb07.ukr.local ([fe80::4dee:3e0b:b33f:60ac]) by
 ukr-excmb07.ukr.local ([fe80::4dee:3e0b:b33f:60ac%8]) with mapi id
 15.02.2562.029; Fri, 31 Oct 2025 11:08:14 +0100
From: "Windl, Ulrich" <u.windl@ukr.de>
To: =?utf-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Junio C Hamano <gitster@pobox.com>, Phillip Wood
	<phillip.wood@dunelm.org.uk>
Subject: RE: [EXT] [PATCH v2 1/5] add-patch: improve help for options j, J, k,
 and K
Thread-Topic: [EXT] [PATCH v2 1/5] add-patch: improve help for options j, J,
 k, and K
Thread-Index: AQHcNhB5h92o3YVwSkaQ6QGQLAv9GLTcL7KA
Date: Fri, 31 Oct 2025 10:08:14 +0000
Message-ID: <697bf0301cd9459195bdd3cc79e517ae@ukr.de>
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
 <17ef29a7-5214-4729-82eb-92a2af33e465@web.de>
 <75b08ed6-4f0f-4ede-b84a-c2f1c3d15734@web.de>
In-Reply-To: <75b08ed6-4f0f-4ede-b84a-c2f1c3d15734@web.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-snts-smtp: 46C5B4D86B080B3ED60EE4CB21A79AF236FC3081106D5FC8EADFFA803769968B2000:8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkhDQoNClNvcnJ5IGZvciB0aGUgZGVsYXksIGJ1dCBJIHdhcyBvbiB2YWNhdGlvbiB3aXRob3V0
IGFjY2VzcyB0byB0aGlzIG1haWxib3guDQoNCkZvciB0aGUgcGF0Y2gNCmRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL2dpdC1hZGQuYWRvYyBiL0RvY3VtZW50YXRpb24vZ2l0LWFkZC5hZG9jDQpp
bmRleCBhZDYyOWM0NmM1Li4zMjY2Y2NmMTA1IDEwMDY0NA0KDQpJIGRvbid0IHNlZSBhbiBhY3R1
YWwgaW1wcm92ZW1lbnQsIGFuZCBJJ2QgcHJlZmVyIHRoZSBwcmV2aW91cyB2ZXJzaW9uIG9mIHRo
ZSBkb2MuDQpMaWt3aXNlIGZvcg0KZGlmZiAtLWdpdCBhL2FkZC1wYXRjaC5jIGIvYWRkLXBhdGNo
LmMNCmluZGV4IGIwMzg5YzVkNWIuLjkxMjI2NmEzZjggMTAwNjQ0DQoNCktpbmQgcmVnYXJkcywN
ClVscmljaCBXaW5kbA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJl
bsOpIFNjaGFyZmUgPGwucy5yQHdlYi5kZT4NCj4gU2VudDogU3VuZGF5LCBPY3RvYmVyIDUsIDIw
MjUgNTo1NSBQTQ0KPiBUbzogZ2l0QHZnZXIua2VybmVsLm9yZw0KPiBDYzogV2luZGwsIFVscmlj
aCA8dS53aW5kbEB1a3IuZGU+OyBKdW5pbyBDIEhhbWFubyA8Z2l0c3RlckBwb2JveC5jb20+Ow0K
PiBQaGlsbGlwIFdvb2QgPHBoaWxsaXAud29vZEBkdW5lbG0ub3JnLnVrPg0KPiBTdWJqZWN0OiBb
RVhUXSBbUEFUQ0ggdjIgMS81XSBhZGQtcGF0Y2g6IGltcHJvdmUgaGVscCBmb3Igb3B0aW9ucyBq
LCBKLCBrLCBhbmQNCj4gSw0KPiANCj4gU2ljaGVyaGVpdHMtSGlud2VpczogRGllc2UgRS1NYWls
IHd1cmRlIHZvbiBlaW5lciBQZXJzb24gYXXDn2VyaGFsYiBkZXMgVUtSDQo+IGdlc2VuZGV0LiBT
ZWllbiBTaWUgdm9yc2ljaHRpZyB2b3IgZ2Vmw6Rsc2NodGVuIEFic2VuZGVybiwgd2VubiBTaWUg
YXVmIExpbmtzDQo+IGtsaWNrZW4sIEFuaMOkbmdlIMO2ZmZuZW4gb2RlciB3ZWl0ZXJlIEFrdGlv
bmVuIGF1c2bDvGhyZW4sIGJldm9yIFNpZSBkaWUNCj4gRWNodGhlaXQgw7xiZXJwcsO8ZnQgaGFi
ZW4uDQo+IA0KPiBUaGUgb3B0aW9ucyBqLCBKLCBrLCBhbmQgSyBkb24ndCBhZmZlY3QgdGhlIHN0
YXR1cyBvZiB0aGUgY3VycmVudCBodW5rLg0KPiBUaGV5IGp1c3QgZ28gdG8gYSBkaWZmZXJlbnQg
b25lLiAgVGhpcyBpcyB0cnVlIHdoZXRoZXIgdGhlIGN1cnJlbnQgaHVuaw0KPiBpcyB1bmRlY2lk
ZWQgb3Igbm90LiAgQXZvaWQgbWlzdW5kZXJzdGFuZGluZyBieSBubyBsb25nZXIgbWVudGlvbmlu
Zw0KPiB0aGUgY3VycmVudCBodW5rIGV4cGxpY2l0bHkgaW4gdGhlaXIgaGVscCB0ZXh0cy4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IFJlbsOpIFNjaGFyZmUgPGwucy5yQHdlYi5kZT4NCj4gLS0tDQo+
ICBEb2N1bWVudGF0aW9uL2dpdC1hZGQuYWRvYyB8IDggKysrKy0tLS0NCj4gIGFkZC1wYXRjaC5j
ICAgICAgICAgICAgICAgIHwgOCArKysrLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2Vy
dGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9naXQtYWRkLmFkb2MgYi9Eb2N1bWVudGF0aW9uL2dpdC1hZGQuYWRvYw0KPiBpbmRleCBhZDYy
OWM0NmM1Li4zMjY2Y2NmMTA1IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2dpdC1hZGQu
YWRvYw0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2dpdC1hZGQuYWRvYw0KPiBAQCAtMzQyLDEwICsz
NDIsMTAgQEAgcGF0Y2g6Og0KPiAgICAgICAgIGQgLSBkbyBub3Qgc3RhZ2UgdGhpcyBodW5rIG9y
IGFueSBvZiB0aGUgbGF0ZXIgaHVua3MgaW4gdGhlIGZpbGUNCj4gICAgICAgICBnIC0gc2VsZWN0
IGEgaHVuayB0byBnbyB0bw0KPiAgICAgICAgIC8gLSBzZWFyY2ggZm9yIGEgaHVuayBtYXRjaGlu
ZyB0aGUgZ2l2ZW4gcmVnZXgNCj4gLSAgICAgICBqIC0gbGVhdmUgdGhpcyBodW5rIHVuZGVjaWRl
ZCwgc2VlIG5leHQgdW5kZWNpZGVkIGh1bmsNCj4gLSAgICAgICBKIC0gbGVhdmUgdGhpcyBodW5r
IHVuZGVjaWRlZCwgc2VlIG5leHQgaHVuaw0KPiAtICAgICAgIGsgLSBsZWF2ZSB0aGlzIGh1bmsg
dW5kZWNpZGVkLCBzZWUgcHJldmlvdXMgdW5kZWNpZGVkIGh1bmsNCj4gLSAgICAgICBLIC0gbGVh
dmUgdGhpcyBodW5rIHVuZGVjaWRlZCwgc2VlIHByZXZpb3VzIGh1bmsNCj4gKyAgICAgICBqIC0g
Z28gdG8gdGhlIG5leHQgdW5kZWNpZGVkIGh1bmsNCj4gKyAgICAgICBKIC0gZ28gdG8gdGhlIG5l
eHQgaHVuaw0KPiArICAgICAgIGsgLSBnbyB0byB0aGUgcHJldmlvdXMgdW5kZWNpZGVkIGh1bmsN
Cj4gKyAgICAgICBLIC0gZ28gdG8gdGhlIHByZXZpb3VzIGh1bmsNCj4gICAgICAgICBzIC0gc3Bs
aXQgdGhlIGN1cnJlbnQgaHVuayBpbnRvIHNtYWxsZXIgaHVua3MNCj4gICAgICAgICBlIC0gbWFu
dWFsbHkgZWRpdCB0aGUgY3VycmVudCBodW5rDQo+ICAgICAgICAgcCAtIHByaW50IHRoZSBjdXJy
ZW50IGh1bmsNCj4gZGlmZiAtLWdpdCBhL2FkZC1wYXRjaC5jIGIvYWRkLXBhdGNoLmMNCj4gaW5k
ZXggYjAzODljNWQ1Yi4uOTEyMjY2YTNmOCAxMDA2NDQNCj4gLS0tIGEvYWRkLXBhdGNoLmMNCj4g
KysrIGIvYWRkLXBhdGNoLmMNCj4gQEAgLTEzOTcsMTAgKzEzOTcsMTAgQEAgc3RhdGljIHNpemVf
dCBkaXNwbGF5X2h1bmtzKHN0cnVjdCBhZGRfcF9zdGF0ZQ0KPiAqcywNCj4gIH0NCj4gDQo+ICBz
dGF0aWMgY29uc3QgY2hhciBoZWxwX3BhdGNoX3JlbWFpbmRlcltdID0NCj4gLU5fKCJqIC0gbGVh
dmUgdGhpcyBodW5rIHVuZGVjaWRlZCwgc2VlIG5leHQgdW5kZWNpZGVkIGh1bmtcbiINCj4gLSAg
ICJKIC0gbGVhdmUgdGhpcyBodW5rIHVuZGVjaWRlZCwgc2VlIG5leHQgaHVua1xuIg0KPiAtICAg
ImsgLSBsZWF2ZSB0aGlzIGh1bmsgdW5kZWNpZGVkLCBzZWUgcHJldmlvdXMgdW5kZWNpZGVkIGh1
bmtcbiINCj4gLSAgICJLIC0gbGVhdmUgdGhpcyBodW5rIHVuZGVjaWRlZCwgc2VlIHByZXZpb3Vz
IGh1bmtcbiINCj4gK05fKCJqIC0gZ28gdG8gdGhlIG5leHQgdW5kZWNpZGVkIGh1bmtcbiINCj4g
KyAgICJKIC0gZ28gdG8gdGhlIG5leHQgaHVua1xuIg0KPiArICAgImsgLSBnbyB0byB0aGUgcHJl
dmlvdXMgdW5kZWNpZGVkIGh1bmtcbiINCj4gKyAgICJLIC0gZ28gdG8gdGhlIHByZXZpb3VzIGh1
bmtcbiINCj4gICAgICJnIC0gc2VsZWN0IGEgaHVuayB0byBnbyB0b1xuIg0KPiAgICAgIi8gLSBz
ZWFyY2ggZm9yIGEgaHVuayBtYXRjaGluZyB0aGUgZ2l2ZW4gcmVnZXhcbiINCj4gICAgICJzIC0g
c3BsaXQgdGhlIGN1cnJlbnQgaHVuayBpbnRvIHNtYWxsZXIgaHVua3NcbiINCj4gLS0NCj4gMi41
MS4wDQo=
