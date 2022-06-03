Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A130C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 14:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245115AbiFCOhJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 10:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244966AbiFCOhH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 10:37:07 -0400
Received: from mail101.atlas-elektronik.com (mail101.atlas-elektronik.com [194.156.172.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA06140AD
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 07:37:04 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2EKAQDHG5pi/zfHxApaHQEBAQEJARIBBQUBQAmBNQUBC?=
 =?us-ascii?q?wGDIYFYhE+RDQOCI5pXgWgLAQEBAQEBAQEBBwEBQgQBAYUCAhaFMiY3Bg4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAwEBAQUBAQEBAQEGAwECAoEYhS9GhkwGIxFVAgEVD?=
 =?us-ascii?q?QImAgICMBUQAgQBEgiCda8BeoExGmeEbYURgREsgWaFWYckglCEfWmDQYNwg?=
 =?us-ascii?q?mUElngdOwNONBKBIXEBCAYGBwoFMgYCDBgUBAIDEBJTHQISDAocDlQZDA8DE?=
 =?us-ascii?q?gMRAQcCCxIIFSwIAwIDCAMCAy4CAxcJBwoDHQgKHBIQFAIEBg0eCwgDGR8tC?=
 =?us-ascii?q?QIEDgNDCAsKAxEEAxMYCxYIEAQGAwkvDSgLAwUPDwEGAwYCBQUBAyADFAMFJ?=
 =?us-ascii?q?wcDIQcLJg0NBCMdAwMFJgMCAhsHAgIDAgYXBgICcQooDQgECAQcHSUQBQIHM?=
 =?us-ascii?q?QUELwIeBAUGEQkCFgIGBAUCBAQWAgISCAIIJxsHFjYZAQVdBgsJIRwpEQUGF?=
 =?us-ascii?q?gMjcQVIDyk0ATggCAEfARuaCkxcHyozk0uDH6sKB6NNLhWDdYw+hisbA5Fel?=
 =?us-ascii?q?mggpmoCBAIEBQIWgXeCAHBQgmhRGZx/dTsCBgEKAQEDCZAUAQE?=
IronPort-Data: A9a23:x9522qDzOUUKwRVW/4Hhw5YqxClBgxIJ4kV8jS/XYbTApDh31DQBm
 zFNCmjQOa2OYGWnKt0kPdvioBsPu8WDnd5kTANkpHpgZkwRpJueD7x1DKtQ0wB+jyHnZBg6h
 ynLQoCYdKjYaFeC+k/1WlTGhSAkjv/WLlbEILeYfHg3H2eIcQ954f5Zs7dRbrVA3J7oWmthh
 fuo+5eFYAH9gGYuWo4pw/vrRC1H7ayaVAww4wRWicBj5DcyQFFMUfrzjYnoR5fJatE88tySH
 o4v/5nglo/txCrBP/v++lrNnu3mdZaJVeSGoiI+t6FPGXGurARqukowHKJ0hUu6F1xlNj2+o
 TlAncXYdOsnAkHDsMI0Sh1SFh1lAYsYpOLNf3Xuv/Wx6VKTJhMAw902ZK03FaE12swuJ0R2r
 aZeISwJZwvGiua7w66hTe9thYIoK8yD0IE34ykmlGCHS693ENaeHs0m5vcBtNs0rttSEPjXY
 YwfYDdwYTzJfxlGIRIaDJ89gP2vgHj8NTZfrTp5oIJuvzmOlFcvuFTrGNnyYfLRfstMonjGn
 3LK4VnmDDoIbMPKnFJp9Vrp3IcjhxjTV4MOPKO3++Qsg1CJwGEXThoMWjOGTeKR0xb4AoMBb
 RVFq2xz8MDe6XCWczU0ZDXgyFbsg/LWc4M4/zESgO1V9pfp3g==
IronPort-HdrOrdr: A9a23:zBaRjaEwisrlD91vpLqEN8eALOsnbusQ8zAXPhhKOHpom7+j5r
 mTdZMgpGLJYVcqKQsdcL+7Scu9qB/nmqKdpLNhWotKPzOWxFdATrsSiLcKqgeIc0aVm4JgPO
 VbAsxD4bbLbGSS+PyKgzVQZOxB/DDoys6VrNab4FsodAdua6txqydVYzzrbXGeDzM2fabRXK
 DsnfZ6mw==
Received: from unknown (HELO DEHB1NMP02.atlas-elektronik.com) ([10.196.199.55])
  by MGW101FE.atlas.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jun 2022 16:37:02 +0200
Received: from mgw201partner.atlas.de ([10.206.101.60])
        by DEHB1NMP02.atlas-elektronik.com  with ESMTP id 253Eb29O006561-253Eb29Q006561
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=CAFAIL)
        for <git@vger.kernel.org>; Fri, 3 Jun 2022 16:37:02 +0200
Received: from dehb1pex06.atlas.de ([10.248.64.143])
  by mgw201data.atlas.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jun 2022 16:37:02 +0200
Received: from DEHB1PEX04.atlas.de (10.248.64.139) by DEHB1PEX06.atlas.de
 (10.248.64.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Fri, 3 Jun 2022
 16:36:59 +0200
Received: from DEHB1PEX04.atlas.de ([fe80::e9bf:575b:6bb5:cc2f]) by
 DEHB1PEX04.atlas.de ([fe80::e9bf:575b:6bb5:cc2f%5]) with mapi id
 15.02.0986.015; Fri, 3 Jun 2022 16:36:59 +0200
From:   <stefan.naewe@atlas-elektronik.com>
To:     <git-ian@mnementh.co.uk>, <git@vger.kernel.org>
Subject: AW: BUG report: git-gui does not show commit message templates
Thread-Topic: BUG report: git-gui does not show commit message templates
Thread-Index: AQHYd1Sv1X+g8yIpvkmeOLl5kkhdGq09v5Dg
Date:   Fri, 3 Jun 2022 14:36:59 +0000
Message-ID: <dfec506780af46639ed67be364cd43cb@atlas-elektronik.com>
References: <870137b1-9134-5791-d9fa-4826687e0781@mnementh.co.uk>
In-Reply-To: <870137b1-9134-5791-d9fa-4826687e0781@mnementh.co.uk>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-FE-Policy-ID: 1:1:17:SYSTEM
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCj4gLS0tLS1VcnNwcsO8bmdsaWNoZSBOYWNocmljaHQtLS0tLQ0KPiBWb246IElhbiBNb2x0
b24gPGdpdC1pYW5AbW5lbWVudGguY28udWs+DQo+IEdlc2VuZGV0OiBGcmVpdGFnLCAzLiBKdW5p
IDIwMjIgMTU6NTgNCj4gQW46IGdpdEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IElhbiBNb2x0b24g
PGdpdC1pYW5AbW5lbWVudGguY28udWs+DQo+IEJldHJlZmY6IEJVRyByZXBvcnQ6IGdpdC1ndWkg
ZG9lcyBub3Qgc2hvdyBjb21taXQgbWVzc2FnZSB0ZW1wbGF0ZXMNCj4gDQo+IEhpLA0KPiANCj4g
UGxlYXNlIENDOiBtZSBpbiByZXBsaWVzLCBJJ20gbm90IGEgbGlzdCBtZW1iZXIuDQo+IA0KPiBJ
J3ZlIGp1c3QgZm91bmQgdGhhdCBnaXQtZ3VpIGRvZXMgbm90IHNob3cgY29tbWl0IHRlbXBsYXRl
cy4NCj4gDQo+IEkndmUgY2hlY2tlZCBhbmQgZm91bmQgdGhpcyBjb21taXQ6DQo+IDYyN2M4N2Y4
NGMxNTc4ODVkNTg3MTI1Y2YwYzczNTkxYTBlM2VlN2ENCj4gDQo+IHdoaWNoIHN1Z2dlc3RzIHRv
IG1lIHRoYXQgdGhlIGlzc3VlIHNob3VsZCBoYXZlIGJlZW4gZml4ZWQsIGJ1dCBpdCBjbGVhcmx5
IGhhcyBub3QuDQo+IA0KPiBJJ3ZlIHJlbW92ZWQgZ2l0LWd1aSBmcm9tIHRoZSBzeXN0ZW0gKFVi
dW50dSBwYWNrYWdlKSwgYW5kIGNvbXBpbGVkIHRoZSBsYXRlc3QNCj4gbWFpbmxpbmUgZ2l0LWd1
aSAoYXMgb2YgdG9kYXkpLCBhbmQgdGhlIHByb2JsZW0gcmVtYWlucy4NCg0KSXQgc2VlbXMgdGhh
dCBnaXQgZ3VpIHdhbnRzIHRvIGxvYWQgdGhlIHRlbXBsYXRlIGZpbGUgZnJvbSAob3IgcmVsYXRp
dmUgdG8pIHRoZSAuZ2l0IGRpcmVjdG9yeS4NCg0KDQo+IChJbiBmYWN0LCB3b3JzZSwgaXRzIG5v
dyBhdXRvLWZpbGxpbmcgaW4gbXkgc2lnbmVkLW9mZi1ieTogbGluZSByYXRoZXIgdGhhbiBsZWF2
aW5nIHRoZQ0KPiBjb21taXQgbWVzc2FnZSBibGFuayAob3IgcHJlZmVyYWJseSwgc2hvd2luZyB0
aGUgdGVtcGxhdGUpLg0KDQpTdGVmYW4NCg==
