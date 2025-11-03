Received: from mail02.ukr.de (mail02.ukr.de [193.175.194.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1C43002CB
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 12:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.194.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173803; cv=none; b=d/ZOukiAsBr7slDvPucdUXBaQF9az0b6JZjTiHWJTgCmAPd67aGJ9SlH1aJqaz3oIXRN8oHkwk4kbCvD4IyJ2249a/CWLv+BCIL+6ma1L+iPNJXmGaCOITQcOrLPd6XYO1Ka5LViWLmYC4PewuXIWevkIDdD4Y1L4jlbfU3T+Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173803; c=relaxed/simple;
	bh=RyjBnkKw9TVckWicjLtefm3RNm7cUJzpxMWbbH/K/5Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aXVD3vMHM2W93UeGyRXH3icpC4tA9lL0ll/8sEFseRKHnUwpnvM7zwaYcCdGh/WHsJ7I6lgPglTTiY+PSqFBclBj1oqEuHPoRnFNBKyT0kkvAZVsERYIvU8i0oPYCuQS8KX5scEHGX03EvkKke4FxZ9lEU7E/PnNoqc2sULqyFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ukr.de; spf=pass smtp.mailfrom=ukr.de; arc=none smtp.client-ip=193.175.194.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ukr.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ukr.de
X-CSE-ConnectionGUID: +DuaQp5XRZG+wdCHAXuhNw==
X-CSE-MsgGUID: wLx+oBcERf66ZpjtpmHrNQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="2199675"
X-IronPort-AV: E=Sophos;i="6.19,276,1754949600"; 
   d="scan'208";a="2199675"
Received: from unknown (HELO ukr-excmb08.ukr.local) ([172.24.2.108])
  by dmz-infcsg02.ukr.dmz with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 13:43:11 +0100
Received: from ukr-excmb07.ukr.local (172.24.2.107) by ukr-excmb08.ukr.local
 (172.24.2.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 3 Nov
 2025 13:43:10 +0100
Received: from ukr-excmb07.ukr.local ([fe80::4dee:3e0b:b33f:60ac]) by
 ukr-excmb07.ukr.local ([fe80::4dee:3e0b:b33f:60ac%8]) with mapi id
 15.02.2562.029; Mon, 3 Nov 2025 13:43:10 +0100
From: "Windl, Ulrich" <u.windl@ukr.de>
To: Junio C Hamano <gitster@pobox.com>
CC: =?utf-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>, "git@vger.kernel.org"
	<git@vger.kernel.org>, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: RE: [EXT] Re: [PATCH v2 1/5] add-patch: improve help for options j,
 J, k, and K
Thread-Topic: [EXT] Re: [PATCH v2 1/5] add-patch: improve help for options j,
 J, k, and K
Thread-Index: AQHcSwgm8ACWbet+8E+E2C+0eK7iOLTg6EXQ
Date: Mon, 3 Nov 2025 12:43:10 +0000
Message-ID: <61fcb89b5843474693ea6d6c90609180@ukr.de>
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
	<17ef29a7-5214-4729-82eb-92a2af33e465@web.de>
	<75b08ed6-4f0f-4ede-b84a-c2f1c3d15734@web.de>
	<697bf0301cd9459195bdd3cc79e517ae@ukr.de> <xmqqjz0axj1i.fsf@gitster.g>
In-Reply-To: <xmqqjz0axj1i.fsf@gitster.g>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-snts-smtp: 13543EA88A796CE2F2E7920CF696A7FEAA91FB3610EC1C42A5EE47E4997678262000:8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T0ssDQoNCmZhaXIgZW5vdWdoOiBJIHRoaW5rIHRoZSBvcmlnaW5hbCB3b3JkaW5nIGlzIG1vcmUg
Y2xlYXIsIHNvIEkgZG9uJ3Qgc2VlIHRoZSBuZWVkIHRvIGNoYW5nZSBpdCBhdCBhbGwuDQpQb3Nz
aWJsZSBjb3JuZXIgY2FzZXMgZWNlcHRlZCwgZS5nLiB3aGV0aGVyICJuZXh0IiBjYW4gd3JhcCBh
dCB0aGUgZW5kIG9yIG5vdC4NCg0KS2luZCByZWdhcmRzLA0KVWxyaWNoIFdpbmRsDQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJA
cG9ib3guY29tPg0KPiBTZW50OiBTYXR1cmRheSwgTm92ZW1iZXIgMSwgMjAyNSA5OjE5IEFNDQo+
IFRvOiBXaW5kbCwgVWxyaWNoIDx1LndpbmRsQHVrci5kZT4NCj4gQ2M6IFJlbsOpIFNjaGFyZmUg
PGwucy5yQHdlYi5kZT47IGdpdEB2Z2VyLmtlcm5lbC5vcmc7IFBoaWxsaXAgV29vZA0KPiA8cGhp
bGxpcC53b29kQGR1bmVsbS5vcmcudWs+DQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggdjIg
MS81XSBhZGQtcGF0Y2g6IGltcHJvdmUgaGVscCBmb3Igb3B0aW9ucyBqLCBKLCBrLA0KPiBhbmQg
Sw0KPiANCj4gU2ljaGVyaGVpdHMtSGlud2VpczogRGllc2UgRS1NYWlsIHd1cmRlIHZvbiBlaW5l
ciBQZXJzb24gYXXDn2VyaGFsYiBkZXMgVUtSDQo+IGdlc2VuZGV0LiBTZWllbiBTaWUgdm9yc2lj
aHRpZyB2b3IgZ2Vmw6Rsc2NodGVuIEFic2VuZGVybiwgd2VubiBTaWUgYXVmIExpbmtzDQo+IGts
aWNrZW4sIEFuaMOkbmdlIMO2ZmZuZW4gb2RlciB3ZWl0ZXJlIEFrdGlvbmVuIGF1c2bDvGhyZW4s
IGJldm9yIFNpZSBkaWUNCj4gRWNodGhlaXQgw7xiZXJwcsO8ZnQgaGFiZW4uDQo+IA0KPiAiV2lu
ZGwsIFVscmljaCIgPHUud2luZGxAdWtyLmRlPiB3cml0ZXM6DQo+IA0KPiA+IEZvciB0aGUgcGF0
Y2gNCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9naXQtYWRkLmFkb2MgYi9Eb2N1bWVu
dGF0aW9uL2dpdC1hZGQuYWRvYw0KPiA+IGluZGV4IGFkNjI5YzQ2YzUuLjMyNjZjY2YxMDUgMTAw
NjQ0DQo+ID4NCj4gPiBJIGRvbid0IHNlZSBhbiBhY3R1YWwgaW1wcm92ZW1lbnQsIGFuZCBJJ2Qg
cHJlZmVyIHRoZSBwcmV2aW91cw0KPiA+IHZlcnNpb24gb2YgdGhlIGRvYy4NCj4gDQo+IFdlJ2Qg
cHJlZmVyIHRvIHNlZSBzb21ldGhpbmcgbW9yZSBjb25jcmV0ZSB0aGF0IHJlZnVzZXMgdGhlDQo+
IHJlYXNvbmluZyB0aGF0IGxlZCB0byB0aGUgY2hhbmdlLCB0aGFuIGEgc3ViamVjdGl2ZSAiSSBk
b24ndCBzZWUsDQo+IEknZCBwcmVmZXIiLg0KPiANCj4gQXQgbGVhc3QsIHRoZSBjb21taXQgbG9n
IG1lc3NnZSBnaXZlbiBieSAyYzNjYzQzZiAoYWRkLXBhdGNoOg0KPiBpbXByb3ZlIGhlbHAgZm9y
IG9wdGlvbnMgaiwgSiwgaywgYW5kIEssIDIwMjUtMTAtMDYpIGV4cGxhaW5zIHdoeQ0KPiB0aGUg
Y2hhbmdlIGlzIGFuIGltcHJvdmVtZW50LCBhbmQgSSBmb3VuZCBpdCBzZW5zaWJsZS4NCj4gKDxi
NTAzNDg1MS02NWJkLTQ5ZGEtYjI3MC00OGI2OGQ5MjEwZmZAd2ViLmRlPikNCj4gDQo+IFRoZSBv
bGQgZGVzY3JpcHRpb24gc2FpZCAnaicgbGVhdmVzIHRoaXMgaHVuayB1bmRlY2lkZWQgYW5kIGdv
ZXMgdG8NCj4gdGhlIG5leHQgdW5kZWNpZGVkIGh1bmssIGJ1dCBpdCBpcyBib3RoIHBvaW50bGVz
cyBhbmQgbWlzbGVhZGluZyB0bw0KPiBzYXkgJ2xlYXZlIHRoaXMgaHVuayB1bmRlY2lkZWQnLiAg
VW5saWtlICd5JyBvciAnbicsIHRoZSBtb3ZlbWVudA0KPiBvcHRpb25zICdqJywgJ2snIGFyZSBu
b3QgYWJvdXQgY2hhbmdpbmcgdGhlIHN0YXRlIG9mIHRoZSBjdXJyZW50DQo+IHRoaW5nIHdlIGFy
ZSBvbiAoc28gaXQgaXMgcG9pbnRsZXNzIHRvIHNheSAiTEVBVkUgaXQgdW5kZWNpZGVkIiksDQo+
IGFuZCBtb3JlIGltcG9ydGFudGx5LCB3aGVuIHdlIHNheSAnaicsIHRoZSBzdGF0ZSBvZiB0aGUg
Y3VycmVudA0KPiB0aGluZyB3ZSBhcmUgb24gbWF5IG5vdCBuZWNlc3NhcmlseSBiZSAndW5kZWNp
ZGVkJyAoc28gaXQgaXMNCj4gbWlzbGVhZGluZyB0byBzYXkgImxlYXZlIGl0IFVOREVDSURFRCIp
Lg0K
