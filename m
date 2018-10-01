Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6D061F453
	for <e@80x24.org>; Mon,  1 Oct 2018 14:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbeJAUzc (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 16:55:32 -0400
Received: from mail-oln040092068029.outbound.protection.outlook.com ([40.92.68.29]:56593
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729341AbeJAUzb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 16:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1vtjNwr+MaY0BLijkaTRpw7vFyLxgdxvIBJG1hKOfE=;
 b=QShwyk7Ws5N0q8ij/cskfxKzYCDr/KVZyCusWUHC9pFwbEFJvhmG5OrXOHZOXrhpa748pr3eSmckxIQVObMmZLJQQlgr7PPyrbJHHf6zOB3mhxsbeRSHsK80viHvSRdoHbHqr1dUj6o3M+DoBHpLbCVGppN5tI9F5iuET93a3c7IvGfEobKmS7WyJMPWHWJsJkLpT9K0defXxHpUKWJHgOmTR82QF61jCm/MPoKaTmostD/QBkz4eOVHrxH45KAaVOcIyQVJ6CrsLisgOUlrq0g9gZWqQoAbu7dZWGfQDxKoqZ+wLhtHIdRfVH5zXJ5nuWpV46643TZOmwPhsW3/Ag==
Received: from AM5EUR02FT039.eop-EUR02.prod.protection.outlook.com
 (10.152.8.60) by AM5EUR02HT083.eop-EUR02.prod.protection.outlook.com
 (10.152.9.239) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1185.13; Mon, 1 Oct
 2018 14:17:25 +0000
Received: from VI1PR0902MB2223.eurprd09.prod.outlook.com (10.152.8.53) by
 AM5EUR02FT039.mail.protection.outlook.com (10.152.9.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1185.13 via Frontend Transport; Mon, 1 Oct 2018 14:17:25 +0000
Received: from VI1PR0902MB2223.eurprd09.prod.outlook.com
 ([fe80::1b9:1b61:c38c:8bd9]) by VI1PR0902MB2223.eurprd09.prod.outlook.com
 ([fe80::1b9:1b61:c38c:8bd9%3]) with mapi id 15.20.1185.024; Mon, 1 Oct 2018
 14:17:25 +0000
From:   Jose Gisbert <jose.gisbert@live.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Using git svn rebase at quarantine environment or a feasible
 alternative to synchronize git and svn repositories
Thread-Topic: Using git svn rebase at quarantine environment or a feasible
 alternative to synchronize git and svn repositories
Thread-Index: AQHUWV6KIMpBHSj6s0iSXwsGXjkPyaUKFkIAgABHv+o=
Date:   Mon, 1 Oct 2018 14:17:25 +0000
Message-ID: <VI1PR0902MB22239E8AFA54DE8FFC0CB67FE2EF0@VI1PR0902MB2223.eurprd09.prod.outlook.com>
References: <VI1PR0902MB2223EA3FC0ACE7E9AFB7A6ACE2EF0@VI1PR0902MB2223.eurprd09.prod.outlook.com>,<87a7nyhwqn.fsf@evledraar.gmail.com>
In-Reply-To: <87a7nyhwqn.fsf@evledraar.gmail.com>
Accept-Language: es-ES, en-US
Content-Language: es-ES
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:53C0395D2406DC3556C60F5742981E931469ECF8214A95C6A51CFB7351B14653;UpperCasedChecksum:BB78C32D93CA788BB857024BB7C200551A29A6A6014CC853F79C989B765B24EF;SizeAsReceived:7313;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [rkXBBoeRcgeQLm1WfH8tF0Nv+GZQ0MNy]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5EUR02HT083;6:17jlsVU/WhqRPXAcjc/Z+JZ5FIR0705m1ZOS91gtENfcOUIsfUbzyOsXMy1x7fNHGjfyU7qDfUC8G6ESpR9ZnIxL0nXxbNK9RAEpULYjRZr/8p+D3WylJWGKbUxrcsyBDDUg4QAbBUPScp8o/Y/IzFXLHa/3xSLSq6nL3dFLVMuoaYbNV5+EuJEE5aj0+XRUDe4bFvAsUZYb+iF0TMOVckfi7aWakUp3fsyNWl8sN09lswWkVAa+fsxivYGd/pjF/Fm5/wnpj1oSEwuDrbG0eQ2ng+KtzpuPKfP8rD+sYkAn7jFuIxEvOybPtaps3bhuiCxkkg1ObWFcxgaqGTBVcMFC48NpTr1iI6wzm73R9vX99RZbvMXOZ30FbeZL72rNUVrKAF733dUGyDb2H9dpt8kTN/vnvijKFh4Ms05hd3Cx/wRaO9fHfQBIuCoMv2YBmEW+J19KJtprX7nrUc9ThA==;5:fWEjvlM6iAofYFIhlXh6+etdyxiuXRn8+d0/fxNG0ez6eVVSEnI/hz9MJrmVm8es02aVm6XOK5nkql/Dvm6JeyoD9Utjb9iC3526YCDw7JTAAX0csewBmFz7WP2WypFa1WhFZrWZ8KM4d8RZz4n1aqTr8OjkLBTNopSt3VXmPhc=;7:B6lwpjkalmx9OU2HZ4K+YOwUTrwvMHrzNFryhuiqXCSB+lCS6oR5TZDTGlOqSgRcxQJ/LnwJygQFJ0sk1m2AXuXJWHoOIv0GdQs4AwTH2lou2ESQpXQE/1VJgS62j2+8hCIFwpDFuo+bOEIOtG1QQ6DlJHZVhdkzPgzwBje6LiySYBru++Rw8hNOw2gCPeZKf1oU4tMkXWXbJAwom66FNLiDWxOlSvD3TBOMkB0PEhJ/ohMFv5HRVVddN0jxK7oF
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:AM5EUR02HT083;
x-ms-traffictypediagnostic: AM5EUR02HT083:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:AM5EUR02HT083;BCL:0;PCL:0;RULEID:;SRVR:AM5EUR02HT083;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(7070007)(189003)(199004)(6246003)(486006)(68736007)(6306002)(9686003)(229853002)(6506007)(256004)(5660300001)(7696005)(561944003)(14444005)(8936002)(33656002)(8676002)(81156014)(76176011)(476003)(82202002)(55016002)(345774005)(56003)(86362001)(6436002)(104016004)(14454004)(25786009)(99286004)(71200400001)(106356001)(1411001)(5250100002)(966005)(305945005)(11346002)(97736004)(446003)(34290500001)(71190400001)(44832011)(74316002)(26005)(39060400002)(6346003)(4326008)(102836004)(6916009)(2900100001)(105586002);DIR:OUT;SFP:1901;SCL:1;SRVR:AM5EUR02HT083;H:VI1PR0902MB2223.eurprd09.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: live.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jose.gisbert@live.com; 
x-microsoft-antispam-message-info: QG9fN0GeuQ2+MQRmaLz2N9E3ia2vjn4rEE/1/4fz9K6ufOHoOM3K1GTTtAvoPFY/PztdiRQDVdBPqu3sj/nBSlBDrAQJkCS/6tiSkpSmK1USNKNg6PAyUbHsDb00R5VqhO7RElfFiHMRnKo22Vr8GykOAuAAgnXLFZnhTFv41baXefR5Ox4TzCwfLA5D8uhsIR3SrBx06cHrZvkEy+DZM2QNTjvPDkFG95RzxJSywAY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 24fd1209-d934-423e-a578-ee886993c07f
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c7f728-ca70-4ae1-2da3-08d627a89cc0
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 24fd1209-d934-423e-a578-ee886993c07f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 14:17:25.6122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR02HT083
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Dear members of the Git community,=0A=
> >=0A=
> > The enterprise I work for is planning to switch from svn to git.=0A=
> >=0A=
> > Before the complete switch to git we have decided to implement a scenar=
io=0A=
> > where the two SCMs live together, being the svn repository the referenc=
e.=0A=
> > We also want this scenario to be transparent for both SCM users.=0A=
> >=0A=
> > I read the articles referenced at the end of the email and I come to th=
e=0A=
> > following solution.=0A=
> >=0A=
> > My proposal consists to import the svn repository to git using git svn =
and=0A=
> > set receive.denyCurrentBranch to updateInstead. Then install pre-receiv=
e=0A=
> > and post-receive hooks and set that repository as the central repositor=
y=0A=
> > for git users.=0A=
> >=0A=
> > The pre-receive hook does git svn rebase and, if there is an update at =
the=0A=
> > svn repository, rejects the push and instructs the user to do git pull.=
=0A=
> > The post-receive hook does git svn dcommit to update the state of the s=
vn=0A=
> > repository, then instructs the user to do git pull too.=0A=
> >=0A=
> > Both scripts check the changes pushed are made at master before doing=
=0A=
> > anything and exit after performing these tasks. branches.master.rebase =
is=0A=
> > set to merges at the user repository to avoid the histories of the cent=
ral=0A=
> > and the user repositories diverge after doing git svn dcommit.=0A=
> >=0A=
> > However I'm stuck at this point because the pre-receive hook it's not=
=0A=
> > allowed to do git svn rebase because update refs are not allowed at the=
=0A=
> > quarantine environment. I was sure that I tried this solution with a pa=
st=0A=
> > version of git and it worked, but now I doubt this because the restrict=
ion=0A=
> > to update refs at quarantine environment was delivered at version 2.13,=
=0A=
> > that dates from April 2017, if I'm not wrong.=0A=
> >=0A=
> > I don't know if this solution could be implemented or is there a better=
=0A=
> > way to accomplish this kind of synchronization (I tried Tmate SubGit, b=
ut=0A=
> > it didn't work for me and I don't know if we will be willing to purchas=
e a=0A=
> > license). Could you help me with this question?=0A=
> >=0A=
> > I come here asking for help because I think this is the appropriate pla=
ce=0A=
> > to do so. I apologise if this is not the case. Any help is welcome. If=
=0A=
> > anything needs to be clarified, please, ask me to do so. I can share wi=
th=0A=
> > you the source code of the hook scripts, if necessary.=0A=
> =0A=
> A very long time ago I had a similar setup where some clients were using=
=0A=
> git-svn. This was for the first attempt to migrate the Wikimedia=0A=
> repositories away from SVN.=0A=
> =0A=
> There I had a setup where users could fetch my git-svn clone, which was=
=0A=
> hosted on github, and through some magic (I forgot the details) "catch up=
"=0A=
> with their local client. I.e. there was some mapping data that wasn't sen=
t=0A=
> over.=0A=
> =0A=
> But users would always push to svn, not git. I think if you can live with=
=0A=
> that you'd have a much easier time, having this setup where you push to g=
it=0A=
> and you then have to carry that push forward to svn is a lot more complex=
=0A=
> than just having the clients do that.=0A=
> =0A=
> GitHub also has a SVN gateway, that has no open source equivalent that I=
=0A=
> know of: https://help.github.com/articles/support-for-subversion-clients/=
=0A=
> =0A=
> Maybe that's something you'd like to consider, i.e. fully migrate to git=
=0A=
> sooner than later, and for any leftover SVN clients have them push to a=
=0A=
> private repo on GitHub. Even if you only keep that GitHub repo as a bride=
=0A=
> during the migration and host Git in-house it'll be a lot easier with git=
 as=0A=
> a DVCS to continually merge in those changes than pulling the same trick=
=0A=
> with a centralized system like SVN.=0A=
=0A=
Hi =C6var,=0A=
=0A=
First of all, thank you very much for your early response.=0A=
=0A=
I don't think making users always commit to svn is necessary. In fact, from=
 my=0A=
point of view, updating the svn repository with the changes committed to th=
e=0A=
git central repository is easy because there is no obstacle preventing to r=
un=0A=
git svn dcommit at the post-update hook.=0A=
=0A=
What I haven't managed to accomplish is to pull diffs from the svn reposito=
ry=0A=
into the git central repository without manual intervention. I suppose that=
 in=0A=
the setup you describe you manually pulled changes from the svn repository=
=0A=
into your git-svn repository at GitHub. If don't, it would be very useful f=
or=0A=
me if you could remember how did you managed to do it automatically.=0A=
=0A=
I guess GitHub svn bridge (thank you for telling me about it, I didn't know=
=0A=
about its existence) could be the solution if it was not for the fact that =
we=0A=
want to keep our svn repository. Our whole CD infrastructure feeds from tha=
t=0A=
repository and we'd like to figure out if everybody is comfortable using gi=
t=0A=
and what is the actual value of using it as a team before making the effort=
 of=0A=
changing everything.=0A=
=0A=
Regards,=0A=
=0A=
Jose=
