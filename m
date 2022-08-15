Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF54C25B0E
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 13:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242909AbiHONPZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 09:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242807AbiHONPM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 09:15:12 -0400
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FFC41900E
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 06:15:09 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,238,1654531200"; 
   d="scan'208";a="39221075"
Received: from hk-mbx02.mioffice.cn (HELO xiaomi.com) ([10.56.8.122])
  by outboundhk.mxmail.xiaomi.com with ESMTP; 15 Aug 2022 21:15:08 +0800
Received: from yz-mbx07.mioffice.cn (10.237.88.127) by HK-MBX02.mioffice.cn
 (10.56.8.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 15 Aug
 2022 21:15:08 +0800
Received: from BJ-MBX01.mioffice.cn (10.237.8.121) by yz-mbx07.mioffice.cn
 (10.237.88.127) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 15 Aug
 2022 21:15:07 +0800
Received: from BJ-MBX01.mioffice.cn ([fe80::1839:49c8:1d62:7218]) by
 BJ-MBX01.mioffice.cn ([fe80::1839:49c8:1d62:7218%9]) with mapi id
 15.02.0986.029; Mon, 15 Aug 2022 21:15:07 +0800
From:   =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
To:     ZheNing Hu <adlternative@gmail.com>
CC:     Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        =?utf-8?B?WGluNyBNYSDpqazpkas=?= <maxin7@xiaomi.com>,
        =?utf-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>,
        =?utf-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?utf-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
Subject: RE: [External Mail]Re: Partial-clone cause big performance impact on
 server
Thread-Topic: [External Mail]Re: Partial-clone cause big performance impact on
 server
Thread-Index: AditV5yCC1rR4WwDR+uOdfckQ0GBIQADD4yAAGB4/fAAT1esgAAhQ0wA
Date:   Mon, 15 Aug 2022 13:15:07 +0000
Message-ID: <44c62b62ce8f418d8929bdffc894d329@xiaomi.com>
References: <bfa3de4485614badb4a27d8cfba99968@xiaomi.com>
 <20220811172219.2308120-1-jonathantanmy@google.com>
 <08dae83ba1b541adac0fd96e2f99b194@xiaomi.com>
 <CAOLTT8R6hNKWGen4RD2sSU-asjjS6HXnxY2JC4k9SeL4YDzB-g@mail.gmail.com>
In-Reply-To: <CAOLTT8R6hNKWGen4RD2sSU-asjjS6HXnxY2JC4k9SeL4YDzB-g@mail.gmail.com>
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

VGhlcmUgaXMgYSByZWFsbHkgZWFzeSB3YXkgdG8gcmVwcm9kdWNlIGl0DQoNCmdpdCBjbG9uZSAt
LWZpbHRlcj1ibG9iOm5vbmUgLWIgbWFzdGVyICJodHRwczovL2FuZHJvaWQuZ29vZ2xlc291cmNl
LmNvbS9wbGF0Zm9ybS9wcmVidWlsdHMvZ3JhZGxlLXBsdWdpbiINCg0KRXZlbiBHb29nbGUgQU9T
UCBHZXJyaXQgd2lsbCBoYXZlIHRoaXMgcHJvYmxlbS4gWW91IHdpbGwgZmluZCBpdCBoYW5nIGZv
ciBtaW51dGVzIG9uIGNoZWNrb3V0DQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBaaGVOaW5nIEh1IDxhZGx0ZXJuYXRpdmVAZ21haWwuY29tPg0KPiBTZW50OiBNb25k
YXksIEF1Z3VzdCAxNSwgMjAyMiAxOjE2IFBNDQo+IFRvOiDnqIvmtIsgPGNoZW5neWFuZ0B4aWFv
bWkuY29tPg0KPiBDYzogSm9uYXRoYW4gVGFuIDxqb25hdGhhbnRhbm15QGdvb2dsZS5jb20+OyBn
aXRAdmdlci5rZXJuZWwub3JnOyDkvZXmtakNCj4gPGhlaGFvQHhpYW9taS5jb20+OyBYaW43IE1h
IOmprOmRqyA8bWF4aW43QHhpYW9taS5jb20+OyDnn7PlpYnlhbUNCj4gPHNoaWZlbmdiaW5nQHhp
YW9taS5jb20+OyDlh6HlhpvovokgPGZhbmp1bmh1aUB4aWFvbWkuY29tPjsg546L5rGJ5Z+6DQo+
IDx3YW5naGFuamlAeGlhb21pLmNvbT4NCj4gU3ViamVjdDogUmU6IFtFeHRlcm5hbCBNYWlsXVJl
OiBQYXJ0aWFsLWNsb25lIGNhdXNlIGJpZyBwZXJmb3JtYW5jZSBpbXBhY3Qgb24NCj4gc2VydmVy
DQo+DQo+IFvlpJbpg6jpgq7ku7ZdIOatpOmCruS7tuadpea6kOS6juWwj+exs+WFrOWPuOWklumD
qO+8jOivt+iwqOaFjuWkhOeQhuOAgg0KPg0KPiDnqIvmtIsgPGNoZW5neWFuZ0B4aWFvbWkuY29t
PiDkuo4yMDIy5bm0OOaciDEz5pel5ZGo5YWtIDE2OjAw5YaZ6YGT77yaDQo+ID4NCj4gPiA+ID4g
ICAgIDMuIHdpdGggR0lUX1RSQUNFX1BBQ0tFVD0xLiBXZSBmb3VuZCBvbiBiaWcgcmVwb3NpdG9y
aWVzDQo+ICgyMDBLK3JlZnMsIDZtKyBvYmplY3RzKS4gR2l0IHdpbGwgc2VuZHMgNDBrIHdhbnQu
DQo+ID4gPiA+ICAgICA0LiBBbmQgd2UgdGhlbiB0cmFjayBvdXIgc2VydmVyKHdoaWNoIGlzIGdl
cnJpdCB3aXRoIGpnaXQpLiBXZSBmb3VuZA0KPiB0aGUgc2VydmVyIGlzIGNvdXRpbmcgb2JqZWN0
cy4gVGhlbiB3ZSBjaGVjayB0aG9zZSA0MGsgb2JqZWN0cywgbW9zdCBvZiB0aGVtDQo+IGFyZSBi
bG9icyByYXRoZXIgdGhhbiBjb21taXQuICh3aGljaCBtZWFucyB0aGV5J3JlIG5vdCBpbiBiaXRt
YXApDQo+ID4gPiA+ICAgICA1LiBXZSBiZWxpZXZlIHRoYXQncyB0aGUgcm9vdCBjYXVzZSBvZiBv
dXIgcHJvYmxlbS4gR2l0IHNlbmRzIHRvbw0KPiBtYW55ICJ3YW50IFNIQTEiIHdoaWNoIGFyZSBu
b3QgaW4gYml0bWFwLCBjYXVzZSB0aGUgc2VydmVyIHRvIGNvdW50DQo+IG9iamVjdHMgZnJlcXVl
bnRseSwgd2hpY2ggdGhlbiBzbG93IGRvd24gdGhlIHNlcnZlci4NCj4gPiA+ID4NCj4gPiA+ID4g
V2hhdCB3ZSB3YW50IGlzLCBkb3dubG9hZCB0aGUgdGhpbmdzIHdlIG5lZWQgdG8gY2hlY2tvdXQg
dG8gc3BlY2lmaWMNCj4gY29tbWl0LiBCdXQgaWYgb25lIGNvbW1pdCBjb250YWluIHNvIG1hbnkg
b2JqZWN0cyAobGlrZSB1cyAsIDQwayspLiBJdCB0YWtlcw0KPiBtb3JlIHRpbWUgdG8gY291bnRp
bmcgdGhhbiBkb3dubG9hZGluZy4NCj4gPiA+ID4gSXMgaXQgcG9zc2libGUgdG8gbGV0IGdpdCBv
bmx5IHNlbmQgImNvbW1pdCB3YW50IiByYXRoZXIgdGhhbiBhbGwgdGhlDQo+IG9iamVjdHMgU0hB
MSBvbmUgYnkgb25lPw0KPiA+ID4NCj4gPiA+IE9uIGEgdGVjaG5pY2FsIGxldmVsLCBpdCBtYXkg
YmUgcG9zc2libGUgLSBhdCB0aGUgcG9pbnQgaW4gdGhlIEdpdA0KPiA+ID4gY29kZSB3aGVyZSB0
aGUgYmF0Y2ggcHJlZmV0Y2ggb2NjdXJzLCBJJ20gbm90IHN1cmUgaWYgd2UgaGF2ZSB0aGUNCj4g
PiA+IGNvbW1pdCwgYnV0IHdlIGNvdWxkIHBsdW1iIHRoZSBjb21taXQgaW5mb3JtYXRpb24gdGhl
cmUuIChXZSBoYXZlDQo+ID4gPiB0aGUgdHJlZSwgYnV0IHRoaXMgZG9lc24ndCBoZWxwIHVzIGhl
cmUgYmVjYXVzZSBhcyBmYXIgYXMgSSBrbm93LA0KPiA+ID4gdGhlIHRyZWUgd29uJ3QgYmUgaW4g
dGhlIGJpdG1hcCBzbyB0aGUgc2VydmVyIHdvdWxkIG5lZWQgdG8gY291bnQNCj4gPiA+IG9iamVj
dHMgYW55d2F5LCByZXN1bHRpbmcgaW4gdGhlIHNhbWUgcHJvYmxlbS4pDQo+ID4gPg0KPiA+ID4g
SG93ZXZlciwgc2VuZGluZyBvbmx5IGNvbW1pdHMgYXMgd2FudHMgd291bGQgbWVhbiB0aGF0IHdl
IHdvdWxkIGJlDQo+ID4gPiBmZXRjaGluZyBtb3JlIGJsb2JzIHRoYW4gbmVlZGVkLiBGb3IgZXhh
bXBsZSwgaWYgd2Ugd2VyZSB0byBjbG9uZQ0KPiA+ID4gKHdpdGgNCj4gPiA+IGNoZWNrb3V0KSBh
bmQgdGhlbiBjaGVja291dCBIRUFEXiwgc2VuZGluZyBhICJjb21taXQgd2FudCIgZm9yIHRoZQ0K
PiA+ID4gbGF0dGVyIGNoZWNrb3V0IHdvdWxkIHJlc3VsdCBpbiBhbGwgYmxvYnMgcmVmZXJlbmNl
ZCBieSB0aGUgY29tbWl0J3MNCj4gPiA+IHRyZWUgYmVpbmcgZmV0Y2hlZCBhbmQgbm90IG9ubHkg
dGhlIGJsb2JzIHRoYXQgYXJlIGRpZmZlcmVudC4NCj4gPg0KPiA+IEl0IHNlZW1zIHlvdXIgc29s
dXRpb24gcmVxdWlyZSBjaGFuZ2VzIGZyb20gYm90aCBzZXJ2ZXIgc2lkZSBhbmQNCj4gPiBjbGll
bnQgc2lkZSBXaHkgbm90IHdlIGp1c3QgYWRkIGFub3RoZXIgZmlsdGVyLCBhbGxvdyBwYXJ0aWFs
LWNsb25lIGFsd2F5cw0KPiBzZW5kcyBjb21taXQgbGV2ZWwgd2FudD8NCj4gPiBJZiB3ZSBjaGVj
a291dCBIRUFEfjEsIHRoZW4gY2xpZW50IGNhbiBzZW5kICJ3YW50IEhFQUR+MSBIRUFEfjIiLg0K
PiA+DQo+DQo+IEkgYW0gaW50ZXJlc3RpbmcgYWJvdXQgdGhpcyBxdWVzdGlvbiB0b28sIG1heWJl
IEkgY2FuIHRyeSBpZiB3ZSBjYW4gZG8gdGhpcy4uIDstKQ0KPg0KPiBaaGVOaW5nIEh1DQojLyoq
KioqKuacrOmCruS7tuWPiuWFtumZhOS7tuWQq+acieWwj+exs+WFrOWPuOeahOS/neWvhuS/oeaB
r++8jOS7hemZkOS6juWPkemAgee7meS4iumdouWcsOWdgOS4reWIl+WHuueahOS4quS6uuaIlue+
pOe7hOOAguemgeatouS7u+S9leWFtuS7luS6uuS7peS7u+S9leW9ouW8j+S9v+eUqO+8iOWMheaL
rOS9huS4jemZkOS6juWFqOmDqOaIlumDqOWIhuWcsOazhOmcsuOAgeWkjeWItuOAgeaIluaVo+WP
ke+8ieacrOmCruS7tuS4reeahOS/oeaBr+OAguWmguaenOaCqOmUmeaUtuS6huacrOmCruS7tu+8
jOivt+aCqOeri+WNs+eUteivneaIlumCruS7tumAmuefpeWPkeS7tuS6uuW5tuWIoOmZpOacrOmC
ruS7tu+8gSBUaGlzIGUtbWFpbCBhbmQgaXRzIGF0dGFjaG1lbnRzIGNvbnRhaW4gY29uZmlkZW50
aWFsIGluZm9ybWF0aW9uIGZyb20gWElBT01JLCB3aGljaCBpcyBpbnRlbmRlZCBvbmx5IGZvciB0
aGUgcGVyc29uIG9yIGVudGl0eSB3aG9zZSBhZGRyZXNzIGlzIGxpc3RlZCBhYm92ZS4gQW55IHVz
ZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVpbiBpbiBhbnkgd2F5IChpbmNsdWRp
bmcsIGJ1dCBub3QgbGltaXRlZCB0bywgdG90YWwgb3IgcGFydGlhbCBkaXNjbG9zdXJlLCByZXBy
b2R1Y3Rpb24sIG9yIGRpc3NlbWluYXRpb24pIGJ5IHBlcnNvbnMgb3RoZXIgdGhhbiB0aGUgaW50
ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNlaXZlIHRoaXMgZS1t
YWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcGhvbmUgb3IgZW1haWwg
aW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSBpdCEqKioqKiovIw0K
