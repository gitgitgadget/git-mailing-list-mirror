Received: from mail101.atlas-elektronik.com (mail101.atlas-elektronik.com [194.156.172.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03953F9E8
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 12:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.156.172.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110321; cv=none; b=UiA5cq4kSM+LYHPC52GhGec4PaQiNmA8iO0s2PX+yMTyLC6D2PKsLAL8uROoqljs2F37kpd/7aSTK8DEsuKDq3jr/7yJb6TNAqCgInezBIAJsEwTfYcLuWv+PJYtP6nlDDjH+r7Frn7/ym4CwjiQ/MeX92rax3t06RWMhMBAKMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110321; c=relaxed/simple;
	bh=Evv9cjUOlTe6fDUekOb7rzxMyndSClluW+VDNWXWAI0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UjACJ+IxGFva/44LyCqCqZNXRy8HVW0TaQiRh3FYLpS3SQRC5ZFeWlQg9slG44kDD8NOktP80wzYlu5MGHpYT/buCf0TFIbYEd3uc1ORTWuTPO3m6BzwhBOi1/gwoiwM1/3kEvvzRTIlGx6gtUZzlKPhsjXSubGGaC0SdrYBOy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atlas-elektronik.com; spf=pass smtp.mailfrom=atlas-elektronik.com; arc=none smtp.client-ip=194.156.172.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atlas-elektronik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlas-elektronik.com
X-CSE-ConnectionGUID: pKQYh4YUTjSL4/ff9bBofA==
X-CSE-MsgGUID: AI3PExOATpGUBy1l9uqikw==
X-IPAS-Result: =?us-ascii?q?A2GuAACwd/1l/zfHxApaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYMygWGEVpFnA6AFDwEBAQEBAQEBAQcBAUQEAQGFBgIWh24nNwYOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQEBBgEBAQUBAQEBAQEGBAECAoEZhS9KhlMBAQEBA?=
 =?us-ascii?q?gEjEUUFBwQCAQgRBAEBAwImAgICLxUICAEBBAENBQiFNSOwdHqBMoEBhHiwJ?=
 =?us-ascii?q?IEaLgGIJQGBVoQDhFiCT4EVgyo+gUKCWXWDDoJGIgSCE4M3iGyPR4ceCSMof?=
 =?us-ascii?q?4EkBFoNBRYQHjcREBMNAwhuHQIxOgMFAwQyChIMCx8FVANDBg46CwMCGgUDA?=
 =?us-ascii?q?wSBLAUNGgIQGgYMJgMDEkkCEBQDOAMDBgMKMS5TQQxQA2QfMQk8DwwaAhsUD?=
 =?us-ascii?q?SQjAiw+AwkKEAIWAx0WBDARCQsmAyoGNgISDAYGBlwgFgkEJQMIBANSAyByE?=
 =?us-ascii?q?QMEGgQLB3aCAIE9BBNGAQ0DgTSKGwyDMymBTimEPwNEHUADCwdmPTUUGwgBH?=
 =?us-ascii?q?wEdfKYXPlEBgUNUAUSXBa5wB6VHLheXRJJrmF8goyKFEgIEAgQFAhaBeoIAc?=
 =?us-ascii?q?IM3UhkPVqE9eDsCBwEKAQEDCYhvgXoBAQ?=
IronPort-Data: A9a23:eyJzVqJWDnrddc+3FE+RsZQlxSXFcZb7ZxGr2PjKsXjdYENS0jAAz
 mVMCmmDbPjbMzb1eNF1Ptiy9hgEvZPdztBjQQForCE8RH9jl5HIVI+TRqvS04N+DSFioGZPt
 Zh2hgzodZhsJpP6jknzauCJQV5UjPjQHOKU5NbsY303HUk8Dn551XqPosZh6qZwm9+1HgiRj
 t37pszbKTeN1iV9Wo4uw/vrRChH4rKq51v0gnRkPaoX5ASEzSFPZH4iDfjZw0XQE9E88tGSG
 r6rIIGRpgvx4xorA9W5pbf3GmVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0MC+7vw60c+VZk
 72hg3AQpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn9IBDJyCAWlvVbD09NqbDklW1
 sUpKGw8UyyBvMbqh7y1G+NGgcoKeZyD0IM34hmMzBn1INYMGLbme/2Qo9ZE2D4rw81KEPXCf
 c0faDkpZxPFC/FNEg5PTstvwqHx1yi5LmAwRFG9/MLb50DI0AF/2b6rNtPYZdGiTNlRl13dq
 2bL/HjjBRcbN5qUzj/tHneE2rSVx3urBer+EpWR16VSrU2071ALJyA8RAK/8OSgi02hDoc3x
 0s8v3BGQbIJ3EOqUvHjUBCi5n2JpBgRX5xXCeJS1e2W4qbZ4wzAAG0cFmQHYcAivdRzSDgn1
 UOTmNXoBnpkt7j9pW+hy4p4ZAiaYUA9RVLurwdeJefZy7EPeL0Osy8=
IronPort-HdrOrdr: A9a23:6deoBamaB8+niTzZH94fwUWpwX/pDfNYimdD5ihNYBxZY6Wkfp
 iV7Y8mPR+dskdzZJhSo6H7BEDmewKqyXcV2/hkAV7MZniAhILFFuBfBM7ZskXd8k7Fh5hgPM
 VbAs5D4bTLZDAQ4amV3OD7KadY/DDtytHLuQ6q9QYIcegcUdAE0+4WMGamO3wzbjNrQbA+E5
 2R7NdGoT2PRVQ7B/7QOlA1G8L4i5nujpzJXT4qbiRL1CC+yRyFrIf9FhiTzlM/flp0sP8f2F
 mAvCDQ3OGItvG2zQKZ91a71eUepDKr8Ko/OCXFsLloFt015zzYGriIgNC5zUAISDvD0idarP
 Dc5xwie9lw72mUfnuwu3LWqnvdOGhC0Q6c9XaIxXD5p8j4WDZ/D9BOhY8xSGqr12Mw+Nsmyb
 lM1W6CrZZbCwjP9R6NkuT1aw==
X-Talos-CUID: =?us-ascii?q?9a23=3ASROWA2i+j3ianhYF0esptiW8KDJual7k/XeMEnK?=
 =?us-ascii?q?EC11NFPqbRw6a0qRqup87?=
X-Talos-MUID: 9a23:pyGX9QqzV40Ucpnq7vMezxhDb/9F84OHNFgirL8X4s3VKDVxOCjI2Q==
Received: from dehb1nmp02.atlas-elektronik.com ([10.196.199.55])
  by MGW101FE.atlas.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2024 13:24:05 +0100
Received: from mgw201partner.atlas.de ([10.206.101.60])
	by DEHB1NMP02.atlas-elektronik.com  with ESMTP id 42MCO5o1003172-42MCO5o3003172
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 13:24:05 +0100
X-CSE-ConnectionGUID: QB1thVdjTj+VQicSo+37ZA==
X-CSE-MsgGUID: KpUFwoQ0SSCDWqyc3oiGiw==
Received: from dehb1pex05.atlas.de ([10.248.64.142])
  by mgw201data.atlas.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2024 13:24:04 +0100
Received: from DEHB1PEX04.atlas.de (10.248.64.139) by DEHB1PEX05.atlas.de
 (10.248.64.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 22 Mar
 2024 13:24:04 +0100
Received: from DEHB1PEX04.atlas.de ([fe80::f72:53ae:3a42:3bb5]) by
 DEHB1PEX04.atlas.de ([fe80::f72:53ae:3a42:3bb5%5]) with mapi id
 15.02.1544.004; Fri, 22 Mar 2024 13:24:04 +0100
From: <stefan.naewe@atlas-elektronik.com>
To: <gitster@pobox.com>, <richard.kerry@eviden.com>
CC: <git@vger.kernel.org>
Subject: RE: Merge selected files or folders
Thread-Topic: Merge selected files or folders
Thread-Index: Adp7r8ohXguDylajRFeMb0SwZpAX+AACJB+dACbAWDA=
Date: Fri, 22 Mar 2024 12:24:04 +0000
Message-ID: <c3f144b20cef46de83f2282dd16a817f@atlas-elektronik.com>
References: <PA4PR07MB7406FAC1F8C00E29979FCFF59E322@PA4PR07MB7406.eurprd07.prod.outlook.com>
 <xmqqbk778oeb.fsf@gitster.g>
In-Reply-To: <xmqqbk778oeb.fsf@gitster.g>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-bjprotectivemarking: <?xml version="1.0" encoding="us-ascii"?><sisl
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsd="http://www.w3.org/2001/XMLSchema" sislVersion="0"
 policy="1474dc32-5c20-42f5-ae16-31584b33af28" origin="userSelected"
 xmlns="http://www.boldonjames.com/2008/01/sie/internal/label"><element
 uid="92b19d4d-09b6-433b-88f8-352dd5b3c937" value="" /><element
 uid="690e14d9-e77b-4e35-9e0a-efe93554201d" value="" /></sisl>
dlp-product: dlpe-windows
dlp-version: 11.10.101.3
dlp-reaction: no-action
x-bromium-msgid: 451df326-8915-47da-961a-50729deae3ea
x-bj-tkms-isms: Offen
x-c2processedorg: 8e578ea2-b414-4638-aa54-659db1be7428
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 10.206.101.60
X-FE-Policy-ID: 1:1:17:SYSTEM

Q2xhc3NpZmljYXRpb27CoC3CoElTTVM6wqBPZmZlbsKgfMKgVlM6wqBPRkZFTg0KDQoNCg0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKdW5pbyBDIEhhbWFubyA8Z2l0c3Rl
ckBwb2JveC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAyMSwgMjAyNCA2OjUxIFBNDQo+
IFRvOiBSaWNoYXJkIEtlcnJ5IDxyaWNoYXJkLmtlcnJ5QGV2aWRlbi5jb20+DQo+IENjOiBnaXRA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBNZXJnZSBzZWxlY3RlZCBmaWxlcyBvciBm
b2xkZXJzDQo+IA0KPiBSaWNoYXJkIEtlcnJ5IDxyaWNoYXJkLmtlcnJ5QGV2aWRlbi5jb20+IHdy
aXRlczoNCj4gDQo+ID4gSSdkIGxpa2UgdG8gbWVyZ2Ugb25seSBjZXJ0YWluIGZpbGVzLCBvciBm
b2xkZXJzLCBmcm9tIGFub3RoZXIgYnJhbmNoLg0KPiA+IFdoYXQgY29tbWFuZCBvciBvcHRpb25z
IHNob3VsZCBJIGJlIGxvb2tpbmcgYXQgdG8gZ2V0IHRoaXMgZG9uZT8NCj4gDQo+IElmIHlvdSBh
cmUgdXNpbmcgdGhlIHZlcmIgIm1lcmdlIiBpbiB0aGUgd2F5IEdpdCB1c2VzLCB0aGVuIHRoZXJl
IGlzDQo+ICpubyogb3B0aW9uIHRvIGRvIHNvIGFuZCB0aGF0IGlzIHZlcnkgbXVjaCBkZWxpYmVy
YXRlLCBhcyBhbGxvd2luZyBzdWNoIGEgb3BlcmF0aW9uDQo+IHdpbGwgYnJlYWsgeW91ciBoaXN0
b3J5Lg0KPiANCj4gQSAibWVyZ2UiIGNvbW1pdCBpbiBHaXQgcmVjb3JkcyB0aGUgZmFjdCB0aGF0
ICphbGwqIGNoYW5nZXMgdGhhdCB3ZXJlIGRvbmUgaW4gZWFjaA0KPiBwYXJlbnQgc2luY2UgdGhl
IG1lcmdlZCBicmFuY2hlcyBkaXZlcmdlZCBoYXZlIGJlZW4gY29uc2lkZXJlZCBhbmQgdGhlIHRy
ZWUNCj4gcmVjb3JkZWQgYnkgdGhlIG1lcmdlIGNvbW1pdCBpcyB0aGUgcmVzdWx0LiAgSGVuY2Us
IGlmIHlvdSBsYXRlciBjaGFuZ2UgeW91ciBtaW5kDQo+IGFuZCAibWVyZ2UiIG90aGVyIGNoYW5n
ZXMgZnJvbSB0aGUgc2FtZSBicmFuY2gsIGl0IHdpbGwgcmVzdWx0IGluIG5vIGNoYW5nZSBhdCBh
bGwsDQo+IGJ5IGRlZmluaXRpb24uDQo+IA0KPiBCdXQgaWYgeW91IGFyZSBwb3J0aW5nIHNvbWUg
Y2hhbmdlcyBtYWRlIG9uIGFub3RoZXIgYnJhbmNoIHRvIHRoZSBjdXJyZW50DQo+IGJyYW5jaCwg
YW5kIHRoZW4gcGxhbm5pbmcgdG8gcmVjb3JkIHRoZSByZXN1bHQgYXMgYSByZWd1bGFyIHNpbmds
ZSBwYXJlbnQgY29tbWl0LA0KPiB0aGVuIHRoZXJlIGlzIG5vIGZ1bmRhbWVudGFsIHJlYXNvbiB0
byBmb3JiaWQgc3VjaCBhbiBvcGVyYXRpb24uICBJdCBpcyB3aGF0IGNoZXJyeS0NCj4gcGljayBv
dWdodCB0byBiZSBhYmxlIHRvIGRvLCBldmVuIHRob3VnaCBJIGRvIG5vdCB0aGluayBpdCBhY2Nl
cHRzIGEgcGF0aHNwZWMgdG8gbGltaXQNCj4gY3VycmVudGx5Lg0KPiANCj4gQXNzdW1pbmcgYSBo
aXN0b3J5IG9mIHRoaXMgc2hhcGU6DQo+IA0KPiAgICAgICB4LS0teC0tLVggKHRoYXQgb3RoZXIg
YnJhbmNoKQ0KPiAgICAgIC8NCj4gICAgIE8tLS1vLS0tby0tLW8tLS1ICShjdXJyZW50IGJyYW5j
aCkNCj4gDQo+IHN1Y2ggYSAiY2hlcnJ5LXBpY2siIHdvdWxkIGVzc2VudGlhbGx5IGJlIGFwcGx5
aW5nIGFsbCB0aGUgY2hhbmdlcyBsZWFkIHRvIFggc2luY2UNCj4gdGhlIGhpc3RvcmllcyBmb3Jr
ZWQgYXQgTyBvbiB0b3Agb2YgSDoNCj4gDQo+ICAgICAkIGdpdCBjaGVja291dCBIDQo+ICAgICAk
IE89JChnaXQgbWVyZ2UtYmFzZSBYIEgpDQo+ICAgICAkIGdpdCBkaWZmICRPIFggfCBnaXQgYXBw
bHkNCj4gICAgICQgZ2l0IGNvbW1pdCAtbSAicGlja2VkIGNoYW5nZXMgZnJvbSBicmFuY2ggWCIN
Cj4gDQo+IEFuZCBpZiB5b3Ugd2FudCB0byBsaW1pdCB0aGUgcGF0aHMgaW52b2x2ZWQgaW4gdGhl
IG9wZXJhdGlvbiwgdGhlICJnaXQgZGlmZiIgc3RlcCBjYW4gYmUNCj4gZ2l2ZW4gYSA8cGF0aHNw
ZWM+IHRvIGxpbWl0IHRoZSBjaGFuZ2VzIHRoYXQgYXJlIHBvcnRlZC4NCj4gDQo+ICAgICAkIGdp
dCBjaGVja291dCBIDQo+ICAgICAkIE89JChnaXQgbWVyZ2UtYmFzZSBYIEgpDQo+ICAgICAkIGdp
dCBkaWZmICRPIFggLS0gdGhpc2Rpci8gdGhhdC9maWxlIHwgZ2l0IGFwcGx5DQo+ICAgICAkIGdp
dCBjb21taXQgLW0gInBpY2tlZCBjaGFuZ2VzIGZyb20gYnJhbmNoIFgiDQoNCklzbid0IHRoYXQg
dGhlIHNhbWUgYXMgc2ltcGx5IGNoZWNraW5nIG91dCB0aGUgZmlsZXMvZm9sZGVycyBvZiAidGhh
dCBvdGhlciBicmFuY2giIGFuZCBjb21taXRpbmcgdGhlIHJlc3VsdCA/DQoNCiQgZ2l0IGNoZWNr
b3V0IFggLS0gdGhpcy9kaXIgdGhhdC9maWxlDQokIGdpdCBjb21taXQgLW0gInBpY2tlZCBjaGFu
Z2VzIGZyb20gYnJhbmNoIFgiDQoNCk9yIGFtIEkgbWlzc2luZyBzb21ldGhpbmcgPw0KDQo+IFRl
YWNoaW5nICJnaXQgY2hlcnJ5LXBpY2siIHRvIGFjY2VwdCBhIHBhdGhzcGVjIGFuZCBuYXRpdmVs
eSBwZXJmb3JtIHNvbWV0aGluZyBsaWtlDQo+IHRoZSBhYm92ZSBpcyBsZWZ0IGFzIGFuIGV4ZXJj
aXNlLg0KDQoNClRoYW5rcywNClN0ZWZhbg0K
