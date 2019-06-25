Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01B8B1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 23:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfFYXJL (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 19:09:11 -0400
Received: from mail-eopbgr840089.outbound.protection.outlook.com ([40.107.84.89]:16293
        "EHLO GCC01-DM2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726287AbfFYXJL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 19:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cityofaustin.onmicrosoft.com; s=selector2-cityofaustin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHZ8rKajSS24g4TwwSITWBEcCH124yTSRUzOihrGhZU=;
 b=My631Qvu9KVwjU5BgjNHrZLbR1eE4Bq28o27BS4xREwgfFY34qnG4mOweqh527AW73ZJmVmpEVytLzyZmTjwvTZ2KGAmxz/3ulQ9QCtxBNoapDBR1sKkiqQCsyG8ZXdviiYi0+AAKlLsrXOkArBf+LmdMsuaT7aNuXNzarUOX+o=
Received: from BL0PR0901MB4466.namprd09.prod.outlook.com (10.255.69.16) by
 BL0PR0901MB4465.namprd09.prod.outlook.com (52.135.45.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Tue, 25 Jun 2019 23:09:08 +0000
Received: from BL0PR0901MB4466.namprd09.prod.outlook.com
 ([fe80::f4a9:9781:26fa:622b]) by BL0PR0901MB4466.namprd09.prod.outlook.com
 ([fe80::f4a9:9781:26fa:622b%2]) with mapi id 15.20.2008.017; Tue, 25 Jun 2019
 23:09:08 +0000
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
Date:   Tue, 25 Jun 2019 23:09:08 +0000
Message-ID: <BL0PR0901MB4466FF7338C085ADBBF594898AE30@BL0PR0901MB4466.namprd09.prod.outlook.com>
References: <20190625213545.GA23411@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Logan.Pugh@austintexas.gov; 
x-originating-ip: [162.89.0.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2719c141-f41e-4437-fb7a-08d6f9c2208a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BL0PR0901MB4465;
x-ms-traffictypediagnostic: BL0PR0901MB4465:
x-microsoft-antispam-prvs: <BL0PR0901MB44658E71AFFC385FAE4889938AE30@BL0PR0901MB4465.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(376002)(346002)(396003)(55674003)(51444003)(189003)(199004)(14454004)(186003)(71190400001)(71200400001)(52536014)(76116006)(66446008)(66556008)(64756008)(25786009)(66476007)(66946007)(476003)(6916009)(73956011)(74316002)(486006)(5660300002)(7736002)(478600001)(33656002)(446003)(72206003)(66066001)(256004)(305945005)(316002)(54906003)(68736007)(8676002)(81166006)(81156014)(3846002)(6116002)(4326008)(8936002)(2351001)(1730700003)(55016002)(86362001)(5640700003)(53936002)(229853002)(6436002)(2501003)(9686003)(2906002)(6246003)(26005)(7696005)(76176011)(102836004)(99286004)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR0901MB4465;H:BL0PR0901MB4466.namprd09.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: austintexas.gov does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: o40+NLzMdp5knj3eibR5sdCP91+45zvN/F2fE3NYCiyUcGbqpiYC4H57hERRL95RUWTWa1TlXwjJ58g6zf+3kdkaWF2GRO4ISuu5wmpqABijar3mfJm4Nj5Z2UD4ucBq3KZ8P4lRxgBIewmj2w3T4YEqOluyPkAwMaGW+7C9y27cOZKqqDpW2bDPBwv9dEYN5nWXz7ktSnMXo2ExIh4kwkRi7O+U40ZnwIFce9QfoMihK7Iqn8VJf6eAeYAIvH0cf5ZYwwR2vyNzDXYZ2rGqoNWTfhPX66iB2GbFDkzmYlgAyw+fNWer42WlIDd+MFzq5sp0w9CCU3eDhXwV1Yrb/hnREvLTcYwuZEoaxL66u8oIbzs8LEzCB+F7WTL1KyBgkXYTtvo6Ud8NvV/PIWeyAz4ICeRILGT/4aWHXPna9nU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: austintexas.gov
X-MS-Exchange-CrossTenant-Network-Message-Id: 2719c141-f41e-4437-fb7a-08d6f9c2208a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 23:09:08.3634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c5e19f6-a6ab-4b45-b1d0-be4608a9a67f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Logan.Pugh@austintexas.gov
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR0901MB4465
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Well, it _is_ true that you can use it the same way. It's just that you
> need to configure it to use whatever 3rd-party tool you want (and if you
> do not want to configure a tool, then you are better off just using
> git-diff directly). It was only due to a bug/historical accident that it
> behaved just like git-diff in the no-index case (but not in the regular
> case -- AFAICT, that would have been broken for your script always).

Yes, it would seem that I had only stumbled upon the broken behavior=20
because of my --no-index use case, but at least the inconsistency is fixed.

> That does make some sense to me for your use case. But I'm worried it
> would be a worse experience for people new to difftool (they run it and
> scratch their heads why it does not do anything different, whereas now
> they get walked through an interactive configuration).

That is a fair point. UX matters even for CLI programs. Prior to it=20
being fixed, I myself was confused as to why I was getting a git-diff=20
output when trying to use an external tool with git-difftool but hadn't=20
configured it correctly. At least now there is some feedback when the=20
configuration is invalid.

> In the meantime, I think you can probably switch behavior in your script
> by checking if the diff.tool config is set. It might be nice if difftool
> had a better way to query that without you having to know if it's
> configured.

What I ended up doing in my app was just requiring the user to be=20
explicit (via separate arguments) about whether they wanted to use=20
git-diff or git-difftool. My app also accepts additional arguments that=20
get passed through to git-diff/difftool and I didn't want to have to=20
check those in addition to git-config. I think that would have been=20
significantly more complex to implement.

> Or in your case I suppose even better would just be an
> option like "--if-not-configured-just-use-regular-diff". Then it would
> do what you want, without impacting users who do want the interactive
> setup.

If such an option was considered I would be in favor of it. Maybe call=20
it "--no-tutorial" or perhaps "--diff-fallback".

But having fixed my app, I'm content with the status quo too, now.

Thanks,

Logan
