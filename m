Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F22F1F404
	for <e@80x24.org>; Sun, 11 Mar 2018 23:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932420AbeCKXq7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 19:46:59 -0400
Received: from mail-cys01nam02on0046.outbound.protection.outlook.com ([104.47.37.46]:4972
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932403AbeCKXq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Mar 2018 19:46:57 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jynelson@email.sc.edu; 
Received: from debian-thinkpad.localnet (47.199.26.65) by
 DM2PR02MB1401.namprd02.prod.outlook.com (2a01:111:e400:50cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.13; Sun, 11
 Mar 2018 23:46:55 +0000
From:   Joshua Nelson <jynelson@email.sc.edu>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [Feature request] Add config option to gpgsign IFF key is present
Date:   Sun, 11 Mar 2018 19:46:43 -0400
Message-ID: <1590381.vKE574KI6v@debian-thinkpad>
Organization: University of South Carolina
User-Agent: KMail/5.2.3 (Linux/4.9.0-4-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <20180311172142.GA249931@genre.crustytoothpaste.net>
References: <CY1PR02MB13991271133B3A6BD334328DF4DD0@CY1PR02MB1399.namprd02.prod.outlook.com> <20180311172142.GA249931@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3018720.kKJ53NVZ5j"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Originating-IP: [47.199.26.65]
X-ClientProxiedBy: BL0PR02CA0043.namprd02.prod.outlook.com
 (2603:10b6:207:3d::20) To DM2PR02MB1401.namprd02.prod.outlook.com
 (2a01:111:e400:50cb::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7c0539b-0582-4920-f432-08d587aa5f36
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:DM2PR02MB1401;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB1401;3:l5xVV/1YkhUEbsYUfZCW9tE8jVnhnqqAqbjknDZBRXURqRTt4emwa6qN6/h4DdqPynIAs6uKvsAXNE3oVhTL1o3XOO43DysJpMtCUA/uRxL6k4hpn2oyLaYsWl7QHYdCUz6ygSvM/t5MBMpPiHGXs2CPpZCgkOR7wkLkTm/+5o5t6BEuUiPaPDLJkBT24U9utXIw+8BDZcHvzeta59/sAXv+dDwXrJOAhmTJGxSRyhXdS+DsGcdJaXZQ++w7F6Ot;25:ExFhB3+bGvOWR2/Eqa0c/mtIPMWifTG5mO88NCW70KXKrPaNa8yumHX24itQR2+LInCI6W6c9U8//2LHjWfDBLyA92rJuqRO2wbbpIx1CpyFwRvt94cFh4QrOWRtoW7IPPXkQZ+pbm5bHckOTdiCkAX/8B46I0Vt5A1fdrOkSyK7ORm7QYuDT7a+xj4eglYH6/36a8qQ8DmEu9pgAdqqdomPxZDPlse9KLstsYTNic5HudA8ilib+OzbiVuR7fyh55wox95VJplNMAS+egFETcQTbPU3MRqM3XfSElLAdPaWLw1oadZ/RPqJAIzZDQwfFn8EYu4ERqdfD2+c5VjRH77DJUKVw+Vny/fJE6ZJMsc=;31:2nejxhLkaNii4q5WcBGdgOObV4wfSUwP4VVH/tCqgb9tI4ZjtweYuH/NNTfRmhPSDmGjs/zbVvtVq5993uPD0jihTEWM/H2W+hf26PFgjoPR/bF3HOxPDysYUy7EOCK5NXAb10wQM5bt1QhsoERHBlz0+Y8oFqrMXvlrXhGfa4IWCueLbJRRsrKKLB6bB5DUlP/4xeOmyYuXHryiIkoRSqc4boL15TSCo3qsRLPlLws=
X-MS-TrafficTypeDiagnostic: DM2PR02MB1401:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB1401;20:YGpDE1sW3SAUQh4POUW95Lmnak6rbXfU67BWr1zcnObqupsYNR9LlOoU6t63e9seX7SydvPXWhrdyXSaEP8iOWU8j6C5GGWoGMrktc4mv1DSLqgjLDdoGBdisBjDf/TwZx7Skahg+TnwGegvrZ9LDhcAvfrjn1QcXicesXIkAmhQ/i4SXGgQPV5xj/SRIT3q3C8XbQ6/1m0hHgYHqoncZZgtq3S7YtoKtbDTb13TtwVeb+3C3+N6Mzq7OYLyni4WnGTssBnrlJofNiocYtm2kYDoe9bT7Uqur6pl6O4hZ5c+Vkr/iMlF3RBDnrbhPCT9SgQkCwBNrIg4YO93kUoOK6Emtn3GVGNQw+KEswBMJt4QI/q7uXeE6QcizHsB4uWGAmFKJJWxXskK/GsiaLdm99/2XGi5/IyjHkXUlvoedRvVo3dbWKXUFWm6qztoqbnvm+Jr2jc5Xd/kjCugeMGKHWRUjhXzHAFHb1m4TgFwXf0AJMyzmcpaIXREdmm4Ifd8;4:7JZwuRI12m/rrsP/nMhM2lCR25HQ4L4EdHL4eu6X3Fx7D3U5VyUwsfHbS6dYkxzV3U93taWfSOwVg36crv7cbXpq+qkoL7AKNMlHmu6/SjZEfflfTYgNyykAox7gYudmP/lvdV12UTZepujKRc73DYhxtmeKpMhUqiq46+CNChoDjWHzxqV9AEvL9Pn8/IXseYsalQqRHYSKQl9hRAeWTyz6L3iZNlcvNeSnWCDY7j9tMXo2z8c9QouU0fPREpQeHRqjRq4m9G2JacFhWTWoEQ==
X-Microsoft-Antispam-PRVS: <DM2PR02MB1401CD41B210EA075EAB7618F4DC0@DM2PR02MB1401.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(6041310)(20161123564045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM2PR02MB1401;BCL:0;PCL:0;RULEID:;SRVR:DM2PR02MB1401;
X-Forefront-PRVS: 0608DEDB67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(39860400002)(376002)(39380400002)(51914003)(189003)(199004)(76176011)(6246003)(229853002)(8936002)(21480400003)(106356001)(6116002)(3846002)(966005)(81166006)(81156014)(8676002)(26005)(33716001)(186003)(16526019)(75432002)(36916002)(2950100002)(52116002)(6916009)(6666003)(88552002)(58126008)(2906002)(7736002)(16586007)(6306002)(478600001)(305945005)(4326008)(53936002)(105586002)(786003)(316002)(68736007)(33896004)(9686003)(5660300001)(6512007)(386003)(6506007)(53546011)(66066001)(59450400001)(6486002)(25786009)(84326002)(97736004)(270700001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR02MB1401;H:debian-thinkpad.localnet;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:0;LANG:en;
Received-SPF: None (protection.outlook.com: email.sc.edu does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR02MB1401;23:/bKBO0xSke7tALvM8EwEfGCG6WQR+n5nFOcFh6OrM?=
 =?us-ascii?Q?Ctq7/ZsGy3nNiGhdel1NxkAu+mN4cN+yseQdswwxHvtbFBSmI7fVgaUNDhM1?=
 =?us-ascii?Q?QiHLKh8I6sCiRKmx6+x5BvGu8sYoBCdGgQzMJRz09NjSlkyljxcXKQcsT6F3?=
 =?us-ascii?Q?1hRJrNK+ZBSXZC5uckFsMmr7I8UCiznYVgaBYlpon7av3wX7uT+ZFU2yy5er?=
 =?us-ascii?Q?3p2ccJU34x/RC7FKBKNYrD7BTgU8LlTlnTP+gsHGbPBV4vz7T+S5crkEnS1N?=
 =?us-ascii?Q?wGWEhso+EZ/kqaopoGzoFHlzeRw3IUjBR4iEUbRrg9ClyQtbkmDznVqvS+Nu?=
 =?us-ascii?Q?ERzJeZfNdoiPogQDSa6kiG7+DTU3mKA6D0GLXxTRrv2CZG8JzUEQ8mUmlWIh?=
 =?us-ascii?Q?nB7rRxwlrTI8Q3lk1Hl0UsWIgFrSaTDV+LX5FFpVYvBOVEZLuFCflVzfi8g9?=
 =?us-ascii?Q?jElHLtY+NC69m7DKNBmfnxo3g2sEDNYSIgH9mvkrTzDY17qmEWntFlXKipdm?=
 =?us-ascii?Q?gkMQcgxyoIV87ByBlceo6wb94sH0KNDBe1fEbRS/CXV8lSYmEmXrzg7ww+OT?=
 =?us-ascii?Q?Epv07h3G7fwMgRnmW7wcKpZeGSfRSIhjifsSZ4dwr1g86SykZ2X0z/Jci3z6?=
 =?us-ascii?Q?yJ51ayUYi31UChxcnH89xouryaUK7SLfTO4WWL64dM9y8tztMKU8ZuO+vKYK?=
 =?us-ascii?Q?A/D5J5nDo2Skwv3r7UsFVjQwJTuhGaS6MhW4r/vcp3KKBgJ+yEYSmYfW98CV?=
 =?us-ascii?Q?RAoXtKLaM/fICI87mwGG02Vc1v5a1SZVMsN8zZ5R+6yzAL2kZSonAUzL6uRI?=
 =?us-ascii?Q?RrcZBLqPRP2g4DG8exzNH6bD2qgpc3XvZtkxgdF3jgpHKpWIutxV2h41tj95?=
 =?us-ascii?Q?/NtB74Xz05JP/Dz3No+PnNqxkpqBaM4AAe99B+fhf59Z7d33rMMM3O9sdUGJ?=
 =?us-ascii?Q?fAPReuznhU2J52hU3h85BariITL44gnTe+SSMkchfCUZszNgtpl4+t3rvIIK?=
 =?us-ascii?Q?UlQ1BzbrzC8j8GlTIdGf0PiMXsdxL8E2tgg/8cD4oLau6Yur7iNyxUfNDX4v?=
 =?us-ascii?Q?z0qcgUQn0979NUr5qx3vnYb7i6zUea+iW8MUFtq5Q0wRe/g2L/L0DiArlijq?=
 =?us-ascii?Q?zLTknfpue4YsZjFUrBqOsRX7JGTRiHoilk9qSwijBWsk4zTA1kgAtdO3s9wC?=
 =?us-ascii?Q?9bH//Xd675K7yZB2JCkT/MAStiNRWoJIEaWNJn3PP9r1x/qBJyioxxKtG7wg?=
 =?us-ascii?Q?SGUqkvIDKdkcZVqZukzQyt/exKa7EXa/88HhpeDFNjOkPGKZnRrd4u4EPDJG?=
 =?us-ascii?Q?MI4GnIxidoy3HXhmaRvk3gOap8LcWNQk3CjlahwD36GUFcIH67hw8+XiR/WL?=
 =?us-ascii?Q?ZPtPg=3D=3D?=
X-Microsoft-Antispam-Message-Info: FEGG0BerhXvs4FCG+EXln46dPwggPpw0PYZkTtZndZoqBefX4sjG6IeNAiPv5AQparR9cf0Z0DtC6pdaN1LpJU0sYi0Y2XgXVE/K5HFVq3RaMxfFoZqs5EL4C6702NuBGWOj87+4Ojkq74kQwm3IDQ87fq5JcuuC9xJUZFqxo7BddCdqkdhEmkcrWjKhHvsn
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB1401;6:Mn/HmuUZlOAuSSR/96MxA84JLgJQxj+XMsysLGlBcBdOtxgX23M31+eIIYLBW21I/Lh9/F8ZZgbdO1BQiSiC0JT68X6lLf8v8B9XhjXUv17aktMJQB4yZhe+tiSIhjEqogpGfNvYvBsAQbxcY3BhljHsFBYWM/ZLprkDzxCnbzTWrMF8HJkv2h1X4DCgVTgLa6+Y5T86eXLOelaTH/ZU4/R3Bh+nZp982tGGhk5zVyj28PitXg14TBYElClT+cUfeyrxTxe+Z5TXMIbe8fJkazjchQfPsUuq7isPLC7+dt4DpS86md/kNkFQbm+JqS1vohRj73CkwYnpFVp3nc5ifiyjEqB5vv39z1Pp6DdMbQY=;5:gqsDuDxg95MYl42LQNcWUkJUqeNIij8TANXev1sRvVw0iGgb0T6Iap4RwgF+cjSdR1XdIKT2cBgKp/p6ixoxjqLTZfVl3RK2B4C/8Zw8WF9+Vnuma4LI+a4Mi2LkjDN2FBU3wNKEIM1i93xxivD4WZqHvyLEhZLFpFe1mD15csM=;24:qAtk+UjZHhNUQp+D7CSMEIy5gB708wY1j0feZ8oPYbMR/brzxN48d31N7sW2qPuL1vE+FfnULoJ7T8PHzDdAObVe3RLCEUK3Xath8BdCwZc=;7:AiY7FQg7kttAMNaj9nuXotTzYdOekzI8ngD3bhLxEFPwMatINs25aEGCZdIv6w635CBWL47M1pf7SPupdHjEOchreckHH7NuK33S6JYh1RW1pfrorBocKLBUCxcmLIrGEdaJyjlXrCj8fuvoCIJ7dBSZZ/z2gP/DZWCZkphP5gO40BWcKP7DLw8QZ4gRVuFYJCA9DcTokLl+p+cTPVDymv84rCCC8wzarMkiKjUb9GJhQphT85xvsS0MIJrn66zo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: email.sc.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2018 23:46:55.3482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c0539b-0582-4920-f432-08d587aa5f36
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2a4b19-d135-420e-8bb2-b1cd238998cc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR02MB1401
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--nextPart3018720.kKJ53NVZ5j
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

I like having machine-specific config in ~/.config/git, I think I'll do that. I 
didn't realize you could forward gpg-agent over a connection, I may look 
further into that.

Thanks for the help!

Joshua Nelson

On Sunday, March 11, 2018 17:21:42 EDT brian m. carlson wrote:
> On Sat, Mar 10, 2018 at 03:28:43PM +0000, NELSON, JOSHUA Y wrote:
> > Currently, `commit.gpgsign` allows you to give either 'true' or 'false' as
> > a value. If the key is not present, commits will fail:
> > 
> > ```sh
> > $ git commit -m "example"
> > error: gpg failed to sign the data
> > fatal: failed to write commit object
> > ```
> > 
> > I like to reuse my config file across several machines, some of which do
> > not have my GPG key. Would it be possible to add an option to sign the
> > commit only if the private key for `user.signingkey` is present? It could
> > be named something like `commit.gpgsign=default-yes`.
> Unfortunately, this isn't always possible.  You can forward the Unix
> socket for the agent over an SSH connection, at which point the remote
> machine has the ability to sign, but the gpg client doesn't list those
> as existing secret keys in its output (because technically, those keys
> don't exist on the remote system).  I use this technique at work, for
> example, to sign things on my development VM.
> 
> It might be possible to make the failure of the signing operation not be
> fatal in this case, although that could cause people to fail to sign due
> to transient failures even when the key is present on the system.
> 
> I usually handle this by storing my main configuration in ~/.gitconfig
> and on machines where I have a key, additionally having a
> ~/.config/git/config file that contains the commit.gpgsign entry.
> --
> brian m. carlson / brian with sandals: Houston, Texas, US
> https://www.crustytoothpaste.net/~bmc | My opinion only
> OpenPGP: https://keybase.io/bk2204

--nextPart3018720.kKJ53NVZ5j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEqDOwG0S92h7oDiYc5lWCPY2LEIgFAlqlv+MACgkQ5lWCPY2L
EIhYoQ/9EERGjNlos6ggiCsBQh6mlzy1tazUbvBagLPDRq/llRYWrM8V3jqlYH7c
4OESlFM+i5DKREn7Fhu6BG8dsd2W61wvPzEngPoxULLS3+q2iJfsDdB/6TutOUT4
zvf22vdLt8UyokXw5Hqt089PbwoKbzMFgaFXh29j60BoAnTBs1inyhb0cS3H+yS6
VSWKA41BdT6RgJ+O8hlvNGrIIpbz3HYPo470aDUcIL31nzbCuN+jFbQB4niokGKh
7S5A8BhnYAHfw0E8Pt3n6Qk4nqhVZAiK2V3RRfaYibjN/Mv2tuCMI3meEZq2ftPW
c7QvWI8VOHHnMW1GyA83D3O8I/l6QUhOVZRIflAIjyXxQ5BZEA79ZBo0mHHSUca5
Ok9Vo9XlBwK6XI15YnOPlM7zgmFbe+Gjy58pY11egrAWz4TQ0EJ+iU2voNNV0+xs
vDFJphUQX0e6KCyKDa1JxNFnScWTnLM+LjZdqLGgfb922HDw/EsRKP8b12G+iVT9
H8x9exEEt/plkSspdyb2ySTCu+b6kzATaxcGMa1MRlWmBBE+Zsnp59D6ti/tRdld
01u3r6PWphSXGc3JXJIzLsVpwvfroCsb+XJUXUtJJeXemYIPyfW9T7Zk5XsS6+Wz
dN/7xESkhL3G/cw2WTZcyRfLjoPSdxqpT3Z+cQG0hHv7l02sn3s=
=E9dm
-----END PGP SIGNATURE-----

--nextPart3018720.kKJ53NVZ5j--
