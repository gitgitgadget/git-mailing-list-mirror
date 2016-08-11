Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 830531F859
	for <e@80x24.org>; Thu, 11 Aug 2016 08:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932761AbcHKI4M (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 04:56:12 -0400
Received: from mail95.atlas.de ([194.156.172.85]:44396 "EHLO mail95.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932244AbcHKI4K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 04:56:10 -0400
X-IPAS-Result: =?us-ascii?q?A2D9DwBBPaxX/wXKxApdHAEBhCdStx6EDIYdAhyCBBABAQE?=
 =?us-ascii?q?BAQEBgQRBEAGEDQEBBCMRRRACAQgYAgImAgICKgYVEAIEDQEFAgEBukyQPgEBA?=
 =?us-ascii?q?QEBAQEDAQEBAQEBAQEfgQGHIQiCTYRAFzWCNYJaAQSIJoVziyOQf4dmhXKGZII?=
 =?us-ascii?q?Gg0uDeDWEGW6FLYFYAQEB?=
Received: from scesrv02.atlas.de ([10.196.202.5])
  by MGW101FE.atlas.de with ESMTP/TLS/DHE-RSA-AES128-GCM-SHA256; 11 Aug 2016 10:56:07 +0200
Received: by SCESRV02.atlas.de (Postfix, from userid 600)
	id 3s921M37cJz2MGjW; Thu, 11 Aug 2016 08:55:10 +0000 (UTC)
Received: from MGW202PAR.atlas.de (unknown [10.206.101.61])
	by SCESRV02.atlas.de (Postfix) with ESMTPS id 3s920G3YFWz2MGjL
	for <git@vger.kernel.org>; Thu, 11 Aug 2016 08:55:10 +0000 (UTC)
Received: from webmail-seb.atlas.de (HELO MSEXSRV1.atlas.de) ([10.200.102.56])
  by MGW202DAT.atlas.de with ESMTP/TLS/AES128-SHA; 11 Aug 2016 10:55:10 +0200
Received: from MSEXSRV6.atlas.de ([169.254.4.101]) by MSEXSRV1.atlas.de
 ([10.200.102.56]) with mapi id 14.03.0301.000; Thu, 11 Aug 2016 10:55:11
 +0200
From:	<stefan.naewe@atlas-elektronik.com>
To:	<christian.couder@gmail.com>
CC:	<git@vger.kernel.org>, <gitster@pobox.com>, <peff@peff.net>,
	<avarab@gmail.com>, <karsten.blees@gmail.com>, <pclouds@gmail.com>,
	<sbeller@google.com>, <sunshine@sunshineco.com>,
	<ramsay@ramsayjones.plus.com>, <j6t@kdbg.org>, <l.s.r@web.de>,
	<chriscool@tuxfamily.org>
Subject: Re: [PATCH v10 01/40] apply: make some names more specific
Thread-Topic: [PATCH v10 01/40] apply: make some names more specific
Thread-Index: AQHR8bixxbEYMjPAdEOHGtt61J06pKBAlgIAgAK9MICAAAP1gA==
Date:	Thu, 11 Aug 2016 08:55:11 +0000
Message-ID: <7443d85c-d024-3907-534b-706dfc35c865@atlas-elektronik.com>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
 <20160808210337.5038-2-chriscool@tuxfamily.org>
 <50063bbb-aa5f-cf75-310e-f8305ef30d2d@atlas-elektronik.com>
 <CAP8UFD1kuriMbc4u89aPgQAjonRZiDH=6H7JjE_a_=tUnNSPaQ@mail.gmail.com>
In-Reply-To: <CAP8UFD1kuriMbc4u89aPgQAjonRZiDH=6H7JjE_a_=tUnNSPaQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D87DF74B05BDD419F31C8C1328EC56B@atlas.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

QW0gMTEuMDguMjAxNiB1bSAxMDo0MCBzY2hyaWViIENocmlzdGlhbiBDb3VkZXI6DQo+IE9uIFR1
ZSwgQXVnIDksIDIwMTYgYXQgNDo1MSBQTSwgIDxzdGVmYW4ubmFld2VAYXRsYXMtZWxla3Ryb25p
ay5jb20+IHdyb3RlOg0KPj4gQW0gMDguMDguMjAxNiB1bSAyMzowMiBzY2hyaWViIENocmlzdGlh
biBDb3VkZXI6DQo+Pj4gVG8gcHJlcGFyZSBmb3Igc29tZSBzdHJ1Y3RzIGFuZCBjb25zdGFudHMg
YmVpbmcgbW92ZWQgZnJvbQ0KPj4+IGJ1aWx0aW4vYXBwbHkuYyB0byBhcHBseS5oLCB3ZSBzaG91
bGQgZ2l2ZSB0aGVtIHNvbWUgbW9yZQ0KPj4+IHNwZWNpZmljIG5hbWVzIHRvIGF2b2lkIHBvc3Np
YmxlIG5hbWUgY29sbGlzaW9ucyBpbiB0aCBnbG9iYWwNCj4+DQo+PiBzL3RoL3RoZS8NCj4+DQo+
Pj4gbmFtZXNwYWNlLg0KPiANCj4gVGhhbmtzLiBJIHdpbGwgc2VuZCBhbiB1cGRhdGUgd2l0aCBv
bmx5IGEgbmV3IHZlcnNpb24gb2YgdGhpcyBwYXRjaA0KPiBhbmQgb2YgMjgvNDAuDQo+IA0KDQpU
aGVyZSdzIGFub3RoZXIgbG93ZXJjYXNlICdhcGknIGluIHBhdGNoIDQwDQoNClN0ZWZhbg0KLS0g
DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQovZGV2L3JhbmRvbSBzYXlzOiBUaXMgYmV0dGVyIHRvIGhhdmUgbG92ZWQgYW5k
IGxvc3QgdGhhbiBqdXN0IHRvIGhhdmUgbG9zdC4NCnB5dGhvbiAtYyAicHJpbnQgJzczNzQ2NTY2
NjE2ZTJlNmU2MTY1Nzc2NTQwNjE3NDZjNjE3MzJkNjU2YzY1NmI3NDcyNmY2ZTY5NmIyZTYzNmY2
ZCcuZGVjb2RlKCdoZXgnKSIgDQpHUEcgS2V5IGZpbmdlcnByaW50ID0gMkRGNSBFMDFCIDA5QzMg
NzUwMSBCQ0E5ICA5NjY2IDgyOUIgNDlDNSA5MjIxIDI3QUY=
