Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15F0B20958
	for <e@80x24.org>; Wed, 29 Mar 2017 13:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754231AbdC2Ngq (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 09:36:46 -0400
Received: from mail96.atlas.de ([194.156.172.86]:7039 "EHLO mail96.atlas.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752770AbdC2Ngq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 09:36:46 -0400
X-IPAS-Result: =?us-ascii?q?A2AmBAAfuNtY/wXKxApdGQEBAQEBAQEBAQEBBwEBAQEBiF1?=
 =?us-ascii?q?Gm2GTP4QdhiICGoNiFAECAQEBAQEBAYEThRYCAQMMFxFFEAIBBgIaAiYCAgIqB?=
 =?us-ascii?q?hUQAgQBDAEHAQGaC51bgiaKSAEBAQEBAQEDAQEBAQEBAQEBH4ELh0iCaoRUF4J?=
 =?us-ascii?q?vgl8BBIkek0KdJYZei1KIGDaBJVmHLoorAQEB?=
Received: from scesrv02.atlas.de ([10.196.202.5])
  by MGW102FE.atlas.de with ESMTP/TLS/DHE-RSA-AES128-GCM-SHA256; 29 Mar 2017 15:36:42 +0200
Received: by SCESRV02.atlas.de (Postfix, from userid 600)
        id 3vtTLy4ccFz2yWQt; Wed, 29 Mar 2017 13:36:38 +0000 (UTC)
Received: from MGW201PAR.atlas.de (unknown [10.206.101.60])
        by SCESRV02.atlas.de (Postfix) with ESMTPS id 3vtTLt3Gvwz2yWQw
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 13:36:38 +0000 (UTC)
Received: from msexsrv3.atlas.de ([10.200.102.58])
  by MGW201DAT.atlas.de with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Mar 2017 15:36:38 +0200
Received: from MSEXSRV6.atlas.de ([169.254.4.156]) by MSEXSRV3.atlas.de
 ([10.200.102.58]) with mapi id 14.03.0319.002; Wed, 29 Mar 2017 15:36:38
 +0200
From:   <stefan.naewe@atlas-elektronik.com>
To:     <avarab@gmail.com>, <git@vger.kernel.org>
CC:     <gitster@pobox.com>, <peff@peff.net>, <noloader@gmail.com>
Subject: Re: [PATCH v2] perl: regenerate perl.mak if perl -V changes
Thread-Topic: [PATCH v2] perl: regenerate perl.mak if perl -V changes
Thread-Index: AQHSqJEx1K2LaYraR0mDaQgfAtTgOaGrsE8A
Date:   Wed, 29 Mar 2017 13:36:37 +0000
Message-ID: <39b203e9-c3a9-80c3-ec24-649e04ef5620@atlas-elektronik.com>
References: <20170329132924.31321-1-avarab@gmail.com>
 <20170329133359.5992-1-avarab@gmail.com>
In-Reply-To: <20170329133359.5992-1-avarab@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C3E27BE2E97EB428D8F9D2CBD0F7DF2@atlas.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

QW0gMjkuMDMuMjAxNyB1bSAxNTozMyBzY2hyaWViIMOGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29u
Og0KPiBDaGFuZ2UgdGhlIHBlcmwvcGVybC5tYWsgYnVpbGQgcHJvY2VzcyBzbyB0aGF0IHRoZSBm
aWxlIGlzIHJlLW1hZGUgaWYNCj4gdGhlIG91dHB1dCBvZiAicGVybCAtViIgY2hhbmdlcy4NCj4g
DQo+IEJlZm9yZSB0aGlzIGNoYW5nZSB1cGRhdGluZyBlLmcuIC91c3IvYmluL3BlcmwgdG8gYSBu
ZXcgbWFqb3IgdmVyc2lvbg0KPiB3b3VsZCBjYXVzZSB0aGUgbmV4dCAibWFrZSIgY29tbWFuZCB0
byBmYWlsLCBzaW5jZSBwZXJsLm1hayBoYXMNCj4gaGFyZGNvZGVkIHBhdGhzIHRvIHBlcmwgbGli
cmFyeSBwYXRocyByZXRyaWV2ZWQgZnJvbSBpdHMgZmlyc3QgcnVuLg0KPiANCj4gTm93IHRoZSBs
b2dpYyBhZGRlZCBpbiBjb21taXQgZWU5YmUwNjc3MCAoInBlcmw6IGRldGVjdCBuZXcgZmlsZXMg
aW4NCj4gTWFrZU1ha2VyIGJ1aWxkcyIsIDIwMTItMDctMjcpIGlzIGV4dGVuZGVkIHRvIHJlZ2Vu
ZXJhdGlvDQoNCnMvcmVnZW5lcmF0aW8vcmVnZW5lcmF0ZS8NCg0KPiBbLi4uXQ0KDQoNCi9TDQot
LSANCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCi9kZXYvcmFuZG9tIHNheXM6IEhFTFAhIEkgbmVlZCBhIHRhZ2xpbmUuIEhF
TFAhIE5vdCBqdXN0IGFueSB0YWdsaW5lLg0KcHl0aG9uIC1jICJwcmludCAnNzM3NDY1NjY2MTZl
MmU2ZTYxNjU3NzY1NDA2MTc0NmM2MTczMmQ2NTZjNjU2Yjc0NzI2ZjZlNjk2YjJlNjM2ZjZkJy5k
ZWNvZGUoJ2hleCcpIiANCkdQRyBLZXkgZmluZ2VycHJpbnQgPSAyREY1IEUwMUIgMDlDMyA3NTAx
IEJDQTkgIDk2NjYgODI5QiA0OUM1IDkyMjEgMjdBRg==
