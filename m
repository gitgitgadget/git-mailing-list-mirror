Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5B4D1F462
	for <e@80x24.org>; Wed, 29 May 2019 05:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfE2FPu (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 01:15:50 -0400
Received: from mx08-002aaa01.pphosted.com ([91.207.212.226]:4768 "EHLO
        mx08-002aaa01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725840AbfE2FPu (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 May 2019 01:15:50 -0400
Received: from pps.filterd (m0118688.ppops.net [127.0.0.1])
        by mx08-002aaa01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4T5Ek8s015030;
        Wed, 29 May 2019 05:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=edenred.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=dk201811;
 bh=04abn52RNNRLzLZ+5o6GJJmU2HsOPxSCgKQlud138fo=;
 b=BTkjH1Ig4WCHF4VhBC7WwSZXVjoPR49xoNB+5qrrd6/jezvz0L4dAiWoXCPOjQk6eeIM
 uIaKXjL5jb/o/R77qSU9mH6wSjUps0wAWjzXI5+nRALLaM50RnQvM1SCnNOego/UcaKb
 cH/B0YNSwG2dX70KSO84fz3KNgk0FPpq+SnGtJX25CPRDUlZBUxn7yIoYJvLjIJ+ZE+J
 UmztGERcrD04bvQ27bQnTaCm18fY08NfBSkhjR0eS88UXSwlc0GNKKF9Lu2334ZuR+gI
 jKR6hqN5gHaoVCX3BywCsd0pfRo+YAZr1sbua0HV5viXmE25kMUxzKujuOhsWtiOAd+i 0w== 
Received: from ehq-smtp-usr-p.edenred.com ([204.103.47.131])
        by mx08-002aaa01.pphosted.com with ESMTP id 2ssfjx8n1w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 May 2019 05:15:47 +0000
Received: from ehq-smtp-usr-mx1p16-p.edenred.com () by
 ehq-smtp-usr-mx1p20-p.edenred.com () with  (TLS) id
 15.0.1395.4; Wed, 29 May 2019 07:15:46 +0200
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (104.47.0.57) by
 ehq-smtp-usr-mx1p16-p.edenred.com () with  (TLS) id 15.0.1395.4
 via Frontend Transport; Wed, 29 May 2019 07:15:46 +0200
Received: from DB7PR05MB5573.eurprd05.prod.outlook.com (20.177.193.214) by
 DB7PR05MB4107.eurprd05.prod.outlook.com (52.134.107.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Wed, 29 May 2019 05:15:44 +0000
Received: from DB7PR05MB5573.eurprd05.prod.outlook.com
 ([fe80::d93a:e741:155:318d]) by DB7PR05MB5573.eurprd05.prod.outlook.com
 ([fe80::d93a:e741:155:318d%6]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 05:15:44 +0000
From:   LU Chuck <Chuck.LU@edenred.com>
To:     Johannes Sixt <j6t@kdbg.org>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "chuck.lu@qq.com" <chuck.lu@qq.com>
Subject: RE: git filter-branch re-write history over a range of commits did
 notwork
Thread-Topic: git filter-branch re-write history over a range of commits did
 notwork
Thread-Index: AdUUYk+0TU9swc+jQ+aKfvGwOQfe0wAVrIqAAEKsFaA=
Date:   Wed, 29 May 2019 05:15:44 +0000
Message-ID: <DB7PR05MB5573AD00490304E00CF6649D8D1F0@DB7PR05MB5573.eurprd05.prod.outlook.com>
References: <DB7PR05MB5573AD842E430342E2BD011B8D1D0@DB7PR05MB5573.eurprd05.prod.outlook.com>
 <db2dcf54-8b1c-39b1-579c-425ef158c6a1@kdbg.org>
In-Reply-To: <db2dcf54-8b1c-39b1-579c-425ef158c6a1@kdbg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [140.207.1.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ceec96b-02e9-446f-fac3-08d6e3f4b3b5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB7PR05MB4107;
x-ms-traffictypediagnostic: DB7PR05MB4107:
x-ms-exchange-purlcount: 5
x-microsoft-antispam-prvs: <DB7PR05MB4107820E6836FB61240C82F28D1F0@DB7PR05MB4107.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:73;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(136003)(346002)(366004)(13464003)(199004)(189003)(51874003)(186003)(476003)(486006)(6916009)(68736007)(66066001)(305945005)(102836004)(76176011)(6506007)(53546011)(966005)(99286004)(7696005)(53936002)(74316002)(11346002)(6246003)(25786009)(5660300002)(316002)(4326008)(54906003)(66446008)(8936002)(446003)(73956011)(66946007)(19627235002)(256004)(3846002)(66476007)(86362001)(81166006)(33656002)(7736002)(81156014)(8676002)(52536014)(71190400001)(71200400001)(14454004)(6116002)(2906002)(6306002)(26005)(72206003)(478600001)(6436002)(66556008)(55016002)(76116006)(9686003)(229853002)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR05MB4107;H:DB7PR05MB5573.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: edenred.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZTfJnjjymdRPJ/YYvGCCJbDEW0d3DYJioupfZINJykVHWV0kWJWjkkDKk7EBy/bKxqFthCvtIm74o4XLq0LXxn/UEcbi9qEXAsLfJEepCWecVx4qkJ+bKB532Xf6zu/WVYRUgFRqh0/ib4jMOGsnW50AEet9Wz9S3QjABtvWonwnTd39jg7SqEiaQ6+NaJoPQjmeJGQdmWUkZnAQVp0FHqiVu5MIZa01RB9YD6HvoyjRaiCv0zXs6+A7avh/YZy09aFwTUQP/5I8QWHS38pqfnylClK/NQV9qrtFWrGoeEl1AoAu3EYJ3z6NlyyXuflbvhmqW7J0cvb59geDDZqAimbcNHg418dNE20khpQh7Ny5icOQ/7oDkzxNIpw8pJS7IgvHZzcUzaiNnI3FUi1vwhMF5AxFbysMc2Sx9a9Jy9U=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ceec96b-02e9-446f-fac3-08d6e3f4b3b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 05:15:44.4557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4c1d9e0f-5c27-4228-a35a-de7b4083ff7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chuck.lu@edenred.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4107
X-OriginatorOrg: edenred.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-29_02:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaGFubmVzIFNpeHQgPGo2
dEBrZGJnLm9yZz4NCj4gU2VudDogVHVlc2RheSwgTWF5IDI4LCAyMDE5IDI6MjIgQU0NCj4gVG86
IExVIENodWNrIDxDaHVjay5MVUBlZGVucmVkLmNvbT4NCj4gQ2M6IGdpdEB2Z2VyLmtlcm5lbC5v
cmc7IGNodWNrLmx1QHFxLmNvbQ0KPiBTdWJqZWN0OiBSZTogZ2l0IGZpbHRlci1icmFuY2ggcmUt
d3JpdGUgaGlzdG9yeSBvdmVyIGEgcmFuZ2Ugb2YgY29tbWl0cyBkaWQgbm90d29yaw0KPiANCj4g
QW0gMjcuMDUuMTkgdW0gMTA6MDEgc2NocmllYiBMVSBDaHVjazoNCj4gPiBIaSB0ZWFtLA0KPiA+
DQo+ID4gICAgIFRoZSBpc3N1ZSBjb21lcyBmcm9tDQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9v
ZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fZ2l0aHViLmNvbV9naXQtMkRmb3ItMg0KPiBE
d2luZG93c19naXRfaXNzdWVzXzIyMDYmZD1Ed0lDYVEmYz1PMTdtNlVkcU9BSVpoOVhROHBUbDRn
JnI9VmNHZQ0KPiBJZU9aXzhfemxyUU5TYm9lbllsdGZ4R05JWE5fcUc2VnBaZ1hWUmsmbT1QQ1Mx
TTFpZmR4NnNBOFRNQ3A3U2NLQQ0KPiAzLUhqVWZBYWplUFpmR25RLTk0byZzPUo3dnROYzZJaEVj
cnVaSkJlQ1BKSk0yWFJfekMtMVowSlhtTng5azVjM3MmZQ0KPiA9IC4NCj4gPg0KPiA+ICAgICBJ
IHdhbnQgdG8gcmUtd3JpdGUgaGlzdG9yeSBieSBmaWx0ZXItYnJhbmNoIGNvbW1hbmQgb3ZlciBh
IHJhbmdlIG9mDQo+IGNvbW1pdHMsIGJ1dCB0aGUgY29tbWFuZCBkaWQgbm90IHdvcmsuDQo+ID4g
ICAgIEkgaGF2ZSByZWZlcnJlZCB0byB0aGUgZm9sbG93aW5nIHRocmVlIGRvY3VtZW50YXRpb24g
YWJvdXQgaG93IHRvIHVzZSBnaXQNCj4gZmlsdGVyLWJyYW5jaDoNCj4gPg0KPiBodHRwczovL3Vy
bGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX3N0YWNrb3ZlcmZsb3cu
Y29tX3F1ZXMNCj4gdGlvbnNfMTUyNTAwNzBfcnVubmluZy0yRGZpbHRlci0yRGJyYW5jaC0yRG92
ZXItMkRhLTJEcmFuZ2UtMkRvZi0yRGNvbQ0KPiBtaXRzJmQ9RHdJQ2FRJmM9TzE3bTZVZHFPQUla
aDlYUThwVGw0ZyZyPVZjR2VJZU9aXzhfemxyUU5TYm9lbllsdGYNCj4geEdOSVhOX3FHNlZwWmdY
VlJrJm09UENTMU0xaWZkeDZzQThUTUNwN1NjS0EzLUhqVWZBYWplUFpmR25RLTk0bw0KPiAmcz1Y
WlR0UGtFcWFqZGNHMXVEeGlYMEFBWDdGMlJhZjBqY3Vid0dUS0Z0cXYwJmU9DQo+ID4NCj4gaHR0
cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19zdGFja292
ZXJmbG93LmNvbV9xdWVzDQo+IHRpb25zXzI4NTM2OTgwX2dpdC0yRGNoYW5nZS0yRGNvbW1pdC0y
RGRhdGUtMkR0by0yRGF1dGhvci0yRGRhdGUmZD1EDQo+IHdJQ2FRJmM9TzE3bTZVZHFPQUlaaDlY
UThwVGw0ZyZyPVZjR2VJZU9aXzhfemxyUU5TYm9lbllsdGZ4R05JWE5fcQ0KPiBHNlZwWmdYVlJr
Jm09UENTMU0xaWZkeDZzQThUTUNwN1NjS0EzLUhqVWZBYWplUFpmR25RLTk0byZzPTZzY0MwDQo+
IFB5UkV6d0U2N3dBZXJWZ1B0ZE8tbmdfM1FfTTFJcjhzV0hYbWZzJmU9DQo+ID4NCj4gPiBodHRw
czovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX2dpdC0yRHNj
bS5jb21fZG9jDQo+ID4NCj4gc19naXQtMkRmaWx0ZXItMkRicmFuY2gmZD1Ed0lDYVEmYz1PMTdt
NlVkcU9BSVpoOVhROHBUbDRnJnI9VmNHZUllT1oNCj4gXzgNCj4gPg0KPiBfemxyUU5TYm9lblls
dGZ4R05JWE5fcUc2VnBaZ1hWUmsmbT1QQ1MxTTFpZmR4NnNBOFRNQ3A3U2NLQTMtSGpVZg0KPiBB
YWplUA0KPiA+IFpmR25RLTk0byZzPXRXYnJjem9QYjExWXdyN1k3SFBPOC1MYVhXaGJxckU0cTZp
eXJDYWJOc2smZT0NCj4gPg0KPiA+ICAgICBZb3UgY2FuIHJlcHJvZHVjZSB0aGUgcHJvYmxlbSBi
eSB0aGUgZm9sbG93aW5nIHN0ZXBzDQo+ID4gICAgIDEuIGNsb25lIHRoZSByZXBvc2l0b3J5DQo+
IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fZ2l0
aHViLmNvbV9jaHVja2x1X0xlZQ0KPiB0Q29kZV8mZD1Ed0lDYVEmYz1PMTdtNlVkcU9BSVpoOVhR
OHBUbDRnJnI9VmNHZUllT1pfOF96bHJRTlNib2VuDQo+IFlsdGZ4R05JWE5fcUc2VnBaZ1hWUmsm
bT1QQ1MxTTFpZmR4NnNBOFRNQ3A3U2NLQTMtSGpVZkFhamVQWmZHblEtDQo+IDk0byZzPUcwdW5N
clJRcm9VSzNlRTN3dTd4QklHSDlOYk8wNXlka0ZZUk9Lb0ljVTAmZT0NCj4gPiAgICAgMi4gY2hl
Y2tvdXQgdG8gdGhlIHRlbXAgYnJhbmNoDQo+ID4gICAgIDMuIHJ1biB0aGUgY29tbWFuZCBnaXQg
ZmlsdGVyLWJyYW5jaCAtLWVudi1maWx0ZXIgJ2V4cG9ydA0KPiA+IEdJVF9DT01NSVRURVJfREFU
RT0iJEdJVF9BVVRIT1JfREFURSInIC4uLiA2N2Q5ZDkuLmY3MGJmNA0KPiANCj4gRGlkIHlvdSBu
b3QgdGVsbCB1cyBldmVyeXRoaW5nIGJlY2F1c2UgeW91IHdyaXRlIC4uLiBpbiB0aGlzIG1lc3Nh
Z2Ugd2hlbiB5b3UgY2l0ZWQNCj4gdGhlIGNvbW1hbmQgeW91IHVzZWQsIG9yIGRvIHlvdSBzYXkg
dGhhdCB5b3UgdXNlZCAuLi4NCj4gbGl0ZXJhbGx5IGluIHRoZSBjb21tYW5kPw0KW0xVIENodWNr
XSBJIGZpbmQgdGhlIGdpdCBmaWx0ZXItYnJhbmNoIGNhbid0IHJlY29nbml6ZSBjb21taXRzIHJh
bmdlIGNvbW1pdEEuLmNvbW1pdEIsDQogICAgICAgICBpdCBjYW4gb25seSByZWNvZ25pemUgYnJh
bmNoQS4uYnJhbmNoQi4gKGJyYW5jaEEgcG9pbnQgdG8gY29tbWl0QSwgYnJhbmNoQiBwb2ludCB0
byBjb21taXRCLikNCiAgICAgICAgIEFuZCB5b3UgYXJlIHJpZ2h0LCBJIG5lZWQgcmVtb3ZlIHRo
ZSB1c2VsZXNzIC4uLiAuDQogICAgICAgICANCiAgICAgICAgIFNvIEkgZml4ZWQgdGhlIHByZXZp
b3VzIGNvbW1hbmQgYXMgZm9sbG93aW5nOg0KICAgICAgICAgQ3JlYXRlIGEgbmV3IGJyYW5jaCB0
ZW1wMiBwb2ludCB0byA2N2Q5ZDkgYW5kIHN3aXRjaCB0byB0ZW1wIGJyYW5jaChwb2ludCB0byBm
NzBiZjQpLCB0aGVuIGl0IHdvcmtzLg0KICAgICAgICAgZ2l0IGZpbHRlci1icmFuY2ggLS1lbnYt
ZmlsdGVyICdleHBvcnQgR0lUX0NPTU1JVFRFUl9EQVRFPSIkR0lUX0FVVEhPUl9EQVRFIicgdGVt
cDIuLnRlbXANCg0KICAgICAgICAgQnkgdGhlIHdheSwgd2hvIGNhbiBpbXByb3ZlIHRoZSBkb2N1
bWVudGF0aW9uIG9uIGh0dHBzOi8vZ2l0LXNjbS5jb20vZG9jcy9naXQtZmlsdGVyLWJyYW5jaD8g
Q3VycmVudGx5IHRoZSBkZW1vIHVzaW5nIGdpdCBmaWx0ZXItYnJhbmNoIHdpdGggY29tbWl0cyBy
YW5nZSBjb21taXRBLi5jb21taXRCLg0KICAgICAgICAgT3IgYW55b25lIGNhbiBtYWtlIGl0IHBv
c3NpYmxlIHRvIHN1cHBvcnQgdGhlIGNvbW1pdCByYW5nZSBieSBjb21taXRBLi5jb21taXRCPw0K
PiANCj4gPiAgICAgNC4gWW91IHdpbGwgZ290IHRoZSBpbmZvICJGb3VuZCBub3RoaW5nIHRvIHJl
d3JpdGUiDQo+ID4NCj4gPiAgICAgSG93ZXZlciwgaXQgd2FzIHN1cHBvc2VkIHRvIG92ZXJ3cml0
ZSB0aGUgaGlzdG9yeSBmcm9tIGNvbW1pdCA5YzE1ODAgdG8NCj4gY29tbWl0IGY3MGJmNCwgbWFr
ZSB0aGUgY29tbWl0IGRhdGUgc2FtZSBhcyBkYXRlLg0KPiA+ICAgICBJIGFtIG5vdCBzdXJlIGlm
IEkgYW0gdXNpbmcgdGhlIGZpbHRlci1icmFuY2ggY29ycmVjdGx5LCBvciBpZiB0aGVyZSBpcyBh
IGJ1ZyBpbg0KPiBnaXQ/DQo+ID4NCj4gPiAgICAgQW55b25lIGNhbiBoZWxwIG1lPyBUaGFua3Mg
aW4gYWR2YW5jZS4NCj4gDQo+IC0tIEhhbm5lcw0K
