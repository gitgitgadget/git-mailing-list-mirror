Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70D0E1F462
	for <e@80x24.org>; Fri, 14 Jun 2019 16:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfFNQsC (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 12:48:02 -0400
Received: from mail-eopbgr790120.outbound.protection.outlook.com ([40.107.79.120]:12128
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbfFNQsC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 12:48:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=nxUVba0vtdIgJKS7Jf4O37ldpMMcXiXWh6gBcdOvB7gqJWdOGTqex1SpTSAlNCeGZQnM1k+uj8nLJVnWZXqNa+Ne5LaL20SOMCVc1GtLPmQu7MqQBSBD2j6mP1pAsVhjLDh+/xju1IirVOClzzV/fm9GCKIycQ30Qn6QLQRvpYk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TmcdrpjTD6M0QMCMA9x6tHfwzJ9KgoILBgNbknjStg=;
 b=ErtJHYnUrz66YnxEa0BzmKRKPhw2IiSoeHUmGbCFTO5riW4QUUOLrjtF4yq+wmE3ARd8sDd3s2n0rLHdtqJX3z+t5ekUSjyJ710OHSoRkSzxqPAuN8YI9rkP2VDn67G9Fpa/BnJE4BYWQIB6EF4RujXPnqO+PjU8IcpgvHgtdYo=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TmcdrpjTD6M0QMCMA9x6tHfwzJ9KgoILBgNbknjStg=;
 b=BDP0JkprwwtW6QS4Cl8TBPMogL36MyvA1MMSWU5Yy8ULv4E6pCbFLtQ2mzxOu9IWKkZyiIqPo6D0cz1VCKJ9BkU8YD90aAkPbL/GYzJWJFp06/zub2X0H4wmJAwfn7PhGmBVu01C6+6ULNKL2w+xkVdV2kMFU4wUtxaF7cKXHlk=
Received: from MN2PR21MB1231.namprd21.prod.outlook.com (2603:10b6:208:3b::12)
 by MN2PR21MB1215.namprd21.prod.outlook.com (2603:10b6:208:3a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.1; Fri, 14 Jun
 2019 16:47:59 +0000
Received: from MN2PR21MB1231.namprd21.prod.outlook.com
 ([fe80::f95d:893d:7d13:2d1f]) by MN2PR21MB1231.namprd21.prod.outlook.com
 ([fe80::f95d:893d:7d13:2d1f%6]) with mapi id 15.20.2008.006; Fri, 14 Jun 2019
 16:47:59 +0000
From:   "Aram Maliachi (WIPRO LIMITED)" <v-armal@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Kranz, Peter" <kranz.peter.ext@siemens-healthineers.com>,
        "Brettschneider, Marco" 
        <marco.brettschneider.ext@siemens-healthineers.com>
Subject: commit sized around 100 gb in changes failed to push to a TFS remote
 - Git
Thread-Topic: commit sized around 100 gb in changes failed to push to a TFS
 remote - Git
Thread-Index: AdUiEtMNbTQxx+KVQ/WGqOvteNH83wABokmQABhdzuAAFJi2YAAAyg1w
Date:   Fri, 14 Jun 2019 16:47:59 +0000
Message-ID: <MN2PR21MB1231DB1D2FCE7622F0AED616E9EE0@MN2PR21MB1231.namprd21.prod.outlook.com>
References: <MN2PR21MB1231B057E9E662BB151B2819E9EF0@MN2PR21MB1231.namprd21.prod.outlook.com>
 <DE8A44FD55B8BE44AC9861D8ECF567F801FEEC1D@DEFTHW99EM2MSX.ww902.siemens.net> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=v-armal@microsoft.com; 
x-originating-ip: [12.41.100.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d9da85d-deca-44c3-cc01-08d6f0e80f11
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR21MB1215;
x-ms-traffictypediagnostic: MN2PR21MB1215:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <MN2PR21MB12153607767576241C22CDB2E9EE0@MN2PR21MB1215.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(376002)(346002)(39860400002)(199004)(189003)(446003)(6916009)(71200400001)(71190400001)(74316002)(66066001)(73956011)(6436002)(53936002)(6306002)(99286004)(2351001)(66446008)(66556008)(2501003)(66476007)(55016002)(64756008)(476003)(9686003)(316002)(22452003)(54906003)(25786009)(186003)(8990500004)(66946007)(5640700003)(76116006)(10090500001)(52536014)(4326008)(5660300002)(7736002)(486006)(10290500003)(305945005)(3846002)(2906002)(26005)(966005)(6116002)(6506007)(33656002)(102836004)(14454004)(52396003)(14444005)(256004)(76176011)(7696005)(8936002)(86362001)(81156014)(8676002)(478600001)(68736007)(81166006)(1730700003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR21MB1215;H:MN2PR21MB1231.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zl96b10jMFXc6NFceKE1Nf0X+mnEEaBO3NM5zFBBpQu4pi/Ph8FbiW/76rcRBoiK9OZpX+A3Ewq4V103xyFNOSYP26Uuj82NB+Fd3xY+kIz/CiyZIWuusEKVr0R3Ktk8sI9pLld5kSmHwv43ssFyH4rUnmmcVdHEAb/Sm2KGTaJ+ej+VVeI+0tGXRKLEMBofXcfRV+k7d4nHyuNcpcWxqNKrUrcOS6u6R2n0v373+Ws9pgDhAGP+x/1eSuhZ0fmy+tKD51177A5t2KJk+Gpov4BwA8ED+22ihXcSR1UJzemtUi+Pl3sXypkR6ayt5UhiWtJAbSlFWPGMlMYt0w9TSd6ORFLnkWawp151wahhSRy6IOrGc9orTeiT8X07BrFK17hzoJYY78/7o32AIizcGcBHNbjuL3d6JkA1LCyLnyM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9da85d-deca-44c3-cc01-08d6f0e80f11
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 16:47:59.3208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v-armal@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1215
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To @Git Community
From the perspective of an Azure DevOps support engineer. I have a customer=
 who is unable to make a push with following error:

fatal: The remote end hung up unexpectedly
failed to push some refs into https://zelos.healthcare.siemens.com/tfs/Hoov=
er/VA20A.DevInt.Gvfs/_git/Saturn

The local repository has only one change when comparing it to the remote an=
d it is a commit labelled with SHA value: 504aedfdbb to a branch called git=
Test
This being said the scheme is as following:

[Remote] - master
b946c27c

[Local] - gitTest branch
504aedfdbb
b946c27c


Important data:
- The commit 504aedfdbb contains +100 GB in file changes=20
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
ation back to default according to the MSFT docs https://docs.microsoft.com=
/en-us/azure/devops/repos/git/rpc-failures-http-postbuffer?view=3Dazure-dev=
ops
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
