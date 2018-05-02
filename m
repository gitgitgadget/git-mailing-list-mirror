Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CB2621841
	for <e@80x24.org>; Wed,  2 May 2018 07:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750999AbeEBHac (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 03:30:32 -0400
Received: from ironport.klsmartin.com ([212.211.191.11]:44306 "EHLO
        ironport.klsmartin.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750895AbeEBHab (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 03:30:31 -0400
X-IronPort-AV: E=Sophos;i="5.49,354,1520895600"; 
   d="scan'208";a="16176878"
Received: from unknown (HELO ares.klsmartin.com) ([172.30.5.65])
  by ironport.klsmartin.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 02 May 2018 09:30:30 +0200
Received: from SUMMAIL01.UMK.KLS.zentral ([172.25.1.63])
        by ares.klsmartin.com (8.14.3/8.13.1/SuSE Linux 0.7) with ESMTP id w427URWb019916;
        Wed, 2 May 2018 09:30:29 +0200
Received: from SUMMBX01.UMK.KLS.zentral ([172.25.1.64]) by
 SUMMAIL01.UMK.KLS.zentral ([172.25.1.63]) with mapi id 14.03.0351.000; Wed, 2
 May 2018 09:30:26 +0200
From:   "Middelschulte, Leif" <Leif.Middelschulte@klsmartin.com>
To:     "hvoigt@hvoigt.net" <hvoigt@hvoigt.net>,
        "sbeller@google.com" <sbeller@google.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "jacob.keller@gmail.com" <jacob.keller@gmail.com>
Subject: Re: git merge banch w/ different submodule revision
Thread-Topic: git merge banch w/ different submodule revision
Thread-Index: AQHT3UxIUeHy1QVy7UGFBG3KFIVVC6QTM84AgABAJgCAAAk9AIAF8LqAgAKD5oA=
Date:   Wed, 2 May 2018 07:30:25 +0000
Message-ID: <1525246025.2176.12.camel@klsmartin.com>
References: <1524739599.20251.17.camel@klsmartin.com>
         <CAGZ79kZA_R-5bA6mPdoHkVW-C21pNn_0x6FayhuuXqnOTrmjWw@mail.gmail.com>
         <CA+P7+xrUwq0G2YySC3SLKqyihhPnFPCiQnQpoVVa89+=W9O9+w@mail.gmail.com>
         <CAGZ79kaub2k-q-Mcj3H5o6ekyZ8ZZzG7+r5sHt5Ne25Nc3_nPQ@mail.gmail.com>
         <20180430170229.GA775@book.hvoigt.net>
In-Reply-To: <20180430170229.GA775@book.hvoigt.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.70.68]
x-kse-serverinfo: SUMMAIL01.UMK.KLS.zentral, 9
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 02.05.2018 03:45:00
Content-Type: text/plain; charset="utf-8"
Content-ID: <475459F8B359D34397E1B862CB3741D3@klsmartin.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

QW0gTW9udGFnLCBkZW4gMzAuMDQuMjAxOCwgMTk6MDIgKzAyMDAgc2NocmllYiBIZWlrbyBWb2ln
dDoNCj4gT24gVGh1LCBBcHIgMjYsIDIwMTggYXQgMDM6MTk6MzZQTSAtMDcwMCwgU3RlZmFuIEJl
bGxlciB3cm90ZToNCj4gPiBTdGVmYW4gd3JvdGU6DQo+ID4gPiBTZWUgaHR0cHM6Ly9naXRodWIu
Y29tL2dpdC9naXQvY29tbWl0LzY4ZDAzZTRhNmU0NDhhYTU1N2Y1MmFkZWY5MjU5NWFjNGQ2Y2Q0
YmQNCj4gPiA+ICg2OGQwM2U0YTZlIChJbXBsZW1lbnQgYXV0b21hdGljIGZhc3QtZm9yd2FyZCBt
ZXJnZSBmb3Igc3VibW9kdWxlcywgMjAxMC0wNy0wNykNCj4gPiA+IHRvIGV4cGxhaW4gdGhlIHNp
dHVhdGlvbiB5b3UgZW5jb3VudGVyLiAoc3BlY2lmaWNhbGx5IG1lcmdlX3N1Ym1vZHVsZQ0KPiA+
ID4gYXQgdGhlIGVuZCBvZiB0aGUgZGlmZikNCj4gPiANCj4gPiArY2MgSGVpa28sIGF1dGhvciBv
ZiB0aGF0IGNvbW1pdC4NCj4gDQo+IEluIHRoYXQgY29tbWl0IHdlIHRyaWVkIHRvIGJlIHZlcnkg
Y2FyZWZ1bCBhYm91dC4gSSBkbyBub3QgdW5kZXJzdGFuZA0KPiB0aGUgc2l0dWF0aW9uIGluIHdo
aWNoIHRoZSBjdXJyZW50IHN0cmF0ZWd5IHdvdWxkIGJlIHdyb25nIGJ5IGRlZmF1bHQuDQo+IA0K
PiBXZSBvbmx5IG1lcmdlIGlmIHRoZSBmb2xsb3dpbmcgYXBwbGllczoNCj4gDQo+ICAqIFRoZSBj
aGFuZ2VzIGluIHRoZSBzdXBlcnByb2plY3Qgb24gYm90aCBzaWRlcyBwb2ludCBmb3J3YXJkIGlu
IHRoZQ0KPiAgICBzdWJtb2R1bGUuDQo+IA0KPiAgKiBPbmUgc2lkZSBpcyBjb250YWluZWQgaW4g
dGhlIG90aGVyLiBDb250YWluZWQgZnJvbSB0aGUgc3VibW9kdWxlDQo+ICAgIHBlcnNwZWN0aXZl
LiBTaWRlcyBmcm9tIHRoZSBzdXBlcnByb2plY3QgbWVyZ2UgcGVyc3BlY3RpdmUuDQo+IA0KPiBT
byBpbiBjYXNlIG9mIHRoZSBtZW50aW9uZWQgcmV3aW5kIG9mIGEgc3VibW9kdWxlOiBPbmx5IG9u
ZSBzaWRlIG9mIHRoZQ0KPiAzLXdheSBtZXJnZSB3b3VsZCBwb2ludCBmb3J3YXJkIGFuZCB0aGUg
bWVyZ2Ugd291bGQgZmFpbC4NCj4gDQo+IEkgY2FuIGltYWdpbmUsIHRoYXQgaW4gY2FzZSBvZiBh
IHRlbXBvcmFyeSByZXZlcnQgb2YgYSBjb21taXQgaW4gdGhlDQo+IHN1Ym1vZHVsZSB0aGF0IHlv
dSB3b3VsZCBub3Qgd2FudCB0aGF0IG1lcmdlZCBpbnRvIHNvbWUgb3RoZXIgYnJhbmNoLg0KPiBC
dXQgdGhhdCB3b3VsZCBiZSB0aGUgc2FtZSB3aXRob3V0IHN1Ym1vZHVsZXMuIElmIHlvdSBtZXJn
ZSBhIHRlbXBvcmFyeQ0KPiByZXZlcnQgZnJvbSBhbm90aGVyIGJyYW5jaCB5b3Ugd2lsbCBub3Qg
Z2V0IGFueSBjb25mbGljdC4NCj4gDQo+IFNvIG1heWJlIHNvbWVvbmUgY2FuIGV4cGxhaW4gdGhl
IHVzZSBjYXNlIGluIHdoaWNoIG9uZSB3b3VsZCBnZXQgdGhlDQo+IHJlc3VsdHMgdGhhdCBzZWVt
IHdyb25nPw0KSW4gYW4gaWRlYWwgd29ybGQsIHdoZXJlIHRoZXJlIGFyZSBubyByZWdyZXNzaW9u
cyBiZXR3ZWVuIHJldmlzaW9ucywgYQ0KZmFzdC1mb3J3YXJkIGlzIGFwcHJvcHJpYXRlLiBIb3dl
dmVyLCB3ZSBtaWdodCBoYXZlIHJlZ3Jlc3Npb25zIHdpdGhpbg0Kc3VibW9kdWxlcy4NCg0KU28g
dGhlIHVzZWNhc2UgaXMgdGhlIGZvbGxvd2luZzoNCg0KRW52aXJvbm1lbnQ6DQotIFdlIGhhdmUg
YSBiYXNlIGxpYnJhcnkgTCB0aGF0IGlzIGRldmVsb3BlZCBieSBzb21lIHRlYW0gKFRlYW0gQiku
DQotIEFub3RoZXIgdGVhbSAoVGVhbSBBKSBkZXZlbG9wZXMgYSBwcm9kdWN0IFAgYmFzZWQgb24g
dGhvc2UgbGlicmFyaWVzIHVzaW5nIGdpdC1mbG93Lg0KDQpDYXNlOg0KVGhlIHByb2JsZW0gb2Nj
dXJzLCB3aGVuIGEgZGV2ZWxvcGVyIChEKSBvZiBUZWFtIEEgdHJpZXMgdG8gaGF2ZSBhIGZlYXR1
cmUNCnRoYXQgaGUgZGV2ZWxvcGVkIG9uIGEgYnJhbmNoIGFjY2VwdGVkIGJ5IGEgY29yZSBkZXZl
bG9wZXIgb2YgUDoNCklmIGEgY29yZSBkZXZlbG9wZXIgb2YgUCBhZHZhbmNlZCB0aGUgcmVmZXJl
bmNlIG9mIEwgd2l0aGluIFAgKGxpbmVhciBoaXN0b3J5KSwgaGUgbWlnaHQNCmRlZW0gdGhlIHdv
cmsgRCBpbnN1ZmZpY2llbnQuIE5vdCBiZWNhdXNlIG9mIHRoZSBhY3R1YWwgd29yayBieSBELCBi
dXQgcmVncmVzc2lvbnMNCnRoYXQgc251Y2sgaW50byBMLiBUaGUgY29yZSBkZXZlbG9wZXIgd2ls
bCBub3QgYmUgaW5mb3JtZWQgYWJvdXQgdGhlIG1pc3NtYXRjaGluZw0KcmV2aXNpb25zIG9mIEwu
DQoNClNvIGl0IHdvdWxkIGJlIG5pY2UgaWYgdGhlcmUgd2FzIHNvbWUga2luZCBvZiBzd2l0Y2gg
b3IgYXQgbGVhc3Qgc29tZSB0cmlnZ2VyLg0KDQpDaGVlcnMsDQoNCkxlaWYNCg0KDQo+IA0KPiBD
aGVlcnMgSGVpa28NCj4g
