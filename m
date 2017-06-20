Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 318C120D0C
	for <e@80x24.org>; Tue, 20 Jun 2017 11:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750992AbdFTLcw (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 07:32:52 -0400
Received: from hel-mailgw-01.vaisala.com ([193.143.230.17]:47984 "EHLO
        hel-mailgw-01.vaisala.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbdFTLcv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 07:32:51 -0400
IronPort-PHdr: =?us-ascii?q?9a23=3AGHaF/hSsFw+8QcL1BNwpf4n5itpsv+yvbD5Q0YIu?=
 =?us-ascii?q?jvd0So/mwa6yYhGN2/xhgRfzUJnB7Loc0qyN4v+mCTxLu8rJmUtBWaQEbwUCh8?=
 =?us-ascii?q?QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFRrlKAV6?=
 =?us-ascii?q?OPn+FJLMgMSrzeCy/IDYbxlViDanb75/KBe7oR/Su8QVjoduNKk8wQbVr3VVfO?=
 =?us-ascii?q?hb2XlmLk+JkRbm4cew8p9j8yBOtP8k6sVNT6b0cbkmQLJBFDgpPHw768PttRnY?=
 =?us-ascii?q?UAuA/WAcXXkMkhpJGAfK8hf3VYrsvyTgt+p93C6aPdDqTb0xRD+v4btnRAPuhS?=
 =?us-ascii?q?waMTMy7WPZhdFqjK9DoByvuQFxw5Labo+WOvpxfKLdcs8VS2VORctRSzdOD5mg?=
 =?us-ascii?q?Y4cTE+YMP+BVpJT9qVsUqhu+ABGhCeTxxTBWnH/22rc23P47HgHCwAwgGNQOv2?=
 =?us-ascii?q?rSrNjuKqcdS+G1zLLSwjXHdfxawyvy6I/Nch04p/yHQLF+cdLJxEUyFQ7JkE+c?=
 =?us-ascii?q?pZLqMj+Py+gBqWuW4up4We6yiWMrtRt9riagy8s2i4TEh5gZxk3H+Ch22Io1K8?=
 =?us-ascii?q?O3RU1nbdOhFZZdtyWXOJZrTs4nXm1noiQ3x7gYtpGmfiUKxpEqywDCZPCacYWF?=
 =?us-ascii?q?5A/oWvyLLjdinn1lfaqyhxO18Ue91OLxTtK00FNWripdldnMq2wN2wTT6seZTv?=
 =?us-ascii?q?t9+V+s1zSA2Q7V8+1KLkE7mLTZJZI43rI8iIAfvljEHi/sgEX6lrGWeV8l+uiz?=
 =?us-ascii?q?8evnZq/pqoWAOI9zjwHyKqUumsqhDuQkKgUCQmqW9fqm2LH98kD1WqhGguc1n6?=
 =?us-ascii?q?TZqJzaIN4Upq+9Aw9byIYj7BO/Ai+439sGh3kHK0hJdwidgIjtJ1HOJ/b4Aum5?=
 =?us-ascii?q?g1m3jjdk3fHGPqb7DZXJNHfPiqvufbF460JE0go80chf545ICrEGOP/zWEjxtN?=
 =?us-ascii?q?rCAR8lMwy72eDnCMln2YMYXGKOArSUMKzVsV+P6eIvJ/eDaJUJtzb6Lvgv/+Tu?=
 =?us-ascii?q?gmMhmV8BYamp2oMaaH+5HvR6OEiZf3XsjckbEWsQvQoxUvbqiFucXj5XfXqyWL?=
 =?us-ascii?q?g85j5oQL6hWNPBQYaknLyI2juyGJhHTm9BDV+IHDHjcIDSCNkWbyfHdsJsiDtC?=
 =?us-ascii?q?XLGlV4gn2BeGqgb70LNjJ6zf/ShO5sGr78R8++CGzUJ6zjdzFcnIi2w=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HrAAChBklZ/1UBGKxcGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBBwEBAQEBFQEBAQECAQEBAQgBAQEBhRwHg2SKGZF+lXiBMgNchiQCGoMDGAE?=
 =?us-ascii?q?BAQEBAQEBAQEBAoEQgjMigkMBAQEBAgEjEUUFCwIBCBgCAiYCAgIwFRACBA4Fi?=
 =?us-ascii?q?iStB4Imi1oBAQEBAQEBAwEBAQEBAQEBIIELh2yCRTSEUxYXNYJGgmEFnmGlb5U?=
 =?us-ascii?q?KH4EFPnSFah2BZnaITIENAQEB?=
X-IPAS-Result: =?us-ascii?q?A2HrAAChBklZ/1UBGKxcGQEBAQEBAQEBAQEBBwEBAQEBFQE?=
 =?us-ascii?q?BAQECAQEBAQgBAQEBhRwHg2SKGZF+lXiBMgNchiQCGoMDGAEBAQEBAQEBAQEBA?=
 =?us-ascii?q?oEQgjMigkMBAQEBAgEjEUUFCwIBCBgCAiYCAgIwFRACBA4FiiStB4Imi1oBAQE?=
 =?us-ascii?q?BAQEBAwEBAQEBAQEBIIELh2yCRTSEUxYXNYJGgmEFnmGlb5UKH4EFPnSFah2BZ?=
 =?us-ascii?q?naITIENAQEB?=
X-IronPort-AV: E=Sophos;i="5.39,364,1493672400"; 
   d="scan'208";a="42481085"
Received: from hel-exch-02.corp.vaisala.com ([172.24.1.85])
  by hel-mailgw-01.vaisala.com with ESMTP/TLS/AES256-SHA; 20 Jun 2017 14:32:48 +0300
Received: from HEL-EXCH-02.corp.vaisala.com (172.24.1.85) by
 HEL-EXCH-02.corp.vaisala.com (172.24.1.85) with Microsoft SMTP Server (TLS)
 id 15.0.1210.3; Tue, 20 Jun 2017 14:32:48 +0300
Received: from HEL-EXCH-02.corp.vaisala.com ([fe80::59d1:1a7:ed7f:2d17]) by
 HEL-EXCH-02.corp.vaisala.com ([fe80::59d1:1a7:ed7f:2d17%14]) with mapi id
 15.00.1210.000; Tue, 20 Jun 2017 14:32:48 +0300
From:   <eero.aaltonen@vaisala.com>
To:     <jonathantanmy@google.com>
CC:     <git@vger.kernel.org>
Subject: Re: Behavior of 'git fetch' for commit hashes
Thread-Topic: Behavior of 'git fetch' for commit hashes
Thread-Index: AQHS6PTmljaresomX0G+oE4gpNMbnaIsRKAAgABNfwCAANuPAA==
Date:   Tue, 20 Jun 2017 11:32:48 +0000
Message-ID: <be81c12a-75b1-386b-d075-f92ee72ddfce@vaisala.com>
References: <14e804c6-0798-8bbd-b182-66c3cd2b870c@vaisala.com>
 <20170619104936.706eff69@twelve2.svl.corp.google.com>
 <20170619152658.4559bce4@twelve2.svl.corp.google.com>
In-Reply-To: <20170619152658.4559bce4@twelve2.svl.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.24.66.184]
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED96BE7917678E4F859B43E1F9038610@exch.vaisala.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T24gMjAuMDYuMjAxNyAwMToyNiwgSm9uYXRoYW4gVGFuIHdyb3RlOg0KPiBPbiBNb24sIDE5IEp1
biAyMDE3IDEwOjQ5OjM2IC0wNzAwDQo+IEpvbmF0aGFuIFRhbiA8am9uYXRoYW50YW5teUBnb29n
bGUuY29tPiB3cm90ZToNCj4gDQo+PiBPbiBNb24sIDE5IEp1biAyMDE3IDEyOjA5OjI4ICswMDAw
DQo+PiA8ZWVyby5hYWx0b25lbkB2YWlzYWxhLmNvbT4gd3JvdGU6DQo+Pg0KPj4+IEZvciB2ZXJz
aW9uIDIuMTMuMw0KPiANCj4gRmlyc3RseSwgZXhhY3RseSB3aGljaCB2ZXJzaW9uIG9mIEdpdCBk
b2Vzbid0IHdvcms/IEknbSBhc3N1bWluZyAyLjEzLjENCj4gKGFzIHdyaXR0ZW4gZWxzZXdoZXJl
IGluIHlvdXIgZS1tYWlsKSwgc2luY2UgMi4xMy4zIGRvZXNuJ3QgZXhpc3QuDQoNClllcy4gMi4x
My4xLiBJIHNob3VsZCBzdGljayB0byBjb3B5LXBhc3RpbmcuDQoNCj4gSSB0cmllZCB0byByZXBy
b2R1Y2Ugd2l0aCB0aGlzIHNjcmlwdCwgYnV0IGl0IHNlZW1zIHRvIHBhc3MgZXZlbiBhdA0KPiAy
LjEzLjE6DQo+IA0KPiAgICAgIyEvYmluL2Jhc2gNCj4gICAgIHJtIC1yZiB+L3RtcC94ICYmDQo+
ICAgICBtYWtlIC0tcXVpZXQgJiYNCj4gICAgIC4vZ2l0IGluaXQgfi90bXAveCAmJg0KPiAgICAg
Li9naXQgLUMgfi90bXAveCBmZXRjaCAtLXF1aWV0IH4vZ2l0cHJpc3RpbmUvZ2l0IG1hc3Rlcjpm
b28gJiYNCj4gICAgIC4vZ2l0IC1DIH4vdG1wL3ggZmV0Y2ggfi9naXRwcmlzdGluZS9naXQgIiQo
Z2l0IC1DIH4vZ2l0cHJpc3RpbmUvZ2l0IHJldi1wYXJzZSBtYXN0ZXJeKSINCj4gICAgIGV4aXQg
JD8NCj4gDQo+IENvbW1lbnRpbmcgb3V0IHRoZSBmaXJzdCBmZXRjaCBsaW5lIHByb2R1Y2VzLCBh
cyBleHBlY3RlZDoNCj4gDQo+ICAgICBlcnJvcjogU2VydmVyIGRvZXMgbm90IGFsbG93IHJlcXVl
c3QgZm9yIHVuYWR2ZXJ0aXNlZCBvYmplY3QgPGhhc2g+DQo+IA0KPiBBbmQgSSBoYXZlIG5vdCBz
ZWVuIHRoZSAiZmF0YWw6IENvdWxkbid0IGZpbmQgcmVtb3RlIHJlZiIgZXJyb3IgeW91DQo+IGRl
c2NyaWJlLg0KDQpJIGFtIG5vdyBnZXR0aW5nIHRoZSBzYW1lICJ1bmFkdmVydGlzZWQgb2JqZWN0
IiBlcnJvci4gVGhlICJyZW1vdGUgcmVmIg0KZXJyb3IgaXQgc2VlbXMgd2FzIGR1ZSB0byBtaXNz
aW5nIHRoZSBsYXN0IGNoYXJhY3RlciBvZiB0aGUgU0hBMSA6Lw0KDQpOb3cgd2l0aCB0aGF0IHJl
c29sdmVkLCB0aGUgImZldGNoIGJyYW5jaDsgZmV0Y2ggY29tbWl0IiBhbHNvIHdvcmtzIGp1c3QN
CmFzIGJlZm9yZS4NCg0KPiBJJ2xsIHRha2UgYSBsb29rIGludG8gdGhlIGV4cGVjdGVkIGJlaGF2
aW9yLCBidXQgaWYgbXkgYXNzdW1wdGlvbnMgYXJlDQo+IGNvcnJlY3QsIHlvdSBzaG91bGQgYmUg
YWJsZSB0byBqdXN0IGNoZWNrb3V0IHRoZSBjb21taXQgeW91IHdhbnQgYWZ0ZXINCj4gZmV0Y2hp
bmcgdGhlIGJyYW5jaDoNCj4gDQo+ICAgZ2l0IGZldGNoIDxmb3JrVXJsPiA8YnJhbmNoPg0KPiAg
IGdpdCBjaGVja291dCA8c2hhMT4NCg0KVGhpcyBhY3R1YWxseSBwcm9kdWNlcw0KZmF0YWw6IHJl
ZmVyZW5jZSBpcyBub3QgYSB0cmVlOiA8c2hhMT4NCg0KQnV0IEkgY2FuIHVzZSB0aGUgYWJvdmUg
ZHVhbCBmZXRjaC4gU2VlbXMgdGhpcyBwcm9ibGVtIHdhcyBtb3JlIGJldHdlZW4NCnRoZSBrZXli
b2FyZCBhbmQgY2hhaXIuIEkgYW0gaG93ZXZlciBnbGFkIHRvIGhlYXIgdGhhdCBsaXRlcmFsIFNI
QTFzIGFyZQ0KYmVjb21pbmcgZmV0Y2hhYmxlLg0KDQpUaGFua3MgZm9yIGludmVzdGlnYXRpbmcs
DQotLSANCkVlcm8gQWFsdG9uZW4NCg==
