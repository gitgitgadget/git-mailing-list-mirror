Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F5CC1F462
	for <e@80x24.org>; Fri, 31 May 2019 15:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfEaPNY (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 11:13:24 -0400
Received: from mail-eopbgr730119.outbound.protection.outlook.com ([40.107.73.119]:53661
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726501AbfEaPNY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 11:13:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=h03p6/DVu3UlFzTzvRCW9WXdRpx3/a2K1WNjRGsThGRXGHKX7Mo/NmwO0R41Np7zJZytwBNsDdYgyXar89iL3sLzCebq6czIZ8igXK/qGS7F1LXb/MAtm/PG/YEBzHktycIFoYCnMMnGfWYfYi0duxX6lIV4++sES4modoQNFkw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNcjuSKGSvvud7A87pHDAyP6F3cReLLacViBeAvdsUc=;
 b=PdySk9BEIyzN9WmOlnlQHYqP6N71HD1CKAPgA+6a2o+RtCNbaWxNUHYFs0bdcq6qXEE1/03XK8xQ+OKiGIw+VvPDfV0encyjvVOovvr8s8vqTkhjaPudouwHw9GEfZyMtwEllIFiSp9H9R8NuI093hQC/CFVtx4qsWeDWTtoxxA=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNcjuSKGSvvud7A87pHDAyP6F3cReLLacViBeAvdsUc=;
 b=Ls8D0O7xmH0uMBiPhXtfuOJq9meFodBmCzUIU0dZvCAwwZ6pihyswdLTN5ekQ7nCu3bKWRjtU6+K9gLTenn5IPpJcIvLgbr4l0qWYA9ll2z9MsqeaGrEOreQXCxvoXh5uCuHn28lm4EvQMaguFBZ8CYQj1xMyo4a/GfwHzgm944=
Received: from BN8PR21MB1156.namprd21.prod.outlook.com (2603:10b6:408:73::11)
 by BN8PR21MB1284.namprd21.prod.outlook.com (2603:10b6:408:a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.1; Fri, 31 May
 2019 15:13:21 +0000
Received: from BN8PR21MB1156.namprd21.prod.outlook.com
 ([fe80::2147:f6c0:c7f:30e1]) by BN8PR21MB1156.namprd21.prod.outlook.com
 ([fe80::2147:f6c0:c7f:30e1%7]) with mapi id 15.20.1965.003; Fri, 31 May 2019
 15:13:21 +0000
From:   Cliff Schomburg <clisc@microsoft.com>
To:     Patryk Obara <dreamer.tan@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Simple shortcut for "git push --set-upstream origin
 newBranchName"
Thread-Topic: Simple shortcut for "git push --set-upstream origin
 newBranchName"
Thread-Index: AdUXME7sW+dzzd+8STqmdbLpESwchwABfZYAAAAnfwAAIhlQgAAAP3sAAAAXsKAAAGgqAAAAPcTg
Date:   Fri, 31 May 2019 15:13:21 +0000
Message-ID: <BN8PR21MB1156D785177A40EA7D8341ABB7190@BN8PR21MB1156.namprd21.prod.outlook.com>
References: <BN8PR21MB1156ED141AE2662BC5328A22B7180@BN8PR21MB1156.namprd21.prod.outlook.com>
 <BN8PR21MB1156F593DAEBD7194DA7041EB7180@BN8PR21MB1156.namprd21.prod.outlook.com>
 <BN8PR21MB1156DA1893F64814F1BE8709B7180@BN8PR21MB1156.namprd21.prod.outlook.com>
 <BN8PR21MB1156F7F3E7EFF9C8A60F33D0B7190@BN8PR21MB1156.namprd21.prod.outlook.com>
 <ac62f96f-0ebc-2dff-3365-781e6b9142a3@gmail.com>
 <BN8PR21MB115693C381F65E97AB65FA18B7190@BN8PR21MB1156.namprd21.prod.outlook.com>
 <ebc03b4e-daf8-d47f-94ca-a4a549589773@gmail.com>
In-Reply-To: <ebc03b4e-daf8-d47f-94ca-a4a549589773@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=clisc@microsoft.com; 
x-originating-ip: [24.182.67.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 293c3950-83eb-4575-0587-08d6e5da84ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BN8PR21MB1284;
x-ms-traffictypediagnostic: BN8PR21MB1284:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN8PR21MB128492CDF58B9C1B13C44E33B7190@BN8PR21MB1284.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(13464003)(71190400001)(66556008)(229853002)(66476007)(68736007)(66446008)(6306002)(2501003)(55016002)(33656002)(7696005)(14454004)(10290500003)(6436002)(66066001)(446003)(64756008)(8990500004)(486006)(476003)(11346002)(256004)(71200400001)(53546011)(66946007)(6506007)(5660300002)(52396003)(76176011)(2906002)(102836004)(22452003)(73956011)(9686003)(110136005)(99286004)(52536014)(26005)(305945005)(8676002)(8936002)(25786009)(81166006)(76116006)(86362001)(10090500001)(6246003)(6116002)(478600001)(74316002)(81156014)(3846002)(7736002)(316002)(966005)(53936002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1284;H:BN8PR21MB1156.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 79gfh+Dxk0U1yAnE0IERdzqFUMK3mWNyU4nne7AkR856LCcwUbp8eM+EiESkz3LN8/RMqm5QA4o3GVahB+rToECSdrMsvlfTEsjHDBo4ztuwrKvtdPzJ2/GzOMvcZrlGC5pq0G+dJeMBKS4ff1kcCKq8Ym5wC7UeJq7f/pBwJriP/byrSUMcg8rxjSLpHlUH7liAjbFM70qCGS+cYeVjjc4NYl3rcf1jJn8LsAg93WmJ5AYZXoBIFdxfLncj0IWE6ZnMjQ1JETdBK6x5kjXWof19vh5JxCVDcZ0Pyo8yT0+m8nDrHFqgjNV5Uh5f6ZP7V2gevHwcfWN0oCgAUpZ/afYQx5SF62GYH0Mvs7vqPfCUAX7DVudal8uV839yLMRnib18hxc+aHhIWJIny7XJhWVWDwCHBLrIcxVOmfJVKyY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 293c3950-83eb-4575-0587-08d6e5da84ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 15:13:21.2967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: clisc@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1284
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzLCBQYXRyeWsuICBJdCdzIGFsd2F5cyBuaWNlIHRvIHNlZSB0aGUgZmVhdHVyZSBJIHdh
bnQgaXMgYWxyZWFkeSBpbXBsZW1lbnRlZCEgIPCfmIoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IFBhdHJ5ayBPYmFyYSA8ZHJlYW1lci50YW5AZ21haWwuY29tPiANClNlbnQ6
IEZyaWRheSwgTWF5IDMxLCAyMDE5IDExOjA1IEFNDQpUbzogQ2xpZmYgU2Nob21idXJnIDxjbGlz
Y0BtaWNyb3NvZnQuY29tPjsgZ2l0QHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFNpbXBs
ZSBzaG9ydGN1dCBmb3IgImdpdCBwdXNoIC0tc2V0LXVwc3RyZWFtIG9yaWdpbiBuZXdCcmFuY2hO
YW1lIg0KDQpPbiAzMS8wNS8yMDE5IDE2OjU2LCBDbGlmZiBTY2hvbWJ1cmcgd3JvdGU6DQo+IFdv
dywgSSBkaWQgbm90IHNlZSB0aGF0IGluIHRoZSBtYW4gcGFnZXMuLi4gYnV0IEkgc2VlIGl0IG5v
dy4gIFRoYW5rcyENCj4gDQo+IFNvIEkgZ3Vlc3MgSSB3b3VsZCBjaGFuZ2UgbXkgYXNrIHRvIHRo
aXM6DQo+IA0KPiAiZ2l0IHB1c2ggLXUiDQo+IA0KPiBTaG91bGQgZGVmYXVsdCB0byAib3JpZ2lu
IGJyYW5jaCIgaWYgbm8gcGFyYW1ldGVycyBhcmUgcHJvdmlkZWQuDQoNCkkgdGhpbmsgbW9zdCBw
ZW9wbGUgd2lsbCBhZ3JlZSwgY29uc2lkZXJpbmcgaXQgYWxyZWFkeSB3b3JrcyB0aGlzIHdheSA6
KQ0KDQpUaGUgZGVmYXVsdCBiZWhhdmlvdXIgb2YgZ2l0IHB1c2ggY2hhbmdlZCBpbiBHaXQgMi4w
LCBwZXJoYXBzIHlvdSB3ZXJlIHJlYWRpbmcgc29tZSBvbGQgdHV0b3JpYWwuIFlvdSBjYW4gY29u
ZmlndXJlIGl0IHRvIG1hdGNoIHlvdXIgcHJlZmVyZW5jZXMgYnkgY2hhbmdpbmcgcHVzaC5kZWZh
dWx0IHZhbHVlIGluIHlvdXIgZ2l0IGNvbmZpZzoNCg0KaHR0cHM6Ly9uYW0wNi5zYWZlbGlua3Mu
cHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGZ2l0LXNjbS5jb20lMkZk
b2NzJTJGZ2l0LWNvbmZpZyUyM0RvY3VtZW50YXRpb24lMkZnaXQtY29uZmlnLnR4dC1wdXNoZGVm
YXVsdCZhbXA7ZGF0YT0wMiU3QzAxJTdDY2xpc2MlNDBtaWNyb3NvZnQuY29tJTdDZjUyZDY5OWMz
ZmMxNDlkMjBkZTUwOGQ2ZTVkOTZhNGMlN0M3MmY5ODhiZjg2ZjE0MWFmOTFhYjJkN2NkMDExZGI0
NyU3QzElN0MwJTdDNjM2OTQ5MTE5Mjg5NzcwODM4JmFtcDtzZGF0YT1LMk5lendPV3pacnFzVTds
OEd5YmpiSnV3bVJuQzJsbFQ3N1VodkYlMkI4UlUlM0QmYW1wO3Jlc2VydmVkPTANCg0KLS0NClBh
dHJ5ayBPYmFyYQ0K
