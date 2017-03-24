Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AABD20966
	for <e@80x24.org>; Fri, 24 Mar 2017 16:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966393AbdCXQWN (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 12:22:13 -0400
Received: from mail-sn1nam02on0134.outbound.protection.outlook.com ([104.47.36.134]:4377
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966379AbdCXQWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 12:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tMH+Gf9ZdeyGjv2DjpOYZ+Mev8cuJwr7J85pkhVgQbE=;
 b=NrFGK8L3axHmyG8oOx9sK5Hi+u4f+zV7aSOwmjZIH9/BAfnwbPJNmEUGNvORsHft6jz7x80a4OZsdKx5nrH+Vuuwyn9afkFZRlrlD/TEtNBpNEn/fzbjH0upexUXx9aHzsP0vphPdBIeRVdVLNf7+rEZ3shTvfQ+Rs369XSX8X4=
Received: from BL2PR03MB323.namprd03.prod.outlook.com (10.141.68.22) by
 BL2PR03MB324.namprd03.prod.outlook.com (10.141.68.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.991.14; Fri, 24 Mar 2017 16:21:55 +0000
Received: from BL2PR03MB323.namprd03.prod.outlook.com ([10.141.68.22]) by
 BL2PR03MB323.namprd03.prod.outlook.com ([10.141.68.22]) with mapi id
 15.01.0991.017; Fri, 24 Mar 2017 16:21:56 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     Ben Peart <peartben@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: RE: [PATCH v2 1/4] t7800: remove whitespace before redirect
Thread-Topic: [PATCH v2 1/4] t7800: remove whitespace before redirect
Thread-Index: AQHSpLMvuGADDCMg1UiaKQXXNVPZBaGkKz9g
Date:   Fri, 24 Mar 2017 16:21:55 +0000
Message-ID: <BL2PR03MB32312344027A7C07573AC85F43E0@BL2PR03MB323.namprd03.prod.outlook.com>
References: <20170324152726.14632-1-benpeart@microsoft.com>
 <20170324152726.14632-3-benpeart@microsoft.com>
In-Reply-To: <20170324152726.14632-3-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [65.222.173.206]
x-microsoft-exchange-diagnostics: 1;BL2PR03MB324;7:DzIJPAO5ZppbWFnKYE5eosA3eLnxPK98+6d9+XBqRnexex6IJSQJbHMXljvX6/02dZTxDt58QmfTODRjNfsVlTyQ6v3k99sDVqnGsXw7GjK4xWmqUfSfBnGha81rgqn5p+fxk4LVmwapNaUdJ41zqOS2e3B4iy5D11B5QUhu5mJKE5hfrXMJIzky1Zf6JGWMUpiAUsgGCPe5YQQ3/m0qQN4iUr6zFfZy2PFXbCqrexKHbQPndEeLiI8SSgqTUEcYsDeRQ+ASquFWvacc5h119EMRSDnzjoCn9fc4kNRAcPswCgqFWmsWRw9Nf6mRB1kvzWk2jnG6IvNtvdUTnF6NqqbLt/eBOy5odKg28yaNfHg=
x-ms-office365-filtering-correlation-id: f27d0599-f5e3-4066-0bc9-08d472d1e3bc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254075)(48565401081);SRVR:BL2PR03MB324;
x-microsoft-antispam-prvs: <BL2PR03MB3246992A5D98217836BFCE0F43E0@BL2PR03MB324.namprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(100324003535756);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040375)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123564025)(20161123558025)(20161123555025)(20161123560025)(20161123562025)(6072148);SRVR:BL2PR03MB324;BCL:0;PCL:0;RULEID:;SRVR:BL2PR03MB324;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39410400002)(39850400002)(39840400002)(39450400003)(39860400002)(13464003)(377454003)(229853002)(86612001)(7696004)(2950100002)(2906002)(305945005)(189998001)(33656002)(76176999)(54356999)(7736002)(74316002)(122556002)(50986999)(3846002)(6116002)(77096006)(3660700001)(4326008)(8676002)(81166006)(3280700002)(54906002)(99286003)(9686003)(55016002)(53936002)(6436002)(2501003)(6506006)(2900100001)(8656002)(25786009)(53546009)(66066001)(8990500004)(10090500001)(38730400002)(39060400002)(5005710100001)(10290500002)(6246003)(102836003)(86362001)(5660300001)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR03MB324;H:BL2PR03MB323.namprd03.prod.outlook.com;FPR:;SPF:None;MLV:ovrnspm;PTR:InfoNoRecords;LANG:en;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2017 16:21:55.8213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB324
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please disregard.  I apologize - somehow my format-patch/send-email went aw=
ry.=20

Thanks,

Ben

> -----Original Message-----
> From: Ben Peart [mailto:peartben@gmail.com]
> Sent: Friday, March 24, 2017 11:27 AM
> To: git@vger.kernel.org
> Cc: Ben Peart <Ben.Peart@microsoft.com>; christian.couder@gmail.com;
> larsxschneider@gmail.com; David Aguilar <davvid@gmail.com>; Junio C
> Hamano <gitster@pobox.com>
> Subject: [PATCH v2 1/4] t7800: remove whitespace before redirect
>=20
> From: David Aguilar <davvid@gmail.com>
>=20
> Signed-off-by: David Aguilar <davvid@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
>  t/t7800-difftool.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh index
> 25241f4096..e1ec292718 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -428,7 +428,7 @@ run_dir_diff_test 'difftool --dir-diff branch from
> subdirectory' '
>  		git difftool --dir-diff $symlinks --extcmd ls branch >output &&
>  		# "sub" must only exist in "right"
>  		# "file" and "file2" must be listed in both "left" and "right"
> -		grep sub output > sub-output &&
> +		grep sub output >sub-output &&
>  		test_line_count =3D 1 sub-output &&
>  		grep file"$" output >file-output &&
>  		test_line_count =3D 2 file-output &&
> --
> 2.12.0.gvfs.1.43.g876ba2a

