Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECA161F406
	for <e@80x24.org>; Wed, 17 Jan 2018 17:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753279AbeAQR0l (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 12:26:41 -0500
Received: from mail-by2nam03on0098.outbound.protection.outlook.com ([104.47.42.98]:54736
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750969AbeAQR0k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 12:26:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RG1YE6BH1KruO3woPTZiAxgHSB+MC9VWHvJvHAVSGH8=;
 b=Ru+7r2dDwiPjPWE82dq9Hhe/vIve1sxMowoe0WazMUd8QlnZ2a840EIxe3iKds/9VMK7ENWiR62y+bo6F+On/q4tEJNUxQKLY0BTQNPQYiAe5aPGOhe+vbupPU7+OGpyyeyFjSQxS4DceAKhYAenddpQnWn7UGz+CvPJJanpEH4=
Received: from DM5PR2101MB0902.namprd21.prod.outlook.com (52.132.132.159) by
 DM5PR2101MB0887.namprd21.prod.outlook.com (52.132.132.156) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.428.7; Wed, 17 Jan 2018 17:26:38 +0000
Received: from DM5PR2101MB0902.namprd21.prod.outlook.com
 ([fe80::b9e9:ed12:fc9b:d9c6]) by DM5PR2101MB0902.namprd21.prod.outlook.com
 ([fe80::b9e9:ed12:fc9b:d9c6%4]) with mapi id 15.20.0428.002; Wed, 17 Jan 2018
 17:26:37 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     Yasushi SHOJI <yashi@atmark-techno.com>,
        "gitster@pobox.com" <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH] RelNotes: fsmonitor: add a pointer to man page and the
 word itself
Thread-Topic: [PATCH] RelNotes: fsmonitor: add a pointer to man page and the
 word itself
Thread-Index: AQHTj1FLNGvBO1k8V0G2VpDFumWV1aN4UDIg
Date:   Wed, 17 Jan 2018 17:26:37 +0000
Message-ID: <DM5PR2101MB090243C1D9F5DA87565D7DEAF4E90@DM5PR2101MB0902.namprd21.prod.outlook.com>
References: <20180117050857.10480-1-yashi@atmark-techno.com>
In-Reply-To: <20180117050857.10480-1-yashi@atmark-techno.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=benpeart@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-01-17T17:26:35.5408216Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [70.33.148.227]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0887;6:wAxSB8VzsY+YeP1V04pfwxzc9B6hrYwxAgqctsPYl0Arv20jF+OssJOLiTzBMIZerWKBqCgPIryO0oR9oNTgvrhoKoa1epTS+0h4u68XHJcEiZEBFHxU8xgJrsteL1Y72PlCT1TruIshtSc78j0re+Y33Ik4s+fcxFZ1ZZ1Oz11GFCc/jCNejnuau3A68NZ8NGWmpxKk6Y/TBAGDVvK9IyLDOkCYFmK4Y4P3k+D+jb2/4wOh6e+m0WKlnn4huAhVZIkzFpMpfeUfINsbUo0B3HqXGLtootB+5O45r3C/yVwaEX8eBu+ZLGCRY9TGQxJVtvUge0R60nDmlDzjfuXPZPeq4hVo/QP+4ws9kw+p/nWKxLOb3r/D3qXrTgnxekRz;5:2xtD9rVrpgW4FOA/O01aWNt8eLXsQJ/+di+kOVuu3ZlfBxUKKNEnioIrKnAkRDTyOEUBoFdCyBZvP82FJhtZi7NHuuGPBRs+HvsfvaI5y1onEagf7fgTFTce9vYCTQJiXvTLz3Ynp97zfR4iyK3k5fbsRzqt44FXLKLrbubVv8I=;24:LucQ/GKSt7SvQ5XLP4t5Qt9XBEkInMEJbqx3s5kzYLTjR+tkj/43A4kzFC4hsowqYlNUjBDiXfQ2VkjKN4yoF0HmoBD0A83JMyib3I4XGqw=;7:Pp6K6hL6gcWn1aIEHGLXjJ1GSYNshZlwv+Qk0Ee9k54yVRjfSx8kAYxYtlTl97J/Yb5/QdHLP1d7kaLyc4pVqqlBY28FHCv46iuQ31x9q3VdX+GOuu69iEMW8vFV3qyhsAXDn+dRfXEfm2+Eduuga0pAv/AIBDMA0RBRKzsdDK+bb5pvC3eyH9gHJykUo+R9giinXEP4M1YNk8pYjFT+fjzZHb3VYU9fY4noXyk5A+PXx5C8khw+0ZfdAiEeT6FV
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 94e58cee-76f3-44f9-f0f5-08d55dcf770a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534125)(4602075)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603307)(7193020);SRVR:DM5PR2101MB0887;
x-ms-traffictypediagnostic: DM5PR2101MB0887:
x-microsoft-antispam-prvs: <DM5PR2101MB0887C088290958423964AEE2F4E90@DM5PR2101MB0887.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(100324003535756);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040470)(2401047)(5005006)(8121501046)(3231042)(2400048)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041268)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0887;BCL:0;PCL:0;RULEID:(100000803126)(100110400120);SRVR:DM5PR2101MB0887;
x-forefront-prvs: 0555EC8317
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(396003)(366004)(346002)(51444003)(189003)(199004)(51914003)(13464003)(3660700001)(305945005)(72206003)(8676002)(478600001)(3280700002)(8936002)(81156014)(25786009)(4326008)(59450400001)(3846002)(6116002)(6246003)(81166006)(86362001)(7736002)(66066001)(2900100001)(10290500003)(7696005)(5660300001)(97736004)(14454004)(76176011)(8656006)(110136005)(6436002)(6506007)(2906002)(86612001)(105586002)(2501003)(74316002)(22452003)(5250100002)(10090500001)(316002)(55016002)(99286004)(6346003)(33656002)(229853002)(53546011)(106356001)(8990500004)(53936002)(102836004)(2950100002)(26005)(68736007)(9686003)(71600200001)(19627235001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0887;H:DM5PR2101MB0902.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: d/+kPM7qV8mos6gAJ/qESDwAY7eYjQyyWRHVNpTMbCR5YvyaF7xX6g7nAH7wMnaRbRXsqTyU9uBs4dnOiEDWOg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e58cee-76f3-44f9-f0f5-08d55dcf770a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2018 17:26:37.8591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0887
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZYXN1c2hpIFNIT0pJIFttYWls
dG86eWFzaGlAYXRtYXJrLXRlY2huby5jb21dDQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAx
NywgMjAxOCAxMjowOSBBTQ0KPiBUbzogQmVuIFBlYXJ0IDxCZW4uUGVhcnRAbWljcm9zb2Z0LmNv
bT47IGdpdHN0ZXJAcG9ib3guY29tDQo+IENjOiBnaXRAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFtQQVRDSF0gUmVsTm90ZXM6IGZzbW9uaXRvcjogYWRkIGEgcG9pbnRlciB0byBtYW4gcGFn
ZSBhbmQgdGhlDQo+IHdvcmQgaXRzZWxmDQo+IA0KPiBBZGQgYSBwb2ludGVyIHRvIGdpdC11cGRh
dGUtaW5kZXgoMSkgYW5kIGEgYml0IG1vcmUgZGV0YWlsIGFib3V0IGZzbW9uaXRvcg0KPiBhbmQg
d2F0Y2htYW4gdG8gaGVscCBwZW9wbGUgZm9sbG93aW5nIHVwIHRoZSBuZXcgZmVhdHVyZS4NCj4g
LS0tDQo+IA0KPiBIaSBCZW4gYW5kIEp1bmlvLA0KPiANCj4gV291bGRuJ3QgaXQgYmUgbmljZSB0
byB0ZWxsIHRoZSB3b3JsZCBhIGJpdCBtb3JlIGFib3V0ICJmaWxlIHN5c3RlbSBtb25pdG9yIg0K
PiB3ZSBub3cgc3VwcG9ydD8gIEkgdGhpbmsgdGhhdCAiZ2l0IHN0YXR1cyIgYW5kICJ3YXRjaG1h
biINCj4gbWlnaHQgbm90IHJpbmcgdGhlIGJlbGwgZm9yIHNvbWUsIGJ1dCBhZGRpbmcgYSB3b3Jk
ICJmaWxlIHN5c3RlbSBtb25pdG9yIg0KPiBtYXkuDQo+IA0KDQpUaGFua3MgZm9yIHRoZSBjYWxs
IG91dCEgIEl0IHdvdWxkIGJlIGdyZWF0IGlmIGV2ZXJ5b25lIHdobyBoYXMgbGFyZ2VyIHJlcG9z
IGFuZCBleHBlcmllbmNpbmcgc2xvd2VyIGNvbW1hbmQgcGVyZm9ybWFuY2UgY291bGQgbGVhcm4g
YWJvdXQgdGhlIG5ldyBmaWxlIHN5c3RlbSBtb25pdG9yIHN1cHBvcnQuICBJJ20gbm90IHN1cmUg
aWYgZWRpdGluZyB0aGUgcmVsZWFzZSBub3RlcyB3b3VsZCBiZSBlbm91Z2ggdG8gZG8gdGhhdCBv
ciBub3QuIPCfmIogIEl0J3MgaW1wb3J0YW50IHRvIG5vdGUgdGhhdCB0aGUgc3VwcG9ydCBmb3Ig
ZmlsZSBzeXN0ZW0gbW9uaXRvcnMgaW4gZ2l0IGlzIGdlbmVyaWMgLSBhbnkgZmlsZSBzeXN0ZW0g
bW9uaXRvciBjYW4gYmUgaW50ZWdyYXRlZCB3aXRoIHRoZSBwcm9wZXIgaG9vay9zY3JpcHQuICBX
ZSBqdXN0IHByb3ZpZGVkIGEgUGVybCBzY3JpcHQgdG8gaW50ZWdyYXRlIHdpdGggV2F0Y2htYW4g
YXMgYSB1c2FibGUgc2FtcGxlIGFzIFdhdGNobWFuIGlzIGFscmVhZHkgYXZhaWxhYmxlIG9uIHNl
dmVyYWwgcGxhdGZvcm1zLg0KDQo+IEkga25vdyBtb3N0IG9mIHJlcG9zIGRvbid0IG5lZWQgZnNt
b25pdG9yIGJ1dCBpdCdzIGEgY29vbCBmZWF0dXJlIHRvIGhhdmUgaXQuIDstDQo+ICkNCj4gDQo+
IFdEWVQ/DQo+IA0KPiANCj4gIERvY3VtZW50YXRpb24vUmVsTm90ZXMvMi4xNi4wLnR4dCB8IDcg
KysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL1JlbE5vdGVzLzIuMTYuMC50eHQN
Cj4gYi9Eb2N1bWVudGF0aW9uL1JlbE5vdGVzLzIuMTYuMC50eHQNCj4gaW5kZXggOTE5ZjNlYjNl
Li4wYzgxYzU5MTUgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vUmVsTm90ZXMvMi4xNi4w
LnR4dA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL1JlbE5vdGVzLzIuMTYuMC50eHQNCj4gQEAgLTYy
LDggKzYyLDExIEBAIFVJLCBXb3JrZmxvd3MgJiBGZWF0dXJlcw0KPiAgICogVGhlIFN1Ym1pdHRp
bmdQYXRjaGVzIGRvY3VtZW50IGhhcyBiZWVuIGNvbnZlcnRlZCB0byBwcm9kdWNlIGFuDQo+ICAg
ICBIVE1MIHZlcnNpb24gdmlhIEFzY2lpRG9jL0FzY2lpZG9jdG9yLg0KPiANCj4gLSAqIFdlIGxl
YXJuZWQgdG8gdGFsayB0byB3YXRjaG1hbiB0byBzcGVlZCB1cCAiZ2l0IHN0YXR1cyIgYW5kIG90
aGVyDQo+IC0gICBvcGVyYXRpb25zIHRoYXQgbmVlZCB0byBzZWUgd2hpY2ggcGF0aHMgaGF2ZSBi
ZWVuIG1vZGlmaWVkLg0KPiArICogV2UgbGVhcm5lZCB0byBvcHRpb25hbGx5IHRhbGsgdG8gYSBm
aWxlIHN5c3RlbSBtb25pdG9yIHZpYSBuZXcNCj4gKyAgIGZzbW9uaXRvciBleHRlbnNpb24gdG8g
c3BlZWQgdXAgImdpdCBzdGF0dXMiIGFuZCBvdGhlciBvcGVyYXRpb25zDQo+ICsgICB0aGF0IG5l
ZWQgdG8gc2VlIHdoaWNoIHBhdGhzIGhhdmUgYmVlbiBtb2RpZmllZC4gIEN1cnJlbnRseSB3ZSBv
bmx5DQo+ICsgICBzdXBwb3J0ICJ3YXRjaG1hbiIuICBTZWUgRmlsZSBTeXN0ZW0gTW9uaXRvciBz
ZWN0aW9uIG9mDQo+ICsgICBnaXQtdXBkYXRlLWluZGV4KDEpIGZvciBtb3JlIGRldGFpbC4NCj4g
DQo+ICAgKiBUaGUgImRpZmYiIGZhbWlseSBvZiBjb21tYW5kcyBsZWFybmVkIHRvIGlnbm9yZSBk
aWZmZXJlbmNlcyBpbg0KPiAgICAgY2FycmlhZ2UgcmV0dXJuIGF0IHRoZSBlbmQgb2YgbGluZS4N
Cj4gLS0NCj4gMi4xNS4xDQo=
