Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0348D20195
	for <e@80x24.org>; Fri, 15 Jul 2016 16:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbcGOQt1 (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 12:49:27 -0400
Received: from hq194.ces.cvnt.net ([69.41.14.194]:28448 "EHLO
	HQWS-EXMB-01.main.covenanteyes.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751764AbcGOQtX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jul 2016 12:49:23 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Jul 2016 12:49:23 EDT
Received: from HQWS-EXMB-01.main.covenanteyes.com (10.0.52.14) by
 HQWS-EXMB-01.main.covenanteyes.com (10.0.52.14) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Fri, 15 Jul 2016 12:34:19 -0400
Received: from HQWS-EXMB-01.main.covenanteyes.com
 ([fe80::cc70:ee29:5605:e9c0]) by HQWS-EXMB-01.main.covenanteyes.com
 ([fe80::cc70:ee29:5605:e9c0%12]) with mapi id 15.00.1156.000; Fri, 15 Jul
 2016 12:34:19 -0400
From:	Andrew Keller <andrew.keller@covenanteyes.com>
To:	Git List <git@vger.kernel.org>
Subject: obsolete index in wt_status_print after pre-commit hook runs
Thread-Topic: obsolete index in wt_status_print after pre-commit hook runs
Thread-Index: AQHR3ra8hjNsCD4EaU6MsSMqTszZoA==
Date:	Fri, 15 Jul 2016 16:34:19 +0000
Message-ID: <5988D847-25A2-4997-9601-083772689879@covenanteyes.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [23.28.40.196]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BA04BC595CD7C439E961D8F547BDB00@covenanteyes.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

SGkgZXZlcnlvbmUsDQoNCkkgaGF2ZSBvYnNlcnZlZCBhbiBpbnRlcmVzdGluZyBzY2VuYXJpby4g
IEhlcmUgYXJlIGV4YW1wbGUgcmVwcm9kdWN0aW9uIHN0ZXBzOg0KDQoxLiBuZXcgcmVwb3NpdG9y
eQ0KMi4gY3JlYXRlIG5ldyBwcmUtY29tbWl0IGhvb2sgdGhhdCBpbnZva2VzIGBnaXQgbXYgb25l
IHR3b2ANCjMuIHRvdWNoIG9uZQ0KNC4gZ2l0IGFkZCBvbmUNCjUuIGdpdCBjb21taXQNCg0KRXhw
ZWN0ZWQgb3V0Y29tZTogSW4gdGhlIGNvbW1pdCBtZXNzYWdlIHRlbXBsYXRlLCBJIGV4cGVjdCB0
byBzZWUg4oCcQ2hhbmdlcyB0byBiZSBjb21taXR0ZWQ6IG5ldyBmaWxlOiB0d28iDQoNCkZvdW5k
IG91dGNvbWU6IEluIHRoZSBjb21taXQgbWVzc2FnZSB0ZW1wbGF0ZSwgSSBzZWUg4oCcQ2hhbmdl
cyB0byBiZSBjb21taXR0ZWQ6IG5ldyBmaWxlOiBvbmUiDQoNClRoaXMgYmVoYXZpb3Igc2VlbXMg
dG8gYmUgcmVwcm9kdWNpYmxlIGluIHZlcnNpb25zIDIuOS4xLCAyLjguMSwgMi4wLjAsIGFuZCAx
LjYuMC4NCg0KU2tpcCB0aGUgbmV4dCAzIHBhcmFncmFwaHMgaWYgeW91IGFyZSBpbiBhIGh1cnJ5
Lg0KDQpJIHB1bGxlZCBvdXQgdGhlIHNvdXJjZSBmb3IgdmVyc2lvbiAyLjkuMSBhbmQgYnJpZWZs
eSBza2ltbWVkIGhvdyBydW5fY29tbWl0IGFuZA0KcHJlcGFyZV90b19jb21taXQgd29yay4gIEl0
IHNlZW1zIHRoYXQgR2l0IGFscmVhZHkgdW5kZXJzdGFuZHMgdGhhdCBhIHByZS1jb21taXQNCmhv
b2sgY2FuIGNoYW5nZSB0aGUgaW5kZXgsIGFuZCBpdCByZXJlYWRzIHRoZSBpbmRleCBiZWZvcmUg
cnVubmluZyB0aGUNCnByZXBhcmUtY29tbWl0LW1zZyBob29rOiBodHRwczovL2dpdGh1Yi5jb20v
Z2l0L2dpdC9ibG9iL3YyLjkuMS9idWlsdGluL2NvbW1pdC5jI0w5NDEtTDk1MQ0KDQpEdXJpbmcg
dGhlIHByZXBhcmUtY29tbWl0LW1zZyBob29rLCBpdCBzZWVtcyB0aGF0IHRoZSBpbmRleCAoYWNj
b3JkaW5nIHRvIEdpdA0KY29tbWFuZHMpIGlzIGNvcnJlY3QgYW5kIHVwLXRvLWRhdGUsIGJ1dCB0
aGUgdGV4dHVhbCBtZXNzYWdlIGluc2lkZSB0aGUgY29tbWl0DQptZXNzYWdlIHRlbXBsYXRlIGlz
IG91dC1vZi1kYXRlIChpdCByZWZlcmVuY2VzIHRoZSBmaWxlIGBvbmVgIGFzIGEgY2hhbmdlIHRv
IGJlDQpjb21taXR0ZWQpLg0KDQpJbiBidWlsdGluL2NvbW1pdC5jLCBpdCBzZWVtcyB0aGF0IHRo
ZSBjb21taXQgbWVzc2FnZSB0ZW1wbGF0ZSBpcyByZW5kZXJlZA0KaW1tZWRpYXRlbHkgYWZ0ZXIg
dGhlIHByZS1jb21taXQgaG9vayBpcyByYW4sIGFuZCBpbW1lZGlhdGVseSBiZWZvcmUgdGhlIGlu
ZGV4IGlzDQpyZXJlYWQuICBJZiBJIG1vdmUgdGhlIHNtYWxsIGJsb2NrIG9mIGNvZGUgdGhhdCBy
ZXJlYWRzIHRoZSBpbmRleCB1cCwgdG8ganVzdCBhZnRlcg0KdGhlIHByZS1jb21taXQgaG9vayBp
cyByYW4sIHRoZSBjb21taXQgbWVzc2FnZSB0ZW1wbGF0ZSBzZWVtcyB0byBiZSBhcyBJIHdvdWxk
DQpleHBlY3QsIGJvdGggaW4gLmdpdC9DT01NSVRfRURJVE1TRyBkdXJpbmcgdGhlIHByZXBhcmUt
Y29tbWl0LW1zZyBob29rIGFuZA0KaW4gdGhlIGVkaXRvciBmb3IgdGhlIGNvbW1pdCBtZXNzYWdl
IGl0c2VsZi4NCg0KSSBhbSBwdXR0aW5nIHRvZ2V0aGVyIGEgMi1wYXRjaCBzZXJpZXMgdGhhdCBp
bmNsdWRlcyBhIGZhaWxpbmcgdGVzdCwgYW5kIHRoZW4gdGhpcw0KY2hhbmdlICh3aGljaCBmaXhl
cyB0aGUgdGVzdCksIGJ1dCB3aGlsZSBJIGRvIHRoYXQsIEkgZmlndXJlIEkgbWF5IGFzIHdlbGwg
cGluZyB0aGUNCmNvbW11bml0eSB0byBtYWtlIHN1cmUgdGhhdCB0aGlzIGJlaGF2aW9yIGlzIG5v
dCBpbnRlbnRpb25hbC4gIEnigJlkIHdhZ2VyIHRoYXQgdGhpcw0KY2hhbmdlIGlzIGZvciB0aGUg
YmV0dGVyLCBidXQgc2luY2UgdGhpcyBiZWhhdmlvciBoYXMgYmVlbiBhcm91bmQgc28gbG9uZyAo
SSBzdG9wcGVkDQpjaGVja2luZyBhdCAxLjYuMCksIGl0IGRvZXNu4oCZdCBodXJ0IHRvIG1ha2Ug
c3VyZS4NCg0KQW55IGNvbW1lbnRzLCBjb25jZXJucywgb3IgYWR2aWNlPw0KDQpUaGFua3MsDQog
LSBBbmRyZXcgS2VsbGVyDQoNCg==
