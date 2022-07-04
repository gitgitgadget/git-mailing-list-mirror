Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE4BC43334
	for <git@archiver.kernel.org>; Mon,  4 Jul 2022 09:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbiGDJqR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 05:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbiGDJqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 05:46:09 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Jul 2022 02:46:01 PDT
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F338DEBC
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 02:46:01 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="26851081"
Received: from hk-mbx03.mioffice.cn (HELO xiaomi.com) ([10.56.8.123])
  by outboundhk.mxmail.xiaomi.com with ESMTP; 04 Jul 2022 17:44:58 +0800
Received: from BJ-MBX02.mioffice.cn (10.237.8.122) by HK-MBX03.mioffice.cn
 (10.56.8.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 4 Jul 2022
 17:44:58 +0800
Received: from BJ-MBX01.mioffice.cn (10.237.8.121) by BJ-MBX02.mioffice.cn
 (10.237.8.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 4 Jul 2022
 17:44:57 +0800
Received: from BJ-MBX01.mioffice.cn ([fe80::5cd6:7afe:4dcf:69a6]) by
 BJ-MBX01.mioffice.cn ([fe80::5cd6:7afe:4dcf:69a6%9]) with mapi id
 15.02.0986.026; Mon, 4 Jul 2022 17:44:57 +0800
From:   =?gb2312?B?s8zR8w==?= <chengyang@xiaomi.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     =?gb2312?B?us66xg==?= <hehao@xiaomi.com>,
        =?gb2312?B?WGluNyBNYSDC7fbO?= <maxin7@xiaomi.com>
Subject: Git fork process infinitely and never stop
Thread-Topic: Git fork process infinitely and never stop
Thread-Index: AdiPihh3UxZZstBISFy+uEVc/YzhjA==
Date:   Mon, 4 Jul 2022 09:44:57 +0000
Message-ID: <9d3b79239a314f72a099040a26ef9ad8@xiaomi.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.237.8.11]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

R2l0IFZlcnNpb246IDIuMzYuMQ0KDQpJbiBzb21lIGNpcmN1bXN0YW5jZSwgR2l0IHdpbGwgZm9y
ayBjaGlsZCBwcm9jZXNzIGZvcmV2ZXIgdW50aWwgbXkgUEMgY3Jhc2guDQpJIGRvbqGvdCB1bmRl
cnN0YW5kIHdoeSBhbmQgSSBkb26hr3Qga25vdyB3aGF0IGxvZyBvciBpbmZvcm1hdGlvbiBJIHNo
b3VsZCBwcm92aWRlDQpEZXRhaWxzIGFyZSBzaG93ZWQgaW4gdGhpcyBZb3V0dWJlIHZpZGVvLiBQ
bGVhc2UgZmVlbCBmcmVlIHRvIGFzayBpZiBJIGNhbiBwcm92aWRlIGFueXRoaW5nLg0KDQpodHRw
czovL3d3dy55b3V0dWJlLmNvbS93YXRjaD92PURUWHZnS1lqeTVrDQojLyoqKioqKrG+08q8/ryw
xuS4vbz+uqzT0NChw9e5q8u+tcSxo8Pc0MXPoqOsvfbP3tPat6LLzbj4yc/D5rXY1rfW0MHQs/a1
xLj2yMu78si61+mho7371rnIzrrOxuTL+8jL0tTIzrrO0M7Kvcq508OjqLD8wKi1q7K7z97T2sir
sr+78rK/t9a12NC5wrahori01sahorvyyaK3oqOpsb7Tyrz+1tC1xNDFz6Kho8jnufvE+rTtytXB
y7G+08q8/qOsx+vE+sGivLS157uwu/LTyrz+zajWqreivP7Iy7Kiyb6z/bG+08q8/qOhIFRoaXMg
ZS1tYWlsIGFuZCBpdHMgYXR0YWNobWVudHMgY29udGFpbiBjb25maWRlbnRpYWwgaW5mb3JtYXRp
b24gZnJvbSBYSUFPTUksIHdoaWNoIGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJzb24gb3Ig
ZW50aXR5IHdob3NlIGFkZHJlc3MgaXMgbGlzdGVkIGFib3ZlLiBBbnkgdXNlIG9mIHRoZSBpbmZv
cm1hdGlvbiBjb250YWluZWQgaGVyZWluIGluIGFueSB3YXkgKGluY2x1ZGluZywgYnV0IG5vdCBs
aW1pdGVkIHRvLCB0b3RhbCBvciBwYXJ0aWFsIGRpc2Nsb3N1cmUsIHJlcHJvZHVjdGlvbiwgb3Ig
ZGlzc2VtaW5hdGlvbikgYnkgcGVyc29ucyBvdGhlciB0aGFuIHRoZSBpbnRlbmRlZCByZWNpcGll
bnQocykgaXMgcHJvaGliaXRlZC4gSWYgeW91IHJlY2VpdmUgdGhpcyBlLW1haWwgaW4gZXJyb3Is
IHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieSBwaG9uZSBvciBlbWFpbCBpbW1lZGlhdGVseSBh
bmQgZGVsZXRlIGl0ISoqKioqKi8jDQo=
