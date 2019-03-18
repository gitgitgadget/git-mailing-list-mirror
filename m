Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D95420248
	for <e@80x24.org>; Mon, 18 Mar 2019 18:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfCRSCb (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 14:02:31 -0400
Received: from mail-eopbgr790128.outbound.protection.outlook.com ([40.107.79.128]:10301
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726677AbfCRSCb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 14:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUmYKpYj0hxkOLofYlH7/7h3lqD0V/W1Lmwsba7V6sw=;
 b=JT6ZD2CzPTbRXisU30U6JEvPgXbob5AmGWm174odu7mccEh+YegkkFt4j+NYCEX5339do8usYoIh/SsASzrrq5A7O8Ykj7g81tfyYegNLmdNDWCFLSo/RHNGu/87Z3rnr//efg42t+9VqEKSXTojl7I4big3/dXjP6tZZbovLNA=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB5339.namprd08.prod.outlook.com (20.176.112.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 18:02:16 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244%3]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 18:02:16 +0000
From:   "Mazo, Andrey" <amazo@checkvideo.com>
To:     "massimo.burcheri@gmx.de" <massimo.burcheri@gmx.de>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "luke@diamand.org" <luke@diamand.org>,
        "Mazo, Andrey" <amazo@checkvideo.com>
Subject: Re: git p4 sync not reflecting mail address changes
Thread-Topic: git p4 sync not reflecting mail address changes
Thread-Index: AQHU3YQNbusqFnwbRU+wYmYOTtHChKYRrl6A
Date:   Mon, 18 Mar 2019 18:02:16 +0000
Message-ID: <20190318180207.11604-1-amazo@checkvideo.com>
References: <273b5fcdf5a59409f1533c2f8a4d71ed99750eef.camel@gmx.de>
In-Reply-To: <273b5fcdf5a59409f1533c2f8a4d71ed99750eef.camel@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:405:39::23) To DM6PR08MB4956.namprd08.prod.outlook.com
 (2603:10b6:5:4b::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.2
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae397cb7-a210-46de-cd6c-08d6abcbdb17
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB5339;
x-ms-traffictypediagnostic: DM6PR08MB5339:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR08MB5339C10AC3EEDC6DE3EE39FADA470@DM6PR08MB5339.namprd08.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(346002)(396003)(39860400002)(189003)(199004)(81166006)(6916009)(256004)(14444005)(5660300002)(54906003)(86362001)(7736002)(305945005)(107886003)(1076003)(2501003)(4326008)(66066001)(229853002)(6246003)(97736004)(99286004)(8676002)(36756003)(3846002)(6116002)(316002)(81156014)(6512007)(4744005)(11346002)(71190400001)(76176011)(106356001)(6306002)(71200400001)(2906002)(8936002)(446003)(68736007)(966005)(6486002)(52116002)(6436002)(50226002)(14454004)(25786009)(478600001)(2616005)(186003)(26005)(476003)(105586002)(53936002)(486006)(2351001)(5640700003)(386003)(6506007)(102836004)(134885004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB5339;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IhlCIGp8UEPFztpaL5c7QVDVgzX4jOdwDKL7Maxnm/69Ag8C43zHR9m5n030hx1B9RfkXpb+jRu6ZeDt0AfnsKnmi5ert+JoksUNCSNUywcJ24v/ILjFk/3wx+j1I2uNk13z3Ho+X8AcPgPKdV5c3TTKyfhZ84wq6eR/+Hb3zfvze8n8Q8+htezEV00KNJZFUkReeIURzGABjl3Syqrx/+FRXDRJNwBPv8wPlS+iRoA8rnC5oI1DI/hRqiAWNTXjBSH0iGta5tVpPJtI6mBQnCd9Wm6a/DIY67PJDqfch6zGSVfenRDSeKR+pBSrPiEYUHuKpTCmG+76OXObmZpVR6cUCaulhOksZHrrRtNZaQiAbUKA4lURcGaTxPXDmx/GDH4BTVKX4uvavp2M/jkGXWy2yodAvzyRj0cnSniPOao=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae397cb7-a210-46de-cd6c-08d6abcbdb17
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 18:02:16.5857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB5339
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>=20
> Hello,
>=20
> we are periodically doing a 'git p4 sync' on a p4 clone that was initiall=
y
> created by 'git p4 clone --bare //DEPOT'. Now on P4 side the mail address=
es have
> changed, but git still uses the old addresses.
> p4 users already shows the new addresses but new changes in the git log a=
re
> showing the old addresses.
>=20
> There is
> https://git-scm.com/docs/git-p4#Documentation/git-p4.txt-git-p4mapUser
> to remap users but afaik there is no mapping at all right now.
>=20
> I tried
>=20
>    mapUser =3D SomeUser =3D Some User <some.user@local>
>=20
> but also with this configuration new changes synced are showed as
> some.user@oldlocal.
>=20
> We are not submitting back to P4, this is just a readonly git p4 clone.
I've just run into the same problem today.
You need to delete (or rename) "$HOME/.gitp4-usercache.txt"
(on Windows, it's under %USERPROFILE% as far as I can tell)
and repeat clone/sync.

Hope, this helps.

--
Andrey
