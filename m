Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5B2C1FF40
	for <e@80x24.org>; Tue, 13 Dec 2016 09:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932675AbcLMJjH (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 04:39:07 -0500
Received: from mail96.atlas.de ([194.156.172.86]:21525 "EHLO mail96.atlas.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932301AbcLMJi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 04:38:26 -0500
X-IPAS-Result: =?us-ascii?q?A2COCAAswU9Y/wTKxApdGQEBAQEBAQEBAQEBBwEBAQEBgzc?=
 =?us-ascii?q?BAQEBAXkuWKRhh3WLAoQYK4V2AhqCKxABAgEBAQEBAQGBCkISAYQUAQEBAyMRR?=
 =?us-ascii?q?RACAQgYAgImAgICHwsGFAEQAgQBDAEFAgEBiE0DJasQgiiHNA2DUgEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQEBAQEBASCBC4cwCIJWgkiBUgkIATOCbYI/HgWIY4pghnM1hk+DEoMVS?=
 =?us-ascii?q?YV3iAmGM4hNgQ5Sg2WEDzaBA4YqcgGFTHKCLgEBAQ?=
Received: from scesrv01.atlas.de ([10.196.202.4])
  by MGW102FE.atlas.de with ESMTP/TLS/DHE-RSA-AES128-GCM-SHA256; 13 Dec 2016 10:38:23 +0100
Received: by SCESRV01.atlas.de (Postfix, from userid 600)
        id 3tdF4v1fH5z17mT0; Tue, 13 Dec 2016 09:37:27 +0000 (UTC)
Received: from MGW201PAR.atlas.de (unknown [10.206.101.60])
        by SCESRV01.atlas.de (Postfix) with ESMTPS id 3tdF3q1vYsz17mT4
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 09:37:27 +0000 (UTC)
Received: from msexsrv3.atlas.de ([10.200.102.58])
  by MGW201DAT.atlas.de with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Dec 2016 10:37:27 +0100
Received: from MSEXSRV5.atlas.de ([169.254.3.48]) by MSEXSRV3.atlas.de
 ([10.200.102.58]) with mapi id 14.03.0319.002; Tue, 13 Dec 2016 10:37:19
 +0100
From:   <stefan.naewe@atlas-elektronik.com>
To:     <judge.packham@gmail.com>, <git@vger.kernel.org>
CC:     <gitter.spiros@gmail.com>
Subject: Re: [RFC/PATCH] Makefile: add cppcheck target
Thread-Topic: [RFC/PATCH] Makefile: add cppcheck target
Thread-Index: AQHSVSJ4XFyJWbZIbkCyifw7P06BeKEFjJCAgAABcwA=
Date:   Tue, 13 Dec 2016 09:37:13 +0000
Message-ID: <ae32eb3f-72b4-0352-d035-701a142b452b@atlas-elektronik.com>
References: <20161213092225.15299-1-judge.packham@gmail.com>
 <CAFOYHZAZAH9Rt1o73cx2uFvtr4weL00J+Yktei3h2GN1JgbY=A@mail.gmail.com>
In-Reply-To: <CAFOYHZAZAH9Rt1o73cx2uFvtr4weL00J+Yktei3h2GN1JgbY=A@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.0
Content-Type: text/plain; charset="utf-8"
Content-ID: <7756E9AF6EE7B349A427EE8CE99FA523@atlas.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

QW0gMTMuMTIuMjAxNiB1bSAxMDozMiBzY2hyaWViIENocmlzIFBhY2toYW06DQo+IE9uIFR1ZSwg
RGVjIDEzLCAyMDE2IGF0IDEwOjIyIFBNLCBDaHJpcyBQYWNraGFtIDxqdWRnZS5wYWNraGFtQGdt
YWlsLmNvbT4gd3JvdGU6DQo+PiBBZGQgY3BwY2hlY2sgdGFyZ2V0IHRvIE1ha2VmaWxlLiBDcHBj
aGVjayBpcyBhIHN0YXRpYw0KPj4gYW5hbHlzaXMgdG9vbCBmb3IgQy9DKysgY29kZS4gQ3BwY2hl
Y2sgcHJpbWFyaWx5IGRldGVjdHMNCj4+IHRoZSB0eXBlcyBvZiBidWdzIHRoYXQgdGhlIGNvbXBp
bGVycyBub3JtYWxseSBkbyBub3QgZGV0ZWN0Lg0KPj4gSXQgaXMgYW4gdXNlZnVsIHRhcmdldCBm
b3IgZG9pbmcgUUEgYW5hbHlzaXMuDQo+Pg0KPj4gQmFzZWQtb24tcGF0Y2gtYnk6IEVsaWEgUGlu
dG8gPGdpdHRlci5zcGlyb3NAZ21haWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFj
a2hhbSA8anVkZ2UucGFja2hhbUBnbWFpbC5jb20+DQo+PiAtLS0NCj4+IEkgaGFkIGJlZW4gcGxh
eWluZyB3aXRoIGNwcGNoZWNrIGZvciBzb21lIG90aGVyIHByb2plY3RzIGFuZCBoYXBwZW5lZCB0
bw0KPj4gbm90aWNlIFsxXSBpbiB0aGUgYXJjaGl2ZXMuIFRoaXMgaXMgbXkgYXR0ZW1wdCB0byBy
ZXNvbHZlIHRoZSBmZWVkYmFjaw0KPj4gdGhhdCBKdW5pbyBtYWRlIGF0IHRoZSB0aW1lLg0KPj4N
Cj4+IEluIHRlcm1zIG9mIGVycm9ycyB0aGF0IGFyZSBhY3R1YWxseSByZXBvcnRlZCB0aGVyZSBh
cmUgb25seSBhIGZldw0KPj4NCj4+ICQgbWFrZSBjcHBjaGVjaw0KPj4gY3BwY2hlY2sgLS1mb3Jj
ZSAtLXF1aWV0IC0taW5saW5lLXN1cHByICAuDQo+PiBbY29tcGF0L25lZG1hbGxvYy9tYWxsb2Mu
Yy5oOjQwOTNdOiAoZXJyb3IpIFBvc3NpYmxlIG51bGwgcG9pbnRlciBkZXJlZmVyZW5jZTogc3AN
Cj4+IFtjb21wYXQvbmVkbWFsbG9jL21hbGxvYy5jLmg6NDEwNl06IChlcnJvcikgUG9zc2libGUg
bnVsbCBwb2ludGVyIGRlcmVmZXJlbmNlOiBzcA0KPj4gW2NvbXBhdC9uZWRtYWxsb2MvbmVkbWFs
bG9jLmM6NTUxXTogKGVycm9yKSBFeHByZXNzaW9uICcqKCZwLm15Y2FjaGUpPVRsc0FsbG9jKCks
VExTX09VVF9PRl9JTkRFWEVTPT0qKCZwLm15Y2FjaGUpJyBkZXBlbmRzIG9uIG9yZGVyIG9mIGV2
YWx1YXRpb24gb2Ygc2lkZSBlZmZlY3RzDQo+PiBbY29tcGF0L3JlZ2V4L3JlZ2NvbXAuYzozMDg2
XTogKGVycm9yKSBNZW1vcnkgbGVhazogc2Jjc2V0DQo+PiBbY29tcGF0L3JlZ2V4L3JlZ2NvbXAu
YzozNjM0XTogKGVycm9yKSBNZW1vcnkgbGVhazogc2Jjc2V0DQo+PiBbY29tcGF0L3JlZ2V4L3Jl
Z2NvbXAuYzozMDg2XTogKGVycm9yKSBNZW1vcnkgbGVhazogbWJjc2V0DQo+PiBbY29tcGF0L3Jl
Z2V4L3JlZ2NvbXAuYzozNjM0XTogKGVycm9yKSBNZW1vcnkgbGVhazogbWJjc2V0DQo+PiBbY29t
cGF0L3JlZ2V4L3JlZ2NvbXAuYzoyODAyXTogKGVycm9yKSBVbmluaXRpYWxpemVkIHZhcmlhYmxl
OiB0YWJsZV9zaXplDQo+PiBbY29tcGF0L3JlZ2V4L3JlZ2NvbXAuYzoyODA1XTogKGVycm9yKSBV
bmluaXRpYWxpemVkIHZhcmlhYmxlOiB0YWJsZV9zaXplDQo+PiBbY29tcGF0L3JlZ2V4L3JlZ2Nv
bXAuYzo1MzJdOiAoZXJyb3IpIE1lbW9yeSBsZWFrOiBmYXN0bWFwDQo+PiBbdC90NDA1MS9hcHBl
bmRlZDEuYzozXTogKGVycm9yKSBJbnZhbGlkIG51bWJlciBvZiBjaGFyYWN0ZXIgJ3snIHdoZW4g
dGhlc2UgbWFjcm9zIGFyZSBkZWZpbmVkOiAnJy4NCj4+IFt0L3Q0MDUxL2FwcGVuZGVkMi5jOjM1
XTogKGVycm9yKSBJbnZhbGlkIG51bWJlciBvZiBjaGFyYWN0ZXIgJ3snIHdoZW4gdGhlc2UgbWFj
cm9zIGFyZSBkZWZpbmVkOiAnJy4NCj4+DQo+PiBUaGUgbGFzdCAyIGFyZSBqdXN0IGZhbHNlIHBv
c2l0aXZlcyBmcm9tIHRlc3QgZGF0YS4gSSBoYXZlbid0IGxvb2tlZA0KPj4gaW50byBhbnkgb2Yg
dGhlIG90aGVycy4NCj4+DQo+PiBJJ3ZlIGFsc28gcHJvdmlzaW9uZWQgZm9yIGVuYWJsaW5nIGV4
dHJhIGNoZWNrcyBieSBwYXNzaW5nIENQUENIRUNLX0FERA0KPj4gaW4gdGhlIG1ha2UgaW52b2Nh
dGlvbi4NCj4+DQo+PiAkIG1ha2UgY3BwY2hlY2sgQ1BQQ0hFQ0tfQUREPS0tZW5hYmxlPWFsbA0K
Pj4gLi4uIGxvdHMgb2Ygb3V0cHV0DQo+Pg0KPj4gWzFdIC0gaHR0cDovL3B1YmxpYy1pbmJveC5v
cmcvZ2l0LzEzOTA5OTMzNzEtMjQzMS0xLWdpdC1zZW5kLWVtYWlsLWdpdHRlci5zcGlyb3NAZ21h
aWwuY29tLyN0DQo+Pg0KPj4gIE1ha2VmaWxlIHwgNCArKysrDQo+PiAgMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9NYWtlZmlsZSBiL01ha2VmaWxl
DQo+PiBpbmRleCBmNTNmY2M5MGQuLjhiNTk3NmQ4OCAxMDA2NDQNCj4+IC0tLSBhL01ha2VmaWxl
DQo+PiArKysgYi9NYWtlZmlsZQ0KPj4gQEAgLTI2MzUsMyArMjYzNSw3IEBAIGNvdmVyX2RiOiBj
b3ZlcmFnZS1yZXBvcnQNCj4+ICBjb3Zlcl9kYl9odG1sOiBjb3Zlcl9kYg0KPj4gICAgICAgICBj
b3ZlciAtcmVwb3J0IGh0bWwgLW91dHB1dGRpciBjb3Zlcl9kYl9odG1sIGNvdmVyX2RiDQo+Pg0K
Pj4gKy5QSE9OWTogY3BwY2hlY2sNCj4+ICsNCj4+ICtjcHBjaGVjazoNCj4+ICsgICAgICAgY3Bw
Y2hlY2sgLS1mb3JjZSAtLXF1aWV0IC0taW5saW5lLXN1cHByICQoQ1BQQ0hFQ0tfQUREKSAuDQo+
IA0KPiBJZiBJJ20gcGVybWl0dGVkIGEgbGl0dGxlIEdOVSBtYWtlLWlzbSB0aGUgZm9sbG93aW5n
IG1pZ2h0IG1ha2UNCj4gQ1BQQ0hFQ0tfQUREIGEgYml0IG1vcmUgdXNhYmxlDQo+IA0KPiArICAg
ICAgIGNwcGNoZWNrIC0tZm9yY2UgLS1xdWlldCAtLWlubGluZS1zdXBwciAkKGlmDQo+ICQoQ1BQ
Q0hFQ0tfQUREKSwtLWVuYWJsZT0kKENQUENIRUNLX0FERCkpIC4NCj4gDQo+IFdoaWNoIHdvdWxk
IHRha2UgdXMgZnJvbQ0KPiANCj4gJCBtYWtlIGNwcGNoZWNrIENQUENIRUNLX0FERD0tLWVuYWJs
ZT1hbGwNCj4gDQo+IHRvDQo+IA0KPiAkIG1ha2UgY3BwY2hlY2sgQ1BQQ0hFQ0tfQUREPWFsbA0K
DQpIaGhtbW0uLi4uYnV0IHRoaXMgYWxsb3dzIGZvciBvbmx5IHNwZWNpZnlpbmcgb3B0aW9ucyB0
byAnLS1lbmFibGUnLg0KVGhlIG90aGVyIHZlcnNpb24gaXMgbXVjaCBtb3JlIGZsZXhpYmxlIChp
LmUuIGFsbG93cyBmb3Igb3RoZXIgY29tcGxldGUgb3B0aW9ucyBhcyB3ZWxsKS4NCg0KSnVzdCBt
eSAwLDAy4oKsDQoNClN0ZWZhbg0KLS0gDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQovZGV2L3JhbmRvbSBzYXlzOiBJJ2Qg
bG92ZSB0bywgYnV0IEkgcHJlZmVyIHRvIHJlbWFpbiBhbiBlbmlnbWEuDQpweXRob24gLWMgInBy
aW50ICc3Mzc0NjU2NjYxNmUyZTZlNjE2NTc3NjU0MDYxNzQ2YzYxNzMyZDY1NmM2NTZiNzQ3MjZm
NmU2OTZiMmU2MzZmNmQnLmRlY29kZSgnaGV4JykiIA0KR1BHIEtleSBmaW5nZXJwcmludCA9IDJE
RjUgRTAxQiAwOUMzIDc1MDEgQkNBOSAgOTY2NiA4MjlCIDQ5QzUgOTIyMSAyN0FG
