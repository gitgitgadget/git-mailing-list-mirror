Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6742A1F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 16:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938805AbcJTQH2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 12:07:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:8633 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932213AbcJTQH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 12:07:27 -0400
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP; 20 Oct 2016 09:07:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,371,1473145200"; 
   d="scan'208";a="892116534"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga003.jf.intel.com with ESMTP; 20 Oct 2016 09:07:26 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.104]) by
 ORSMSX107.amr.corp.intel.com ([10.22.240.5]) with mapi id 14.03.0248.002;
 Thu, 20 Oct 2016 09:07:26 -0700
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     "gitster@pobox.com" <gitster@pobox.com>,
        "jacob.keller@gmail.com" <jacob.keller@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "j6t@kdbg.org" <j6t@kdbg.org>, "peff@peff.net" <peff@peff.net>,
        "stefanbeller@gmail.com" <stefanbeller@gmail.com>,
        "dennis@kaarsemaker.net" <dennis@kaarsemaker.net>
Subject: Re: [PATCH] rev-list: restore the NUL commit separator in --header
 mode
Thread-Topic: [PATCH] rev-list: restore the NUL commit separator in --header
 mode
Thread-Index: AQHSKlm4PXytacf+T0ak3SZMJIQwIaCx+LwA
Date:   Thu, 20 Oct 2016 16:07:25 +0000
Message-ID: <1476979644.3349.2.camel@intel.com>
References: <1476908699.26043.9.camel@kaarsemaker.net>
         <20161019210448.aupphybw5qar6mqe@hurricane>
         <CA+P7+xogHOCbPV+rx7yrur85m=HX5ms9kGQYvTpQ7n2i7Hzuvw@mail.gmail.com>
         <xmqq8ttkj740.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqq8ttkj740.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.3.116]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AB1A7F446414A42A9B4F7C0648DF674@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T24gV2VkLCAyMDE2LTEwLTE5IGF0IDE1OjM5IC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gSmFjb2IgS2VsbGVyIDxqYWNvYi5rZWxsZXJAZ21haWwuY29tPiB3cml0ZXM6DQo+IA0KPiA+
IA0KPiA+IEhpLA0KPiA+IA0KPiA+IE9uIFdlZCwgT2N0IDE5LCAyMDE2IGF0IDI6MDQgUE0sIERl
bm5pcyBLYWFyc2VtYWtlcg0KPiA+IDxkZW5uaXNAa2FhcnNlbWFrZXIubmV0PiB3cm90ZToNCj4g
PiA+IA0KPiA+ID4gQ29tbWl0IDY2MGUxMTMgKGdyYXBoOiBhZGQgc3VwcG9ydCBmb3IgLS1saW5l
LXByZWZpeCBvbiBhbGwNCj4gPiA+IGdyYXBoLWF3YXJlDQo+ID4gPiBvdXRwdXQpIGNoYW5nZWQg
dGhlIHdheSBjb21taXRzIHdlcmUgc2hvd24uIFVuZm9ydHVuYXRlbHkgdGhpcw0KPiA+ID4gZHJv
cHBlZA0KPiA+ID4gdGhlIE5VTCBiZXR3ZWVuIGNvbW1pdHMgaW4gLS1oZWFkZXIgbW9kZS4gUmVz
dG9yZSB0aGUgTlVMIGFuZCBhZGQNCj4gPiA+IGEgdGVzdA0KPiA+ID4gZm9yIHRoaXMgZmVhdHVy
ZS4NCj4gPiA+IA0KPiA+IA0KPiA+IE9vcHMhIFRoYW5rcyBmb3IgdGhlIGJ1ZyBmaXguDQo+ID4g
DQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IERlbm5pcyBLYWFyc2VtYWtlciA8ZGVubmlz
QGthYXJzZW1ha2VyLm5ldD4NCj4gPiA+IC0tLQ0KPiA+ID4gwqBidWlsdGluL3Jldi1saXN0LmPC
oMKgwqDCoMKgwqDCoHwgNCArKysrDQo+ID4gPiDCoHQvdDYwMDAtcmV2LWxpc3QtbWlzYy5zaCB8
IDcgKysrKysrKw0KPiA+ID4gwqAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykNCj4g
PiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2J1aWx0aW4vcmV2LWxpc3QuYyBiL2J1aWx0aW4vcmV2
LWxpc3QuYw0KPiA+ID4gaW5kZXggODQ3OWY2ZS4uY2ZhNmE3ZCAxMDA2NDQNCj4gPiA+IC0tLSBh
L2J1aWx0aW4vcmV2LWxpc3QuYw0KPiA+ID4gKysrIGIvYnVpbHRpbi9yZXYtbGlzdC5jDQo+ID4g
PiBAQCAtMTU3LDYgKzE1NywxMCBAQCBzdGF0aWMgdm9pZCBzaG93X2NvbW1pdChzdHJ1Y3QgY29t
bWl0DQo+ID4gPiAqY29tbWl0LCB2b2lkICpkYXRhKQ0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldnMtPmNvbW1pdF9mb3JtYXQgPT0N
Cj4gPiA+IENNSVRfRk1UX09ORUxJTkUpDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcHV0Y2hhcignXG4nKTsNCj4g
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQ0KPiA+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGlmIChyZXZzLT5jb21taXRfZm9ybWF0ID09IENNSVRfRk1UX1JB
Vykgew0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBwdXRjaGFyKGluZm8tPmhkcl90ZXJtaW5hdGlvbik7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgfQ0KPiA+ID4gKw0KPiA+IA0KPiA+IFRoaXMgc2VlbXMgcmlnaHQgdG8g
bWUuIE15IG9uZSBjb25jZXJuIGlzIHRoYXQgd2UgbWFrZSBzdXJlIHdlDQo+ID4gcmVzdG9yZQ0K
PiA+IGl0IGZvciBldmVyeSBjYXNlIChpbiBjYXNlIGl0IG5lZWRzIHRvIGJlIHRoZXJlIGZvciBv
dGhlciBmb3JtYXRzPykNCj4gPiBJJ20gbm90IGVudGlyZWx5IHN1cmUgYWJvdXQgd2hldGhlciBv
dGhlciBub24tcmF3IG1vZGVzIG5lZWQgdGhpcw0KPiA+IG9yDQo+ID4gbm90Pw0KPiANCj4gUmln
aHQuwqDCoFRoZSBvcmlnaW5hbCBkaWRuJ3QgZG8gYW55dGhpbmcgc3BlY2lhbCBmb3IgQ01JVF9G
TVRfUkFXLA0KPiBhbmQgNjYwZTExMyBkaWQgbm90IHJlbW92ZSBhbnl0aGluZyBzcGVjaWFsIGZv
ciBDTUlUX0ZNVF9SQVcsIHNvIGl0DQo+IGlzbid0IGltbWVkaWF0ZWx5IG9idmlvdXMgd2h5IHRo
aXMgcGF0Y2ggaXMgc3VmZmljaWVudC7CoMKgDQo+IA0KPiBEZW5uaXMsIGNhcmUgdG8gZWxhYm9y
YXRlPw0KDQpJIGJlbGlldmUgYWxsIHdlIG5lZWQgdG8gZG8gaXMgY2hhbmdlIG9uZSBvZiB0aGUg
cGxhY2VzIHdoZXJlIHdlIGVtaXQNCiJcbiIgd2l0aCBlbWl0aW5nIGluZm8tPmhkcl90ZXJtaW5h
dGlvbiBpbnN0ZWFkLg0KDQpJJ20gbG9va2luZyBhdCB0aGUgb3JpZ2luYWwgY29kZSBub3cuDQoN
ClRoYW5rcywNCkpha2U=
