Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DBFC1F453
	for <e@80x24.org>; Tue,  2 Oct 2018 10:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbeJBRMP (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 13:12:15 -0400
Received: from mail-oln040092068065.outbound.protection.outlook.com ([40.92.68.65]:37472
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726935AbeJBRMO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 13:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FRPS/4WX//IgzNGG3581U4jumDGllaTep8t+w5CvMs=;
 b=YypvZTgGYR8v7FOqfeedNs1T7ZHA9bNZGpaCNYo5d7b3HpONI+0Y6kmqaN1Xn0ANilHjdP+c4lYzZpmDue/yNfNN1pL2twPe/cXuwFvD5xS4Hqc0aZW3XJaPlzWWCaOwmOjEo1vCgXMPNl0P+GAYUchEBWWk9GP1gWnYhYO1h1/s9WFOFV9BkDI/4sxnMmX9Lujv7Y4RfktrggemiLL9BES8QophBrMQfkczhMP5laHRr4DSpHUbbzhk2jdZWN7KxZHEpenJ/oQSWKse6FQXNf1K6AyMbrtK/2W7lAK03saLzo3iJcVOwHlfvYR4xTub/oUq5n5kE77SOf/wYleuiQ==
Received: from VE1EUR02FT033.eop-EUR02.prod.protection.outlook.com
 (10.152.12.55) by VE1EUR02HT122.eop-EUR02.prod.protection.outlook.com
 (10.152.13.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.20.1185.13; Tue, 2
 Oct 2018 10:29:35 +0000
Received: from VI1PR0902MB2223.eurprd09.prod.outlook.com (10.152.12.53) by
 VE1EUR02FT033.mail.protection.outlook.com (10.152.12.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1185.13 via Frontend Transport; Tue, 2 Oct 2018 10:29:35 +0000
Received: from VI1PR0902MB2223.eurprd09.prod.outlook.com
 ([fe80::1b9:1b61:c38c:8bd9]) by VI1PR0902MB2223.eurprd09.prod.outlook.com
 ([fe80::1b9:1b61:c38c:8bd9%3]) with mapi id 15.20.1185.024; Tue, 2 Oct 2018
 10:29:35 +0000
From:   Jose Gisbert <jose.gisbert@live.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
CC:     Git Mailing List <git@vger.kernel.org>
Subject: RE: Using git svn rebase at quarantine environment or a feasible
 alternative to synchronize git and svn repositories
Thread-Topic: Using git svn rebase at quarantine environment or a feasible
 alternative to synchronize git and svn repositories
Thread-Index: AQHUWV6KIMpBHSj6s0iSXwsGXjkPyaUKFkIAgABHv+qAAB4sAIABRn8B
Date:   Tue, 2 Oct 2018 10:29:35 +0000
Message-ID: <VI1PR0902MB22232AB6B650C8A71B42F48EE2E80@VI1PR0902MB2223.eurprd09.prod.outlook.com>
References: <VI1PR0902MB2223EA3FC0ACE7E9AFB7A6ACE2EF0@VI1PR0902MB2223.eurprd09.prod.outlook.com>
 <87a7nyhwqn.fsf@evledraar.gmail.com>
 <VI1PR0902MB22239E8AFA54DE8FFC0CB67FE2EF0@VI1PR0902MB2223.eurprd09.prod.outlook.com>,<CACBZZX5bLPKYg3jSxxH_s71ZrsuDmp2ffUE-x_LbyHybrxF0Rg@mail.gmail.com>
In-Reply-To: <CACBZZX5bLPKYg3jSxxH_s71ZrsuDmp2ffUE-x_LbyHybrxF0Rg@mail.gmail.com>
Accept-Language: es-ES, en-US
Content-Language: es-ES
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:4BCFAE7E49D21385137A6AFD0FE0A053E188AAC5659D27CE6B6EECFC831B5E84;UpperCasedChecksum:C294FB6EDF743D5F8B899BA7E2CA8E8C84E8061A8E387972703E3E8160ABD1A2;SizeAsReceived:7513;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [/IHdvkIrQt9S3kFhFtZMbG+ygxTyeq/9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VE1EUR02HT122;6:CdSt7VENmUX/C6B1Xe2ZvWV+eQenyUcdHbAxlt2a5SWlbLX+HYfLgr1y7JLHCsZz5bkj1v4+Op1WQT4eBmYz3hRmHriYaT6LZ16QNrXjrXSxvhKNrZkIToyYABvh3t1o9hC+Gzk0WnR3BXRM5bxFYWD9145sqLr+BzJ3DARgggLFt6CKAaGYe0CUgO7Wx7E2tX36kp0RANaxC6+dMMr4Enh0xUOXYT6Mk12y/HG3Gb44++GnegzrZOYKr/20PJR4KAnmCekdPFlDQYlQoEdoZqY12zN81+c5MDgh3Z7q+UklwW8kvICb2bBKmvJeDG48sZDMgt5sYJqqonejTLgV3CN4JEjCitMkirn81Pkv85whwFUs0XgYYqwO77CjJpex1Aw3gxvFJJJjEQ3YVN8G9lgld+J4ZXLDBE4IbUtEOsIU/E15bQoiCqc3gj6gYzkIpzpKvL0DdU/e6P8G9piIsg==;5:q+hSJIVOrMDNKC+J6vvnXcsTtsxwRQfU9gG1nPYrzOdntQlnkUFc1Yn1vSp4b5aigrs2E5lqvcpPWxebpU2eNbeQ+7ZlFM6NPzJ89eEFFH+2XsAF7j1nWwJUHiJmybXHbjffRfiP63qzg+VIRCHzNIggndngdl9DlQTdwrVYcPA=;7:LFWm79H348m3hCmJtcDxK3OElZnCCZCliYSgrYxLbJb8KnTse7Z4U0zmG7IxUrTdOPA1fHFaMpWk2JR2euRAY8Xs6a2h9D2HwOwq1AoB9PmjlqktO861jVRZWijWmfnAsBOKHWRAL7OK9TDuWJw/dIchdr4Clc8QIEldx99ngYEBNEJe4/eGNouUA6CDCWTyRzi23O6eluefGOgoF7qPJ0xPLp5IuyO08xgLMRsgBbSwT2+aEkEEa7sfaZETsOnf
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:VE1EUR02HT122;
x-ms-traffictypediagnostic: VE1EUR02HT122:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:VE1EUR02HT122;BCL:0;PCL:0;RULEID:;SRVR:VE1EUR02HT122;
x-forefront-prvs: 0813C68E65
x-forefront-antispam-report: SFV:NSPM;SFS:(7070007)(199004)(189003)(105586002)(8936002)(4326008)(6346003)(6506007)(229853002)(1411001)(106356001)(102836004)(6436002)(14444005)(256004)(93886005)(56003)(5660300001)(82202002)(33656002)(86362001)(68736007)(5250100002)(99286004)(8676002)(25786009)(39060400002)(14454004)(305945005)(6916009)(97736004)(76176011)(81156014)(26005)(476003)(104016004)(9686003)(7696005)(74316002)(44832011)(6246003)(446003)(71190400001)(486006)(55016002)(11346002)(71200400001)(2900100001);DIR:OUT;SFP:1901;SCL:1;SRVR:VE1EUR02HT122;H:VI1PR0902MB2223.eurprd09.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: live.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jose.gisbert@live.com; 
x-microsoft-antispam-message-info: oAy79nnGzckHwW2S32lx5Cpq7vDwt9rFN+fVjfMZlEX+4WfTjNRk6sKbAfIVXcbEAy4WqoxM1gRiKwnjGBQiWqsmn1C6XPZ3XeCLaqMIJe3m8GslODmZyzNnR0PYioIT55/uFfgRE/L/lpXkTqYH1amYJP47O3FQ3XQk/JDasp/9OkOS+JkOv53JJxsrEekP7HkcZY2y43kiEVc53inJ3091SxJsKn2Yzu2kaaaui6s=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 24fd1209-d934-423e-a578-ee886993c07f
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea9cd54-3cd8-4853-824d-08d62851f2cf
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 24fd1209-d934-423e-a578-ee886993c07f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2018 10:29:35.0211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR02HT122
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Makes sense. It's certainly not impossible to have some magic "push to=0A=
> git". I only wanted to point out that it's extra complexity, so if you=0A=
> could do away with that aspect of it you'd save yourself some=0A=
> complexity. I was going to elaborate a bit on how that can go wrong,=0A=
> but I see Jeff sent a mail just now that was better than what I had :)=0A=
> =0A=
> I'll only add that I think you're somewhat fooling yourself if you=0A=
> think you can run Subversion and Git side-by-side and evaluate both on=0A=
> their merits, even if you solve the technical aspects of doing that.=0A=
> Such a system will always need to cater to the lowest common=0A=
> denominator of Subversion's very centralized workflow.=0A=
> =0A=
> The big advantage you get out of DVCSs is being able to be more=0A=
> flexible, and e.g. using hosting sites (in-house or external) like=0A=
> GitHub or GitLab which are built around that flexibility. So=0A=
> ultimately any decision about switching SCMs needs to be a=0A=
> forward-looking management decision for the project, not based on how=0A=
> well Git can emulate a SVN-based workflow, which is ultimately not=0A=
> what you're interested in if you do make the switch.=0A=
=0A=
I agree with you about the extra complexity of letting users push to git an=
d=0A=
carrying the changes to svn through git hooks, =C6var. The reason because w=
e=0A=
decided to do this is to avoid forcing those who will play git to use svn t=
o=0A=
perform some actions. We think letting them focus on using git will provide=
=0A=
them with a better understanding of git and all of its mechanisms.=0A=
=0A=
I know well about the benefits of git, I've been a git user since 2009. But=
 I=0A=
agreed with development team leaders that this temporary setup will give te=
am=0A=
members the opportunity to learn git while, at the same time, we avoid to=
=0A=
change all of our CD infrastructure until we are ready. Besides that, this=
=0A=
will allow both team leaders and members to experience git advantages, for=
=0A=
instance, developers will be able to use branches to work on specific featu=
res=0A=
or commit only changes that are ready. Though, as you well say, they won't=
=0A=
know about git veritable benefits until we definitely migrate to git and=0A=
discard svn.=0A=
=0A=
Nevertheless, thank you very much for your advice, I will consider it.=0A=
=0A=
Regards,=0A=
=0A=
Jose=
