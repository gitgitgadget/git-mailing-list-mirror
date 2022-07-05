Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E48CCA47F
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 15:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiGEPZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 11:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiGEPZS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 11:25:18 -0400
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0941A183A7
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 08:25:14 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,247,1650902400"; 
   d="scan'208";a="26974364"
Received: from hk-mbx01.mioffice.cn (HELO xiaomi.com) ([10.56.8.121])
  by outboundhk.mxmail.xiaomi.com with ESMTP; 05 Jul 2022 23:25:13 +0800
Received: from BJ-MBX04.mioffice.cn (10.237.8.124) by HK-MBX01.mioffice.cn
 (10.56.8.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 5 Jul 2022
 23:25:13 +0800
Received: from BJ-MBX01.mioffice.cn (10.237.8.121) by BJ-MBX04.mioffice.cn
 (10.237.8.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 5 Jul 2022
 23:25:12 +0800
Received: from BJ-MBX01.mioffice.cn ([fe80::5cd6:7afe:4dcf:69a6]) by
 BJ-MBX01.mioffice.cn ([fe80::5cd6:7afe:4dcf:69a6%9]) with mapi id
 15.02.0986.026; Tue, 5 Jul 2022 23:25:12 +0800
From:   =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
CC:     =?utf-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        =?utf-8?B?WGluNyBNYSDpqazpkas=?= <maxin7@xiaomi.com>
Subject: RE: [External Mail]Re: Git fork process infinitely and never stop
Thread-Topic: [External Mail]Re: Git fork process infinitely and never stop
Thread-Index: AdiPihh3UxZZstBISFy+uEVc/YzhjAAnjPMAABMHSwA=
Date:   Tue, 5 Jul 2022 15:25:12 +0000
Message-ID: <8ccd27ef3a344596b6237e98e1a5f204@xiaomi.com>
References: <9d3b79239a314f72a099040a26ef9ad8@xiaomi.com>
 <8e1d019e-6456-ed05-7d3e-a0c4beeb35fa@gmail.com>
In-Reply-To: <8e1d019e-6456-ed05-7d3e-a0c4beeb35fa@gmail.com>
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

LSBnaXQgdmVyc2lvbjoNCjIuMzYuMQ0KLSBzdGVwcyB0byByZXByb2R1Y2UgdGhlIGJ1Zw0KOiBX
ZSBoYXZlIG5vIGlkZWEgYWN0dWFsbHkuIFdlJ3JlIG1haW50YWluZXIgb2Ygb3VyIGludGVybmFs
IGdpdC9nZXJyaXQuIFdlIGZvdW5kIHNvbWV0aW1lcyBzb21lIHVzZXIgd2lsbCBpbnZva2UgMTAw
KyB0aHJlYWRzIHRvIGNsb25lIHRoZSBzYW1lIHJlcG9zaXRvcnkuIEFuZCB3aGVuIHdlIGFzayB0
aG9zZSBndXksIHRoZXkgc2F5IHRoZXkgb25seSBleGVjdXRlZCB0aGUgImdpdCBmZXRjaCIgb25j
ZS4gQW5kIGp1c3QgbGlrZSB0aGUgeW91dHViZSB2aWRlaW8sIHlvdSB3aWxsIGZpbmQgZ2l0IGZv
cmsgYSBjaGlsZCBnaXQsIGFuZCB0aGVuIGdyYW5kc29uIGNoaWxkIGdpdCwgYW5kIGxvb3AgbGlr
ZSB0aGlzIGZvcmV2ZXIgdW50aWwgdGhlIHNlcnZlciBkb3duLg0KSWYgd2UgY29weSB0aGVpciBs
b2NhbCByZXBvc2l0b3J5IHRvIG91ciBvd24gUEMsIGFuZCB0aGVuIGV4ZWN1dGUgYGdpdCBmZXRj
aGAsIHdlIGNhbiBhbHNvIHJlcHJvZHVjZSBpdC4gSXQgc2VlbXMgdGhhdCBzb21lIGJyb2tlbiBs
b2NhbCBnaXQgZmlsZXMgY2F1c2UgdGhpcyBidWcNCi0gd2hhdCB5b3UgZXhwZWN0IGFuZCBhY3R1
YWwgYmVoYXZpb3IsIGFzIHdlbGwgYXMgdGhlIGRpZmZlcmVuY2VzDQpNZW50aW9uZWQgYWJvdmUN
Ci0gc3lzdGVtIGluZm8NCiAgICAgICAgICAgICBVYnVudHUgIDE4LjA0DQotIG1pc2NlbGxhbmVv
dXMNCk4vQQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQmFnYXMgU2FuamF5
YSA8YmFnYXNkb3RtZUBnbWFpbC5jb20+DQpTZW50OiBUdWVzZGF5LCBKdWx5IDUsIDIwMjIgODoz
MyBQTQ0KVG86IOeoi+a0iyA8Y2hlbmd5YW5nQHhpYW9taS5jb20+OyBnaXRAdmdlci5rZXJuZWwu
b3JnDQpDYzog5L2V5rWpIDxoZWhhb0B4aWFvbWkuY29tPjsgWGluNyBNYSDpqazpkasgPG1heGlu
N0B4aWFvbWkuY29tPg0KU3ViamVjdDogW0V4dGVybmFsIE1haWxdUmU6IEdpdCBmb3JrIHByb2Nl
c3MgaW5maW5pdGVseSBhbmQgbmV2ZXIgc3RvcA0KDQpb5aSW6YOo6YKu5Lu2XSDmraTpgq7ku7bm
naXmupDkuo7lsI/nsbPlhazlj7jlpJbpg6jvvIzor7fosKjmhY7lpITnkIbjgIINCg0KT24gNy80
LzIyIDE2OjQ0LCDnqIvmtIsgd3JvdGU6DQo+IEdpdCBWZXJzaW9uOiAyLjM2LjENCj4NCj4gSW4g
c29tZSBjaXJjdW1zdGFuY2UsIEdpdCB3aWxsIGZvcmsgY2hpbGQgcHJvY2VzcyBmb3JldmVyIHVu
dGlsIG15IFBDIGNyYXNoLg0KPiBJIGRvbuKAmXQgdW5kZXJzdGFuZCB3aHkgYW5kIEkgZG9u4oCZ
dCBrbm93IHdoYXQgbG9nIG9yIGluZm9ybWF0aW9uIEkNCj4gc2hvdWxkIHByb3ZpZGUgRGV0YWls
cyBhcmUgc2hvd2VkIGluIHRoaXMgWW91dHViZSB2aWRlby4gUGxlYXNlIGZlZWwgZnJlZSB0byBh
c2sgaWYgSSBjYW4gcHJvdmlkZSBhbnl0aGluZy4NCj4NCg0KSGkgYW5kIHdlbGNvbWUgdG8gR2l0
IG1haWxpbmcgbGlzdCENCg0KRm9yIHRoaXMgYnVnIHJlcG9ydCB0byBiZSB1c2VmdWwsIHBsZWFz
ZSBpbmNsdWRlIGZvbGxvd2luZyBpbmZvcm1hdGlvbiwgaW5saW5lIGluIHlvdXIgZW1haWw6DQot
IGdpdCB2ZXJzaW9uDQotIHN0ZXBzIHRvIHJlcHJvZHVjZSB0aGUgYnVnDQotIHdoYXQgeW91IGV4
cGVjdCBhbmQgYWN0dWFsIGJlaGF2aW9yLCBhcyB3ZWxsIGFzIHRoZSBkaWZmZXJlbmNlcw0KLSBz
eXN0ZW0gaW5mbw0KLSBtaXNjZWxsYW5lb3VzDQoNCkFuZCBkb24ndCBmb3JnZXQgdG8gc2VuZCBh
cyBwbGFpbnRleHQgZW1haWwuDQoNClRoYW5rcy4NCg0KLS0NCkFuIG9sZCBtYW4gZG9sbC4uLiBq
dXN0IHdoYXQgSSBhbHdheXMgd2FudGVkISAtIENsYXJhDQojLyoqKioqKuacrOmCruS7tuWPiuWF
tumZhOS7tuWQq+acieWwj+exs+WFrOWPuOeahOS/neWvhuS/oeaBr++8jOS7hemZkOS6juWPkemA
gee7meS4iumdouWcsOWdgOS4reWIl+WHuueahOS4quS6uuaIlue+pOe7hOOAguemgeatouS7u+S9
leWFtuS7luS6uuS7peS7u+S9leW9ouW8j+S9v+eUqO+8iOWMheaLrOS9huS4jemZkOS6juWFqOmD
qOaIlumDqOWIhuWcsOazhOmcsuOAgeWkjeWItuOAgeaIluaVo+WPke+8ieacrOmCruS7tuS4reea
hOS/oeaBr+OAguWmguaenOaCqOmUmeaUtuS6huacrOmCruS7tu+8jOivt+aCqOeri+WNs+eUteiv
neaIlumCruS7tumAmuefpeWPkeS7tuS6uuW5tuWIoOmZpOacrOmCruS7tu+8gSBUaGlzIGUtbWFp
bCBhbmQgaXRzIGF0dGFjaG1lbnRzIGNvbnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGZy
b20gWElBT01JLCB3aGljaCBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVudGl0
eSB3aG9zZSBhZGRyZXNzIGlzIGxpc3RlZCBhYm92ZS4gQW55IHVzZSBvZiB0aGUgaW5mb3JtYXRp
b24gY29udGFpbmVkIGhlcmVpbiBpbiBhbnkgd2F5IChpbmNsdWRpbmcsIGJ1dCBub3QgbGltaXRl
ZCB0bywgdG90YWwgb3IgcGFydGlhbCBkaXNjbG9zdXJlLCByZXByb2R1Y3Rpb24sIG9yIGRpc3Nl
bWluYXRpb24pIGJ5IHBlcnNvbnMgb3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMp
IGlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNlaXZlIHRoaXMgZS1tYWlsIGluIGVycm9yLCBwbGVh
c2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcGhvbmUgb3IgZW1haWwgaW1tZWRpYXRlbHkgYW5kIGRl
bGV0ZSBpdCEqKioqKiovIw0K
