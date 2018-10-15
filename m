Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10FF01F453
	for <e@80x24.org>; Mon, 15 Oct 2018 13:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeJOUrK (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 16:47:10 -0400
Received: from mail-eopbgr20138.outbound.protection.outlook.com ([40.107.2.138]:11584
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726422AbeJOUrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 16:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hiboxsystems.onmicrosoft.com; s=selector1-hibox-tv;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOvdn/98mjVGsETfYVpkAVSN/wISZPybVT/w2SfYpks=;
 b=or35Zceaev+KcVvsnZ2q/e804TCja0WYFJpBGYPWW/Fes0blpV6EdVkN2yVZqcwSb6P85FnXRALcYyL9QziGdQIcJGAKXWV0uCe1FvBFyKvsI6OJpXNjoSJtd5a3mol3jIHhdsz885tgwR5nBWfKWCFSdTOiZp7CazW36UDroL8=
Received: from HE1PR08MB1066.eurprd08.prod.outlook.com (10.166.125.152) by
 HE1PR08MB1114.eurprd08.prod.outlook.com (10.166.87.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Mon, 15 Oct 2018 13:01:51 +0000
Received: from HE1PR08MB1066.eurprd08.prod.outlook.com
 ([fe80::e856:c531:fe82:602f]) by HE1PR08MB1066.eurprd08.prod.outlook.com
 ([fe80::e856:c531:fe82:602f%2]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 13:01:50 +0000
From:   Per Lundberg <per.lundberg@hibox.tv>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Ignored files being silently overwritten when switching branches
Thread-Topic: Ignored files being silently overwritten when switching branches
Thread-Index: AQHUZIc8aHVcNpRY0kGFmhm8Got3Vw==
Date:   Mon, 15 Oct 2018 13:01:50 +0000
Message-ID: <7d6858c8-aa84-aa05-6c69-22dbbff7dfaa@hibox.tv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0086.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::27) To HE1PR08MB1066.eurprd08.prod.outlook.com
 (2a01:111:e400:c524::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=per.lundberg@hibox.tv; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:999:70:5c07:ace4:b5ff:fe14:8c7b]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR08MB1114;6:GW4T9sIcnDL0h2WNzPZrO4YXYNp7L/2lCvyMFMC+Ducbv2YQOhAwnn6dQGd0HAxVuxJkn4pTChIykzMinH7eD8gOwAl0AQKWjfm/VwQalXyH5dvFTpxy6vMQKAGelfEwQKcrAF6NrX2QxY4S6WoJNAz+k6roaY70Bx2BWdrt7W+cHeyp5JHu4fg9a7lUh3liVW+AhiSgLyVt6E9xgDhwBh7Z9IQ0GFvy1xsv+61PEBIoD44bqtMRB7eC1Cq3PJQGZciUdc7SGDVfkAGX8qdKPc4/VGl1rjwH44IJZax7pMokg1pzfJ0C2GERJ2MUxIn4dyzwgtvh0tDNw2qhKtIZzgAhVB/znfmI8gIs45KRH74apOTXkdTWxPOUN85u8MvnyNRFbEOo7zWfWL2iFyEiBs4SSlFjWeRPtGUQ9UK7vvQyGF2WGtqrISGwF9EKGB46FgyUqj6zOa3D4Bo3i05HSg==;5:6a6Z4YBRv6lL0gNZqRgpiWnQ2SiGAg8Q66xcj/7+Sg2a1JBaDKyzaIjvWSwczRCGssIIGyu1uyW3JHMd+WsZGk7bSknUecJgU0Wsbe9BqsLIzbvUG8tTF6YBhwcJ0xHkUYAKJwdPbHFplYtIMwfGViIDUjwvqtNqURh9SWbNjzw=;7:x6+LhjnAnz+PHA6pGcINKEMSK8xJxiAnPtpX/bNeGIzHmYspfsNsRYHgyRMzCuJ0FEB0MZe+7wgl7x9BsXj78PVCFNYLK4eKWkWCL1KSjy+ecUF5Vkh+Mz3fVHbOgiUDyiTiCPrRq3ROot1FQCzei11d2cuwL8zhrVqiq/w4kmNRwCjcvyIZWToVBM9CIu0n9biEp5vqGjYAGGtA0kYMzMoIhpIjviD7Vl6lbgompu2s5GEKBnRs3tqJ5mlxKgQ8
x-ms-office365-filtering-correlation-id: 769102af-10bf-4d66-3e33-08d6329e5f31
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR08MB1114;
x-ms-traffictypediagnostic: HE1PR08MB1114:
x-microsoft-antispam-prvs: <HE1PR08MB11145D9A75097FF4BDDE5EEDEAFD0@HE1PR08MB1114.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(2016111802025)(20161123560045)(6043046)(201708071742011)(7699051)(76991067);SRVR:HE1PR08MB1114;BCL:0;PCL:0;RULEID:;SRVR:HE1PR08MB1114;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(346002)(376002)(396003)(366004)(136003)(189003)(199004)(2906002)(2501003)(5660300001)(6486002)(14454004)(256004)(14444005)(71190400001)(71200400001)(68736007)(966005)(97736004)(6916009)(31696002)(86362001)(6116002)(508600001)(7736002)(5250100002)(305945005)(102836004)(186003)(106356001)(46003)(2351001)(105586002)(2900100001)(53936002)(36756003)(44832011)(486006)(476003)(2616005)(316002)(74482002)(25786009)(99286004)(8936002)(386003)(5640700003)(6506007)(8676002)(52116002)(81156014)(81166006)(1730700003)(6512007)(6436002)(31686004)(6306002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR08MB1114;H:HE1PR08MB1066.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hibox.tv does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OYGALFm+LwGC8aakwa53n9Mt8WRMN0EAFsS09LvFiaky2ZVaSd2A+GWFUj4+I+Tn9W4e7HIsrtgU3PgJlgkhfJkR2Qa6arodWO1vJ9UBRejrzZbAElvx+4hr4XKi5/5FOj/iaoIn0P1oVm0/LNzfpuUE9zySPpXqx4aZv6d7WNiL2q9xRznGzmVjH4y/1mAnNFgZkw23GsQZImH2S6nX4zfIlnqtmlZWoJUrXzDIziLFsf2OJkNT5NFpOt5xzM0qLdFhrEWB0hibZkXxzA74HzZpcPjVdyGdEAQqD4LSYpdnoLP2jJy3Hbs35wKbJolem7qTU71gsgt2K0fCxOGvR4x+HNush829To2zv3+nE8U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB92818951A5D64DB22110C36216C14D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hibox.tv
X-MS-Exchange-CrossTenant-Network-Message-Id: 769102af-10bf-4d66-3e33-08d6329e5f31
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 13:01:50.8257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eec7d2e0-55d2-4f5e-ac15-00bd4e779ed6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB1114
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGksDQoNClNvcnJ5IGlmIHRoaXMgcXVlc3Rpb24gaGFzIGJlZW4gYXNrZWQgYmVmb3JlOyBJIHNr
aW1tZWQgdGhyb3VnaCB0aGUgbGlzdCANCmFyY2hpdmVzIGFuZCB0aGUgRkFRIGJ1dCBjb3VsZG4n
dCBpbW1lZGlhdGVseSBmaW5kIGl0IC0gcGxlYXNlIHBvaW50IG1lIA0KaW4gdGhlIHJpZ2h0IGRp
cmVjdGlvbiBpZiBpdCBoYXMgaW5kZWVkIGJlZW4gZGlzY3Vzc2VkIGJlZm9yZS4NCg0KV2Ugd2Vy
ZSByZW5hbWluZyBzb21lIHByZXZpb3VzbHktaW5jbHVkZWQgY29uZmlndXJhdGlvbiBmaWxlcyAo
Zm9vLmNvbmYpIA0KaW4gb25lIG9mIG91ciByZXBvcywgaW5zdGVhZCBwcm92aWRpbmcgYSAiZGVm
YXVsdCIgY29uZmlndXJhdGlvbiANCihmb28uY29uZi5kZWZhdWx0KSB0aGF0IGNhbiBlYXNpbHkg
YmUgY29waWVkIG92ZXIgdG8gZm9vLmNvbmYgYnkgDQppbmRpdmlkdWFsIGRldmVsb3BlcnMuIFRo
aXMgYWxsIHdvcmtzIGZpbmUsIGFuZCB0aGUgKi5jb25mIGFyZSBub3cgYWRkZWQgDQp0byB0aGUg
LmdpdGlnbm9yZSBsaXN0Lg0KDQpfSG93ZXZlcl8sIHdoZW4gc3dpdGNoaW5nIGJhY2sgdG8gb3Vy
IHByZXZpb3VzIHJlbGVhc2UgYnJhbmNoZXMgKHdoaWNoIA0KaW5jbHVkZXMgdGhlIGZvby5jb25m
IGZpbGUgaW4gdGhlIHRyZWUpLCB3ZSBoYXZlIG5vdGljZWQgdGhhdCBnaXQgDQpzaWxlbnRseSBv
dmVyd3JpdGVzIHRoZSBsb2NhbGx5LW1vZGlmaWVkIGZvby5jb25mIGZpbGUgd2l0aCB0aGUgdXBz
dHJlYW0gDQpmb28uY29uZiBmaWxlIGZyb20gdGhhdCBicmFuY2guIFdoZW4gc3dpdGNoaW5nIGJh
Y2sgdG8gbWFzdGVyLCB0aGUgZmlsZSANCmNvbnRlbnRzIGlzIHRoZXJlZm9yZSBwZXJwZXR1YWxs
eSBsb3N0LCB3aGljaCBpcyBhIGJpdCB1bmZvcnR1bmF0ZS4NCg0KSSBkaWQgYSBxdWljayByZXBy
byBjYXNlIGhlcmU6IGh0dHBzOi8vZ2l0aHViLmNvbS9wZXJsdW4vZ2l0LXRlc3QsIGFuZCANCml0
IHNlZW1zIGVhc3kgdG8gcmVwcm9kdWNlIHRoaXMgYmVoYXZpb3IgdXNpbmcgdGhlIGZvbGxvd2lu
ZyBzdGVwcyAoYWxzbyANCmRvY3VtZW50ZWQgaW4gdGhhdCBnaXQgcmVwbyk6DQoNCiQgZ2l0IGlu
aXQNCiQgdG91Y2ggZm9vLnR4dA0KJCBuYW5vIGZvby50eHQNCiQgZ2l0IGFkZCBmb28udHh0DQok
IGdpdCBjb21taXQgLW0gJ0FkZCBmb28udHh0Jw0KW21hc3RlciAocm9vdC1jb21taXQpIDhlZjA1
Y2JdIEFkZCBmb28udHh0DQogIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KICBjcmVh
dGUgbW9kZSAxMDA2NDQgZm9vLnR4dA0KJCBnaXQgY2hlY2tvdXQgLWIgZGV2DQpTd2l0Y2hlZCB0
byBhIG5ldyBicmFuY2ggJ2RldicNCiQgZ2l0IG12IGZvby50eHQgZm9vLmJhcg0KJCBnaXQgY29t
bWl0IC1tICJSZW5hbWUgZm9vLnR4dCAtPiBmb28uYmFyIg0KW2RldiA0YzU1YzliXSBSZW5hbWUg
Zm9vLnR4dCAtPiBmb28uYmFyDQogIDEgZmlsZSBjaGFuZ2VkLCAwIGluc2VydGlvbnMoKyksIDAg
ZGVsZXRpb25zKC0pDQogIHJlbmFtZSBmb28udHh0ID0+IGZvby5iYXIgKDEwMCUpDQokIGVjaG8g
J215IGxvY2FsIGZvby50eHQnID4gZm9vLnR4dA0KJCBlY2hvIGZvby50eHQgPiAuZ2l0aWdub3Jl
DQokIGdpdCBjb21taXQgLW0gIkFkZCAuZ2l0aWdub3JlIg0KW2RldiA0YzE2YWNiXSBBZGQgLmdp
dGlnbm9yZQ0KICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQogIGNyZWF0ZSBtb2Rl
IDEwMDY0NCAuZ2l0aWdub3JlDQokIGdpdCBjaGVja291dCBtYXN0ZXIgIyBUaGlzIHdpbGwgc2ls
ZW50bHkgb3ZlcndyaXRlIHRoZSBsb2NhbCBmb28udHh0DQoNClNvIG15IHF1ZXN0aW9uIGlzOiBp
cyB0aGlzIGJ5IGRlc2lnbiBvciBzaG91bGQgdGhpcyBiZSBjb25zaWRlcmVkIGEgYnVnIA0KaW4g
Z2l0PyBPZiBjb3Vyc2UsIGl0IGRlcGVuZHMgbGFyZ2VseSBvbiB3aGF0IC5naXRpZ25vcmUgaXMg
YmVpbmcgdXNlZCANCmZvciAtIGlmIHdlIGFyZSB0YWxraW5nIGFib3V0IGZpbGVzIHdoaWNoIGNh
biBlYXNpbHkgYmUgcmVnZW5lcmF0ZWQgDQooYnVpbGQgYXJ0aWZhY3RzLCBub2RlX21vZHVsZXMg
Zm9sZGVycyBldGMuKSBJIGNhbiB0b3RhbGx5IHVuZGVyc3RhbmQgDQp0aGUgY3VycmVudCBiZWhh
dmlvciwgYnV0IHdoZW4gZGVhbGluZyB3aXRoIG1vcmUgc2Vuc2l0aXZlICYgaW1wb3J0YW50IA0K
Y29udGVudCBpdCdzIGEgYml0IGluY29udmVuaWVudC4NCg0KDQpXaGF0IEkgd291bGQgaGF2ZSBl
eHBlY3RlZCB3b3VsZCBiZSBmb3IgZ2l0IHRvIGNvbXBsYWluLCB3aXRoIHRoaXMgbWVzc2FnZToN
Cg0KZXJyb3I6IFRoZSBmb2xsb3dpbmcgdW50cmFja2VkIHdvcmtpbmcgdHJlZSBmaWxlcyB3b3Vs
ZCBiZSBvdmVyd3JpdHRlbiANCmJ5IGNoZWNrb3V0Og0KCWZvby50eHQNClBsZWFzZSBtb3ZlIG9y
IHJlbW92ZSB0aGVtIGJlZm9yZSB5b3Ugc3dpdGNoIGJyYW5jaGVzLg0KQWJvcnRpbmcNCg0KVGhp
cyBpcyBub3JtYWxseSB0aGUgbWVzc2FnZSB5b3UgZ2V0IHdoZW4gYSBfbm9uLWlnbm9yZWRfIGZp
bGUgaXMgYmVpbmcgDQpvdmVyd3JpdHRlbi4gQnV0IGFwcGFyZW50bHkgbm90IHNvIHdoZW4gYW4g
aWdub3JlZCBmaWxlIGlzIGJlaW5nIA0Kb3ZlcndyaXR0ZW4uIElmIHRoaXMgY2FuIGJlIHR3ZWFr
ZWQgaW4gdGhlIGxvY2FsIHJlcG8gc2V0dGluZ3Mgc29tZWhvdywgDQpwbGVhc2UgbGV0IG1lIGtu
b3cuDQotLQ0KQmVzdCByZWdhcmRzLA0KUGVyDQo=
