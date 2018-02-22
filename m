Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BB351F404
	for <e@80x24.org>; Thu, 22 Feb 2018 20:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbeBVUqP (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 15:46:15 -0500
Received: from mails1.kns.com ([199.171.180.11]:35210 "EHLO Mails1.kns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751119AbeBVUqO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 15:46:14 -0500
X-Greylist: delayed 1179 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Feb 2018 15:46:14 EST
X-ASG-Debug-ID: 1519331190-0a96b614031ba5a0001-QuoKaX
Received: from USEPRDEX2.corp.kns.com (useprdex2.corp.kns.com [10.40.10.31]) by Mails1.kns.com with ESMTP id nDbNFO3y8po4Ffix for <git@vger.kernel.org>; Thu, 22 Feb 2018 15:26:30 -0500 (EST)
X-Barracuda-Envelope-From: mfriedrich@kns.com
Received: from USEPRDEX2.corp.kns.com (10.40.10.31) by USEPRDEX2.corp.kns.com
 (10.40.10.31) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Thu, 22 Feb
 2018 15:26:27 -0500
Received: from USEPRDEX2.corp.kns.com ([fe80::c152:b74f:f217:7b3f]) by
 USEPRDEX2.corp.kns.com ([fe80::c152:b74f:f217:7b3f%22]) with mapi id
 15.00.1263.000; Thu, 22 Feb 2018 15:26:27 -0500
From:   Mike Friedrich <mfriedrich@kns.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: removed submodules shown as untracked when switching branches
Thread-Topic: removed submodules shown as untracked when switching branches
X-ASG-Orig-Subj: removed submodules shown as untracked when switching branches
Thread-Index: AdOsGWaWcRU9e7ZFTuWRD2s0N7udsw==
Date:   Thu, 22 Feb 2018 20:26:27 +0000
Message-ID: <6add3709b4eb469bb7c8d6319637b53a@USEPRDEX2.corp.kns.com>
Accept-Language: en-US, en-GB, de-CH
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.40.22.144]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Barracuda-Connect: useprdex2.corp.kns.com[10.40.10.31]
X-Barracuda-Start-Time: 1519331190
X-Barracuda-URL: https://Mails1.kns.com:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 2506
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at kns.com
X-Barracuda-Malware-Scanned: by bsmtpd at kns.com
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.48211
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGksDQoNCldoZW4gc3dpdGNoaW5nIGNsZWFuIGJyYW5jaGVzIEkgc2VlIHVudHJhY2tlZCBmaWxl
cyBhcHBlYXJpbmcgd2hlcmUgSSBleHBlY3QgdG8gc2VlICJub3RoaW5nIHRvIGNvbW1pdCwgd29y
a2luZyB0cmVlIGNsZWFuIi4NClRoaXMgaGFwcGVucyB3aGVuIHN1Ym1vZHVsZXMgZ2V0IHJlbW92
ZWQgb24gb25lIGJyYW5jaCBidXQgaXRzIHByZXNlbnQgaW4gYW5vdGhlci4NCkkgZXhwZWN0IGdp
dCB0byBlaXRoZXIgbm90IG1hcmsgdGhlIHN1Ym1vZHVsZSBpbiBnaXQgc3RhdHVzIGFzIHVudHJh
Y2tlZCBvciBnaXQgdG8gcmVtb3ZlIHRoZSBzdWJtb2R1bGUgYXMgaXQgd291bGQgZm9yIG9yZGlu
YXJ5IHRyYWNrZWQgZmlsZXMgd2hpY2ggZG8gbm90IGV4aXN0IG9uIGEgYnJhbmNoIGFueW1vcmUu
DQoNClRlc3RlZCBvbiBXaW5kb3dzIHdpdGg6IGdpdCB2ZXJzaW9uIDIuMTUuMS53aW5kb3dzLjIN
ClRlc3RlZCBvbiBVYnVudHUgTGludXggd2l0aCBzYW1lIG91dHB1dDogZ2l0IHZlcnNpb24gMi4x
NC4xDQoNClRlc3Q6DQogICAgZ2l0IGluaXQgdGVzdA0KICAgIGdpdCBpbml0IHN1Ym1vZHVsZQ0K
ICAgIGNkIHN1Ym1vZHVsZQ0KICAgIHRvdWNoIGZpbGUudHh0DQogICAgZ2l0IGFkZCBmaWxlLnR4
dA0KICAgIGdpdCBjb21taXQgLW0gInRlc3QiDQogICAgY2QgLi4vdGVzdA0KICAgIHRvdWNoIGlu
aXRpYWwudHh0DQogICAgZ2l0IGFkZCBpbml0aWFsLnR4dA0KICAgIGdpdCBjb21taXQgLW0gImlu
aXRpYWwiDQogICAgZ2l0IGNoZWNrb3V0IC1iIGRldmVsb3ANCiAgICBnaXQgc3RhdHVzDQogICAg
I09uIGJyYW5jaCBkZXZlbG9wDQogICAgI25vdGhpbmcgdG8gY29tbWl0LCB3b3JraW5nIHRyZWUg
Y2xlYW4NCg0KICAgIGdpdCBzdWJtb2R1bGUgYWRkIC4uL3N1Ym1vZHVsZSBzdWINCiAgICBnaXQg
YWRkIHN1Yg0KICAgIGdpdCBjb21taXQgLW0gInN1Ym1vZHVsZSBhZGRlZCINCiAgICBnaXQgc3Rh
dHVzDQogICAgI09uIGJyYW5jaCBkZXZlbG9wDQogICAgI25vdGhpbmcgdG8gY29tbWl0LCB3b3Jr
aW5nIHRyZWUgY2xlYW4NCg0KICAgIGdpdCBjaGVja291dCBtYXN0ZXINCiAgICBnaXQgc3RhdHVz
DQogICAgI09uIGJyYW5jaCBtYXN0ZXINCiAgICAjVW50cmFja2VkIGZpbGVzOg0KICAgICMgICh1
c2UgImdpdCBhZGQgPGZpbGU+Li4uIiB0byBpbmNsdWRlIGluIHdoYXQgd2lsbCBiZSBjb21taXR0
ZWQpDQogICAgIw0KICAgICMgICAgICAgIHN1Yi8NCiAgICAjDQogICAgI25vdGhpbmcgYWRkZWQg
dG8gY29tbWl0IGJ1dCB1bnRyYWNrZWQgZmlsZXMgcHJlc2VudCAodXNlICJnaXQgYWRkIiB0byB0
cmFjaykNCiAgICAjIGV4cGVjdGVkOiBub3RoaW5nIHRvIGNvbW1pdCwgd29ya2luZyB0cmVlIGNs
ZWFuDQoNCiAgICBnaXQgc3VibW9kdWxlIHVwZGF0ZQ0KICAgICMgKG5vIG91dHB1dCkNCiAgICBn
aXQgc3VibW9kdWxlDQogICAgIyAobm8gb3V0cHV0KQ0KICAgIGdpdCBzdGF0dXMNCiAgICAjT24g
YnJhbmNoIG1hc3Rlcg0KICAgICNVbnRyYWNrZWQgZmlsZXM6DQogICAgIyAgKHVzZSAiZ2l0IGFk
ZCA8ZmlsZT4uLi4iIHRvIGluY2x1ZGUgaW4gd2hhdCB3aWxsIGJlIGNvbW1pdHRlZCkNCiAgICAj
DQogICAgIyAgICAgICAgc3ViLw0KICAgICMNCiAgICAjbm90aGluZyBhZGRlZCB0byBjb21taXQg
YnV0IHVudHJhY2tlZCBmaWxlcyBwcmVzZW50ICh1c2UgImdpdCBhZGQiIHRvIHRyYWNrKQ0KICAg
ICMgZXhwZWN0ZWQ6IG5vdGhpbmcgdG8gY29tbWl0LCB3b3JraW5nIHRyZWUgY2xlYW4NCg0KICAg
IGdpdCBjbGVhbiAtZGZ4DQogICAgI1NraXBwaW5nIHJlcG9zaXRvcnkgc3ViLw0KDQpCZXN0IFJl
Z2FyZHMsDQpNaWtlIEZyaWVkcmljaA0KDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fDQoNClRoaXMgZW1haWwgaXMgbm9uLWJpbmRpbmcsIGlzIHN1YmplY3QgdG8gY29udHJhY3Qs
IGFuZCBuZWl0aGVyIEt1bGlja2UgYW5kIFNvZmZhIEluZHVzdHJpZXMsIEluYy4gbm9yIGl0cyBz
dWJzaWRpYXJpZXMgKGVhY2ggYW5kIGNvbGxlY3RpdmVseSDigJxLJlPigJ0pIHNoYWxsIGhhdmUg
YW55IG9ibGlnYXRpb24gdG8geW91IHRvIGNvbnN1bW1hdGUgdGhlIHRyYW5zYWN0aW9ucyBoZXJl
aW4gb3IgdG8gZW50ZXIgaW50byBhbnkgYWdyZWVtZW50LCBvdGhlciB0aGFuIGluIGFjY29yZGFu
Y2Ugd2l0aCB0aGUgdGVybXMgYW5kIGNvbmRpdGlvbnMgb2YgYSBkZWZpbml0aXZlIGFncmVlbWVu
dCBpZiBhbmQgd2hlbiBuZWdvdGlhdGVkLCBmaW5hbGl6ZWQgYW5kIGV4ZWN1dGVkIGJldHdlZW4g
dGhlIHBhcnRpZXMuIFRoaXMgZW1haWwgYW5kIGFsbCBpdHMgY29udGVudHMgYXJlIHByb3RlY3Rl
ZCBieSBJbnRlcm5hdGlvbmFsIGFuZCBVbml0ZWQgU3RhdGVzIGNvcHlyaWdodCBsYXdzLiBBbnkg
cmVwcm9kdWN0aW9uIG9yIHVzZSBvZiBhbGwgb3IgYW55IHBhcnQgb2YgdGhpcyBlbWFpbCB3aXRo
b3V0IHRoZSBleHByZXNzIHdyaXR0ZW4gY29uc2VudCBvZiBLJlMgaXMgcHJvaGliaXRlZC4NCg==
