Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 428BC1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 17:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753849AbeAHRmL (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 12:42:11 -0500
Received: from mail-bl2nam02on0126.outbound.protection.outlook.com ([104.47.38.126]:2801
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753595AbeAHRmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 12:42:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=JEry+aoxu1+HUVePOuPjPfFnCb8ejy0tDzZDPv4E6wM=;
 b=cQjOfuL/NklEusEXrdkZi/U+DRjWSyN8SioBBjLZjVxA96NLyMixFU2dkJd9Upgrwy9IdLDX4+Y+C6zINzzl5ivvTN56yMy4Q66xEoVG3daF99GDoetG28mpFlKuhWXcTqMhNhIjkQRRzlZVSjfdV40OKabmB5ezA8qX/KqCY3Q=
Received: from DM5PR2101MB0902.namprd21.prod.outlook.com (52.132.132.159) by
 DM5PR2101MB0934.namprd21.prod.outlook.com (52.132.131.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.407.2; Mon, 8 Jan 2018 17:42:07 +0000
Received: from DM5PR2101MB0902.namprd21.prod.outlook.com
 ([fe80::b9e9:ed12:fc9b:d9c6]) by DM5PR2101MB0902.namprd21.prod.outlook.com
 ([fe80::b9e9:ed12:fc9b:d9c6%4]) with mapi id 15.20.0407.000; Mon, 8 Jan 2018
 17:42:07 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>
CC:     Alex Vandiver <alexmv@dropbox.com>
Subject: RE: git-p4 + watchman - watching the p4 repo?
Thread-Topic: git-p4 + watchman - watching the p4 repo?
Thread-Index: AQHTiKRRnzxm8LWLE06LEWhFOj1OGqNqPaUA
Date:   Mon, 8 Jan 2018 17:42:06 +0000
Message-ID: <DM5PR2101MB0902FE564628A5604AB860F9F4130@DM5PR2101MB0902.namprd21.prod.outlook.com>
References: <CAE5ih79t8N969E-8qm9JMNZZo6qvRqw6GA=b6UTHskB-ozt7Fg@mail.gmail.com>
In-Reply-To: <CAE5ih79t8N969E-8qm9JMNZZo6qvRqw6GA=b6UTHskB-ozt7Fg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=benpeart@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-01-08T17:42:03.2841015Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [70.33.148.227]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0934;7:M9P990/cMF68A3qGvmPIfP1FdIoqLHLi8BpLzSyHGUgOVB2elSJ5D5yZXRMYE7zFCRYA/BsdhN50CdvwECK9T3Xmpgilx8uzDzs2M31MCDniUZEyPv8M7705GBKSJhBg3r9v4QozBqH7fXFzEhcMEX2fQqyFFjYIBrgMPhoQPQ3aLGpUiW1ux5X03ylVSUvYFyqesXuoR+4EVQdAdjxcTwoNO3LWGAgHoHwv0UZFnKkxTluKBI4GeMjmC1uanY8d
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: b8b99753-dc87-4864-1407-08d556bf2328
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020040)(5600026)(4604075)(3008032)(48565401081)(2017052603307)(7193020);SRVR:DM5PR2101MB0934;
x-ms-traffictypediagnostic: DM5PR2101MB0934:
x-microsoft-antispam-prvs: <DM5PR2101MB0934E58D6D0F631D4301C509F4130@DM5PR2101MB0934.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(89211679590171)(9452136761055)(60067363179207);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040470)(2401047)(8121501046)(5005006)(10201501046)(3231023)(944501098)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041268)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0934;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:DM5PR2101MB0934;
x-forefront-prvs: 054642504A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(346002)(366004)(376002)(13464003)(199004)(189003)(5660300001)(229853002)(6436002)(2906002)(66066001)(102836004)(106356001)(105586002)(55016002)(14454004)(68736007)(25786009)(8676002)(4326008)(3846002)(2950100002)(8936002)(9686003)(3660700001)(3280700002)(81166006)(6116002)(81156014)(6246003)(97736004)(72206003)(53936002)(2900100001)(8990500004)(10090500001)(5250100002)(10290500003)(74316002)(76176011)(99286004)(110136005)(22452003)(53546011)(305945005)(6506007)(316002)(478600001)(7696005)(33656002)(7736002)(86362001)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0934;H:DM5PR2101MB0902.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: emXxBJSOKxHNdKHkB/IXQhd3oCAIgQRE+Dm+6c+wBxCaF8xWm6PdhPHC+9lbmmKwxv4yeez+KLWFXWydzcI/Zw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b99753-dc87-4864-1407-08d556bf2328
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2018 17:42:07.0564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0934
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SSBoYXZlbid0IHVzZWQgcGVyZm9yY2Ugc28gYW0gdW5mYW1pbGlhciB3aXRoIGFueSBiZWhhdmlv
cnMgc3BlY2lmaWMgdG8gdGhhdCBidXQgdGhlIGxvZ2ljIHRvIGhhdmUgZ2l0IGF1dG9tYXRpY2Fs
bHkgdGVsbCB3YXRjaG1hbiB0byBzdGFydCB3YXRjaGluZyByZXBvcyBpcyBqdXN0IGEgY29udmVu
aWVuY2UgZmVhdHVyZS4gIEZlZWwgZnJlZSB0byByZW1vdmUvZGlzYWJsZS9tb2RpZnkgaXQgaW4g
dGhlIGZzbW9uaXRvci13YXRjaG1hbiBpbnRlZ3JhdGlvbiBzY3JpcHQ6DQoNCglpZiAoJHJldHJ5
ID4gMCBhbmQgJG8tPntlcnJvcn0gYW5kICRvLT57ZXJyb3J9ID1+IG0vdW5hYmxlIHRvIHJlc29s
dmUgcm9vdCAuKiBkaXJlY3RvcnkgKC4qKSBpcyBub3Qgd2F0Y2hlZC8pIHsNCgkJcHJpbnQgU1RE
RVJSICJBZGRpbmcgJyRnaXRfd29ya190cmVlJyB0byB3YXRjaG1hbidzIHdhdGNoIGxpc3QuXG4i
Ow0KCQkkcmV0cnktLTsNCgkJcXgvd2F0Y2htYW4gd2F0Y2ggIiRnaXRfd29ya190cmVlIi87DQoN
CkJlbg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEx1a2UgRGlhbWFu
ZCBbbWFpbHRvOmx1a2VAZGlhbWFuZC5vcmddDQo+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSA4LCAy
MDE4IDEyOjE1IFBNDQo+IFRvOiBHaXQgVXNlcnMgPGdpdEB2Z2VyLmtlcm5lbC5vcmc+DQo+IENj
OiBBbGV4IFZhbmRpdmVyIDxhbGV4bXZAZHJvcGJveC5jb20+OyBCZW4gUGVhcnQNCj4gPEJlbi5Q
ZWFydEBtaWNyb3NvZnQuY29tPg0KPiBTdWJqZWN0OiBnaXQtcDQgKyB3YXRjaG1hbiAtIHdhdGNo
aW5nIHRoZSBwNCByZXBvPw0KPiANCj4gSGkhDQo+IA0KPiBJIGNvdWxkIGJlIHdyb25nIGFib3V0
IHRoaXMsIGJ1dCBJIHdoZW4gSSB0cmllZCBtaXhpbmcgd2F0Y2htYW4gd2l0aCBnaXQtcDQsIEkN
Cj4gZm91bmQgdGhhdCBvbiAiZ2l0IHA0IHN1Ym1pdCIgaXQgZW5kZWQgdXAgd2F0Y2hpbmcgdGhl
IHA0IHJlcG8sIHdoaWNoIHNlZW1zDQo+IGEgYml0IHBvaW50bGVzcyAoYW5kIHdhcyBhbHNvIHZl
cnkgc2xvdykuDQo+IA0KPiAkIFtjcmVhdGUgZ2l0LXA0IGNsb25lIG9mIHNvbWUgcDQgcmVwb10N
Cj4gJCA6ID5iYXINCj4gJCBnaXQgYWRkIGJhciAmJiBnaXQgY29tbWl0IC1tICdhZGRpbmcgYmFy
Jw0KPiAkIGdpdCBwNCBzdWJtaXQgLS1vcmlnaW4gSEVBRF4gLS1zaGVsdmUNCj4gUGVyZm9yY2Ug
Y2hlY2tvdXQgZm9yIGRlcG90IHBhdGggLy9kZXBvdC8gbG9jYXRlZCBhdCAvdG1wL3A0L2NsaS8N
Cj4gU3luY2hyb25pemluZyBwNCBjaGVja291dC4uLg0KPiAuLi4gLSBmaWxlKHMpIHVwLXRvLWRh
dGUuDQo+IEFwcGx5aW5nIDRjZTQwNTcgY2hhbmdlDQo+IC8vZGVwb3QvYmFyIzEgLSBvcGVuZWQg
Zm9yIGVkaXQNCj4gQWRkaW5nICcvdG1wL3A0L2NsaScgdG8gd2F0Y2htYW4ncyB3YXRjaCBsaXN0
Lg0KPiANCj4gSXMgdGhlcmUgYW55IHdheSB0byBzdG9wIGl0IGRvaW5nIHRoaXM/DQo+IA0KPiBU
aGFua3MhDQo+IEx1a2UNCg==
