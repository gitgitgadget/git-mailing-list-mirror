Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FA351F453
	for <e@80x24.org>; Tue,  2 Oct 2018 10:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeJBRLV (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 13:11:21 -0400
Received: from mail-oln040092070020.outbound.protection.outlook.com ([40.92.70.20]:27220
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726925AbeJBRLU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 13:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Pzqf06bclaofhtjJVBUtVptEZzLwvyoe/F6eyDIn1E=;
 b=LApqCc1Jvnrm4kv5mpYSj5CdiC2264YUIE3OW1skv6Y/z5vkOSZbl0hBOA/DTrfUAFzOT10zbrrI9xOv3E2aa3ulzbwGW1MAUV89oHTdFY6j89KDRcO1GiGKRyZ8kRJLhfZiu0s/nkaddW5VYBG0Kpqk4nqFEMt3fOXflH9iUP2a+MkZBj7DVDe9/JUbMO6DgirSkv88cooSnNKJr0HrrwXRgVKyvEkiG26yGYCzAM6n/2aUV6B0nR1S1oNgbskCv9F9s3DOl27yLy2p6trwPUYZ9zCH1f2IyQKeN+PdEJbgk/cge/g+rVoLXk96oFj4VFSYqZY7g8O0/aIj4Q+MmA==
Received: from VE1EUR03FT064.eop-EUR03.prod.protection.outlook.com
 (10.152.18.59) by VE1EUR03HT176.eop-EUR03.prod.protection.outlook.com
 (10.152.19.96) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.1185.13; Tue, 2
 Oct 2018 10:28:38 +0000
Received: from VI1PR0902MB2223.eurprd09.prod.outlook.com (10.152.18.60) by
 VE1EUR03FT064.mail.protection.outlook.com (10.152.19.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.20.1185.13 via Frontend Transport; Tue, 2 Oct 2018 10:28:39 +0000
Received: from VI1PR0902MB2223.eurprd09.prod.outlook.com
 ([fe80::1b9:1b61:c38c:8bd9]) by VI1PR0902MB2223.eurprd09.prod.outlook.com
 ([fe80::1b9:1b61:c38c:8bd9%3]) with mapi id 15.20.1185.024; Tue, 2 Oct 2018
 10:28:39 +0000
From:   Jose Gisbert <jose.gisbert@live.com>
To:     Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Using git svn rebase at quarantine environment or a feasible
 alternative to synchronize git and svn repositories
Thread-Topic: Using git svn rebase at quarantine environment or a feasible
 alternative to synchronize git and svn repositories
Thread-Index: AQHUWV6KIMpBHSj6s0iSXwsGXjkPyaUKelwAgAFHov4=
Date:   Tue, 2 Oct 2018 10:28:38 +0000
Message-ID: <VI1PR0902MB2223AB8C9A721478E82449FEE2E80@VI1PR0902MB2223.eurprd09.prod.outlook.com>
References: <VI1PR0902MB2223EA3FC0ACE7E9AFB7A6ACE2EF0@VI1PR0902MB2223.eurprd09.prod.outlook.com>,<20181001145344.GA26349@sigill.intra.peff.net>
In-Reply-To: <20181001145344.GA26349@sigill.intra.peff.net>
Accept-Language: es-ES, en-US
Content-Language: es-ES
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:A80C778813D3A8664972D04C7169CB0ADEF46408EA7A1C4EB7B4BD78DD0EF1F1;UpperCasedChecksum:FF10A6B34945FAFDC45FC930F1896DEF3C66031CB9549AE692B2A10C327EE7A1;SizeAsReceived:7293;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [xVhANKtU2YY1Z3fRJkbOlo8mbSNAE2mP]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VE1EUR03HT176;6:py3ngbyLQc0+bC6bk0KLj23pqdZzLZ38DOgZ4TrVwdTexibATH/wh2D53zWueGZqcq6ijD28DGKAVzEGJPg+EWaUXXr+oXXKO+IEDDu0cDUmlK6B03AIcMemnrNb2aYW7+FDbKqWHY17XznvjKvzvtAr9Ievh3/2qe4EKg6tDQ3yWlcZeus5czIyWImgfgvVKWiDKPHLJYMGSG8YNytrpnHY8K4XYK2XziTAvAaM01vxcZPzPRprFCecTTP5iv7GlRtqZhkKt5hm6/SOoGHXjx0xvjy0Mnke0vBvn3i9rvWDtRmuKSMX9AKNrah1AcYQHgCOXz0syZA3NrPUwxYlr4G4tdg2l9LMkNebG3bXsIPZ0LVnXUoPLzwb8UESKQhOUcmdGZqBsnsTk3U2f9KFkTVPQvLtd1yig8cs4ZbSsA4FUdKUZLRgEz6t3qE+YEolc40pOgaXMJKZZd2TfqNIEQ==;5:03UHcnKlp7t4X+ywrqp/MAYDjI4aPpqH8GdI9Vfv4hZA2Naee0Pn2CmeafIQp2gWN/skWlLiU66p+Zx1nysuYWrj7/lov/t2h0BtIwz+h/DbXEudwBueXnlMlLqUKmWizlxXWtNfnhVp3DekHzEAMmJpzBjxt01bdRF7ZhYWplo=;7:h893C4B9j5O/WjSlWLlBlikVsqhA268z8HuNQgoSUvdxHkmj+rP395rCqII4tstInov1ajZD2jNupQfxPoIS4DbTvEDTL4cTr42oXBI+m1ilWTy1aaMdWCPByclfN4VdfjmfMXGb1c663FeTfjGft88jWQk9wdVPODn6aPURLWwTJErYuYrMXnZv1tZJM9CU/oM+IkWSV/0u8Wf8AS1b9ptCf5kDohgQFI+aMJgCTZUw1JXkirkE9v9Hn1AtcsTN
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:VE1EUR03HT176;
x-ms-traffictypediagnostic: VE1EUR03HT176:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:VE1EUR03HT176;BCL:0;PCL:0;RULEID:;SRVR:VE1EUR03HT176;
x-forefront-prvs: 0813C68E65
x-forefront-antispam-report: SFV:NSPM;SFS:(7070007)(189003)(199004)(14454004)(5660300001)(33656002)(74316002)(8936002)(305945005)(11346002)(102836004)(229853002)(6346003)(6506007)(446003)(6436002)(104016004)(345774005)(26005)(55016002)(2900100001)(476003)(97736004)(106356001)(105586002)(71190400001)(5250100002)(8676002)(81156014)(99286004)(25786009)(71200400001)(9686003)(256004)(56003)(14444005)(76176011)(7696005)(86362001)(4326008)(68736007)(6916009)(82202002)(6246003)(486006)(44832011);DIR:OUT;SFP:1901;SCL:1;SRVR:VE1EUR03HT176;H:VI1PR0902MB2223.eurprd09.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: live.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jose.gisbert@live.com; 
x-microsoft-antispam-message-info: fCW1y36JW7C1EH6BDZbTf8wLNWhwsgBZQEQ0rKhhNFfcnV74O+Jpuca0wBbvCO6u+5UbG6524EXyfPGSRcO/wX3feX71WWSknA/hr3okt4okFybPNhZwDNxSlb+Lbyx4WOB6F/3tc/Kt4xhxCH4hkEntPqn77sa/DiRmVtOWadc+p9REWw+SLvfks5Ji+xIyjQf1uIeRCSm+pVdU/p4ukDVGu2c5Pl8GbacsIS19S5I=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 24fd1209-d934-423e-a578-ee886993c07f
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e079241-6e60-4065-a1e6-08d62851d170
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 24fd1209-d934-423e-a578-ee886993c07f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2018 10:28:38.9894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR03HT176
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> As you noticed, this used to be allowed. But it's dangerous, because if=
=0A=
> the movement of the objects out of quarantine fails, then you're left=0A=
> with a corrupted ref (ditto, anybody looking at the ref after update but=
=0A=
> before quarantine ends will see what appears to be a corrupted=0A=
> repository).=0A=
> =0A=
> There are two solutions I can think of:=0A=
> =0A=
>   1. The unsafe thing is to just unset $GIT_QUARANTINE_PATH before=0A=
>      running "git svn rebase". That will skip the safety check=0A=
>      completely, enabling the pre-v2.13 behavior. I don't really=0A=
>      recommend this, but modulo the race and unlikely file-moving=0A=
>      errors, it would probably generally work.=0A=
> =0A=
>   2. Store intermediate results from pre-receive not as actual refs, and=
=0A=
>      then install the refs as part of the post-receive. I don't think=0A=
>      there's out of the box support for this, since "git svn rebase" is=
=0A=
>      always going to call "git rebase", which is going to try to write=0A=
>      refs.=0A=
> =0A=
>      The smoothest thing would be for the refs code to see that=0A=
>      $GIT_QUARANTINE_PATH is set, write a journal of ref updates into a=
=0A=
>      file in that path, and then have the quarantine code try to apply=0A=
>      those ref updates immediately after moving the objects out of=0A=
>      quarantine (with the usual lease-locking mechanism).=0A=
> =0A=
>      That's likely to be pretty tricky to implement, so I'm not even=0A=
>      going to try to sketch out a patch in this email.=0A=
> =0A=
>      You might be able to do something similar by hand by using a=0A=
>      temporary sub-repository. E.g., "clone -s" to a temp repo, do the=0A=
>      rebase there, and then in the post-receive fetch the refs back.=0A=
>      That's less efficient, but the boundaries of the operation are very=
=0A=
>      easy to understand.=0A=
=0A=
I read about the dangers of updating refs at the pre-receive hook at=0A=
git-receive-pack man pages and, of course, it's something to take into=0A=
account. But, given that this setup will be temporary and the technical=0A=
complexity of the other solutions you propose (solution #2 seems unfeasible=
=0A=
and I don't know where to find and how to modify refs code or quarantine co=
de)=0A=
I'm more predisposed to try solution #1 by now.=0A=
=0A=
Moreover, assuming that solution #1 will generally work and the facts that:=
=0A=
=0A=
- I think it would be possible to us to recover from a corrupted repository=
=0A=
  somehow easily. Couldn't we, for instance, reset from a failed push and t=
ry=0A=
  it again?=0A=
- the chances of corrupting the svn repository, our reference here, seem sm=
all=0A=
  because git svn dcommit is the last operation in the chain and is only=0A=
  performed when everything else went ok=0A=
- we are a small team and git is not our main CVS, so we can stop pushing t=
o=0A=
  git while we fix the repository=0A=
=0A=
I'm more inclined to apply this solution. Maybe I'm being too much optimist=
ic=0A=
with my assumptions.=0A=
=0A=
Nevertheless I will investigate the "clone -s" alternative. It seems easy t=
o=0A=
implement and performance is currently not a limitation for us.=0A=
=0A=
> This is definitely the right place. Sorry I don't have a better answer!=
=0A=
=0A=
Thank you for your elaborated response Jeff. It has been a pleasure to writ=
e=0A=
to the git community email group.=0A=
=0A=
Regards,=0A=
=0A=
Jose=
