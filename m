Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9D5C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 04:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiGKELJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 00:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGKELH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 00:11:07 -0400
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E171636A
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 21:11:05 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,262,1650902400"; 
   d="scan'208";a="29741099"
Received: from hk-mbx02.mioffice.cn (HELO xiaomi.com) ([10.56.8.122])
  by outboundhk.mxmail.xiaomi.com with ESMTP; 11 Jul 2022 12:11:04 +0800
Received: from BJ-MBX07.mioffice.cn (10.237.8.127) by HK-MBX02.mioffice.cn
 (10.56.8.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 11 Jul
 2022 12:11:03 +0800
Received: from BJ-MBX01.mioffice.cn (10.237.8.121) by BJ-MBX07.mioffice.cn
 (10.237.8.127) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 11 Jul
 2022 12:11:03 +0800
Received: from BJ-MBX01.mioffice.cn ([fe80::5cd6:7afe:4dcf:69a6]) by
 BJ-MBX01.mioffice.cn ([fe80::5cd6:7afe:4dcf:69a6%9]) with mapi id
 15.02.0986.026; Mon, 11 Jul 2022 12:11:03 +0800
From:   =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
To:     Carlo Arenas <carenas@gmail.com>, Han Xin <hanxin.hx@bytedance.com>
CC:     "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "derrickstolee@github.com" <derrickstolee@github.com>,
        =?utf-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        "lilinchao@oschina.cn" <lilinchao@oschina.cn>,
        =?utf-8?B?WGluNyBNYSDpqazpkas=?= <maxin7@xiaomi.com>,
        =?utf-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>
Subject: RE: possible bug with commit-graph causing git to fork bomb (was Re:
 [External Mail]Re: Git fork process infinitely and never stop)
Thread-Topic: possible bug with commit-graph causing git to fork bomb (was Re:
 [External Mail]Re: Git fork process infinitely and never stop)
Thread-Index: AQHYkyqfW8rRbTmyTUC0VnyKJLR31610r+CAgABhBoCAA4D9AA==
Date:   Mon, 11 Jul 2022 04:11:03 +0000
Message-ID: <5feb6f6d61b24e3e989a0dbcb70df48b@xiaomi.com>
References: <20220709002658.vt34nnzhxefg72d3@Carlos-MacBook-Pro-2.local>
 <20220709005227.82423-1-hanxin.hx@bytedance.com>
 <CAPUEspiP=U+pBYm3tx1wPc46He=5WKkdFYCr-58a-UfhAD+PUg@mail.gmail.com>
In-Reply-To: <CAPUEspiP=U+pBYm3tx1wPc46He=5WKkdFYCr-58a-UfhAD+PUg@mail.gmail.com>
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

PiBpZiB5b3UgY291bGQgYnVpbGQgYSBuZXcgZ2l0IHZlcnNpb24gYmFzZWQgb24gbmV4dCBhbmQg
Y29uZmlybSBpdCBzb2x2ZXMgeW91cg0KPiBwcm9ibGVtLCBpdCB3b3VsZCBoZWxwIHVzIGFsbC4N
Cj4NCj4gQWx0ZXJuYXRpdmUgY2FuIGdldCB0aGF0IHNpbmdsZSAib25lIGxpbmUiIHBhdGNoWzFd
IGFuZCBpbnRlZ3JhdGUgaXQgb24gdG9wIG9mDQo+IHRoZSBnaXQgdmVyc2lvbiB5b3UgYXJlIHVz
aW5nLg0KPg0KPiBDYXJsbw0KPg0KPiBbMV0NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvZ2l0
Lzk2ZDRiYjcxNTA1ZDg3ZWQ1MDFjMDU4YmJkODliZmMxM2QwOGIyNGEuMQ0KPiA2NTY1OTMyNzku
Z2l0Lmhhbnhpbi5oeEBieXRlZGFuY2UuY29tLw0KDQpZZXMuIFRoaXMgcGF0Y2ggd29ya3MuIEkg
dGhpbmsgaXQgaXMgdGhlIHJvb3QgY2F1c2Ugb2YgbXkgcHJvYmxlbQ0KIy8qKioqKirmnKzpgq7k
u7blj4rlhbbpmYTku7blkKvmnInlsI/nsbPlhazlj7jnmoTkv53lr4bkv6Hmga/vvIzku4XpmZDk
uo7lj5HpgIHnu5nkuIrpnaLlnLDlnYDkuK3liJflh7rnmoTkuKrkurrmiJbnvqTnu4TjgILnpoHm
raLku7vkvZXlhbbku5bkurrku6Xku7vkvZXlvaLlvI/kvb/nlKjvvIjljIXmi6zkvYbkuI3pmZDk
uo7lhajpg6jmiJbpg6jliIblnLDms4TpnLLjgIHlpI3liLbjgIHmiJbmlaPlj5HvvInmnKzpgq7k
u7bkuK3nmoTkv6Hmga/jgILlpoLmnpzmgqjplJnmlLbkuobmnKzpgq7ku7bvvIzor7fmgqjnq4vl
jbPnlLXor53miJbpgq7ku7bpgJrnn6Xlj5Hku7bkurrlubbliKDpmaTmnKzpgq7ku7bvvIEgVGhp
cyBlLW1haWwgYW5kIGl0cyBhdHRhY2htZW50cyBjb250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1h
dGlvbiBmcm9tIFhJQU9NSSwgd2hpY2ggaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiBv
ciBlbnRpdHkgd2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2YgdGhlIGlu
Zm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4gaW4gYW55IHdheSAoaW5jbHVkaW5nLCBidXQgbm90
IGxpbWl0ZWQgdG8sIHRvdGFsIG9yIHBhcnRpYWwgZGlzY2xvc3VyZSwgcmVwcm9kdWN0aW9uLCBv
ciBkaXNzZW1pbmF0aW9uKSBieSBwZXJzb25zIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lw
aWVudChzKSBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIGUtbWFpbCBpbiBlcnJv
ciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHBob25lIG9yIGVtYWlsIGltbWVkaWF0ZWx5
IGFuZCBkZWxldGUgaXQhKioqKioqLyMNCg==
