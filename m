Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8174C56202
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 14:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A248F22284
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 14:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgKNOfF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Nov 2020 09:35:05 -0500
Received: from mail2.kobil.com ([194.25.29.118]:7787 "EHLO mail2.kobil.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgKNOfD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Nov 2020 09:35:03 -0500
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Nov 2020 09:35:02 EST
Received: from KEX1.kobil.com (10.10.0.128) by KEX2.kobil.com (10.10.0.129)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.2.529.5; Sat, 14 Nov 2020
 15:20:00 +0100
Received: from KEX1.kobil.com ([fe80::2cb3:aee5:3cce:4e77]) by KEX1.kobil.com
 ([fe80::2cb3:aee5:3cce:4e77%6]) with mapi id 15.02.0529.005; Sat, 14 Nov 2020
 15:19:59 +0100
From:   Lukasz Niemier <Lukasz.Niemier@kobil.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Don Goodman-Wilson" <don@goodman-wilson.com>
Subject: Re: The master branch rename, and avoiding another v1.6.0 git-foo
 fiasco
Thread-Topic: The master branch rename, and avoiding another v1.6.0 git-foo
 fiasco
Thread-Index: AQHWupE8x1aOUYe5d0arrwPnk6hGXg==
Date:   Sat, 14 Nov 2020 14:19:59 +0000
Message-ID: <CBC2DBAA-A409-49CD-B932-AC82D3C20D55@kobil.com>
References: <CAMP44s3BJ3dGsLJ-6yA-Po459=+m826KD9an4+P3qOY1vkbxZg@mail.gmail.com>
 <20201113010107.GL6252@camp.crustytoothpaste.net>
 <CAMP44s1U1FevS7NrAYxvgVyzfR5tnD9-+BbPdw5bKnaNHkyD+A@mail.gmail.com>
 <20201113051408.GA3985404@mit.edu>
 <CAMP44s3AeESm7VBKbar0ir_Py35g99ZW6bNX_=AK4N=OFkcrdA@mail.gmail.com>
 <20201113145802.GB3985404@mit.edu>
In-Reply-To: <20201113145802.GB3985404@mit.edu>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-endpointsecurity-0xde81-ev: v:6.6.21.304, d:out, a:y, w:t, t:67,
 sv:1605357916, ts:1605363600
Content-Type: text/plain; charset="utf-8"
Content-ID: <074D582CE814BF48B3F410619F557891@kobil.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBPSywgZmluZS4gIFRoYXQgd2Fzbid0IGNsZWFyIGluIHlvdXIgZWFybGllciBtZXNzYWdlcy4g
IFNvIHRoaXMgaXMNCj4gKm5vdCogbGlrZSAyMDA4LCB3aGVyZSB3ZSBhcmUgYnJlYWtpbmcgd29y
a2Zsb3dzIG9yIGZpbmdlciBtYWNyb3Mgb2YNCj4gKmV4aXN0aW5nKiBnaXQgdXNlcnMuDQo+IA0K
PiBJbnN0ZWFkLCB3ZSBtaWdodCBiZSBjYXVzaW5nIGEgY2VydGFpbiBhbW91bnQgb2YgY29uZnVz
aW9uIHdpdGgNCj4gcmVzcGVjdCB0byAqbmV3KiB1c2VycywgZXNwZWNpYWxseSBpZiBzb21lIHBv
cnRpb24gb2YgdGhlbSBhcmUgdXNpbmcNCj4gYW4gb2xkZXIgdmVyc2lvbiBvZiBnaXQsIHdoZXJl
IHRoZSBkZWZhdWx0IGluaXRpYWwgYnJhbmNoIG5hbWUgaXMNCj4gIm1hc3RlciIsIG9yIGEgbmV3
ZXIgdmVyc2lvbiBvZiBnaXQsIHdoZXJlIHRoZSBkZWZhdWx0IGluaXRpYWwgYnJhbmNoDQo+IG5h
bWUgaXMgIm1haW4iLg0KDQpJIGFtIHByZXR0eSBtdWNoICoqZXhpc3RpbmcqKiBHaXQgdXNlciB3
aGVyZSBJIGFtIG1haW50YWluaW5nIGZldyByZXBvcw0KeWV0IEkgYW0gY29uc3RhbnRseSBjcmVh
dGluZyBuZXcgb25lcyBmb3IgYW5vdGhlciBwcm9qZWN0cyBvZiBtaW5lLiBTdWNoDQphYnJ1cHQg
Y2hhbmdlIGluIHRoZSBkZWZhdWx0IGJyYW5jaCBuYW1lLCB3aXRob3V0IGFueSB3YXJuaW5nLCB3
b3VsZCBiZQ0KdmVyeSBjb25mdXNpbmcgZm9yIG1lLiBOb3QgZXZlcnkgdXNlciBpcyB3b3JraW5n
IG9uIGEgc2luZ2xlIEdpdCByZXBvDQpmb3IgdGhlaXIgd2hvbGUgbGlmZS4NCg0KSSBmZWVsIHRo
YXQgb3VyIHZpZXcgb24gd2hvIGlzICoqbmV3Kiogb3IgKipleGlzdGluZyoqIHVzZXIgZGlmZmVy
cy4NCg0KLS0NCg0KxYF1a2FzeiBOaWVtaWVyDQpsdWthc3oubmllbWllckBrb2JpbC5jb20NCg0K
