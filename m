Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449D3C25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 10:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbiHQKWd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 06:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiHQKWc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 06:22:32 -0400
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAD6A6BD55
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 03:22:29 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,242,1654531200"; 
   d="scan'208";a="39742950"
Received: from hk-mbx03.mioffice.cn (HELO xiaomi.com) ([10.56.8.123])
  by outboundhk.mxmail.xiaomi.com with ESMTP; 17 Aug 2022 18:22:27 +0800
Received: from yz-mbx03.mioffice.cn (10.237.88.123) by HK-MBX03.mioffice.cn
 (10.56.8.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 17 Aug
 2022 18:22:26 +0800
Received: from BJ-MBX01.mioffice.cn (10.237.8.121) by yz-mbx03.mioffice.cn
 (10.237.88.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 17 Aug
 2022 18:22:25 +0800
Received: from BJ-MBX01.mioffice.cn ([fe80::1839:49c8:1d62:7218]) by
 BJ-MBX01.mioffice.cn ([fe80::1839:49c8:1d62:7218%9]) with mapi id
 15.02.0986.029; Wed, 17 Aug 2022 18:22:25 +0800
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
Thread-Index: AditV5yCC1rR4WwDR+uOdfckQ0GBIQCDyEaAAD/u/QAAZ+1+YA==
Date:   Wed, 17 Aug 2022 10:22:25 +0000
Message-ID: <11d7fc5721c541d6bc44bf635517497b@xiaomi.com>
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

QnV0IEkgc3RpbGwgdGhpbmsgdGhlIHByb3RvY29sIHN0aWxsIHNob3VsZCB0ZWxsIHRoZSBzZXJ2
ZXIgd2hpY2ggcmVmIHRoZSBibG9iIGlzIHJlYWNoYWJsZS4NCkJlY2F1c2UgaXQgd291bGQgYmUg
cmVhbGx5IGhhcmQgdG8gaW1wbGVtZW50IGFueSBraW5kIG9mIEFDTA0KQnV0IGdpdCBpcyBzdXJl
bHkgZGVzaWduZWQgZm9yIG9wZW4gc291cmNlcyBjb21tdW5pdHkuIEl0IG1ha2VzIHNlbnNlcyB0
aGlzIHJlcXVlc3Qgd2lsbCBiZSByZWplY3RlZC4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiBGcm9tOiBEZXJyaWNrIFN0b2xlZSA8ZGVycmlja3N0b2xlZUBnaXRodWIuY29tPg0K
PiBTZW50OiBNb25kYXksIEF1Z3VzdCAxNSwgMjAyMiA5OjE5IFBNDQo+IFRvOiBKZWZmIEtpbmcg
PHBlZmZAcGVmZi5uZXQ+OyDnqIvmtIsgPGNoZW5neWFuZ0B4aWFvbWkuY29tPg0KPiBDYzogZ2l0
QHZnZXIua2VybmVsLm9yZzsg5L2V5rWpIDxoZWhhb0B4aWFvbWkuY29tPjsgWGluNyBNYSDpqazp
kasNCj4gPG1heGluN0B4aWFvbWkuY29tPjsg55+z5aWJ5YW1IDxzaGlmZW5nYmluZ0B4aWFvbWku
Y29tPjsg5Yeh5Yab6L6JDQo+IDxmYW5qdW5odWlAeGlhb21pLmNvbT47IOeOi+axieWfuiA8d2Fu
Z2hhbmppQHhpYW9taS5jb20+DQo+IFN1YmplY3Q6IFtFeHRlcm5hbCBNYWlsXVJlOiBQYXJ0aWFs
LWNsb25lIGNhdXNlIGJpZyBwZXJmb3JtYW5jZSBpbXBhY3Qgb24NCj4gc2VydmVyDQo+DQo+IFvl
pJbpg6jpgq7ku7ZdIOatpOmCruS7tuadpea6kOS6juWwj+exs+WFrOWPuOWklumDqO+8jOivt+iw
qOaFjuWkhOeQhuOAgg0KPg0KPiBPbiA4LzE0LzIwMjIgMjo0OCBBTSwgSmVmZiBLaW5nIHdyb3Rl
Og0KPiA+IE9uIFRodSwgQXVnIDExLCAyMDIyIGF0IDA4OjA5OjU2QU0gKzAwMDAsIOeoi+a0iyB3
cm90ZToNCj4gPg0KPiA+PiAgICAgNC4gQW5kIHdlIHRoZW4gdHJhY2sgb3VyIHNlcnZlcih3aGlj
aCBpcyBnZXJyaXQgd2l0aCBqZ2l0KS4gV2UNCj4gPj4gICAgICAgIGZvdW5kIHRoZSBzZXJ2ZXIg
aXMgY291dGluZyBvYmplY3RzLiBUaGVuIHdlIGNoZWNrIHRob3NlIDQwaw0KPiA+PiAgICAgICAg
b2JqZWN0cywgbW9zdCBvZiB0aGVtIGFyZSBibG9icyByYXRoZXIgdGhhbiBjb21taXQuICh3aGlj
aA0KPiA+PiAgICAgICAgbWVhbnMgdGhleSdyZSBub3QgaW4gYml0bWFwKQ0KPiA+PiAgICAgNS4g
V2UgYmVsaWV2ZSB0aGF0J3MgdGhlIHJvb3QgY2F1c2Ugb2Ygb3VyIHByb2JsZW0uIEdpdCBzZW5k
cyB0b28NCj4gPj4gICAgICAgIG1hbnkgIndhbnQgU0hBMSIgd2hpY2ggYXJlIG5vdCBpbiBiaXRt
YXAsIGNhdXNlIHRoZSBzZXJ2ZXIgdG8NCj4gPj4gICAgICAgIGNvdW50IG9iamVjdHMgIGZyZXF1
ZW50bHksIHdoaWNoIHRoZW4gc2xvdyBkb3duIHRoZSBzZXJ2ZXIuDQo+ID4NCj4gPiBJJ2QgYmUg
c3VycHJpc2VkIGlmIGJpdG1hcHMgbWFrZSBhIGJpZyBkaWZmZXJlbmNlIGVpdGhlciB3YXkgaGVy
ZSwNCj4gPiBzaW5jZSBibG9icyBhcmUgdmVyeSBxdWljayBpbiB0aGUgImNvdW50aW5nIiBwaGFz
ZSBvZiBwYWNrLW9iamVjdHMuDQo+ID4gVGhleSBjYW4ndCBsaW5rIHRvIGFueXRoaW5nIGVsc2Us
IHNvIHdlIHNob3VsZCBub3QgYmUgb3BlbmluZyB0aGUNCj4gPiBvYmplY3QgY29udGVudHMgYXQg
YWxsISBXZSBqdXN0IG5lZWQgdG8gZmluZCB0aGVtIG9uIGRpc2ssIGFuZCB0aGVuIGluDQo+ID4g
bWFueSBjYXNlcyB3ZSBjYW4gc2VuZCB0aGVtIG92ZXIgdGhlIHdpcmUgd2l0aG91dCBldmVuIGRl
Y29tcHJlc3NpbmcNCj4gPiAodGhlIGV4Y2VwdGlvbiBpcyBpZiB0aGV5IGFyZSBzdG9yZWQgYXMg
ZGVsdGFzIGFnYWluc3QgYW4gb2JqZWN0IHRoZSBjbGllbnQNCj4gZG9lc24ndCBoYXZlKS4NCj4g
Pg0KPiA+IEkgZGlkbid0IGdlbmVyYXRlIGEgdGVzdCBjYXNlLCBidXQgSSdtIHByZXR0eSBzdXJl
IHRoYXQgaXMgaG93DQo+ID4gZ2l0LmdpdCdzIHBhY2stb2JqZWN0cyBzaG91bGQgYmVoYXZlLiBC
dXQgeW91IG1lbnRpb25lZCB0aGF0IHRoZQ0KPiA+IHNlcnZlciBpcyBqZ2l0OyBpdCdzIHBvc3Np
YmxlIHRoYXQgaXQgaXNuJ3QgYXMgb3B0aW1pemVkIGluIHRoYXQgYXJlYS4NCj4NCj4gSSBqdXN0
IHJlbWVtYmVyZWQgdGhhdCBHZXJyaXQgc3BlY2lmaWNhbGx5IGhhcyBicmFuY2gtbGV2ZWwgc2Vj
dXJpdHksIHdoZXJlDQo+IHNvbWUgYnJhbmNoZXMgYXJlIG5vdCB2aXNpYmxlIHRvIGFsbCB1c2Vy
cy4gRm9yIHRoYXQgcmVhc29uLCBibG9icyBjYW5ub3QgYmUNCj4gc2VydmVkIHdpdGhvdXQgZmly
c3QgZGV0ZXJtaW5pbmcgaWYgdGhleSBhcmUgcmVhY2hhYmxlIGZyb20gYSBicmFuY2ggdmlzaWJs
ZQ0KPiB0byB0aGUgY3VycmVudCB1c2VyLg0KPg0KPiBJJ20gbm90IHN1cmUgaWYgdGhhdCdzIHRo
ZSBwcm9ibGVtIGluIHRoaXMgcGFydGljdWxhciBjYXNlLCBidXQgaXQgY291bGQgYmUuDQo+DQo+
IFRoYW5rcywNCj4gLVN0b2xlZQ0KDQojLyoqKioqKuacrOmCruS7tuWPiuWFtumZhOS7tuWQq+ac
ieWwj+exs+WFrOWPuOeahOS/neWvhuS/oeaBr++8jOS7hemZkOS6juWPkemAgee7meS4iumdouWc
sOWdgOS4reWIl+WHuueahOS4quS6uuaIlue+pOe7hOOAguemgeatouS7u+S9leWFtuS7luS6uuS7
peS7u+S9leW9ouW8j+S9v+eUqO+8iOWMheaLrOS9huS4jemZkOS6juWFqOmDqOaIlumDqOWIhuWc
sOazhOmcsuOAgeWkjeWItuOAgeaIluaVo+WPke+8ieacrOmCruS7tuS4reeahOS/oeaBr+OAguWm
guaenOaCqOmUmeaUtuS6huacrOmCruS7tu+8jOivt+aCqOeri+WNs+eUteivneaIlumCruS7tumA
muefpeWPkeS7tuS6uuW5tuWIoOmZpOacrOmCruS7tu+8gSBUaGlzIGUtbWFpbCBhbmQgaXRzIGF0
dGFjaG1lbnRzIGNvbnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGZyb20gWElBT01JLCB3
aGljaCBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVudGl0eSB3aG9zZSBhZGRy
ZXNzIGlzIGxpc3RlZCBhYm92ZS4gQW55IHVzZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFpbmVk
IGhlcmVpbiBpbiBhbnkgd2F5IChpbmNsdWRpbmcsIGJ1dCBub3QgbGltaXRlZCB0bywgdG90YWwg
b3IgcGFydGlhbCBkaXNjbG9zdXJlLCByZXByb2R1Y3Rpb24sIG9yIGRpc3NlbWluYXRpb24pIGJ5
IHBlcnNvbnMgb3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHByb2hpYml0
ZWQuIElmIHlvdSByZWNlaXZlIHRoaXMgZS1tYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRo
ZSBzZW5kZXIgYnkgcGhvbmUgb3IgZW1haWwgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSBpdCEqKioq
KiovIw0K
