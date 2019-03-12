Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBAF820248
	for <e@80x24.org>; Tue, 12 Mar 2019 09:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbfCLJSt (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 05:18:49 -0400
Received: from mail-eopbgr60097.outbound.protection.outlook.com ([40.107.6.97]:20256
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725887AbfCLJSt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 05:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sT6wIBxvAMEjsSApNYKNxBjazTYIUaIi5ROChgJ6QP8=;
 b=Q2ZzJFo/c5kBJPOEJWI8uGHdWPNBuoHBD8fuor6OZvrcop41dNcnsYCyQzWBmHs2GgZHpY3bGo0T01jGAqDTzlRKSLYoji0lD4T37E8I+Wwr+bxAAsNF0FknK6J32zpD7MF69QyVeZucvFUbsSp5DSbPSwdd+sV+zMkc6lutRng=
Received: from VI1PR8303MB0080.EURPRD83.prod.outlook.com (129.75.141.87) by
 VI1PR8303MB0094.EURPRD83.prod.outlook.com (129.75.141.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.2; Tue, 12 Mar 2019 09:18:43 +0000
Received: from VI1PR8303MB0080.EURPRD83.prod.outlook.com
 ([fe80::dcda:e76b:b47b:d5dc]) by VI1PR8303MB0080.EURPRD83.prod.outlook.com
 ([fe80::dcda:e76b:b47b:d5dc%7]) with mapi id 15.20.1730.000; Tue, 12 Mar 2019
 09:18:43 +0000
From:   Norbert Nemec <Norbert.Nemec@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: fast-import on existing branches
Thread-Topic: fast-import on existing branches
Thread-Index: AdTVnL4X4Jxw2/2tSNKV4QAkAn17vAAKIfkAAAMbPeAAnFnlAAAa355w
Date:   Tue, 12 Mar 2019 09:18:42 +0000
Message-ID: <VI1PR8303MB008034B99238403D0BCEBBACFD490@VI1PR8303MB0080.EURPRD83.prod.outlook.com>
References: <DB6PR8303MB0069AA4D630BFDF0EC72C47BFD4D0@DB6PR8303MB0069.EURPRD83.prod.outlook.com>
 <CABPp-BF0PcdwpJR3NteCmQw0QhN3E0UAi22FvmjUc6SBr=UB_A@mail.gmail.com>
 <DB6PR8303MB006927B6267629467F783F58FD4D0@DB6PR8303MB0069.EURPRD83.prod.outlook.com>
 <CABPp-BGs4E48bBQ0e94jxhoXv6t9nzwoNEEnb37tUBpTsi_mCw@mail.gmail.com>
In-Reply-To: <CABPp-BGs4E48bBQ0e94jxhoXv6t9nzwoNEEnb37tUBpTsi_mCw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=nonemec@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-12T09:18:40.7151600Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e2a840df-9979-4c0a-87d1-6f34e4caa901;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [2a01:110:8012:1012:3bd:2fb3:9f64:f5bd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4a94bb5-8d69-403b-a887-08d6a6cbb8e8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR8303MB0094;
x-ms-traffictypediagnostic: VI1PR8303MB0094:
x-microsoft-antispam-prvs: <VI1PR8303MB0094604C34D9571FA76659ACFD490@VI1PR8303MB0094.EURPRD83.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(376002)(346002)(396003)(189003)(199004)(52314003)(13464003)(81166006)(25786009)(2501003)(11346002)(6116002)(86362001)(2351001)(8936002)(3480700005)(229853002)(106356001)(8676002)(76176011)(10090500001)(53936002)(186003)(81156014)(305945005)(71200400001)(5660300002)(316002)(68736007)(52536013)(7696005)(6506007)(6346003)(14454004)(1730700003)(105586002)(7736002)(55016002)(5640700003)(8990500004)(93886005)(6436002)(6246003)(14444005)(9686003)(86612001)(71190400001)(446003)(22452003)(53546011)(478600001)(6916009)(99286004)(72206003)(476003)(46003)(102836004)(97736004)(2906002)(256004)(486006)(10290500003)(33656002)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR8303MB0094;H:VI1PR8303MB0080.EURPRD83.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Norbert.Nemec@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bMZzP5V1FnoMzdElGOa+IktzFjwi2QHHzCOKIHgXoRMOvNPW5Zfbrb7i4T5EFuG8i7QZufgWwjI1xwzHXzNc+DWE0QyBfJBdYzk/9gCQHkGc5ktdJTrkBoXKEIvsKTNz97S4NCWzsGQTKBRq/cY2+fMnuEDx5Z1dIjtFp6hMMiedsm1Kuvm/IgILXAfADo+nq4bkfH3kxIbrpQwtpxfBl4ij82JBT41xWpPA3gAFHg4ZQQvQd/dWO7r58zaPkH3t/2Fa1HeXdkH39zT2wXINltLz+687fGAGKnowSFAGmvs4prcqwXLy4HwoocTlkgz6kLypeC4LelLG/cjc4vv5cl5iDHB/s/g52WXgktPuZWHcgBGBoKMTKbqKvGLqIEChX27Nz6GwITYHESLVvpZIIFcFpR/vdSX1bw9LEHVIYys=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a94bb5-8d69-403b-a887-08d6a6cbb8e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 09:18:42.6647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR8303MB0094
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgRWxpamFoLA0KDQp0aGFua3MgZm9yIGV4cGxhaW5pbmcgdGhlIG1vdGl2YXRpb24gYmVoaW5k
IHRoZSBjdXJyZW50IHNvbHV0aW9uIQ0KDQpJIHN0aWxsIGJlbGlldmUgdGhlIHNpdHVhdGlvbiBj
b3VsZCBiZSBpbXByb3ZlZCB3aXRob3V0IGJyZWFraW5nIGNvbXBhdGliaWxpdHk6DQoqIGluIHRo
ZSBkb2N1bWVudGF0aW9uIHRoZSBwYXJhZ3JhcGggYWJvdXQgIk9taXR0aW5nIHRoZSBmcm9tIGNv
bW1hbmQiIHNob3VsZCBjaGFuZ2UgImV4aXN0aW5nIGJyYW5jaGVzIiBpbnRvIHNvbWV0aGluZyBs
aWtlICJleGlzdGluZyBicmFuY2hlcyB3aXRoaW4gdGhlIGNhY2hlIG9mIHRoZSBjdXJyZW50IGZh
c3QtaW1wb3J0IHN0cmVhbSIuIFRoZSBjdXJyZW50IHBocmFzaW5nIGlzIHNpbXBseSB3cm9uZy4N
CiogdGhlIGRvY3VtZW50YXRpb24gb2YgdGhlICJmcm9tIGJyYW5jaF4wIiB2YXJpYW50IGN1cnJl
bnRseSBsb29rcyBsaWtlIGEgc29sdXRpb24gZm9yIGEgcmFyZSBzaXR1YXRpb24gdGhhdCBpcyBl
YXNpbHkgb3Zlcmxvb2tlZC4gTWF5YmUgaXQgY291bGQgYmUgaW50ZWdyYXRlZCB3aXRoIHRoZSBw
YXJhZ3JhcGggYWJvdXQgIk9taXR0aW5nIiBzaW5jZSBpdCBpcyB2ZXJ5IGNsb3NlbHkgcmVsYXRl
ZC4NCiogaW4gdXBkYXRlX2JyYW5jaCB0aGUgd2FybmluZyBjb3VsZCBoaW50IGF0IHRoZSBwb3Nz
aWJsZSBzb2x1dGlvbiAoZXhwbGljaXRseSBzdXBwbHkgYSBmcm9tIHBhcmVudF9icmFuY2heMCBh
cmd1bWVudCkNCiogSSdtIHN0aWxsIG5vdCBzdXJlIHdoeSBpdCB3b3VsZCBodXJ0IHRvIGNoYW5n
ZSBmYXRhbCBlcnJvciBpbiBwYXJzZV9mcm9tIGFib3V0IGNyZWF0aW5nIGEgYnJhbmNoIGZyb20g
aXRzZWxmIHRvIHNpbXBseSBmYWxsIGJhY2sgdG8gdGhlIF4wIGJlaGF2aW9yPw0KDQpBIG11Y2gg
YmV0dGVyIHNvbHV0aW9uIGluIG15IHZpZXcgd291bGQgYmUgdG8gYWltIGZvciByZWFsIHN0YXRl
bGVzc25lc3MgYW5kIG1ha2UgdGhlIGNhY2hpbmcgb2YgYnJhbmNoIHBvaW50ZXJzIGNvbXBsZXRl
bHkgdHJhbnNwYXJlbnQuIEZvciBhbGwgSSBjYW4gc2VlLCBmYXN0LWltcG9ydCBuZWFybHkgZm9s
bG93cyB0aGlzIHBhcmFkaWdtIGJ1dCB2aW9sYXRlcyBpdCBpbiB0aGlzIHN1YnRsZSBwb2ludC4g
T25jZSB3YXkgdG8gYWNoaWV2ZSB0aGlzIHdvdWxkIGJlIHRvIG9mZmVyIGFuIGV4cGxpY2l0IHdh
eSB0byBzdGF0ZSB0aGF0IGEgY29tbWl0IHNob3VsZCBoYXZlIG5vIHBhcmVudCBhbmQgZGVwcmVj
YXRlIHRoZSB2YXJpYW50IHdpdGhvdXQgImZyb20iIGFyZ3VtZW50LCBpc3N1aW5nIGEgd2Fybmlu
Zy4gVGhlIGdyZWF0IHByYWN0aWNhbCBhZHZhbnRhZ2Ugb2YgdGhhdCB3b3VsZCBiZSB0aGF0IGlu
dGVycnVwdGluZyBhbmQgY29udGludWluZyB0aGUgZmFzdC1pbXBvcnQgc3RyZWFtIHdvdWxkIGJl
IGd1YXJhbnRlZWQgdG8gZGVsaXZlciB0aGUgc2FtZSByZXN1bHQuIEZhciBtb3JlIGltcG9ydGFu
dCBpcyB0aGUgY29uY2VwdHVhbCBzaW1wbGljaXR5OiBBIGRldmVsb3BlciBjb3VsZCBjb21wbGV0
ZWx5IGZvcmdldCBhYm91dCBjYWNoaW5nIHdoZW4gaXQgY29tZXMgdG8gY29ycmVjdG5lc3MgYW5k
IG9ubHkgdGhpbmsgb2YgaXQgd2hlbiBpdCBjb21lcyB0byBwZXJmb3JtYW5jZSBvcHRpbWl6YXRp
b24uDQoNCkFueXdheTogdGhlc2UgYXJlIGFsbCBpbXByb3ZlbWVudHMgZm9yIGZ1dHVyZSBkZXZl
bG9wZXJzLiBQZXJzb25hbGx5LCBJIGFtIHNhdGlzZmllZCB3aXRoIGV2ZXJ5dGhpbmcgSSBoYXZl
Lg0KDQpHcmVldGluZ3MsDQpOb3JiZXJ0DQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IEVsaWphaCBOZXdyZW4gPG5ld3JlbkBnbWFpbC5jb20+IA0KU2VudDogTW9uZGF5LCBN
YXJjaCAxMSwgMjAxOSA4OjQ2IFBNDQpUbzogTm9yYmVydCBOZW1lYyA8Tm9yYmVydC5OZW1lY0Bt
aWNyb3NvZnQuY29tPg0KQ2M6IGdpdEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBmYXN0
LWltcG9ydCBvbiBleGlzdGluZyBicmFuY2hlcw0KDQpIaSBOb3JiZXJ0LA0KDQpPbiBGcmksIE1h
ciA4LCAyMDE5IGF0IDk6MzggQU0gTm9yYmVydCBOZW1lYyA8Tm9yYmVydC5OZW1lY0BtaWNyb3Nv
ZnQuY29tPiB3cm90ZToNCj4NCj4gVGhhbmtzLCBFbGlqYWgsIEkgaGFkIGluZGVlZCBtaXNzZWQg
dGhhdCBibG9jayBhYm91dCB0aGUgXjAgaGFuZGxpbmcuDQo+DQo+IEkgc3RpbGwgZG9uJ3QgZ2V0
IHdoeSB0aGlzIGF3a3dhcmQgd29ya2Fyb3VuZCBpcyByZXF1aXJlZC4gV2h5IGlzbid0IHRoYXQg
bG9va3VwIGRvbmUgYnkgZGVmYXVsdD8gUGVyZm9ybWFuY2UgY2FuJ3QgYmUgdGhlIHJlYXNvbiwg
c2luY2UgdGhlIHNhbWUgbG9va3VwIGlzIGRvbmUgbGF0ZXJvbiBhbnl3YXksIGp1c3QgYXMgY29y
cmVjdG5lc3MgY2hlY2suIFRoZSB3YXkgSSByZWFkIHRoZSBkb2N1bWVudGF0aW9uLCBwcm92aWRp
bmcgbm8gImZyb20iIHNob3VsZCBjb250aW51ZSBjb21taXR0aW5nIHRvIGEgYnJhbmNoIGluIGFu
eSBjYXNlLiBJIHdvdWxkIG5ldmVyIGhhdmUgc2VlbiB0aGUgY29udGludWF0aW9uIG9mIGFuIGlu
Y3JlbWVudGFsIGltcG9ydCBhICJzcGVjaWFsIGNhc2UiLiBUaGVyZSBpcyBhIG51bWJlciBvZiB0
b29scyBhcm91bmQgdGhhdCBzeW5jIGEgZ2l0IHJlcG8gZnJvbSBzb21lIG90aGVyIHNvdXJjZSBh
bmQgd291bGQgcmVndWxhcmx5IG5lZWQgdG8gY29udGludWUgYW4gZXhpc3RpbmcgYnJhbmNoLg0K
Pg0KPiBHcmVldGluZ3MsDQo+IE5vcmJlcnQNCg0KSWYgdGhpcyAiYXdrd2FyZCB3b3JrYXJvdW5k
IiwgYXMgeW91IHB1dCBpdCwgd2VyZSByZW1vdmVkIGl0IHdvdWxkIG1ha2UgaXQgaW1wb3NzaWJs
ZSB0byBjcmVhdGUgYSBjb21taXQgd2l0aCBubyBwYXJlbnQgd2l0aG91dCB1c2luZyBhIGRpZmZl
cmVudCBicmFuY2ggbmFtZS4gIEkgcmVhbGx5IGxpa2UgYmVpbmcgYWJsZSB0byBleHBvcnQsIG1v
ZGlmeSwgYW5kIHJlLWltcG9ydCBoaXN0b3J5LCB1c2luZyBzb21ldGhpbmcgb2YgdGhlIGZvcm06
DQoNCiAgIGdpdCBmYXN0LWV4cG9ydCAtLWFsbCB8IDxlZGl0IHRoZSBzdHJlYW0gc29tZWhvdz4g
fCBnaXQgZmFzdC1pbXBvcnQgLS1mb3JjZQ0KDQp3aGljaCB3b3VsZCBubyBsb25nZXIgd29yayBp
ZiBmYXN0LWltcG9ydCBhdXRvbWF0aWNhbGx5IGFzc3VtZWQgYSBwYXJlbnQgZm9yIGV2ZXJ5IGZy
b20tbGVzcyBjb21taXQgaW4gdGhlIGlucHV0IGJhc2VkIG9uIHRoZSByZWZlcmVuY2UgbmFtZS4g
IFBlcnNvbmFsbHksIEknbSBtb3JlIG9uIHRoZSBzaWRlIG9mIG5vdCB1bmRlcnN0YW5kaW5nIHdo
eSAiZnJvbSIgaXNuJ3QgcmVxdWlyZWQgd2hlbmV2ZXIgeW91IHdhbnQgeW91ciBjb21taXQgdG8g
aGF2ZSBhIHBhcmVudDsgdXNlcnMgY2FuIHNwZWNpZnkgZWl0aGVyIGEgc2hhIG9yIGEgbWFyay1p
ZCBlYXNpbHkgZW5vdWdoOyBJIGRvbid0IHNlZSB3aGF0IGl0IHNhdmVzIHRvIGFsbG93IG9taXR0
aW5nIGl0LCBhbmQgaXQgaW5ldml0YWJseSBsZWFkcyB0byBvdGhlciBjb25mdXNpb24gbGlrZSB5
b3Vycy4gIEJ1dCBJJ20gd2VsbCBvdmVyIGEgZGVjYWRlIHRvbyBsYXRlIHRvIGFkdm9jYXRlIGZv
ciB0aGF0Lg0KDQoNCkhvcGUgdGhhdCBoZWxwcywNCkVsaWphaA0K
