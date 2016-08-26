Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA51D2018E
	for <e@80x24.org>; Fri, 26 Aug 2016 18:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753688AbcHZS06 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 14:26:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:33046 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753109AbcHZS06 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 14:26:58 -0400
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP; 26 Aug 2016 11:26:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,582,1464678000"; 
   d="scan'208";a="161364906"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga004.fm.intel.com with ESMTP; 26 Aug 2016 11:26:57 -0700
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.248.2; Fri, 26 Aug 2016 11:26:56 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.215]) by
 ORSMSX112.amr.corp.intel.com ([169.254.3.251]) with mapi id 14.03.0248.002;
 Fri, 26 Aug 2016 11:26:56 -0700
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     "sbeller@google.com" <sbeller@google.com>,
        "jacob.keller@gmail.com" <jacob.keller@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "j6t@kdbg.org" <j6t@kdbg.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "peff@peff.net" <peff@peff.net>,
        "stefanbeller@gmail.com" <stefanbeller@gmail.com>
Subject: Re: [PATCH v10 0/9] submodule inline diff format
Thread-Topic: [PATCH v10 0/9] submodule inline diff format
Thread-Index: AQHR/yFzvg3BbrRPkUK1o75dHC4GwKBau/wAgAE7pQCAAA5NgA==
Date:   Fri, 26 Aug 2016 18:26:55 +0000
Message-ID: <1472236015.28343.3.camel@intel.com>
References: <20160822234344.22797-1-jacob.e.keller@intel.com>
         <CAGZ79kbKibe2RpQ9QWN1naY07feZLKbhc+dts3BD-4+y-pUOVw@mail.gmail.com>
         <xmqqlgznwg6o.fsf@gitster.mtv.corp.google.com>
         <CAGZ79kbsq52Qh0Jtn5hpPPfHu_9r2CUHvAHOTh6Cgz8ODkzreg@mail.gmail.com>
         <CA+P7+xrQy33gt8bnsagLVPAHhZPZx-3s0E_Aj7tOwXnHjOoCBg@mail.gmail.com>
         <xmqqr39cjwxx.fsf@gitster.mtv.corp.google.com>
         <CA+P7+xqDRD4akNShqxs4D2dDUBK0E5Eyp2Y3-8xK6wEb5gCU6w@mail.gmail.com>
         <CAGZ79kYbHz2E6-0qNS47KfA5Gs=Ew327LxhOyq+i3axwPVHKGQ@mail.gmail.com>
In-Reply-To: <CAGZ79kYbHz2E6-0qNS47KfA5Gs=Ew327LxhOyq+i3axwPVHKGQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.3.116]
Content-Type: text/plain; charset="utf-8"
Content-ID: <41A3DC9D78D1B14ABEA1DFC490BC0FE0@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T24gRnJpLCAyMDE2LTA4LTI2IGF0IDEwOjM1IC0wNzAwLCBTdGVmYW4gQmVsbGVyIHdyb3RlOg0K
PiA+IGEpIHJlYWRfZ2l0ZmlsZSBvbiA8cGF0aD4vLmdpdA0KPiA+IGIpIGlmIHJlYWRfZ2l0Zmls
ZSBzdWNjZWVkcywgdXNlIGl0J3MgY29udGVudHMsIG90aGVyd2lzZSB1c2UNCj4gPiA8cGF0aD4v
LmdpdCBmb3IgbmV4dCBzdGVwcw0KPiA+IGMpIGNoZWNrIGlmIHRoZSByZXN1bHRpbmcgZmlsZSBp
cyBhIGdpdCBkaXJlY3RvcnksIHdlJ3JlIGZpbmUuLiB3ZQ0KPiA+IGZvdW5kIGEgZ2l0ZGlyLCBz
byBzdG9wLg0KPiA+IGQpIG90aGVyd2lzZSzCoMKgZW1wdHkgdGhlIGJ1ZmZlciwgdGhlbiBsb29r
dXAgc3VibW9kdWxlcw0KPiA+IGUpIHdoZW4gc3VibW9kdWxlcyBsb29rdXAgc3VjY2VlZHMuLiBz
ZWUgaWYgd2UgZm91bmQgYSBuYW1lLiBJZiBzbywNCj4gPiB1c2UgdGhhdC4NCj4gDQo+IFdoZW4g
dGhlIHN1Ym1vZHVsZXMgbG9va3VwIHN1Y2NlZWRzLCB3ZSBjYW4gYXNzZXJ0IHRoZSBuYW1lIGV4
aXN0cy4NCj4gVGhlcmUgaXMgY3VycmVudGx5IG9ubHkgb25lIHdheSB0aGUgbG9va3VwIGlzIHBv
cHVsYXRlZCwgYW5kIHRoYXQgaXMNCj4gbG9va3VwX29yX2NyZWF0ZV9ieV9uYW1lIGluIHN1Ym1v
ZHVsZS1jb25maWcuYzoxODIsIHdoaWNoIGZpbGxzIGluDQo+IHRoZSBuYW1lIGFsbCB0aGUgdGlt
ZS4NCg0KWWVzLCB0aGF0IHdhcyBob3cgSSB3YXMgdHJ5aW5nIHRvIHdvcmQgaXQsIGFuZCB0aGF0
J3Mgd2hhdCBJJ3ZlIGRvbmUgaW4NCmNvZGUuDQoNCj4gDQo+ID4gDQo+ID4gZikgaWYgd2UgZGlk
bid0IGp1c3QgZXhpdCB3aXRoIGFuIGVtcHR5IGJ1ZmZlci4NCj4gPiANCj4gPiBUaGF0IGVtcHR5
IGJ1ZmZlciAqc2hvdWxkKiB0cmlnZ2VywqDCoHJldmlzaW9uIGVycm9yIGNvZGVzIHNpbmNlIGl0
DQo+ID4gd29uJ3QgcG9pbnQgdG8gYW55IHZhbGlkIHBhdGggYW5kIGl0IGFsc28gdHJpZ2dlcnMg
dGhlIHJlZ3VsYXINCj4gPiBlcnJvcg0KPiA+IGNvZGUgaW4gYWRkX3N1Ym1vZHVsZV9vZGIgc28g
aXQgaGFuZGxlcyB0aGF0IHdpdGggc2hvd2luZyBub3QNCj4gPiBpbml0aXpsaWVkLg0KPiA+IA0K
PiA+IFRoaXMgbWV0aG9kIGlzIGxlc3Mgd29yayB0aGVuIHJlLWltcGxlbWVudGluZyBhIF9nZW50
bHkoKSB2YXJpYW50DQo+ID4gZm9yDQo+ID4gYWxsIG9mIHRoZXNlIGZ1bmN0aW9ucy4NCj4gPiAN
Cj4gPiBTdGVmYW4sIGRvZXMgdGhpcyBtYWtlIHNlbnNlIGFuZCBzZWVtIHJlYXNvbmFibGU/DQo+
IA0KPiBTb3VuZHMgcmVhc29uYWJsZSB0byBtZS4NCj4gDQo+IFRoYW5rcyBmb3Igd29ya2luZyBv
biB0aGlzIQ0KPiBTdGVmYW4NCg0KVGhhbmtzIGZvciByZXZpZXchDQoNClJlZ2FyZHMsDQpKYWtl
DQo=
