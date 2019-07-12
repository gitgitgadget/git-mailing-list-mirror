Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE8DD1F461
	for <e@80x24.org>; Fri, 12 Jul 2019 20:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfGLUpb (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 16:45:31 -0400
Received: from mail-eopbgr760047.outbound.protection.outlook.com ([40.107.76.47]:57285
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727919AbfGLUpa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 16:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ra.rockwell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=We0KMrS4R/XcCUnHv2AyvVTO7L2Uu0GSo+KnTzEv3fw=;
 b=FhuH4moJP+cHZmbdXgDFaAe+ZXR7eokXoQz9TQkOTWn1odiEt3CzJunEDZqIRKO8nCTv37EpSl5blQQ1c/ypcmVnk99I9dvYWb7h6cpneeaEwcRDrMl9VS/VMOZkdDFyfESaaljmxdLjG9Vphj/2CYhs2woGxWUoPS+gzQrc/4s=
Received: from CY4PR2201MB1559.namprd22.prod.outlook.com (10.171.214.147) by
 CY4PR2201MB1638.namprd22.prod.outlook.com (10.171.241.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Fri, 12 Jul 2019 20:44:47 +0000
Received: from CY4PR2201MB1559.namprd22.prod.outlook.com
 ([fe80::a492:8110:c29:3f13]) by CY4PR2201MB1559.namprd22.prod.outlook.com
 ([fe80::a492:8110:c29:3f13%2]) with mapi id 15.20.2052.019; Fri, 12 Jul 2019
 20:44:47 +0000
From:   "Mark T. Ortell" <mtortell@ra.rockwell.com>
To:     Elijah Newren <newren@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: List of Known Issues for a particular release
Thread-Topic: List of Known Issues for a particular release
Thread-Index: AdU48qLif05yJSi4S/CDJhkAbzkd4g==
Date:   Fri, 12 Jul 2019 20:44:46 +0000
Message-ID: <CY4PR2201MB1559011A74B7252BFCAFDD489AF20@CY4PR2201MB1559.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mtortell@ra.rockwell.com; 
x-originating-ip: [205.175.240.243]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa193a02-661c-4430-0dd7-08d70709c702
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CY4PR2201MB1638;
x-ms-traffictypediagnostic: CY4PR2201MB1638:
x-microsoft-antispam-prvs: <CY4PR2201MB16388AB21AF19E78EE8966AE9AF20@CY4PR2201MB1638.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(51914003)(199004)(189003)(5660300002)(478600001)(25786009)(7736002)(305945005)(14444005)(256004)(66066001)(68736007)(2906002)(8676002)(81166006)(81156014)(33656002)(186003)(26005)(86362001)(52536014)(486006)(476003)(102836004)(229853002)(6436002)(6246003)(1411001)(53936002)(55016002)(99286004)(316002)(9686003)(74316002)(4326008)(6916009)(8936002)(76116006)(66946007)(66556008)(3846002)(66446008)(66476007)(64756008)(6116002)(71200400001)(6506007)(71190400001)(7696005)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR2201MB1638;H:CY4PR2201MB1559.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ra.rockwell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y9zL4vnN+JbjvhldPZAUrLHthA43m88oWnyztwa+pCE/WDdSsLlnoLzWCoxZcwvrlv8L0/bd6PXGIHM6e//nS/w61rJ57fWMe6eO7aE1i4PcDJGrA1l0mFMat8m567iO+wzQMn76rODVececDMyh0iWKSdEJ7c/JasOl6ot8UO04G+tf0r0+gWMEdDM3xo5wwTBeor2cY8CsDt8pKT3/7EgIexQsimjFUCgi5k7Lt59qucNeKsQRYdYawqeLw7XQ1DtjBZmAQOhylLwvVkDV3NA7iymrcHldaz8vVJF/wiaCTjT0wXnhcLqnC5O8La6VpHnxTN4TkBfyYyqwEr58Vkn2xC1t7FwOk9Jny1ZN0+nq8nf440ZeyIDdW1AWNNfAlbyUyjz69P2jzETN/Rr1RqaZgElhWO/V9fCrlBkrj5Y=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ra.rockwell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa193a02-661c-4430-0dd7-08d70709c702
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 20:44:46.9023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 855b093e-7340-45c7-9f0c-96150415893e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mtortell@rockwellautomation.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1638
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiB0ZXN0X2V4cGVjdF9mYWlsdXJlIChhcyB3ZWxsIGFzIG90aGVyIGhlbHBlciBmdW5jdGlvbnMg
aW4gdGhlIHRlc3QgDQo+IGhhcm5lc3MgbGlicmFyeSwgc3VjaCBhcyB0ZXN0X2V4cGVjdF9zdWNj
ZXNzLCB0ZXN0X211c3RfZmFpbCwgDQo+IHRlc3RfbWlnaHRfZmFpbCwgZXRjLikgYXJlIGV4cGxh
aW5lZCBpbiB0L1JFQURNRS4gIEJ5IGl0cyBkZWZpbml0aW9uLCANCj4gaXQgdGVjaG5pY2FsbHkg
c2F0aXNmaWVzICJsaXN0IG9mIGtub3duIGlzc3VlcyIgYXMgeW91IGFza2VkIGZvci4NCj4gSG93
ZXZlciwgbW9zdCBzb2Z0d2FyZSBwcm9kdWN0cyB0aGF0IHB1Ymxpc2ggYSBsaXN0IG9mIGtub3du
IGlzc3VlcyANCj4gaGFzIHByb2JhYmx5IGN1cmF0ZWQgcHJvYmxlbXMgdGhhdCB1c2VycyBhcmUg
bGlrZWx5IHRvIHNlZSBvciBiZSANCj4gY3VyaW91cyBhYm91dCwgYW5kIHdoaWNoIHRoZXkgd2Fu
dCB0byBpbmZvcm0gdXNlcnMgb2YgYm90aCB0byByZWR1Y2UNCj4gIHN1cHBvcnQgbG9hZCBhbmQg
aGVscCB1c2VycyBhdm9pZCBwcm9ibGVtcy4NCg0KUGVyZmVjdCwgdGhhdCBhbnN3ZXJzIG15IHF1
ZXN0aW9uLiANCg0KPiBUaGlzIGxpc3QgaXMgbm90IGN1cmF0ZWQgaW4gYW55IHN1Y2ggd2F5LiAg
SXQncyBqdXN0IGEgbGlzdCBvZiBpc3N1ZXMgDQo+IGRldmVsb3BlcnMgdGhvdWdodCB0byBkb2N1
bWVudCBmb3IgdGhlbXNlbHZlcyBhbmQvb3Igb3RoZXIgZGV2ZWxvcGVycy4NCj4gSXQgaXMgdGh1
cyB3YXkgZGlmZmVyZW50IHRoYW4gd2hhdCB5b3UgbWlnaHQgd2FudDoNCj4gDQo+ICgxKSBUaGVy
ZSBpcyBldmlkZW5jZSB0aGF0IHNvbWUgaGF2ZSB1c2VkIGl0IGZvciAiSW4gYW4gaWRlYWwgd29y
bGQsIA0KPiB0aGlzIHRoaW5nIHNob3VsZCBzdXBwb3J0IHRoaXMgZmVhdHVyZSB0b28gaW4gd2hp
Y2ggY2FzZSBJJ2QgZXhwZWN0IGl0IA0KPiB0byBiZWhhdmUgYSBjZXJ0YWluIHdheSB0aGF0IGl0
IGRvZXNuJ3QgeWV0LiIgIFRoZSBsaW5lIGJldHdlZW4gDQo+IGZlYXR1cmUgKHdoYXQgd29ya3Mg
aXMgZmluZSBidXQgd2UgY291bGQgbWFrZSBpdCBiZXR0ZXIpIGFuZCBidWcgKGl0J3MgDQo+IG5v
dCByZWFsbHkgY29ycmVjdCBpZiBpdCBkb2Vzbid0IGRvIGl0IHRoaXMgd2F5KSBnZXRzIHJlYWxs
eSBibHVycnkgYXQgDQo+IHRpbWVzLCBhbmQgeW91J2QgcGljayBhIG11Y2ggZGlmZmVyZW50IHRy
YWRlb2ZmIGluIGNvbW11bmljYXRpb24gDQo+IGJldHdlZW4gZGV2ZWxvcGVycyB0aGFuIHlvdSB3
b3VsZCBpbiBjb21tdW5pY2F0aW9uIGZyb20gZGV2ZWxvcGVycyB0byANCj4gdXNlcnM7IHdpdGgg
b3RoZXIgZGV2ZWxvcGVycyB5b3Ugc3BlbmQgYSBsb3QgbW9yZSB0aW1lIHRhbGtpbmcgYWJvdXQg
DQo+IGludGVybmFscyBhbmQgZ29hbHMgYW5kIGRpcmVjdGlvbiB3ZSdkIGxpa2UgdG8gbW92ZSB0
aGUgc29mdHdhcmUgaW4uDQo+IA0KPiAoMikgQWxzbywgc29tZSBvZiB0aGVzZSAia25vd24gYnJl
YWthZ2VzIiBjb3VsZCBiZSBpbiBjb3JuZXIgY2FzZXMgDQo+IHRoYXQgYXJlIHZlcnkgdW5saWtl
bHkgdG8gYmUgaGl0IGJlIHVzZXJzLCBhbmQgcGVyaGFwcyBub3Qgb25seSBsaWtlbHkgDQo+IHRv
IGJlIGhpdCBieSBpbmRpdmlkdWFsIHVzZXJzLCBidXQgdW5saWtlbHkgdGhhdCBhbnlvbmUgYW55
d2hlcmUgd2lsbCANCj4gZXZlciBoaXQgdGhhdCBlcnJvciAoc29tZSBvZiB0aGUgbWVyZ2UgcmVj
dXJzaXZlIHRlc3RzIEkgYWRkZWQgbWlnaHQgDQo+IGZhbGwgaW50byB0aGF0IGNhdGVnb3J5KS4N
Cj4gDQo+ICgzKSBUaGVyZSBtYXkgYWxzbyBiZSBjYXNlcyB3aGVyZSBzb21lb25lIG9uY2UgdGhv
dWdodCB0aGF0IG9wdGltYWwgDQo+IGJlaGF2aW9yIHdvdWxkIGJlIGEgbGl0dGxlIGRpZmZlcmVu
dCBhbmQgdGhhdCB0aGV5IHdlcmUgcGxhbm5pbmcgdG8gDQo+IGltcGxlbWVudCBtb3JlIGZlYXR1
cmVzLCBhbmQgdGhlbiBsYXRlciBjaGFuZ2VkIHRoZWlyIG1pbmQgYnV0IGZvcmdvdCANCj4gdG8g
Y2xlYW4gdXAgdGhlIHRlc3RjYXNlcy4NCj4gDQo+ICg0KSAuLi5hbmQgdGhhdCdzIGp1c3QgYSBm
ZXcgb2ZmIHRoZSB0b3Agb2YgbXkgaGVhZC4gIEknbSBzdXJlIHRoZSANCj4gbGlzdCBoYXMgc2V2
ZXJhbCBvdGhlciB0aGluZ3MgdGhhdCBtYWtlIGl0IG5vdCBxdWl0ZSBtYXRjaCB3aGF0IHlvdSAN
Cj4gd2FudC4NCg0KVGhhbmtzIGZvciB0aGUgZGV0YWlsZWQgY2xhcmlmaWNhdGlvbi4gVGhpcyBo
ZWxwcyBhIGxvdC4gSXQgbWF5IHJlcXVpcmUgYQ0KYml0IG9mIG1hbnVhbCB3b3JrIHNpZnRpbmcg
dGhyb3VnaCB0aGVzZSB0byBzZWUgd2hpY2ggY291bGQgcG90ZW50aWFsbHkNCmFmZmVjdCBvdXIg
dXNlIGNhc2VzICh2ZXJ5IHZlcnkgdW5saWtlbHkgYW55IHdpbGwsIGJ1dCB0aGF04oCZcyB0aGUg
ZHVlIGRpbGlnZW5jZQ0KdGhhdCBpcyByZXF1aXJlZCBmb3IgZnVuY3Rpb25hbCBzYWZldHkpLg0K
DQo+IEFzIHN1Y2gsIEJyaWFuJ3MgYW5zd2VyIHRvIHlvdXIgcXVlc3Rpb24gZWxzZXdoZXJlIGlu
IHRoaXMgdGhyZWFkIGlzIA0KPiBwcm9iYWJseSBiZXR0ZXIgdGhhbiBtaW5lLCBidXQgaWYgYnkg
Y2hhbmNlIHlvdSBhcmUganVzdCBiZWluZyBmb3JjZWQgDQo+IHRvIGdvIHRocm91Z2ggYSBib3gg
Y2hlY2tpbmcgZXhlcmNpc2UgYW5kIHRoZXJlJ3Mgbm8gcmVhc29uIGZvciANCj4gbmVlZGluZyB0
aGVzZSByZXN1bHRzIG90aGVyIHRoYW4gdGhhdCBzb21lb25lIGFza2VkIHRoYXQgdGhleSBiZSAN
Cj4gcHJvdmlkZWQgKEkgc29tZXRpbWVzIGhhZCB0byBnbyB0aHJvdWdoIHN1Y2ggZXhlcmNpc2Vz
IHdoZW4gSSB3b3JrZWQgDQo+IGF0IFNhbmRpYSBOYXRpb25hbCBMYWJzIHllYXJzIGFnbyksIHRo
ZW4gdGVjaG5pY2FsbHkgdGhlIGNvbW1hbmQgSSANCj4gZ2F2ZSB5b3UgY291bGQgYmUgdXNlZCB0
byBzYXRpc2Z5IGl0Lg0KDQpUaGFua3MgQnJpYW4gZm9yIHlvdXIgdGhvdWdodHMuIFdlIGRvbid0
IHVzZSBtdWNoIG9wZW4gc291cmNlIHNvZnR3YXJlDQpmb3Igb3VyIGZ1bmN0aW9uYWwgc2FmZXR5
IGRldmVsb3BtZW50IChmb3IgdGhpcyByZWFzb24pLCBzbyB0aGlzIGlzIG5ldyANCnRlcnJpdG9y
eSBmb3IgdXMuIEkgdGhpbmsgRWxpamFoJ3MgaW5mb3JtYXRpb24gd2lsbCBnZXQgbWUgbW9zdCBv
ZiB0aGUgd2F5IHRoZXJlLg0KDQpBbHNvLCBJIHB1bGxlZCBkb3duIHRoZSBzb3VyY2UgZm9yIHRo
ZSByZWxlYXNlIHZlcnNpb24gd2UgYXJlIHVzaW5nIGFuZCByYW4gDQp0aGUgdGVzdCBzdWl0ZSBv
biBpdCB0byBoYXZlIHJlc3VsdHMgdGhhdCBjb25maXJtIHRoYXQgdGhlIHNvZnR3YXJlIGlzIHdv
cmtpbmcgDQphY2NvcmRpbmcgdG8gdGhlIGRlc2lnbiwgc28gdGhhdCBpcyByZWFsbHkgaGVscGZ1
bCB0byBoYXZlIGFzIHdlbGwuIA0KDQpDaGVlcnMsDQpNYXJrDQo=
