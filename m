Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD6CC1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 00:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeBWAlm (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 19:41:42 -0500
Received: from mails1.kns.com ([199.171.180.11]:37537 "EHLO Mails1.kns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751775AbeBWAll (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 19:41:41 -0500
X-ASG-Debug-ID: 1519346499-0a96b614061bac10001-QuoKaX
Received: from USEPRDEX1.corp.kns.com (useprdex1.corp.kns.com [10.40.10.30]) by Mails1.kns.com with ESMTP id 9ryGh1Qrt6Zhq8Yq; Thu, 22 Feb 2018 19:41:39 -0500 (EST)
X-Barracuda-Envelope-From: mfriedrich@kns.com
Received: from USEPRDEX2.corp.kns.com (10.40.10.31) by USEPRDEX1.corp.kns.com
 (10.40.10.30) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Thu, 22 Feb
 2018 19:41:35 -0500
Received: from USEPRDEX2.corp.kns.com ([fe80::c152:b74f:f217:7b3f]) by
 USEPRDEX2.corp.kns.com ([fe80::c152:b74f:f217:7b3f%22]) with mapi id
 15.00.1263.000; Thu, 22 Feb 2018 19:41:35 -0500
From:   Mike Friedrich <mfriedrich@kns.com>
To:     Stefan Beller <sbeller@google.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: removed submodules shown as untracked when switching branches
Thread-Topic: removed submodules shown as untracked when switching branches
X-ASG-Orig-Subj: RE: removed submodules shown as untracked when switching branches
Thread-Index: AdOsGWaWcRU9e7ZFTuWRD2s0N7udswASNT6AAAkBTKA=
Date:   Fri, 23 Feb 2018 00:41:35 +0000
Message-ID: <ed3eddb3da05471c8195326043f46740@USEPRDEX2.corp.kns.com>
References: <6add3709b4eb469bb7c8d6319637b53a@USEPRDEX2.corp.kns.com>
 <CAGZ79kYS_yJs2uFqLDwCgq4W0HrnMxZcCx8-dTXYf3hpPZYWFg@mail.gmail.com>
In-Reply-To: <CAGZ79kYS_yJs2uFqLDwCgq4W0HrnMxZcCx8-dTXYf3hpPZYWFg@mail.gmail.com>
Accept-Language: en-US, en-GB, de-CH
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.40.22.144]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Barracuda-Connect: useprdex1.corp.kns.com[10.40.10.30]
X-Barracuda-Start-Time: 1519346499
X-Barracuda-URL: https://Mails1.kns.com:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 1564
X-Virus-Scanned: by bsmtpd at kns.com
X-Barracuda-Malware-Scanned: by bsmtpd at kns.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.48221
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmsgWW91LiBUaGlzIGlzIGludGVyZXN0aW5nLiBUaGVyZSBzZWVtcyB0byBiZSBhbHNvIGEg
Y29uZmlnIG9wdGlvbiBzdWJtb2R1bGUucmVjdXJzZS4gSSBkaWQgbm90IGtub3cgdGhhdCB0aGVz
ZSBvcHRpb25zIGhhdmUgc3VjaCBhbiBlZmZlY3Qgb24gdGhlIGNoZWNrb3V0IGNvbW1hbmQuDQoN
CkJlc3QgUmVnYXJkcywgTWlrZQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTog
U3RlZmFuIEJlbGxlciBbbWFpbHRvOnNiZWxsZXJAZ29vZ2xlLmNvbV0NClNlbnQ6IFRodXJzZGF5
LCBGZWJydWFyeSAyMiwgMjAxOCA2OjUzIFBNDQpUbzogTWlrZSBGcmllZHJpY2ggPG1mcmllZHJp
Y2hAa25zLmNvbT4NCkNjOiBnaXRAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogcmVtb3Zl
ZCBzdWJtb2R1bGVzIHNob3duIGFzIHVudHJhY2tlZCB3aGVuIHN3aXRjaGluZyBicmFuY2hlcw0K
DQpPbiBUaHUsIEZlYiAyMiwgMjAxOCBhdCAxMjoyNiBQTSwgTWlrZSBGcmllZHJpY2ggPG1mcmll
ZHJpY2hAa25zLmNvbT4gd3JvdGU6DQoNCj4gICAgIGdpdCBzdWJtb2R1bGUgYWRkIC4uL3N1Ym1v
ZHVsZSBzdWINCj4gICAgIGdpdCBhZGQgc3ViDQo+ICAgICBnaXQgY29tbWl0IC1tICJzdWJtb2R1
bGUgYWRkZWQiDQo+DQo+ICAgICBnaXQgY2hlY2tvdXQgbWFzdGVyDQoNClRoZSBvcmlnaW5hbCBi
ZWhhdmlvciBvZiBjaGVja291dCBpcyB0byBpZ25vcmUgc3VibW9kdWxlcywgaGVuY2UgaXQgd2ls
bCBiZSBsZWZ0IGFsb25lLg0KQ2FuIHlvdSByZXRyeSB0aGlzIHJlY2lwZSB3aXRoIC0tcmVjdXJz
ZS1zdWJtb2R1bGVzIGdpdmVuIHRvIGNoZWNrb3V0Lg0KKE9yIHJhdGhlciBydW4gImdpdCBjb25m
aWcgc3VibW9kdWxlLnJlY3Vyc2UgdHJ1ZSIgb25jZSkNCg0KVGhhbmtzLA0KU3RlZmFuDQoNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQoNClRoaXMgZW1haWwgaXMgbm9uLWJpbmRp
bmcsIGlzIHN1YmplY3QgdG8gY29udHJhY3QsIGFuZCBuZWl0aGVyIEt1bGlja2UgYW5kIFNvZmZh
IEluZHVzdHJpZXMsIEluYy4gbm9yIGl0cyBzdWJzaWRpYXJpZXMgKGVhY2ggYW5kIGNvbGxlY3Rp
dmVseSDigJxLJlPigJ0pIHNoYWxsIGhhdmUgYW55IG9ibGlnYXRpb24gdG8geW91IHRvIGNvbnN1
bW1hdGUgdGhlIHRyYW5zYWN0aW9ucyBoZXJlaW4gb3IgdG8gZW50ZXIgaW50byBhbnkgYWdyZWVt
ZW50LCBvdGhlciB0aGFuIGluIGFjY29yZGFuY2Ugd2l0aCB0aGUgdGVybXMgYW5kIGNvbmRpdGlv
bnMgb2YgYSBkZWZpbml0aXZlIGFncmVlbWVudCBpZiBhbmQgd2hlbiBuZWdvdGlhdGVkLCBmaW5h
bGl6ZWQgYW5kIGV4ZWN1dGVkIGJldHdlZW4gdGhlIHBhcnRpZXMuIFRoaXMgZW1haWwgYW5kIGFs
bCBpdHMgY29udGVudHMgYXJlIHByb3RlY3RlZCBieSBJbnRlcm5hdGlvbmFsIGFuZCBVbml0ZWQg
U3RhdGVzIGNvcHlyaWdodCBsYXdzLiBBbnkgcmVwcm9kdWN0aW9uIG9yIHVzZSBvZiBhbGwgb3Ig
YW55IHBhcnQgb2YgdGhpcyBlbWFpbCB3aXRob3V0IHRoZSBleHByZXNzIHdyaXR0ZW4gY29uc2Vu
dCBvZiBLJlMgaXMgcHJvaGliaXRlZC4NCg==
