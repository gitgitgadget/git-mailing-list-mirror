Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40CCC43334
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 14:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbiGFODR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 10:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiGFODO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 10:03:14 -0400
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C9CD18E13
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 07:03:11 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,250,1650902400"; 
   d="scan'208";a="29079390"
Received: from hk-mbx02.mioffice.cn (HELO xiaomi.com) ([10.56.8.122])
  by outboundhk.mxmail.xiaomi.com with ESMTP; 06 Jul 2022 22:03:09 +0800
Received: from BJ-MBX02.mioffice.cn (10.237.8.122) by HK-MBX02.mioffice.cn
 (10.56.8.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 6 Jul 2022
 22:03:09 +0800
Received: from BJ-MBX01.mioffice.cn (10.237.8.121) by BJ-MBX02.mioffice.cn
 (10.237.8.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 6 Jul 2022
 22:03:08 +0800
Received: from BJ-MBX01.mioffice.cn ([fe80::5cd6:7afe:4dcf:69a6]) by
 BJ-MBX01.mioffice.cn ([fe80::5cd6:7afe:4dcf:69a6%9]) with mapi id
 15.02.0986.026; Wed, 6 Jul 2022 22:03:08 +0800
From:   =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
To:     "lilinchao@oschina.cn" <lilinchao@oschina.cn>,
        Bagas Sanjaya <bagasdotme@gmail.com>, git <git@vger.kernel.org>
CC:     =?utf-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        =?utf-8?B?WGluNyBNYSDpqazpkas=?= <maxin7@xiaomi.com>
Subject: =?utf-8?B?5Zue5aSNOiBSRTogW0V4dGVybmFsIE1haWxdUmU6IEdpdCBmb3JrIHByb2Nl?=
 =?utf-8?Q?ss_infinitely_and_never_stop?=
Thread-Topic: RE: [External Mail]Re: Git fork process infinitely and never
 stop
Thread-Index: AdiPihh3UxZZstBISFy+uEVc/YzhjAAnjPMAABMHSwAAJSsJZQANbb+g
Date:   Wed, 6 Jul 2022 14:03:08 +0000
Message-ID: <e071496cfdb04cce8eac322febb6af45@xiaomi.com>
References: <9d3b79239a314f72a099040a26ef9ad8@xiaomi.com>,
        <8e1d019e-6456-ed05-7d3e-a0c4beeb35fa@gmail.com>,
        <8ccd27ef3a344596b6237e98e1a5f204@xiaomi.com>
 <202207061520052718298@oschina.cn>
In-Reply-To: <202207061520052718298@oschina.cn>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.237.8.11]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VG8gbGlsaW5jaGFvOg0KPlNvIHRoZSByZXBvICJnaXQvZ2Vycml0IiBpcyBob3N0ZWQgaW4geW91
ciBsb2NhbD8gYW5kIGhvdyB5b3UgImNvcHkiIGl0IHRvIHlvdXIgb3duIFBDPw0KMS4gZ2l0L2dl
cnJpdCBpcyBob3N0ZWQgb24gcmVtb3RlIHNlcnZlcg0KICAgICAgICAgICAgICAgMi4gSSBqdXN0
IHNjcCB0aGUgd2hvbGUgcmVwb3NpdG9yeSBvZiB0aGUgdXNlciB3aG8gcmVwcm9kdWNlIHRoZSBw
cm9ibGVtIHRvIG91ciBvd24gUEMuIEFuZCB0aGVuIHdlIGNhbiByZXByb2R1Y2UgaXQgb24gb3Vy
IG93biBQQy4NCg0KVG8gSm9oYW5uZXM6DQo+IEhvb2tzIG1heSBhbHNvIHBsYXkgYSByb2xlLg0K
V2UgZG8gaGF2ZSBzb21lIGhvb2tzLiBCdXQgSSBkb24ndCB0aGluayB0aGV5J3JlIHJlbGF0ZWQu
IEJlY2F1c2UgZXZlbiBJIGRlbGV0ZSB0aG9zZSBob29rcywgdGhlIHByb2JsZW0gc3RhbmRzIHN0
aWxsDQoNClRvIMOGdmFyIEFybmZqw7Zyw7A6DQo+SSBhc3N1bWUgeW91IGNhbid0IHNoYXJlIHRo
ZSByZXBvLCBidXQgcGVyaGFwcyB0cnkgaWYgeW91IGNhbiByZXByb2R1Y2UgaXQgd2l0aCBhICJn
aXQgZmFzdC1leHBvcnQgLS1hbm9ueW1pemUiIHZlcnNpb24gb2YgaXQsIGFuZCBpZiBzbyB3aGV0
aGVyIHlvdSdkIGJlIHdpbGxpbmcgdG8gc2hhcmUgdGhhdC4gSXQgd2lsbCBwdWJsaXNoIHRoZSAi
c2hhcGUgb2YgdGhlIGhpc3RvcnkiIG9mIHRoZSByZXBvLCBidXQgbm90IGFueSBtZWFuaW5nZnVs
IGRhdGEgKGFsbCBjb21taXRzLCB0cmVlcywgYmxvYnMgZXRjLiBhcmUgcmVwbGFjZWQpLg0KYGdp
dCBmYXN0LWV4cG9ydCAtLWFub255bWl6ZWAganVzdCBvdXRwdXQgaXMgZW1wdHkuIElmIEkgdHJ5
IGBnaXQgZmFzdC1leHBvcnQgLS1hbm9ueW1pemUgLS1hbGxgLCBpdCBzZWVtcyB0byBmZXRjaCBm
aXJzdCwgd2hpY2ggZ29lcyBpbnRvIHRoZSBpbmZpbml0ZSBsb29wIGFnYWluDQoNCj5UaGUgWW91
VHViZSB2aWRlbyBzaG93cyB0aGF0IHlvdSdyZSB1c2luZyB2YXJpb3VzIG9wdGlvbnMgdG8gZ2l0
LWZldGNoLCBpbmNsdWRpbmcgZmlsdGVycywgcmVmc3BlY3MgZXRjLiBEb2VzIGEgcGxhaW4gImdp
dCBmZXRjaCIgcmVwcm9kdWNlIHRoaXMsIGFuZCBpZiBub3Qgd2hhdCdzIHRoZSBvcHRpb24gKHRy
eSBhZGRpbmcgdGhlbSBvbmUgYXQgYSB0aW1lICYNCj5leHBlcmltZW50KSB0aGF0IG5lZWRzIHRv
IGJlIGFkZGVkIHRvIHRyaWdnZXIgdGhpcz8NCg0KYGdpdCBmZXRjaGAgYWxzbyBoYXMgdGhpcyBw
cm9ibGVtLg0KDQpJIHNvbWV3aGF0IHN1c3BlY3Qgc29tZSAtLWZpbHRlciBmdW5ueSBidXNpbmVz
cywgYnV0IHRoYXQncyBqdXN0IGEgaHVuY2guLi4NCkl0IHNlZW1zIHRvIGhhcHBlbiBhZnRlciBJ
IHRvbGQgbXkgdGVhbSB0byB1c2UgInBhcnRpYWwtY2xvbmUiIEFORCAiZ2l0IHYyLjM2LjEiLiAg
SSdtIG5vdCBzdXJlIHdoaWNoIG9uZSBpcyB0aGUgY2F1c2Ugb3IgYm90aCBvZiB0aGVtIGNhdXNl
IHRoaXMuDQojLyoqKioqKuacrOmCruS7tuWPiuWFtumZhOS7tuWQq+acieWwj+exs+WFrOWPuOea
hOS/neWvhuS/oeaBr++8jOS7hemZkOS6juWPkemAgee7meS4iumdouWcsOWdgOS4reWIl+WHuuea
hOS4quS6uuaIlue+pOe7hOOAguemgeatouS7u+S9leWFtuS7luS6uuS7peS7u+S9leW9ouW8j+S9
v+eUqO+8iOWMheaLrOS9huS4jemZkOS6juWFqOmDqOaIlumDqOWIhuWcsOazhOmcsuOAgeWkjeWI
tuOAgeaIluaVo+WPke+8ieacrOmCruS7tuS4reeahOS/oeaBr+OAguWmguaenOaCqOmUmeaUtuS6
huacrOmCruS7tu+8jOivt+aCqOeri+WNs+eUteivneaIlumCruS7tumAmuefpeWPkeS7tuS6uuW5
tuWIoOmZpOacrOmCruS7tu+8gSBUaGlzIGUtbWFpbCBhbmQgaXRzIGF0dGFjaG1lbnRzIGNvbnRh
aW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGZyb20gWElBT01JLCB3aGljaCBpcyBpbnRlbmRl
ZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVudGl0eSB3aG9zZSBhZGRyZXNzIGlzIGxpc3RlZCBh
Ym92ZS4gQW55IHVzZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVpbiBpbiBhbnkg
d2F5IChpbmNsdWRpbmcsIGJ1dCBub3QgbGltaXRlZCB0bywgdG90YWwgb3IgcGFydGlhbCBkaXNj
bG9zdXJlLCByZXByb2R1Y3Rpb24sIG9yIGRpc3NlbWluYXRpb24pIGJ5IHBlcnNvbnMgb3RoZXIg
dGhhbiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNl
aXZlIHRoaXMgZS1tYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcGhv
bmUgb3IgZW1haWwgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSBpdCEqKioqKiovIw0K
