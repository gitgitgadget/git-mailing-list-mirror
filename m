Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61A471FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 19:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753151AbcHZT6K (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 15:58:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:16607 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751554AbcHZT6I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 15:58:08 -0400
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP; 26 Aug 2016 12:58:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,582,1464678000"; 
   d="scan'208";a="871523125"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga003.jf.intel.com with ESMTP; 26 Aug 2016 12:58:07 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.215]) by
 ORSMSX109.amr.corp.intel.com ([169.254.11.150]) with mapi id 14.03.0248.002;
 Fri, 26 Aug 2016 12:58:07 -0700
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     "sbeller@google.com" <sbeller@google.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "j6t@kdbg.org" <j6t@kdbg.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "peff@peff.net" <peff@peff.net>,
        "stefanbeller@gmail.com" <stefanbeller@gmail.com>,
        "jacob.keller@gmail.com" <jacob.keller@gmail.com>
Subject: Re: [PATCH v11 0/8] submodule inline diff format
Thread-Topic: [PATCH v11 0/8] submodule inline diff format
Thread-Index: AQHR/yneWTobHf5W70GnYEj7iJWf9qBcFAQAgAALUwA=
Date:   Fri, 26 Aug 2016 19:58:07 +0000
Message-ID: <1472241486.28343.10.camel@intel.com>
References: <20160825233243.30700-1-jacob.e.keller@intel.com>
         <CAGZ79kao12f8VTT3uxRvAUBhvbfSLjsYRjidTau3M-Kf81uXDQ@mail.gmail.com>
In-Reply-To: <CAGZ79kao12f8VTT3uxRvAUBhvbfSLjsYRjidTau3M-Kf81uXDQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.3.116]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5157B6B7B128BB449B84200978DB3EE4@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T24gRnJpLCAyMDE2LTA4LTI2IGF0IDEyOjE3IC0wNzAwLCBTdGVmYW4gQmVsbGVyIHdyb3RlOg0K
PiBPbiBUaHUsIEF1ZyAyNSwgMjAxNiBhdCA0OjMyIFBNLCBKYWNvYiBLZWxsZXIgPGphY29iLmUu
a2VsbGVyQGludGVsLmMNCj4gb20+IHdyb3RlOg0KPiANCj4gPiANCj4gPiBAQCAtNDg3LDEyICs0
OTAsMTQgQEAgc3RhdGljIHZvaWQgZG9fc3VibW9kdWxlX3BhdGgoc3RydWN0IHN0cmJ1Zg0KPiA+
ICpidWYsIGNvbnN0IGNoYXIgKnBhdGgsDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBzdHJidWZfYWRkc3RyKGJ1ZiwgZ2l0X2Rpcik7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoH0N
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCFpc19naXRfZGlyZWN0b3J5KGJ1Zi0+YnVmKSkgew0K
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnaXRtb2R1bGVzX2NvbmZpZygpOw0K
PiANCj4gV2UgZGV0ZXJtaW5lZCB2aWEgY2hhdCB0aGF0IGNhbGxpbmcgZ2l0bW9kdWxlc19jb25m
aWcNCj4gaXMgbm90IGhhcm1mdWwgdy5yLnQuIGNvcnJlY3RuZXNzLCBidXQgbWlnaHQgcmVxdWly
ZSBzb21lDQo+IGltcHJvdmVtZW50cyBpbiB0aGUgZnV0dXJlIGZvciBwZXJmb3JtYW5jZS4NCj4g
KGkuZS4gd2UgbWF5IHdhbnQgdG8gYWRkIGluIGEgbGF0ZXIgc2VyaWVzIGENCj4gwqDCoMKgwqBp
ZiAoYWxyZWFkeSBjYWxsZWQgZ2l0bW9kdWxlc19jb25maWcpDQo+IMKgwqDCoMKgwqDCoHNldCBm
bGFnICJhbHJlYWR5IGNhbGxlZCBnaXRtb2R1bGVzX2NvbmZpZyI7DQo+IMKgwqDCoMKgwqDCoHJl
dHVybjsNCj4gaW50byBnaXRtb2R1bGVzX2NvbmZpZykNCj4gDQo+ID4gDQo+ID4gDQo+ID4gwqBj
aGFyICpnaXRfcGF0aGR1cF9zdWJtb2R1bGUoY29uc3QgY2hhciAqcGF0aCwgY29uc3QgY2hhciAq
Zm10LA0KPiA+IC4uLikNCj4gPiDCoHsNCj4gPiArwqDCoMKgwqDCoMKgwqBpbnQgZXJyOw0KPiA+
IMKgwqDCoMKgwqDCoMKgwqB2YV9saXN0IGFyZ3M7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoHN0cnVj
dCBzdHJidWYgYnVmID0gU1RSQlVGX0lOSVQ7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoHZhX3N0YXJ0
KGFyZ3MsIGZtdCk7DQo+ID4gLcKgwqDCoMKgwqDCoMKgZG9fc3VibW9kdWxlX3BhdGgoJmJ1Ziwg
cGF0aCwgZm10LCBhcmdzKTsNCj4gPiArwqDCoMKgwqDCoMKgwqBlcnIgPSBkb19zdWJtb2R1bGVf
cGF0aCgmYnVmLCBwYXRoLCBmbXQsIGFyZ3MpOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqB2YV9lbmQo
YXJncyk7DQo+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKGVycikNCj4gDQo+IEhlcmUgd2UgbmVlZCBh
IHN0cmJ1Zl9yZWxlYXNlKCZidWYpIHRvIGF2b2lkIGEgbWVtb3J5IGxlYWs/DQoNCk5vLCBjYXVz
ZSB3ZSAic3RyYnVmX2RldGFjaCIgYWZ0ZXIgdGhpcyB0byByZXR1cm4gdGhlIGJ1ZmZlcj8gT3Ig
aXMNCnRoYXQgbm90IHNhZmU/DQoNClRoYW5rcywNCkpha2UNCg0KPiAtLQ0KPiBUbyB1bnN1YnNj
cmliZSBmcm9tIHRoaXMgbGlzdDogc2VuZCB0aGUgbGluZSAidW5zdWJzY3JpYmUgZ2l0IiBpbg0K
PiB0aGUgYm9keSBvZiBhIG1lc3NhZ2UgdG8gbWFqb3Jkb21vQHZnZXIua2VybmVsLm9yZw0KPiBN
b3JlIG1ham9yZG9tbyBpbmZvIGF0wqDCoGh0dHA6Ly92Z2VyLmtlcm5lbC5vcmcvbWFqb3Jkb21v
LWluZm8uaHRtbA0K
