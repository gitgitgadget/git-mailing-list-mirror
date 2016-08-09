Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8743F1F859
	for <e@80x24.org>; Tue,  9 Aug 2016 15:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbcHIPFK (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 11:05:10 -0400
Received: from mail96.atlas.de ([194.156.172.86]:44010 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752111AbcHIPFH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 11:05:07 -0400
X-IPAS-Result: =?us-ascii?q?A2AwDADN7alX/wXKxApdHAEBhCdStxWEDIYdAhyBahABAQE?=
 =?us-ascii?q?BAQEBgQRBEAGEDQEBAwEjBA1FBQsCAQgaAiYCAgIqBhUQAgQBDAEFAgEBiCWxS?=
 =?us-ascii?q?5AjAQEBAQEBAQECAQEBAQEBAQEfgQGHIYJVhEAXgmqCWgEEiCWFc4shmFuFcoh?=
 =?us-ascii?q?qg0qDeDWCMRyBTG6Fc4FaAQEB?=
Received: from scesrv02.atlas.de ([10.196.202.5])
  by MGW102FE.atlas.de with ESMTP/TLS/DHE-RSA-AES128-GCM-SHA256; 09 Aug 2016 16:51:29 +0200
Received: by SCESRV02.atlas.de (Postfix, from userid 600)
	id 3s7y0K656Vz2MGjS; Tue,  9 Aug 2016 14:51:21 +0000 (UTC)
Received: from MGW202PAR.atlas.de (unknown [10.206.101.61])
	by SCESRV02.atlas.de (Postfix) with ESMTPS id 3s7y094xV6z2MGjN
	for <git@vger.kernel.org>; Tue,  9 Aug 2016 14:51:21 +0000 (UTC)
Received: from msexsrv3.atlas.de ([10.200.102.58])
  by MGW202DAT.atlas.de with ESMTP/TLS/AES128-SHA; 09 Aug 2016 16:51:21 +0200
Received: from MSEXSRV6.atlas.de ([169.254.4.101]) by MSEXSRV3.atlas.de
 ([10.200.102.58]) with mapi id 14.03.0301.000; Tue, 9 Aug 2016 16:51:22 +0200
From:	<stefan.naewe@atlas-elektronik.com>
To:	<christian.couder@gmail.com>, <git@vger.kernel.org>
CC:	<gitster@pobox.com>, <peff@peff.net>, <avarab@gmail.com>,
	<karsten.blees@gmail.com>, <pclouds@gmail.com>,
	<sbeller@google.com>, <sunshine@sunshineco.com>,
	<ramsay@ramsayjones.plus.com>, <j6t@kdbg.org>, <l.s.r@web.de>,
	<chriscool@tuxfamily.org>
Subject: Re: [PATCH v10 01/40] apply: make some names more specific
Thread-Topic: [PATCH v10 01/40] apply: make some names more specific
Thread-Index: AQHR8bixxbEYMjPAdEOHGtt61J06pKBAlgIA
Date:	Tue, 9 Aug 2016 14:51:20 +0000
Message-ID: <50063bbb-aa5f-cf75-310e-f8305ef30d2d@atlas-elektronik.com>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
 <20160808210337.5038-2-chriscool@tuxfamily.org>
In-Reply-To: <20160808210337.5038-2-chriscool@tuxfamily.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
Content-Type: text/plain; charset="utf-8"
Content-ID: <0EB65E57128C6A41BB77690351517BC5@atlas.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

QW0gMDguMDguMjAxNiB1bSAyMzowMiBzY2hyaWViIENocmlzdGlhbiBDb3VkZXI6DQo+IFRvIHBy
ZXBhcmUgZm9yIHNvbWUgc3RydWN0cyBhbmQgY29uc3RhbnRzIGJlaW5nIG1vdmVkIGZyb20NCj4g
YnVpbHRpbi9hcHBseS5jIHRvIGFwcGx5LmgsIHdlIHNob3VsZCBnaXZlIHRoZW0gc29tZSBtb3Jl
DQo+IHNwZWNpZmljIG5hbWVzIHRvIGF2b2lkIHBvc3NpYmxlIG5hbWUgY29sbGlzaW9ucyBpbiB0
aCBnbG9iYWwNCg0Kcy90aC90aGUvDQoNCj4gbmFtZXNwYWNlLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQ2hyaXN0aWFuIENvdWRlciA8Y2hyaXNjb29sQHR1eGZhbWlseS5vcmc+DQo+IC0tLQ0KPiAg
YnVpbHRpbi9hcHBseS5jIHwgMjAgKysrKysrKysrKy0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxMCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9idWlsdGluL2FwcGx5LmMgYi9idWlsdGluL2FwcGx5LmMNCj4gaW5kZXggMWE0ODhmOS4uYWI4
ZjBiZCAxMDA2NDQNCj4gLS0tIGEvYnVpbHRpbi9hcHBseS5jDQo+ICsrKyBiL2J1aWx0aW4vYXBw
bHkuYw0KPiBAQCAtMjEsNyArMjEsNyBAQA0KPiAgI2luY2x1ZGUgImxsLW1lcmdlLmgiDQo+ICAj
aW5jbHVkZSAicmVyZXJlLmgiDQo+ICANCj4gLWVudW0gd3NfZXJyb3JfYWN0aW9uIHsNCj4gK2Vu
dW0gYXBwbHlfd3NfZXJyb3JfYWN0aW9uIHsNCj4gIAlub3dhcm5fd3NfZXJyb3IsDQo+ICAJd2Fy
bl9vbl93c19lcnJvciwNCj4gIAlkaWVfb25fd3NfZXJyb3IsDQo+IEBAIC0yOSw3ICsyOSw3IEBA
IGVudW0gd3NfZXJyb3JfYWN0aW9uIHsNCj4gIH07DQo+ICANCj4gIA0KPiAtZW51bSB3c19pZ25v
cmUgew0KPiArZW51bSBhcHBseV93c19pZ25vcmUgew0KPiAgCWlnbm9yZV93c19ub25lLA0KPiAg
CWlnbm9yZV93c19jaGFuZ2UNCj4gIH07DQo+IEBAIC00NSw4ICs0NSw4IEBAIGVudW0gd3NfaWdu
b3JlIHsNCj4gICAqIFNlZSBhbHNvICJzdHJ1Y3Qgc3RyaW5nX2xpc3Qgc3ltbGlua19jaGFuZ2Vz
IiBpbiAic3RydWN0DQo+ICAgKiBhcHBseV9zdGF0ZSIuDQo+ICAgKi8NCj4gLSNkZWZpbmUgU1lN
TElOS19HT0VTX0FXQVkgMDENCj4gLSNkZWZpbmUgU1lNTElOS19JTl9SRVNVTFQgMDINCj4gKyNk
ZWZpbmUgQVBQTFlfU1lNTElOS19HT0VTX0FXQVkgMDENCj4gKyNkZWZpbmUgQVBQTFlfU1lNTElO
S19JTl9SRVNVTFQgMDINCj4gIA0KPiAgc3RydWN0IGFwcGx5X3N0YXRlIHsNCj4gIAljb25zdCBj
aGFyICpwcmVmaXg7DQo+IEBAIC0xMTAsOCArMTEwLDggQEAgc3RydWN0IGFwcGx5X3N0YXRlIHsN
Cj4gIAlzdHJ1Y3Qgc3RyaW5nX2xpc3QgZm5fdGFibGU7DQo+ICANCj4gIAkvKiBUaGVzZSBjb250
cm9sIHdoaXRlc3BhY2UgZXJyb3JzICovDQo+IC0JZW51bSB3c19lcnJvcl9hY3Rpb24gd3NfZXJy
b3JfYWN0aW9uOw0KPiAtCWVudW0gd3NfaWdub3JlIHdzX2lnbm9yZV9hY3Rpb247DQo+ICsJZW51
bSBhcHBseV93c19lcnJvcl9hY3Rpb24gd3NfZXJyb3JfYWN0aW9uOw0KPiArCWVudW0gYXBwbHlf
d3NfaWdub3JlIHdzX2lnbm9yZV9hY3Rpb247DQo+ICAJY29uc3QgY2hhciAqd2hpdGVzcGFjZV9v
cHRpb247DQo+ICAJaW50IHdoaXRlc3BhY2VfZXJyb3I7DQo+ICAJaW50IHNxdWVsY2hfd2hpdGVz
cGFjZV9lcnJvcnM7DQo+IEBAIC0zNzUwLDExICszNzUwLDExIEBAIHN0YXRpYyB2b2lkIHByZXBh
cmVfc3ltbGlua19jaGFuZ2VzKHN0cnVjdCBhcHBseV9zdGF0ZSAqc3RhdGUsIHN0cnVjdCBwYXRj
aCAqcGF0DQo+ICAJCWlmICgocGF0Y2gtPm9sZF9uYW1lICYmIFNfSVNMTksocGF0Y2gtPm9sZF9t
b2RlKSkgJiYNCj4gIAkJICAgIChwYXRjaC0+aXNfcmVuYW1lIHx8IHBhdGNoLT5pc19kZWxldGUp
KQ0KPiAgCQkJLyogdGhlIHN5bWxpbmsgYXQgcGF0Y2gtPm9sZF9uYW1lIGlzIHJlbW92ZWQgKi8N
Cj4gLQkJCXJlZ2lzdGVyX3N5bWxpbmtfY2hhbmdlcyhzdGF0ZSwgcGF0Y2gtPm9sZF9uYW1lLCBT
WU1MSU5LX0dPRVNfQVdBWSk7DQo+ICsJCQlyZWdpc3Rlcl9zeW1saW5rX2NoYW5nZXMoc3RhdGUs
IHBhdGNoLT5vbGRfbmFtZSwgQVBQTFlfU1lNTElOS19HT0VTX0FXQVkpOw0KPiAgDQo+ICAJCWlm
IChwYXRjaC0+bmV3X25hbWUgJiYgU19JU0xOSyhwYXRjaC0+bmV3X21vZGUpKQ0KPiAgCQkJLyog
dGhlIHN5bWxpbmsgYXQgcGF0Y2gtPm5ld19uYW1lIGlzIGNyZWF0ZWQgb3IgcmVtYWlucyAqLw0K
PiAtCQkJcmVnaXN0ZXJfc3ltbGlua19jaGFuZ2VzKHN0YXRlLCBwYXRjaC0+bmV3X25hbWUsIFNZ
TUxJTktfSU5fUkVTVUxUKTsNCj4gKwkJCXJlZ2lzdGVyX3N5bWxpbmtfY2hhbmdlcyhzdGF0ZSwg
cGF0Y2gtPm5ld19uYW1lLCBBUFBMWV9TWU1MSU5LX0lOX1JFU1VMVCk7DQo+ICAJfQ0KPiAgfQ0K
PiAgDQo+IEBAIC0zNzY5LDkgKzM3NjksOSBAQCBzdGF0aWMgaW50IHBhdGhfaXNfYmV5b25kX3N5
bWxpbmtfMShzdHJ1Y3QgYXBwbHlfc3RhdGUgKnN0YXRlLCBzdHJ1Y3Qgc3RyYnVmICpuYQ0KPiAg
CQkJYnJlYWs7DQo+ICAJCW5hbWUtPmJ1ZltuYW1lLT5sZW5dID0gJ1wwJzsNCj4gIAkJY2hhbmdl
ID0gY2hlY2tfc3ltbGlua19jaGFuZ2VzKHN0YXRlLCBuYW1lLT5idWYpOw0KPiAtCQlpZiAoY2hh
bmdlICYgU1lNTElOS19JTl9SRVNVTFQpDQo+ICsJCWlmIChjaGFuZ2UgJiBBUFBMWV9TWU1MSU5L
X0lOX1JFU1VMVCkNCj4gIAkJCXJldHVybiAxOw0KPiAtCQlpZiAoY2hhbmdlICYgU1lNTElOS19H
T0VTX0FXQVkpDQo+ICsJCWlmIChjaGFuZ2UgJiBBUFBMWV9TWU1MSU5LX0dPRVNfQVdBWSkNCj4g
IAkJCS8qDQo+ICAJCQkgKiBUaGlzIGNhbm5vdCBiZSAicmV0dXJuIDAiLCBiZWNhdXNlIHdlIG1h
eQ0KPiAgCQkJICogc2VlIGEgbmV3IG9uZSBjcmVhdGVkIGF0IGEgaGlnaGVyIGxldmVsLg0KPiAN
Cg0KU3RlZmFuDQotLSANCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCi9kZXYvcmFuZG9tIHNheXM6IERvbid0IGJlIHNvIGh1
bWJsZSwgeW91J3JlIG5vdCB0aGF0IGdyZWF0LiAtR29sZGEgTWVpcg0KcHl0aG9uIC1jICJwcmlu
dCAnNzM3NDY1NjY2MTZlMmU2ZTYxNjU3NzY1NDA2MTc0NmM2MTczMmQ2NTZjNjU2Yjc0NzI2ZjZl
Njk2YjJlNjM2ZjZkJy5kZWNvZGUoJ2hleCcpIiANCkdQRyBLZXkgZmluZ2VycHJpbnQgPSAyREY1
IEUwMUIgMDlDMyA3NTAxIEJDQTkgIDk2NjYgODI5QiA0OUM1IDkyMjEgMjdBRg==
