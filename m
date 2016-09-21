Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 773011F4F8
	for <e@80x24.org>; Wed, 21 Sep 2016 09:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932283AbcIUJcF (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 05:32:05 -0400
Received: from mail95.atlas.de ([194.156.172.85]:21273 "EHLO mail95.atlas.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751493AbcIUJcD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 05:32:03 -0400
X-IPAS-Result: =?us-ascii?q?A2DQAgBcU+JX/wTKxApeGwEBAQMBAQEJAQEBgzsBAQEBAXU?=
 =?us-ascii?q?qUo0znwCKNYIPggQmhT42AgICHIF+FAECAQEBAQEBAYEFhGEBAQEBAgEjEUUFC?=
 =?us-ascii?q?wIBCBUCAwImAgICHwsGFQgIAgQBDAEFAgEBiC0DDxauLokcDYMyAQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQEBAQEBAQEBFwWBBoctCIJQgkeBTTAXgm2CWgEEiDWRCjWGJ4ZGhGKHd?=
 =?us-ascii?q?IYKhwSBU0CDT4N8HoQBgThyBYQ6gi4BAQE?=
Received: from scesrv01.atlas.de ([10.196.202.4])
  by MGW101FE.atlas.de with ESMTP/TLS/DHE-RSA-AES128-GCM-SHA256; 21 Sep 2016 11:31:44 +0200
Received: by SCESRV01.atlas.de (Postfix, from userid 600)
        id 3sfDsX2XK2z17mSg; Wed, 21 Sep 2016 09:31:40 +0000 (UTC)
Received: from MGW201PAR.atlas.de (unknown [10.206.101.60])
        by SCESRV01.atlas.de (Postfix) with ESMTPS id 3sfDsS1tJFz17mSm
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 09:31:40 +0000 (UTC)
Received: from atlas-elektronik.com (HELO MSEXSRV1.atlas.de) ([10.200.102.56])
  by MGW201DAT.atlas.de with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 Sep 2016 11:31:40 +0200
Received: from MSEXSRV5.atlas.de ([169.254.3.46]) by MSEXSRV1.atlas.de
 ([10.200.102.56]) with mapi id 14.03.0301.000; Wed, 21 Sep 2016 11:31:40
 +0200
From:   <stefan.naewe@atlas-elektronik.com>
To:     <larsxschneider@gmail.com>, <git@vger.kernel.org>
CC:     <gitster@pobox.com>
Subject: Re: [PATCH v1] travis-ci: ask homebrew for the its path instead of
 hardcoding it
Thread-Topic: [PATCH v1] travis-ci: ask homebrew for the its path instead of
 hardcoding it
Thread-Index: AQHSE+SXXXhrCf54P02Q6FakyOAp8qCDjJcA
Date:   Wed, 21 Sep 2016 09:31:38 +0000
Message-ID: <83e3049c-34ea-4440-7b4d-061cb98ba2dd@atlas-elektronik.com>
References: <20160921084518.13091-1-larsxschneider@gmail.com>
In-Reply-To: <20160921084518.13091-1-larsxschneider@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C9C1DBEA308C44AB8482D14A79D6484@atlas.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SW4gdGhlIFN1YmplY3Q6IHMvdGhlIC8vDQoNCkFtIDIxLjA5LjIwMTYgdW0gMTA6NDUgc2Nocmll
YiBsYXJzeHNjaG5laWRlckBnbWFpbC5jb206DQo+IEZyb206IExhcnMgU2NobmVpZGVyIDxsYXJz
eHNjaG5laWRlckBnbWFpbC5jb20+DQo+IA0KPiBUaGUgVHJhdmlzQ0kgbWFjT1MgYnVpbGQgaXMg
YnJva2VuIGJlY2F1c2UgaG9tZWJyZXcgKGEgbWFjT1MgZGVwZWRlbmN5DQoNCnMvZGVwZWRlbmN5
L2RlcGVuZGVuY3kvDQoNCj4gbWFuYWdlcikgY2hhbmdlZCBpdHMgaW50ZXJuYWwgZGlyZWN0b3J5
IHN0cnVjdHVyZSBbMV0uIFRoaXMgaXMgYSBwcm9ibGVtDQo+IGJlY2F1c2Ugd2UgbW9kaWZ5IHRo
ZSBQZXJmb3JjZSBkZXBlbmRlbmNpZXMgaW4gdGhlIGhvbWVicmV3IHJlcG9zaXRvcnkNCj4gYmVm
b3JlIGluc3RhbGxpbmcgdGhlbS4NCj4gDQo+IEZpeCBpdCBieSBhc2tpbmcgaG9tZWJyZXcgZm9y
IGl0cyBwYXRoIGluc3RlYWQgb2YgaGFyZGNvZGluZyBpdC4NCj4gDQo+IFsxXSBodHRwczovL2dp
dGh1Yi5jb20vSG9tZWJyZXcvYnJldy9jb21taXQvMGEwOWFlMzBmOGI2MTE3YWQ2OTliNGEwNDM5
MDEwNzM4OTg5YzU0Nw0KPiANCj4gU2lnbmVkLW9mZi1ieTogTGFycyBTY2huZWlkZXIgPGxhcnN4
c2NobmVpZGVyQGdtYWlsLmNvbT4NCj4gLS0tDQo+IA0KPiBIaSBKdW5pbywNCj4gDQo+IHRoZSBw
cm9ibGVtIGFmZmVjdHMgYWxsIGJyYW5jaGVzIChwdSwgbmV4dCwgbWFzdGVyLCBtYWludCk6DQo+
IGh0dHBzOi8vdHJhdmlzLWNpLm9yZy9naXQvZ2l0L2JyYW5jaGVzDQo+IA0KPiBJcyBpdCBwb3Nz
aWJsZSBmb3IgdGhpcyBmaXggdG8gZ3JhZHVhdGUgbW9yZSBxdWlja2x5Pw0KPiANCj4gVGhhbmtz
LA0KPiBMYXJzDQo+IA0KPiAgLnRyYXZpcy55bWwgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS8udHJhdmlz
LnltbCBiLy50cmF2aXMueW1sDQo+IGluZGV4IDQ3N2MzZDIuLjM3YTFlMWYgMTAwNjQ0DQo+IC0t
LSBhLy50cmF2aXMueW1sDQo+ICsrKyBiLy50cmF2aXMueW1sDQo+IEBAIC03OCw3ICs3OCw3IEBA
IGJlZm9yZV9pbnN0YWxsOg0KPiAgICAgICAgICBGT1JNVUxBPSQxDQo+ICAgICAgICAgIFNIQT0k
KGJyZXcgZmV0Y2ggLS1mb3JjZSAkRk9STVVMQSAyPiYxIHwgZ3JlcCBeU0hBMjU2OiB8IGN1dCAt
ZCAnICcgLWYgMikNCj4gICAgICAgICAgc2VkIC1FIC1pLmJhayAicy9zaGEyNTYgXCJbMC05YS1m
XXs2NH1cIi9zaGEyNTYgXCIkU0hBXCIvZyIgXA0KPiAtICAgICAgICAgIC91c3IvbG9jYWwvTGli
cmFyeS9UYXBzL2hvbWVicmV3L2hvbWVicmV3LWJpbmFyeS8kRk9STVVMQS5yYg0KPiArICAgICAg
ICAgICIkKGJyZXcgLS1yZXBvc2l0b3J5IGhvbWVicmV3L2hvbWVicmV3LWJpbmFyeSkvJEZPUk1V
TEEucmIiDQo+ICAgICAgICB9DQo+ICAgICAgICBicmV3IHVwZGF0ZSAtLXF1aWV0DQo+ICAgICAg
ICBicmV3IHRhcCBob21lYnJldy9iaW5hcnkgLS1xdWlldA0KPiAtLQ0KPiAyLjEwLjANCj4gDQo+
IA0KDQoNCi0tIA0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KL2Rldi9yYW5kb20gc2F5czogSWYgd2lubmluZyBpc24ndCBp
bXBvcnRhbnQgdGhlbiB3aHkga2VlcCBzY29yZT8NCnB5dGhvbiAtYyAicHJpbnQgJzczNzQ2NTY2
NjE2ZTJlNmU2MTY1Nzc2NTQwNjE3NDZjNjE3MzJkNjU2YzY1NmI3NDcyNmY2ZTY5NmIyZTYzNmY2
ZCcuZGVjb2RlKCdoZXgnKSIgDQpHUEcgS2V5IGZpbmdlcnByaW50ID0gMkRGNSBFMDFCIDA5QzMg
NzUwMSBCQ0E5ICA5NjY2IDgyOUIgNDlDNSA5MjIxIDI3QUY=
