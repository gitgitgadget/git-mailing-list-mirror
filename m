Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B46A1F462
	for <e@80x24.org>; Fri, 14 Jun 2019 18:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfFNSku (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 14:40:50 -0400
Received: from mail-eopbgr720118.outbound.protection.outlook.com ([40.107.72.118]:11040
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbfFNSkt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 14:40:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=j+z+p5v2FVMVcL5+FJR8BiF5Khe/kS1hvK87v5lhzVnXdDdIqZ/h9nmZt0Xm1DHj+S6lJr1y72H8xvjrXOBxFX58j0Q1lYzud+ExsCC0tgIFOCOQNAHBg1lKPTpHXh9DlJxA8kMOzWVSQ8VDw8idXDHNlgDlJ09O5i0JNzNRt4c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ixl4+3R143yuzRtXM/vjOiLQ34tpL9cNQbUbMeiWAuw=;
 b=n/c9ga915opjIhdwJVvlKVgqMVLRtW3+/hRphl29SLvvbOrlFOKxPMMwBiHmXieOh2EufrYeXAZGEyCsFXVjsxsiSa9aetqMH11pUjqtXliwZMNbCQJTaRmvZkq+3yNqtstjCp9fT0fUcEcOP5mkQhASrKe6M8O8YHmV8TsC0gE=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ixl4+3R143yuzRtXM/vjOiLQ34tpL9cNQbUbMeiWAuw=;
 b=MTl8yNIN7LwKH/Gps7z+bKY1OasvTeRN+1GJBuCERcAX2GlazA/R8xLOLetr5qmhKt8iFKzLavBxP6OQrwyik5aEVrnqXNlOZOlVK7qPG/C7jEwPXK+JwiGukTn4gYOeo0QBFTBE/latjsbHw/bahrPQO2HhjdErGDLIXNBzJyM=
Received: from MN2PR21MB1231.namprd21.prod.outlook.com (2603:10b6:208:3b::12)
 by MN2PR21MB1168.namprd21.prod.outlook.com (2603:10b6:208:ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.0; Fri, 14 Jun
 2019 18:40:45 +0000
Received: from MN2PR21MB1231.namprd21.prod.outlook.com
 ([fe80::f95d:893d:7d13:2d1f]) by MN2PR21MB1231.namprd21.prod.outlook.com
 ([fe80::f95d:893d:7d13:2d1f%6]) with mapi id 15.20.2008.006; Fri, 14 Jun 2019
 18:40:45 +0000
From:   "Aram Maliachi (WIPRO LIMITED)" <v-armal@microsoft.com>
To:     "Aram Maliachi (WIPRO LIMITED)" <v-armal@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Kranz, Peter" <kranz.peter.ext@siemens-healthineers.com>,
        "Brettschneider, Marco" 
        <marco.brettschneider.ext@siemens-healthineers.com>
Subject: RE: commit sized around 100 gb in changes failed to push to a TFS
 remote - Git
Thread-Topic: commit sized around 100 gb in changes failed to push to a TFS
 remote - Git
Thread-Index: AdUiEtMNbTQxx+KVQ/WGqOvteNH83wABokmQABhdzuAAFJi2YAAAyg1wAAQZ3VA=
Date:   Fri, 14 Jun 2019 18:40:45 +0000
Message-ID: <MN2PR21MB1231AACB729D9D7E2B09E150E9EE0@MN2PR21MB1231.namprd21.prod.outlook.com>
References: <MN2PR21MB1231B057E9E662BB151B2819E9EF0@MN2PR21MB1231.namprd21.prod.outlook.com>
 <DE8A44FD55B8BE44AC9861D8ECF567F801FEEC1D@DEFTHW99EM2MSX.ww902.siemens.net>
  <MN2PR21MB1231DB1D2FCE7622F0AED616E9EE0@MN2PR21MB1231.namprd21.prod.outlook.com>
In-Reply-To: <MN2PR21MB1231DB1D2FCE7622F0AED616E9EE0@MN2PR21MB1231.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=v-armal@microsoft.com; 
x-originating-ip: [12.41.100.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19f10545-0b47-4ea3-fc2d-08d6f0f7d02e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR21MB1168;
x-ms-traffictypediagnostic: MN2PR21MB1168:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <MN2PR21MB1168EF8ACCF42174EFDCDC80E9EE0@MN2PR21MB1168.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(39860400002)(376002)(136003)(13464003)(199004)(189003)(71190400001)(229853002)(52536014)(10090500001)(2501003)(9686003)(14444005)(256004)(5660300002)(6436002)(99286004)(68736007)(76176011)(71200400001)(86362001)(53936002)(52396003)(7696005)(6246003)(6306002)(54906003)(110136005)(73956011)(11346002)(446003)(25786009)(478600001)(4326008)(10290500003)(33656002)(22452003)(316002)(8990500004)(2906002)(476003)(76116006)(66066001)(3846002)(74316002)(26005)(102836004)(8936002)(6116002)(186003)(6506007)(53546011)(486006)(2940100002)(1511001)(55016002)(305945005)(8676002)(966005)(66446008)(81166006)(14454004)(7736002)(66556008)(64756008)(66946007)(81156014)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR21MB1168;H:MN2PR21MB1231.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iYXQvYHA1isdFLiRgUxOqHw+n6m5rFVcx5L5+nlmJFzye40FbrOI0xMILv5dTkcJS8F8pgGUFgA59Gkan9nkrVgCiY4s5w1jGevhfN/jJ5WHyVJUEUuEYS5/VxuXVAwHGehcKaZFkIdN3fMbiWmP5gtsGnDXL9CTKJTlXyNCjTlxJekNjbUiWH6BjRySqT/qAgg+h96amk3eg8ou2GN/Ls5mqemEW/R1zID4NksyEQjF+ZapoKbTuMS8rurESi4KAtxoHz2wY1lPxt5LEFAJsetMXXMFTEBo3hblQDlmbJemrfqpVanHmTVtxD5rQ9UgEmmE+4FyUYRKE5B/J9AUEW0D0iKFRVpeQ0+ylhMgJwY1FHks9LqXGlseYQUfVfF2Y9Hngrm2WiCDD12zxKB/7G7qE1dTFVLYO08/Nb4ImTE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f10545-0b47-4ea3-fc2d-08d6f0f7d02e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 18:40:45.8503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v-armal@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1168
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a hard limit in the service of 5GB for a single push.

The advice we've given other customers is to do partial pushes by checking =
out an older commit, pushing that, and then checking out a newer commit, pu=
shing, etc.  You have to push multiple times, but you can build up the enti=
re history that way.

This is due to a limit set by the TFS product.

-----Original Message-----
From: git-owner@vger.kernel.org <git-owner@vger.kernel.org> On Behalf Of Ar=
am Maliachi (WIPRO LIMITED)
Sent: Friday, June 14, 2019 11:48 AM
To: git@vger.kernel.org
Cc: Kranz, Peter <kranz.peter.ext@siemens-healthineers.com>; Brettschneider=
, Marco <marco.brettschneider.ext@siemens-healthineers.com>
Subject: commit sized around 100 gb in changes failed to push to a TFS remo=
te - Git

To @Git Community
From the perspective of an Azure DevOps support engineer. I have a customer=
 who is unable to make a push with following error:

fatal: The remote end hung up unexpectedly failed to push some refs into ht=
tps://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fzelos.hea=
lthcare.siemens.com%2Ftfs%2FHoover%2FVA20A.DevInt.Gvfs%2F_git%2FSaturn&amp;=
data=3D02%7C01%7Cv-armal%40microsoft.com%7C00a886aa8e6e4eb7b38308d6f0e81171=
%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636961276860256000&amp;sdata=
=3DHF36q%2FZff3882jBBNdyXQdQMUcFrsJ1jHtWJyfbTu0s%3D&amp;reserved=3D0

The local repository has only one change when comparing it to the remote an=
d it is a commit labelled with SHA value: 504aedfdbb to a branch called git=
Test This being said the scheme is as following:

[Remote] - master
b946c27c

[Local] - gitTest branch
504aedfdbb
b946c27c


Important data:
- The commit 504aedfdbb contains +100 GB in file changes
- The remote git repository is a TFS server
- Customer isn't building code - it is using the remote kind of as a storag=
e service <- We understand these are not best practices but is the way cust=
omer is using Git and TFS. If @Git Community could confirm/elaborate on thi=
s customer may change up the current approach he is using.

Things tried:
- reset the history for the local repository back to the latest shared comm=
it b946c27c =A0and committed something small which succeeded to push into r=
emote into a brand new branch by running $ git push origin <name of local b=
ranch>
- cherry-picked the commit into local master and attempted to push =3D fail=
ed. <- this makes me think this is entirely caused by the oversized commit
- boosted up the http post buffer configuration =3D failed. Rolled configur=
ation back to default according to the MSFT docs https://nam06.safelinks.pr=
otection.outlook.com/?url=3Dhttps%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fazur=
e%2Fdevops%2Frepos%2Fgit%2Frpc-failures-http-postbuffer%3Fview%3Dazure-devo=
ps&amp;data=3D02%7C01%7Cv-armal%40microsoft.com%7C00a886aa8e6e4eb7b38308d6f=
0e81171%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636961276860256000&amp=
;sdata=3DjnxDSnfGiRpHbs%2F1n0yRt3V%2FE3UogElyRhhyoxFc%2FTM%3D&amp;reserved=
=3D0
- since this is a TFS server I initially though this could be caused by ins=
ufficient disk storage capacity in the server containing the TFS product. B=
ut @Vimal Thiagaraj has confirmed that the repositories size limit depend u=
pon the remote TFS databases and not the server itself. Is there a limit on=
 these databases or on how much changes can a git commit contain?

Things I've suggested to customer:
- commit more frequently in smaller batches
- understand that the nature of git is to collaborate and track versions of=
 files over time - not a cloud storage provider

Would appreciate any insight on this @Git Community. Thanks to @Phillip Oak=
ley who took the time to answer last time I posted a question to this maili=
ng list.
