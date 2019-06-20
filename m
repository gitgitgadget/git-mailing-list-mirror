Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B33D1F461
	for <e@80x24.org>; Thu, 20 Jun 2019 19:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfFTT3j (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 15:29:39 -0400
Received: from mail-eopbgr830088.outbound.protection.outlook.com ([40.107.83.88]:57553
        "EHLO GCC01-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726169AbfFTT3i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 15:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cityofaustin.onmicrosoft.com; s=selector2-cityofaustin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tp7O4NpMJpwAvJugwj9W3FrNqdvuaNdZvdI84DXPGkU=;
 b=JKScJjatKB6q/EwE5627WtsYmAnZwKaWlLGdlDfTbK5BqqWKieQa3gFWBeaXaAotL49GtEMOf059YRWnDNuflJXBuZCNK2/6RL8VAw+4aoob07SpewJqUltPUWckyzrGUjrWcyLrGdCgSoPmf3P0M9vk77k88i5WkldyLMvqTKc=
Received: from SN6PR09MB3248.namprd09.prod.outlook.com (20.177.251.17) by
 SN6PR09MB2605.namprd09.prod.outlook.com (52.135.96.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 20 Jun 2019 19:29:36 +0000
Received: from SN6PR09MB3248.namprd09.prod.outlook.com
 ([fe80::b933:6b75:e283:3899]) by SN6PR09MB3248.namprd09.prod.outlook.com
 ([fe80::b933:6b75:e283:3899%4]) with mapi id 15.20.1987.014; Thu, 20 Jun 2019
 19:29:36 +0000
From:   "Pugh, Logan" <Logan.Pugh@austintexas.gov>
To:     "peff@peff.net" <peff@peff.net>
CC:     "Pugh, Logan" <Logan.Pugh@austintexas.gov>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "liu.denton@gmail.com" <liu.denton@gmail.com>
Subject: Re: [2.22.0] difftool no longer passes through to git diff if
 diff.tool is unset
Thread-Topic: [2.22.0] difftool no longer passes through to git diff if
 diff.tool is unset
Thread-Index: AdUm+T+1c7ctjjbIR+WEKBBEplAQZw==
Date:   Thu, 20 Jun 2019 19:29:36 +0000
Message-ID: <SN6PR09MB3248412C9E5AE197B65A8D878AE40@SN6PR09MB3248.namprd09.prod.outlook.com>
References: <20190620052125.GA12434@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Logan.Pugh@austintexas.gov; 
x-originating-ip: [162.89.0.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc9aa328-b6cb-4c8a-12bf-08d6f5b5a161
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR09MB2605;
x-ms-traffictypediagnostic: SN6PR09MB2605:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR09MB2605551307E9D5AE8D8E386E8AE40@SN6PR09MB2605.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0074BBE012
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(346002)(376002)(136003)(189003)(199004)(51914003)(6916009)(74316002)(66446008)(229853002)(102836004)(66476007)(66556008)(476003)(72206003)(14454004)(9686003)(4326008)(7736002)(446003)(26005)(66946007)(99286004)(73956011)(316002)(478600001)(256004)(305945005)(486006)(76116006)(2501003)(6116002)(71190400001)(186003)(68736007)(71200400001)(5660300002)(66066001)(81166006)(6436002)(86362001)(6506007)(64756008)(25786009)(1730700003)(3846002)(81156014)(52536014)(8676002)(2351001)(76176011)(6246003)(2906002)(7696005)(53936002)(55016002)(5640700003)(8936002)(6306002)(54906003)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR09MB2605;H:SN6PR09MB3248.namprd09.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: austintexas.gov does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tPrI4iXnPT+VvZw5ikLUjhRoFXyl6sbpaYLueH/ye39uN0QbOFMWD4SbqzkLiAC8eY6eUhGQdWitjcijR8OQUSbonYZSPAFtUss8F12wZUA920b8/9g2Z35CZkacXYV9iYp6er4D0EsrKcf0j1fFsIlTwsHIxidfCBWO7xvQoEEOCzubuoVMLghUyqvVnu+O7N53Y/9d++XSbewtssUrdXBPeIShm3mEwxb0FW3x3ZoMMOgoYjQhXP/bYdSXaSV/YKpf47h2rFLdH5XS0u49f+Ld641LG6WGlDmv+unYJKPz6siIz0j1w1QjZrxnqwpqScnLd8U2MmLHyakHhjKW3V3T1IVyOcbdyL6DZmI8O2XO64lQdYfJQXPjgO/3tZZCW/KWy9UAlpHNNpFvV9Aowmz/Ik3nBPCZv0yKFgOZEQo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: austintexas.gov
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9aa328-b6cb-4c8a-12bf-08d6f5b5a161
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2019 19:29:36.3793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c5e19f6-a6ab-4b45-b1d0-be4608a9a67f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Logan.Pugh@austintexas.gov
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR09MB2605
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Wed, Jun 19, 2019 at 10:45:17PM -0400, Denton Liu wrote:
>=20
>> Using the following command on git.git,
>>=20
>> 	$ HOME=3D/dev/null ./git --exec-path=3D. difftool --no-index color.c co=
lor.h
>>=20
>> I did a quick bisect on the issue and it seems like the cause of this
>> bug is actually 287ab28bfa (diff: reuse diff setup for --no-index case,
>> 2019-02-16). I'll do a bit more digging tomorrow.
>=20
> I don't know much about how git-difftool works, but it looks like it
> sets GIT_EXTERNAL_DIFF=3Dgit-difftool--helper.
>=20
> Prior to 287ab28bfa, we would not have respected any external diff
> command when running git-diff. But after it, we do.
>=20
> In the case that he user has not provided --no-index, then this all
> works as I guess difftool is meant to: it runs the helper and says "hey,
> you have not configured this".
>=20
> It seems like the behavior of the above command prior to 287ab28bfa was
> not intentional. It would run git-diff, expecting it to trigger the
> helper, but it never did (and instead just did a normal no-index diff).
>=20
> So it seems like the new behavior is actually the right thing, as it
> makes the --no-index case consistent with the regular one? I'm not
> at all clear why you would run "difftool" here if you it is not
> configured and you just want the straight diff output.
>=20
> -Peff


Hi Peff,

Thanks for the explanation. It sounds like I was under the incorrect=20
assumption that I could use the difftool command the same way as the=20
diff command. Part of my confusion could be blamed on the git-difftool=20
documentation (https://git-scm.com/docs/git-difftool) which near the top=20
states:

 > git difftool is a frontend to git diff and accepts the same options=20
and arguments. See git-diff[1].

My use case is a CLI program I've written that processes and then=20
compares two arbitrary files using the git difftool apparatus as=20
configured by the end user, leaving the choice to them whether to use=20
the internal diff tool or an external tool.

Now, if I'm understanding correctly, I should not rely on the behavior=20
of git difftool --no-index passing through to git diff. I could add=20
another CLI switch and code path to my program that calls git diff=20
directly instead of git difftool but the passthrough behavior seemed=20
more elegant at the time.

Ideally, in my mind, git difftool should work as it says on the tin, as=20
a straight up passthrough to git diff *unless* explicitly configured to=20
use external tools (e.g. diff.tool and diff.guitool).

Hopefully that makes sense, please let me know if I am off-base.

Thanks,

Logan
