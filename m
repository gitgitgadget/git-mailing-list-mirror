Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62BC92042F
	for <e@80x24.org>; Wed, 16 Nov 2016 15:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751670AbcKPPsU (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 10:48:20 -0500
Received: from sp-internet-ext-ply.uhc.com ([198.203.175.175]:41712 "EHLO
        mail6.uhc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751741AbcKPPsT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 10:48:19 -0500
X-IronPort-AV: E=Sophos;i="5.31,500,1473138000"; 
   d="scan'208";a="631678930"
Received: from irmply48.uhc.com (HELO mail26.uhc.com) ([10.114.170.75])
  by mail8.uhc.com with ESMTP; 16 Nov 2016 09:48:18 -0600
X-IronPort-AV: E=Sophos;i="5.31,500,1473138000"; 
   d="scan'208";a="598928033"
X-CONF-FOOTER: True
Received: from apsep0925.ms.ds.uhc.com ([10.114.192.113])
  by mail26.uhc.com with ESMTP; 16 Nov 2016 09:48:18 -0600
Received: from apswp0428.ms.ds.uhc.com ([fe80::7cb7:a560:d0b0:bc2d]) by
 APSEP0925.ms.ds.uhc.com ([fe80::71f3:9715:e387:7dce%18]) with mapi id
 14.03.0279.002; Wed, 16 Nov 2016 09:48:18 -0600
From:   "Vanderhoof, Tzadik" <tzadik.vanderhoof@optum360.com>
To:     Mike Rappazzo <rappazzo@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: merge --no-ff is NOT mentioned in help
Thread-Topic: merge --no-ff is NOT mentioned in help
Thread-Index: AdJAHG6Flm+eVlqaTkiiWd+ULmGgtwANRkoAAAxIIaA=
Date:   Wed, 16 Nov 2016 15:48:18 +0000
Message-ID: <2C8817BDA27E034F8E9A669458E375EF2BE689@APSWP0428.ms.ds.uhc.com>
References: <2C8817BDA27E034F8E9A669458E375EF2BE63B@APSWP0428.ms.ds.uhc.com>
 <CANoM8SX91JAvJ6EAE6=wavPutUG4ZU1BY-A=5EobW=8zrdEcjw@mail.gmail.com>
In-Reply-To: <CANoM8SX91JAvJ6EAE6=wavPutUG4ZU1BY-A=5EobW=8zrdEcjw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.204.2.151]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-IP-VFilter-R: R
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SSBhbSBydW5uaW5nOiAgICBnaXQgdmVyc2lvbiAyLjEwLjEud2luZG93cy4xDQoNCkkgdHlwZWQ6
IGdpdCBtZXJnZSAtaA0KDQphbmQgZ290Og0KDQp1c2FnZTogZ2l0IG1lcmdlIFs8b3B0aW9ucz5d
IFs8Y29tbWl0Pi4uLl0NCiAgIG9yOiBnaXQgbWVyZ2UgWzxvcHRpb25zPl0gPG1zZz4gSEVBRCA8
Y29tbWl0Pg0KICAgb3I6IGdpdCBtZXJnZSAtLWFib3J0DQoNCiAgICAtbiAgICAgICAgICAgICAg
ICAgICAgZG8gbm90IHNob3cgYSBkaWZmc3RhdCBhdCB0aGUgZW5kIG9mIHRoZSBtZXJnZQ0KICAg
IC0tc3RhdCAgICAgICAgICAgICAgICBzaG93IGEgZGlmZnN0YXQgYXQgdGhlIGVuZCBvZiB0aGUg
bWVyZ2UNCiAgICAtLXN1bW1hcnkgICAgICAgICAgICAgKHN5bm9ueW0gdG8gLS1zdGF0KQ0KICAg
IC0tbG9nWz08bj5dICAgICAgICAgICBhZGQgKGF0IG1vc3QgPG4+KSBlbnRyaWVzIGZyb20gc2hv
cnRsb2cgdG8gbWVyZ2UgY29tbWl0IG1lc3NhZ2UNCiAgICAtLXNxdWFzaCAgICAgICAgICAgICAg
Y3JlYXRlIGEgc2luZ2xlIGNvbW1pdCBpbnN0ZWFkIG9mIGRvaW5nIGEgbWVyZ2UNCiAgICAtLWNv
bW1pdCAgICAgICAgICAgICAgcGVyZm9ybSBhIGNvbW1pdCBpZiB0aGUgbWVyZ2Ugc3VjY2VlZHMg
KGRlZmF1bHQpDQogICAgLWUsIC0tZWRpdCAgICAgICAgICAgIGVkaXQgbWVzc2FnZSBiZWZvcmUg
Y29tbWl0dGluZw0KICAgIC0tZmYgICAgICAgICAgICAgICAgICBhbGxvdyBmYXN0LWZvcndhcmQg
KGRlZmF1bHQpDQogICAgLS1mZi1vbmx5ICAgICAgICAgICAgIGFib3J0IGlmIGZhc3QtZm9yd2Fy
ZCBpcyBub3QgcG9zc2libGUNCiAgICAtLXJlcmVyZS1hdXRvdXBkYXRlICAgdXBkYXRlIHRoZSBp
bmRleCB3aXRoIHJldXNlZCBjb25mbGljdCByZXNvbHV0aW9uIGlmIHBvc3NpYmxlDQogICAgLS12
ZXJpZnktc2lnbmF0dXJlcyAgIHZlcmlmeSB0aGF0IHRoZSBuYW1lZCBjb21taXQgaGFzIGEgdmFs
aWQgR1BHIHNpZ25hdHVyZQ0KICAgIC1zLCAtLXN0cmF0ZWd5IDxzdHJhdGVneT4NCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgbWVyZ2Ugc3RyYXRlZ3kgdG8gdXNlDQogICAgLVgsIC0tc3RyYXRl
Z3ktb3B0aW9uIDxvcHRpb249dmFsdWU+DQogICAgICAgICAgICAgICAgICAgICAgICAgIG9wdGlv
biBmb3Igc2VsZWN0ZWQgbWVyZ2Ugc3RyYXRlZ3kNCiAgICAtbSwgLS1tZXNzYWdlIDxtZXNzYWdl
Pg0KICAgICAgICAgICAgICAgICAgICAgICAgICBtZXJnZSBjb21taXQgbWVzc2FnZSAoZm9yIGEg
bm9uLWZhc3QtZm9yd2FyZCBtZXJnZSkNCiAgICAtdiwgLS12ZXJib3NlICAgICAgICAgYmUgbW9y
ZSB2ZXJib3NlDQogICAgLXEsIC0tcXVpZXQgICAgICAgICAgIGJlIG1vcmUgcXVpZXQNCiAgICAt
LWFib3J0ICAgICAgICAgICAgICAgYWJvcnQgdGhlIGN1cnJlbnQgaW4tcHJvZ3Jlc3MgbWVyZ2UN
CiAgICAtLWFsbG93LXVucmVsYXRlZC1oaXN0b3JpZXMNCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgYWxsb3cgbWVyZ2luZyB1bnJlbGF0ZWQgaGlzdG9yaWVzDQogICAgLS1wcm9ncmVzcyAgICAg
ICAgICAgIGZvcmNlIHByb2dyZXNzIHJlcG9ydGluZw0KICAgIC1TLCAtLWdwZy1zaWduWz08a2V5
LWlkPl0NCiAgICAgICAgICAgICAgICAgICAgICAgICAgR1BHIHNpZ24gY29tbWl0DQogICAgLS1v
dmVyd3JpdGUtaWdub3JlICAgIHVwZGF0ZSBpZ25vcmVkIGZpbGVzIChkZWZhdWx0KQ0KDQpOb3Rp
Y2UgdGhlcmUgaXMgTk8gbWVudGlvbiBvZiB0aGUgIi0tbm8tZmYiIG9wdGlvbg0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTWlrZSBSYXBwYXp6byBbbWFpbHRvOnJhcHBhenpv
QGdtYWlsLmNvbV0gDQpTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDE2LCAyMDE2IDc6MzcgQU0N
ClRvOiBWYW5kZXJob29mLCBUemFkaWsNCkNjOiBnaXRAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0
OiBSZTogbWVyZ2UgLS1uby1mZiBpcyBOT1QgbWVudGlvbmVkIGluIGhlbHANCg0KT24gV2VkLCBO
b3YgMTYsIDIwMTYgYXQgMTA6MTYgQU0sIFZhbmRlcmhvb2YsIFR6YWRpayA8dHphZGlrLnZhbmRl
cmhvb2ZAb3B0dW0zNjAuY29tPiB3cm90ZToNCj4gV2hlbiBJIGRvOiAiZ2l0IG1lcmdlIC1oIiAg
dG8gZ2V0IGhlbHAsIHRoZSBvcHRpb24gIi0tbm8tZmYiIGlzIGxlZnQgb3V0IG9mIHRoZSBsaXN0
IG9mIG9wdGlvbnMuDQoNCkkgYW0gcnVubmluZyBnaXQgdmVyc2lvbiAyLjEwLjAsIGFuZCBydW5u
aW5nIGdpdCBtZXJnZSAtLWhlbHAgY29udGFpbnMgdGhlc2UgbGluZXM6DQoNCiAgICAgICAtLWZm
DQogICAgICAgICAgIFdoZW4gdGhlIG1lcmdlIHJlc29sdmVzIGFzIGEgZmFzdC1mb3J3YXJkLCBv
bmx5IHVwZGF0ZSB0aGUgYnJhbmNoIHBvaW50ZXIsIHdpdGhvdXQgY3JlYXRpbmcgYSBtZXJnZSBj
b21taXQuIFRoaXMgaXMgdGhlIGRlZmF1bHQgYmVoYXZpb3IuDQoNCiAgICAgICAtLW5vLWZmDQog
ICAgICAgICAgIENyZWF0ZSBhIG1lcmdlIGNvbW1pdCBldmVuIHdoZW4gdGhlIG1lcmdlIHJlc29s
dmVzIGFzIGEgZmFzdC1mb3J3YXJkLiBUaGlzIGlzIHRoZSBkZWZhdWx0IGJlaGF2aW91ciB3aGVu
IG1lcmdpbmcgYW4gYW5ub3RhdGVkIChhbmQgcG9zc2libHkgc2lnbmVkKSB0YWcuDQoNCiAgICAg
ICAtLWZmLW9ubHkNCiAgICAgICAgICAgUmVmdXNlIHRvIG1lcmdlIGFuZCBleGl0IHdpdGggYSBu
b24temVybyBzdGF0dXMgdW5sZXNzIHRoZSBjdXJyZW50IEhFQUQgaXMgYWxyZWFkeSB1cC10by1k
YXRlIG9yIHRoZSBtZXJnZSBjYW4gYmUgcmVzb2x2ZWQgYXMgYSBmYXN0LWZvcndhcmQuDQoNCg0K
ClRoaXMgZS1tYWlsLCBpbmNsdWRpbmcgYXR0YWNobWVudHMsIG1heSBpbmNsdWRlIGNvbmZpZGVu
dGlhbCBhbmQvb3IKcHJvcHJpZXRhcnkgaW5mb3JtYXRpb24sIGFuZCBtYXkgYmUgdXNlZCBvbmx5
IGJ5IHRoZSBwZXJzb24gb3IgZW50aXR5CnRvIHdoaWNoIGl0IGlzIGFkZHJlc3NlZC4gSWYgdGhl
IHJlYWRlciBvZiB0aGlzIGUtbWFpbCBpcyBub3QgdGhlIGludGVuZGVkCnJlY2lwaWVudCBvciBo
aXMgb3IgaGVyIGF1dGhvcml6ZWQgYWdlbnQsIHRoZSByZWFkZXIgaXMgaGVyZWJ5IG5vdGlmaWVk
CnRoYXQgYW55IGRpc3NlbWluYXRpb24sIGRpc3RyaWJ1dGlvbiBvciBjb3B5aW5nIG9mIHRoaXMg
ZS1tYWlsIGlzCnByb2hpYml0ZWQuIElmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZS1tYWlsIGlu
IGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZQpzZW5kZXIgYnkgcmVwbHlpbmcgdG8gdGhpcyBtZXNz
YWdlIGFuZCBkZWxldGUgdGhpcyBlLW1haWwgaW1tZWRpYXRlbHkuCg==

