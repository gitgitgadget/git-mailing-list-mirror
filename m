Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C38C11F64
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 22:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 403C761CF7
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 22:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhF1WaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 18:30:14 -0400
Received: from us-smtp-delivery-104.mimecast.com ([216.205.24.104]:43424 "EHLO
        us-smtp-delivery-104.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235371AbhF1WaI (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 28 Jun 2021 18:30:08 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Jun 2021 18:30:08 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=globalfinishing.com;
        s=mimecast20180829; t=1624919260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=peORLFdhuWQ2MWCc0jH1LqStp1/rE8cV4abHDVeEcUk=;
        b=Ab4or8TvW4WPk3cjK1YHhMaw+3MvPF2pCK1n1lBBbl5tDruZX2WZ7imeYyA+AMMU2xnP9H
        hxUI2TbQFPAB5JFcNocaZbkTX8ZZ+uXsgK3TvHFMUEztsfIAUrvkHw0TulReGSO3oWbb2W
        TAb4yggoOkTki+7JqzAMmDZhr4OffCs=
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
 (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-sX645KM2N-WVaxHWnF9ryQ-1; Mon, 28 Jun 2021 18:21:28 -0400
X-MC-Unique: sX645KM2N-WVaxHWnF9ryQ-1
Received: from CY4PR16MB1655.namprd16.prod.outlook.com (2603:10b6:910:6d::10)
 by CY4PR16MB1718.namprd16.prod.outlook.com (2603:10b6:910:69::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Mon, 28 Jun
 2021 22:21:26 +0000
Received: from CY4PR16MB1655.namprd16.prod.outlook.com
 ([fe80::6998:4869:a283:d3b]) by CY4PR16MB1655.namprd16.prod.outlook.com
 ([fe80::6998:4869:a283:d3b%12]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 22:21:26 +0000
From:   Jason Hatton <jhatton@globalfinishing.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Documentation Typo
Thread-Topic: Documentation Typo
Thread-Index: Addsa1xUHnxDfzdDSau23n5TT7fI8g==
Date:   Mon, 28 Jun 2021 22:21:26 +0000
Message-ID: <CY4PR16MB1655C5F8225B32A2029EADE2AF039@CY4PR16MB1655.namprd16.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [69.147.212.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3eaa13d-2f8a-4a86-703b-08d93a831210
x-ms-traffictypediagnostic: CY4PR16MB1718:
x-microsoft-antispam-prvs: <CY4PR16MB17185FBE61D8239227FD8A60AF039@CY4PR16MB1718.namprd16.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: umMePXik2abpa48BeR9N5vhmjw71Oe0IuLwCf5MnrZNvqlHDfhRgvHcJg1LDGcb/kE0Ic5Q3n7dsZq20VkwVyZ57wobhfMopIsh8vgUA8veHIiV2A7bJTLNQ/91CZx+a/Oy5IVz1jIhSPn5J6pPJ4c45NrCy6cdXIRlwDRGGxpt9FdA+mPfT1dxhlfVkDNlL8Jr4BaSta1dJlGMBYEK1rnVCZBKTfbXjMgdqHpFelYThFnK/VyLY80Fx4eiNLvHQf3baw6Ss8N+/AO+DttRJSZi8ABB3QzvIE1ArOZcQE8XHZsIcBB7XYMSAQfpygnTCUFeg0SpCwKPpEfvh/WjtPOBk5lP8GRaozfPyJb/KFwgzpJP0INfAUy2IhtUYZvrJ+J92YTL9BIPDOlja97/SWN5VcU6OTXflplmsReGYaLaHdxphughkJYZ7kImhk7JlEhdgWeuda9vH4OM94voQHM3nezy7RdF6efA0Uu2Tw6LkIonvXsV1PisiAF189XDiDDNQv7rysOIzAUa2mOLRfsT6iYK0PAG1vIT7dN2MTcTLe3EB6+oylFZCREyfzAiKuSSZBrKkDePSkIlAvjMypww2GrrpylFIjvN7eS9P79dTTJqACD75lQnfFCLSz/nMKd0/tLhSq0jaxmzuUgp8sQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR16MB1655.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(396003)(366004)(136003)(346002)(376002)(5660300002)(33656002)(66476007)(9686003)(7116003)(76116006)(66446008)(4744005)(8676002)(55016002)(66556008)(64756008)(52536014)(83380400001)(71200400001)(66946007)(8936002)(6916009)(186003)(6506007)(26005)(38100700002)(122000001)(86362001)(316002)(3480700007)(7696005)(478600001)(2906002);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDZPV21hbHZ0Vzgrek8vVDhCcmJLMGcvVkRMbTlLN3BTNTMwY2dPNGpTUnNa?=
 =?utf-8?B?VjVITWVZYzNFREVyK0ptMTB5bjZtZ2cwdWptSWJsSm5XYytLQVp3ZmVPbnN4?=
 =?utf-8?B?ZGhaNEMybUM5UGVaSXlnK0Q4S0dSOEQ0cms1QkhmZ0I5QU5sTHNBZGtTNEtv?=
 =?utf-8?B?a0pCejNKeURESWtMdkorcjhXWDU4QmZiSnNqRE9MQWtqYXpJUlh1K1J0ZVBD?=
 =?utf-8?B?cmdXQ05Cd05jQmZ4c3hFNGl0TzVuWmxOOVNtOWFJdEpva3N1TG8ydVdsL2M2?=
 =?utf-8?B?Y3VtaDhtOWtnMmpSQkEyTFI0UHVtQXF2dnJ3Q2dxM2xvS0RoeVlENnFBOFB3?=
 =?utf-8?B?dkt1bGxkR1JVQkJObjh4aXRRSjlmS1drcTlDc1ljWnZzYlNKLzhjRXRRQ0hP?=
 =?utf-8?B?WHdDWHpTQ1lxYWo5NUZiTDQ1bElzRlNTSnQ5aWFxaUlwRllyNU12TDFMNGpt?=
 =?utf-8?B?SEs4R1puUC9DaUMzNnh3VHBTak9aQmYzL0Vyd3hUcmpWU0NuVWVYVnoyN2J1?=
 =?utf-8?B?T25TdW41Ukp5SEhaTXRGWnB4ZzJqK1JLaU00S1RvZm93aW5iMUFWSC83cGRT?=
 =?utf-8?B?eldVNS9sOTFHcUNLdXRaY2srN1drOHNrM0V5NkhIQWlEL2MzVzdWekhtNklZ?=
 =?utf-8?B?RWJtR2RQVDVkcDJsUjBaeEtXY0JMUkdZYURGcEh4RXRNV1Z0VXcwYTJiQWJD?=
 =?utf-8?B?TWtCU0YvS1EzTVBoMDhKdWdqUzJYNk1HdTdjajNTaHlzR2RWdmVzeHRFYUox?=
 =?utf-8?B?SDIyRk9aT1RMLzVFR1RoNjdOTmkyTWJIalBXNis1NjNTdnljVXJCbDhDVlNG?=
 =?utf-8?B?cVRDZGJ0QlBNeHJ6blpDSVdjYjFOd0tUT3pvMzFBYTg3M0lXSm1ZcFlmR1RR?=
 =?utf-8?B?RWdBUTdoOHJHNXlVRk5VTXBLTUp0dVQrcSszT1pCdUl6TDBvVm5NTUJnSC9v?=
 =?utf-8?B?ZVJnaDNLbGFSUnJUNldtUFpmU2tkREFBWkFQa1BoTE85eFdWMTMzV255ZGpq?=
 =?utf-8?B?d3FBcGY3WmtrclBJT3B4Mi9CWWhGNlh4c0p3VG5zOXhxdmlwTFNHTE51cXF4?=
 =?utf-8?B?WUN0ai96ZytVUFhRWEVsanJRS05xSTFtaGxBV1BOeDk2Kzc3U0lyUWRpRXhL?=
 =?utf-8?B?ZUtIVktqb2FHb25xSGdna2IrOFdTdGNFQmw3N1JTQjJpY0ZJR3JTNkk4bUI5?=
 =?utf-8?B?ZE51cEx4dCtuRkNpZVdCQ2tDeU1sNEZFMjl2K3lwdnJYTEgzVVhGcHl1azZj?=
 =?utf-8?B?UEpVQmtiQXhNUzFUY1lwMkpwekxpU2Z4YXRFeGd5T3Ywc3NZek4xOUdFaVg4?=
 =?utf-8?B?VUlHYytxZ1dBbGxFOEZtR3cyaXNNNVdrUjc3Q3d2djAxR3ZoalZKRlU1VDlO?=
 =?utf-8?B?N1FaVHVZQ0IyT0RISzB1cTVyWUdvS01TVERHZDBUeUM5SnlCazE5dW8xUlQ3?=
 =?utf-8?B?NUJIeXRxN2plNEFmRjY3MGJIN1RscWFvTVFzNTV6VHpjTU1Ic0xzZWNGMjk3?=
 =?utf-8?B?Wk04Z2M3TU5uY25oSzRac0dSUThvSkNWbUpKMFVzSTlWZm5aRFhRcDQ5TTdN?=
 =?utf-8?B?alpIWm95czRGWkVMZW1EL1pZUVZaV3V6SFZmb3l0YmJieTNpa0plVVM3dm4v?=
 =?utf-8?B?TUlPNTlDK1B4aEIvR0ZIUnU2S2lCMkhiaEFyekJxZkRJa08zemU0RlhLUmJE?=
 =?utf-8?B?UXlPTjA1RVNwYlk0V1U5VFE2bmVwZ3dCMUVCNWdTK2Y4b0VQbi9kTVoxUDNj?=
 =?utf-8?Q?e47APVtEDfNekBvIjuZ1p1UHHjEtUq6z58X1/Dm?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: globalfinishing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR16MB1655.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3eaa13d-2f8a-4a86-703b-08d93a831210
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 22:21:26.7000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 41026ff0-b4fb-4e53-ada8-a2e2e3e9ec4d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n8e5IvtMnJxvkUdYjnGmfkfJEB/zHtKtHFYMOpEO6zYmGhu/j69tTnQ8g65vCnlM3gJU4scSxuCznRlIX8xerF3vC3bjmsmNnkdELj74oHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR16MB1718
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA104A295 smtp.mailfrom=jhatton@globalfinishing.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: globalfinishing.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SSBiZWxpZXZlIEkgZm91bmQgYSBkb2N1bWVudGF0aW9uIHR5cG8uDQoNCkRvY3VtZW50YXRpb24v
cmV2LWxpc3Qtb3B0aW9ucy50eHQNCg0KODk4OiBUaGUgZm9ybSAnLS1maWx0ZXI9c3BhcnNlOm9p
ZD08YmxvYi1pc2g+JyB1c2VzIGEgc3BhcnNlLWNoZWNrb3V0DQo4OTk6IHNwZWNpZmljYXRpb24g
Y29udGFpbmVkIGluIHRoZSBibG9iIChvciBibG9iLWV4cHJlc3Npb24pICc8YmxvYi1pc2g+Jw0K
OTAwOiB0byBvbWl0IGJsb2JzIHRoYXQgd291bGQgKipub3QgYmUgbm90KiogcmVxdWlyZWQgZm9y
IGEgc3BhcnNlIGNoZWNrb3V0IG9uDQo5MDE6IHRoZSByZXF1ZXN0ZWQgcmVmcy4NCg0KSSBlbXBo
YXNpemVkIHRoZSAibm90IGJlIG5vdCIgb24gbGluZSA5MDAuIEkgaG9wZSB0aGlzIGlzIHRoZSBj
b3JyZWN0IHBsYWNlDQp0byByZXBvcnQgdGhpcy4NCg0KVGhhbmtzDQotLS0NCkphc29uIEhhdHRv
bg0KDQo=

