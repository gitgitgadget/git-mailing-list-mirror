Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5724FC25B0E
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 14:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiHOOuo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 10:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiHOOul (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 10:50:41 -0400
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D251855A3
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 07:50:38 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,238,1654531200"; 
   d="scan'208";a="39243985"
Received: from hk-mbx01.mioffice.cn (HELO xiaomi.com) ([10.56.8.121])
  by outboundhk.mxmail.xiaomi.com with ESMTP; 15 Aug 2022 22:50:37 +0800
Received: from BJ-MBX06.mioffice.cn (10.237.8.126) by HK-MBX01.mioffice.cn
 (10.56.8.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 15 Aug
 2022 22:50:37 +0800
Received: from BJ-MBX01.mioffice.cn (10.237.8.121) by BJ-MBX06.mioffice.cn
 (10.237.8.126) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 15 Aug
 2022 22:50:36 +0800
Received: from BJ-MBX01.mioffice.cn ([fe80::1839:49c8:1d62:7218]) by
 BJ-MBX01.mioffice.cn ([fe80::1839:49c8:1d62:7218%9]) with mapi id
 15.02.0986.029; Mon, 15 Aug 2022 22:50:36 +0800
From:   =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
To:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        =?utf-8?B?WGluNyBNYSDpqazpkas=?= <maxin7@xiaomi.com>,
        =?utf-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>,
        =?utf-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?utf-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
Subject: RE: [External Mail]Re: Partial-clone cause big performance impact on
 server
Thread-Topic: [External Mail]Re: Partial-clone cause big performance impact on
 server
Thread-Index: AditV5yCC1rR4WwDR+uOdfckQ0GBIQCDyEaAAD/u/QAAE9t5AA==
Date:   Mon, 15 Aug 2022 14:50:36 +0000
Message-ID: <68d8bfb7d94b4cd9a1312eddd6740f30@xiaomi.com>
References: <bfa3de4485614badb4a27d8cfba99968@xiaomi.com>
 <YviaoXRctE9fg/mB@coredump.intra.peff.net>
 <85e6fd08-c741-26d4-1393-4b115133e687@github.com>
In-Reply-To: <85e6fd08-c741-26d4-1393-4b115133e687@github.com>
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

aHR0cHM6Ly9nZXJyaXQuZ29vZ2xlc291cmNlLmNvbS9qZ2l0LysvcmVmcy9oZWFkcy9tYXN0ZXIv
b3JnLmVjbGlwc2UuamdpdC9zcmMvb3JnL2VjbGlwc2UvamdpdC90cmFuc3BvcnQvVXBsb2FkUGFj
ay5qYXZhIzIwMzcNCkl0IHNlZW1zIHlvdSdyZSByaWdodC4NCkFjY29yZGluZyB0byBjb21tbmV0
IEkgZm91bmQgaW4gamdpdCBzb3VyY2UgY29kZS4gSXQgc2VlbXMgaXQgaXMgaW5kZWVkIGRvaW5n
IHdoYXQgeW91IHNhaWQhDQoNCj4gT24gOC8xNC8yMDIyIDI6NDggQU0sIEplZmYgS2luZyB3cm90
ZToNCj4gPiBPbiBUaHUsIEF1ZyAxMSwgMjAyMiBhdCAwODowOTo1NkFNICswMDAwLCDnqIvmtIsg
d3JvdGU6DQo+ID4NCj4gPj4gICAgIDQuIEFuZCB3ZSB0aGVuIHRyYWNrIG91ciBzZXJ2ZXIod2hp
Y2ggaXMgZ2Vycml0IHdpdGggamdpdCkuIFdlDQo+ID4+ICAgICAgICBmb3VuZCB0aGUgc2VydmVy
IGlzIGNvdXRpbmcgb2JqZWN0cy4gVGhlbiB3ZSBjaGVjayB0aG9zZSA0MGsNCj4gPj4gICAgICAg
IG9iamVjdHMsIG1vc3Qgb2YgdGhlbSBhcmUgYmxvYnMgcmF0aGVyIHRoYW4gY29tbWl0LiAod2hp
Y2gNCj4gPj4gICAgICAgIG1lYW5zIHRoZXkncmUgbm90IGluIGJpdG1hcCkNCj4gPj4gICAgIDUu
IFdlIGJlbGlldmUgdGhhdCdzIHRoZSByb290IGNhdXNlIG9mIG91ciBwcm9ibGVtLiBHaXQgc2Vu
ZHMgdG9vDQo+ID4+ICAgICAgICBtYW55ICJ3YW50IFNIQTEiIHdoaWNoIGFyZSBub3QgaW4gYml0
bWFwLCBjYXVzZSB0aGUgc2VydmVyIHRvDQo+ID4+ICAgICAgICBjb3VudCBvYmplY3RzICBmcmVx
dWVudGx5LCB3aGljaCB0aGVuIHNsb3cgZG93biB0aGUgc2VydmVyLg0KPiA+DQo+ID4gSSdkIGJl
IHN1cnByaXNlZCBpZiBiaXRtYXBzIG1ha2UgYSBiaWcgZGlmZmVyZW5jZSBlaXRoZXIgd2F5IGhl
cmUsDQo+ID4gc2luY2UgYmxvYnMgYXJlIHZlcnkgcXVpY2sgaW4gdGhlICJjb3VudGluZyIgcGhh
c2Ugb2YgcGFjay1vYmplY3RzLg0KPiA+IFRoZXkgY2FuJ3QgbGluayB0byBhbnl0aGluZyBlbHNl
LCBzbyB3ZSBzaG91bGQgbm90IGJlIG9wZW5pbmcgdGhlDQo+ID4gb2JqZWN0IGNvbnRlbnRzIGF0
IGFsbCEgV2UganVzdCBuZWVkIHRvIGZpbmQgdGhlbSBvbiBkaXNrLCBhbmQgdGhlbiBpbg0KPiA+
IG1hbnkgY2FzZXMgd2UgY2FuIHNlbmQgdGhlbSBvdmVyIHRoZSB3aXJlIHdpdGhvdXQgZXZlbiBk
ZWNvbXByZXNzaW5nDQo+ID4gKHRoZSBleGNlcHRpb24gaXMgaWYgdGhleSBhcmUgc3RvcmVkIGFz
IGRlbHRhcyBhZ2FpbnN0IGFuIG9iamVjdCB0aGUgY2xpZW50DQo+IGRvZXNuJ3QgaGF2ZSkuDQo+
ID4NCj4gPiBJIGRpZG4ndCBnZW5lcmF0ZSBhIHRlc3QgY2FzZSwgYnV0IEknbSBwcmV0dHkgc3Vy
ZSB0aGF0IGlzIGhvdw0KPiA+IGdpdC5naXQncyBwYWNrLW9iamVjdHMgc2hvdWxkIGJlaGF2ZS4g
QnV0IHlvdSBtZW50aW9uZWQgdGhhdCB0aGUNCj4gPiBzZXJ2ZXIgaXMgamdpdDsgaXQncyBwb3Nz
aWJsZSB0aGF0IGl0IGlzbid0IGFzIG9wdGltaXplZCBpbiB0aGF0IGFyZWEuDQo+DQo+IEkganVz
dCByZW1lbWJlcmVkIHRoYXQgR2Vycml0IHNwZWNpZmljYWxseSBoYXMgYnJhbmNoLWxldmVsIHNl
Y3VyaXR5LCB3aGVyZQ0KPiBzb21lIGJyYW5jaGVzIGFyZSBub3QgdmlzaWJsZSB0byBhbGwgdXNl
cnMuIEZvciB0aGF0IHJlYXNvbiwgYmxvYnMgY2Fubm90IGJlDQo+IHNlcnZlZCB3aXRob3V0IGZp
cnN0IGRldGVybWluaW5nIGlmIHRoZXkgYXJlIHJlYWNoYWJsZSBmcm9tIGEgYnJhbmNoIHZpc2li
bGUNCj4gdG8gdGhlIGN1cnJlbnQgdXNlci4NCj4NCj4gSSdtIG5vdCBzdXJlIGlmIHRoYXQncyB0
aGUgcHJvYmxlbSBpbiB0aGlzIHBhcnRpY3VsYXIgY2FzZSwgYnV0IGl0IGNvdWxkIGJlLg0KPg0K
PiBUaGFua3MsDQo+IC1TdG9sZWUNCg0KIy8qKioqKirmnKzpgq7ku7blj4rlhbbpmYTku7blkKvm
nInlsI/nsbPlhazlj7jnmoTkv53lr4bkv6Hmga/vvIzku4XpmZDkuo7lj5HpgIHnu5nkuIrpnaLl
nLDlnYDkuK3liJflh7rnmoTkuKrkurrmiJbnvqTnu4TjgILnpoHmraLku7vkvZXlhbbku5bkurrk
u6Xku7vkvZXlvaLlvI/kvb/nlKjvvIjljIXmi6zkvYbkuI3pmZDkuo7lhajpg6jmiJbpg6jliIbl
nLDms4TpnLLjgIHlpI3liLbjgIHmiJbmlaPlj5HvvInmnKzpgq7ku7bkuK3nmoTkv6Hmga/jgILl
poLmnpzmgqjplJnmlLbkuobmnKzpgq7ku7bvvIzor7fmgqjnq4vljbPnlLXor53miJbpgq7ku7bp
gJrnn6Xlj5Hku7bkurrlubbliKDpmaTmnKzpgq7ku7bvvIEgVGhpcyBlLW1haWwgYW5kIGl0cyBh
dHRhY2htZW50cyBjb250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBmcm9tIFhJQU9NSSwg
d2hpY2ggaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkgd2hvc2UgYWRk
cmVzcyBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNvbnRhaW5l
ZCBoZXJlaW4gaW4gYW55IHdheSAoaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQgdG8sIHRvdGFs
IG9yIHBhcnRpYWwgZGlzY2xvc3VyZSwgcmVwcm9kdWN0aW9uLCBvciBkaXNzZW1pbmF0aW9uKSBi
eSBwZXJzb25zIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lwaWVudChzKSBpcyBwcm9oaWJp
dGVkLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0
aGUgc2VuZGVyIGJ5IHBob25lIG9yIGVtYWlsIGltbWVkaWF0ZWx5IGFuZCBkZWxldGUgaXQhKioq
KioqLyMNCg==
