Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AC0F1FBB0
	for <e@80x24.org>; Thu,  1 Sep 2016 11:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932939AbcIALeh (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 07:34:37 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:12882 "EHLO edge10.ethz.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932240AbcIALed (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 07:34:33 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.3.301.0; Thu, 1 Sep
 2016 13:34:25 +0200
Received: from MBX115.d.ethz.ch ([fe80::444b:8481:c05f:ab21]) by
 CAS11.d.ethz.ch ([fe80::ecc9:4e2d:b26b:1614%10]) with mapi id 14.03.0301.000;
 Thu, 1 Sep 2016 13:34:29 +0200
From:   "Hedges  Alexander" <ahedges@student.ethz.ch>
To:     Jacob Keller <jacob.keller@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Feature Request: Branch-Aware Submodules
Thread-Topic: Feature Request: Branch-Aware Submodules
Thread-Index: AQHR/q8rhVL81GY7sUSbiDPBMOmPz6BfGCmAgAVSigA=
Date:   Thu, 1 Sep 2016 11:34:28 +0000
Message-ID: <AAED3CA2-3BDA-49CF-8930-FBC96F1EFE34@student.ethz.ch>
References: <5EA7D232-5D41-4653-9E35-21C502C79C92@student.ethz.ch>
 <51671371-C59A-4304-99B2-B2C2256C4001@student.ethz.ch>
 <CA+P7+xqA_3a8EPZ=2Y5pgkL+N=_F1v5pfyzErwest9aoKZC37w@mail.gmail.com>
In-Reply-To: <CA+P7+xqA_3a8EPZ=2Y5pgkL+N=_F1v5pfyzErwest9aoKZC37w@mail.gmail.com>
Accept-Language: en-US, de-CH
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [85.2.67.2]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F26A14DD46B0D4496564FD5FD6C9A81@intern.ethz.ch>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

U2luY2UgSSBkb27igJl0IHdhbnQgdG8gY2hhbmdlIGFueSBoaXN0b3J5IGluIHRoZSBzdWJwcm9q
ZWN0LCB0byBtZSB0aGUgbW9zdCANCmV4cGVjdGVkIGJlaGF2aW9yIHdvdWxkIGJlOg0KDQpnaXQg
c3VibW9kdWxlIHVwZGF0ZSDigJQtcmVjdXJzaXZlDQoNCndpdGggc3VibW9kdWxlLioudXBkYXRl
IHNldCB0byB0aGUgY29tbWFuZDoNCg0KYGBgDQojIS9iaW4vYmFzaA0KDQpicmFuY2hlcz1gZ2l0
IGJyYW5jaCAtLXBvaW50cy1hdCAiJDEiYA0KDQppZiBbICEgJGJyYW5jaGVzIF0gOyB0aGVuDQog
ICAgZ2l0IGNoZWNrb3V0ICIkMSINCiAgICBlY2hvICJkbyBub3JtYWwgY2hlY2tvdXQiDQplbHNl
DQogICAgcG9pbnRzX3RvX21hc3Rlcj0NCiAgICBvdGhlcl9icmFuY2g9DQogICAgZm9yIGIgaW4g
JGJyYW5jaGVzIDsgZG8NCiAgICAgICAgaWYgWyAiJGIiID0gIm1hc3RlciIgXSA7IHRoZW4NCiAg
ICAgICAgICAgIHBvaW50c190b19tYXN0ZXI9InRydWUiDQogICAgICAgIGVsc2UNCiAgICAgICAg
ICAgIG90aGVyX2JyYW5jaD0iJGIiDQogICAgICAgIGZpDQogICAgZG9uZQ0KICAgIGlmIFsgcG9p
bnRzX3RvX21hc3RlciBdIDsgdGhlbg0KICAgICAgICBnaXQgY2hlY2tvdXQgbWFzdGVyDQogICAg
ZWxzZQ0KICAgICAgICBnaXQgY2hlY2tvdXQgIiRvdGhlcl9icmFuY2giDQogICAgZmkNCmZpDQpg
YGANCg0KTm93LCB0aGlzIGlzIG5vdCBwZXJmZWN0IGFuZCBJ4oCZbSBzdXJlIEnigJlsbCByZWZp
bmUgaXQgd2hlbmV2ZXIgSSBmaW5kIGl0IGRvZXNu4oCZdA0Kc3VpdCBteSBuZWVkcywgYnV0IEni
gJltIHN1cmUgeW91IGNhbiBzZWUgdGhlIGludGVudGlvbnMgaGVyZS4gSeKAmW0gYWxzbyBub3Qg
cXVpdGUNCnN1cmUgd2hldGhlciB0byBwcmlvcml0aXplIHRhZ3Mgb3ZlciBicmFuY2hlcyBvciB0
aGUgb3RoZXIgd2F5IGFyb3VuZC4NCg0KVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbi4gSSBob3Bl
IHRoaXMgb3IgYSBzaW1pbGFyIGJlaGF2aW9yIGNvdWxkIHNvbWV0aW1lDQpiZWNvbWUgdGhlIGRl
ZmF1bHQgaW4gZ2l0LiBVbnRpbCB0aGUgc3VnZ2VzdGVkIHF1aWNrIGZpeCB3aWxsIGRvIGZvciBt
ZS4NCg0KQmVzdCBSZWdhcmRzLA0KQWxleGFuZGVyIEhlZGdlcw0KDQo+IE9uIDI5IEF1ZyAyMDE2
LCBhdCAwNDoxNywgSmFjb2IgS2VsbGVyIDxqYWNvYi5rZWxsZXJAZ21haWwuY29tPiB3cm90ZToN
Cj4gDQo+IE9uIEZyaSwgQXVnIDI2LCAyMDE2IGF0IDg6MTIgQU0sIEhlZGdlcyAgQWxleGFuZGVy
DQo+IDxhaGVkZ2VzQHN0dWRlbnQuZXRoei5jaD4gd3JvdGU6DQo+Pj4gT24gMjUgQXVnIDIwMTYs
IGF0IDE5OjQ1LCBTdGVmYW4gQmVsbGVyIDxzYmVsbGVyQGdvb2dsZS5jb20+IHdyb3RlOg0KPj4+
IFsxXSBodHRwczovL2dpdGh1Yi5jb20vamxlaG1hbm4vZ2l0LXN1Ym1vZC1lbmhhbmNlbWVudHMN
Cj4+PiB3aGljaCBoYXMgc29tZSBhdHRlbXB0cyBmb3IgY2hlY2tvdXQgaW5jbHVkaW5nIHRoZSBz
dWJtb2R1bGVzLg0KPj4+IEkgYWxzbyB0cmllZCB3cml0aW5nIHNvbWUgcGF0Y2hlcyB3aGljaCBp
bnRlZ3JhdGUgY2hlY2tpbmcgb3V0IHN1Ym1vZHVsZXMNCj4+PiB2aWEgY2hlY2tvdXQgYXMgd2Vs
bC4gQSBxdWlja2VyIGBzb2x1dGlvbmAgd291bGQgYmUgYSBjb25maWcgb3B0aW9uIHRoYXQNCj4+
PiBqdXN0IHJ1bnMgYGdpdCBzdWJtb2R1bGUgdXBkYXRlYCBhZnRlciBlYWNoIGNoZWNrb3V0L3B1
bGwgZXRjLg0KPj4+IA0KPj4gDQo+PiBJIHNlZS4gVGhlIHF1aWNrIGZpeCBpcyBhbG1vc3Qgd2hh
dCBJ4oCZbSBsb29raW5nIGZvciwgZXhjZXB0IHRoYXQgaXQgbGVhdmVzDQo+PiB0aGUgcmVwbyBp
biBhIGRldGFjaGVkIGhlYWQgc3RhdGUuIENvdWxkIHRoZSBzdWJtb2R1bGUgdXBkYXRlIGJlIG1h
ZGUNCj4+IGF1dG9tYXRpY2FsbHkgYW5kIGludGVsbGlnZW50bHkgcGljayB0aGUgYnJhbmNoPw0K
Pj4gDQo+IA0KPiBZb3UgcHJvYmFibHkgd2FudCAiZ2l0IHN1Ym1vZHVsZSB1cGRhdGUgLS1yZWJh
c2UiIG9yICJnaXQgc3VibW9kdWxlDQo+IHVwZGF0ZSAtLW1lcmdlIiBTZWUgZ2l0IGhlbHAgc3Vi
bW9kdWxlIHVuZGVyIHRoZSB1cGRhdGUgc2VjdGlvbiwgb3INCj4gZXZlbiBhIGN1c3RvbSBjb21t
YW5kIHZhcmlhbnQgd2hlcmUgeW91IGNhbiB3cml0ZSB5b3VyIG93biBiaXQgb2YNCj4gc2hlbGwg
dGhhdCBkb2VzIHdoYXQgeW91ciBwcm9qZWN0IGV4cGVjdHMuDQo+IA0KPiBUaGFua3MsDQo+IEph
a2UNCg0K
