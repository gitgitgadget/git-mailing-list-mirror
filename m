Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5E751F597
	for <e@80x24.org>; Fri,  3 Aug 2018 08:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbeHCKPy (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 06:15:54 -0400
Received: from smtppost.atos.net ([193.56.114.166]:18583 "EHLO
        smtppost.atos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbeHCKPx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 06:15:53 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Aug 2018 06:15:44 EDT
Received: from mail1-ext.my-it-solutions.net (mail1-ext.my-it-solutions.net) by smarthost6.atos.net with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 49ae_0438_a37ba49a_6435_4465_9036_a2ca1ddb9eab;
        Fri, 03 Aug 2018 10:13:18 +0200
Received: from mail2-int.my-it-solutions.net ([10.92.32.13])
        by mail1-ext.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id w738DH1w011647
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Aug 2018 10:13:17 +0200
Received: from DEFTHW99ETVMSX.ww931.my-it-solutions.net ([10.86.142.50])
        by mail2-int.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id w738DGRO007431
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Aug 2018 10:13:17 +0200
Received: from DEERLM99ETUMSX.ww931.my-it-solutions.net (10.86.142.96) by
 DEFTHW99ETVMSX.ww931.my-it-solutions.net (10.86.142.50) with Microsoft SMTP
 Server (TLS) id 14.3.389.1; Fri, 3 Aug 2018 10:13:16 +0200
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (10.86.142.137)
 by hybridsmtp.it-solutions.atos.net (10.86.142.96) with Microsoft SMTP Server
 (TLS) id 14.3.389.1; Fri, 3 Aug 2018 10:13:16 +0200
Received: from AM0PR02MB3715.eurprd02.prod.outlook.com (52.133.63.148) by
 AM0PR02MB3763.eurprd02.prod.outlook.com (52.133.63.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Fri, 3 Aug 2018 08:13:15 +0000
Received: from AM0PR02MB3715.eurprd02.prod.outlook.com
 ([fe80::7990:3106:8ac2:3ff9]) by AM0PR02MB3715.eurprd02.prod.outlook.com
 ([fe80::7990:3106:8ac2:3ff9%2]) with mapi id 15.20.1017.010; Fri, 3 Aug 2018
 08:13:15 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     =?iso-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
CC:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 6/6] parse-options: automatically infer
 PARSE_OPT_LITERAL_ARGHELP
Thread-Topic: [PATCH 6/6] parse-options: automatically infer
 PARSE_OPT_LITERAL_ARGHELP
Thread-Index: AQHUKpWnel6c5NPVeUau1/pUmDvXeKStrimD
Date:   Fri, 3 Aug 2018 08:13:15 +0000
Message-ID: <AM0PR02MB371539182CB9D1FD201D1CAF9C230@AM0PR02MB3715.eurprd02.prod.outlook.com>
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
 <87k1p9u860.fsf@evledraar.gmail.com>
 <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
 <87h8kdu3ay.fsf@evledraar.gmail.com>
 <30a6105c-4cb7-b52f-0b0a-c4504b90a5b1@web.de>
 <xmqqftzw4weq.fsf@gitster-ct.c.googlers.com>
 <20180802165457.GC15984@sigill.intra.peff.net>
 <ad2d8f99-07a3-0191-88a2-c43081657988@web.de>,<757ca573-3954-9c31-8a7b-56a2de8e3793@web.de>
In-Reply-To: <757ca573-3954-9c31-8a7b-56a2de8e3793@web.de>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=richard.kerry@atos.net; 
x-originating-ip: [212.56.108.147]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR02MB3763;6:KMCyw5Bot0UrFoUQNJ052uPrL5BE8uaUXA8y7mCVco+b1XK4ji/6dQhrBpR3zeOsZ7bq6dbLSK5wa31/zA2WSQIc6Q9O7bda+bE6ohoq/TjSxklNy9TsZDLxsLYF3FY/ySDkw2d2ZFNJZt94GDTgkeTu6DjDFDRFDTEDF9DFjmfxFC9OXr4ymnrxIcuY5VKY4o7VMNJMVLeyQuTSYpJKu+NpZwUaeBABqScCr0nNfA/l3HLTxw6YmVXMImvx93d3rTaW6ZykysCHkSFZir2k/e4+yB+T8rzf8FEvJKyo0+uN5r58R8nDi0nKpa3dFfO7iTp59+8iq5bNrBsxncK4BsCB29UvmvgqGj5qcaMspAh/E7Fxio5bBML+pJ6cbl/EA8PRCxV5zYVmfqg27svhJgwMwi9T9SGyNd7iY+PS3+z1iu6VBknETxmXB+oUFBXH+fAguYPudATT1TyyyPwv6g==;5:5bLwToh71UJIrHKVtS61CQKNP/ImpyKndgBB21LEBEPYRpDO2au0+/FFspPRSclqXbHecUo04YrAD/a9is13zJNuslqp1CG7tBcvbtgcEvnGvRFS5X6OvYGP8sUFVYa0SuUPBQlWIqZyYP/K5YZPs1eFqvK33FnvSoSitSzEaCQ=;7:6xwKm/e8UcoHzemq5nH+5LFVVsrUR3hssgIOVUzSbzYlN7t6NIIZ57HEEVDS0DI2vwQu4aUgRI60oY3l0YC08YsO5uhAO0pLyVNvXGYGr9PR3xCaKjRPnq80OJ/proeW/tx3g4Grqyiu9nIEbfsM27dy7zTpZ1Kk7CT158TBFMuhMJISJPQsKoGWhgbyq4IVqgPfaKmM+wlv09Dgrf5pkgueN4K5SaOd1gd3BUwY5QkyuWAkN5qpKTBPxQwB6hQ+
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f17fa1ab-1327-4ca8-5849-08d5f918f66d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR02MB3763;
x-ms-traffictypediagnostic: AM0PR02MB3763:
x-microsoft-antispam-prvs: <AM0PR02MB37631614BB3551429959F3F49C230@AM0PR02MB3763.eurprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(164563717011359)(9452136761055)(244887542470375)(788757137089)(245156298449039);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR02MB3763;BCL:0;PCL:0;RULEID:;SRVR:AM0PR02MB3763;
x-forefront-prvs: 0753EA505A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(366004)(376002)(346002)(396003)(199004)(189003)(39060400002)(7736002)(4326008)(446003)(25786009)(14454004)(11346002)(74316002)(5660300001)(66066001)(8936002)(2900100001)(81156014)(478600001)(8676002)(33656002)(81166006)(5250100002)(256004)(14444005)(5024004)(19627405001)(68736007)(53936002)(6246003)(106356001)(186003)(229853002)(6306002)(105586002)(86362001)(7696005)(54896002)(54906003)(316002)(486006)(476003)(99286004)(110136005)(6436002)(102836004)(6506007)(6606003)(55016002)(97736004)(76176011)(606006)(93886005)(9686003)(53546011)(6116002)(26005)(236005)(3846002)(2906002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR02MB3763;H:AM0PR02MB3715.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: atos.net does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XIEcU45vBRVi2ypm0bEFtsMvyNDcG7AOb/+FvVE+3WXHuo8b18JCjuT2HG7rKKgS8opSO9ulp52wnY8PkANMROFwto2/fN2hQJIFEbVgEVWvuKfX7NEBQ4bH+9nGSjr923N0pkQwq0jEzIMJKDf1GzjmQgZbSsp0lYoQ5wqGXu37RLpbKIY/VKjNQTPKIg0XD2vxwznWfviHZ8sRcYVSSRxFGaRNWrxUDxH7Twy3tZooDhPMAGgh+ypa7/cmdXZMYiBymJfojwFpHPWuR7M8E2vbSeyV4KT9yor3LA4NwHVK5uBlVnH8+kNtu4BPh2OXQ6L0uNH2DFdgpu3axqx1c20NKr8c8AWAUzRvzbOCK2s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/alternative;
        boundary="_000_AM0PR02MB371539182CB9D1FD201D1CAF9C230AM0PR02MB3715eurp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f17fa1ab-1327-4ca8-5849-08d5f918f66d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2018 08:13:15.0714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB3763
X-OriginatorOrg: atos.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--_000_AM0PR02MB371539182CB9D1FD201D1CAF9C230AM0PR02MB3715eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


s/angular brackets/angle brackets/



I've never seen these called "angular brackets".


Richard Kerry
BNCS Engineer, SI SOL Telco & Media Vertical Practice
M: +44 (0)7812 325518
2nd Floor, MidCity Place, 71 High Holborn, London, WC1V 6EA
richard.kerry@atos.net<https://webmail.siemens-it-solutions.com/owa/redir.a=
spx?C=3D9fb20d019e3e4cb99344d708709a3177&URL=3Dmailto%3arichard.kerry%40ato=
s.net>

This e-mail and the documents attached are confidential and intended solely=
 for the addressee; it may also be privileged. If you receive this e-mail i=
n error, please notify the sender immediately and destroy it. As its integr=
ity cannot be secured on the Internet, the Atos group liability cannot be t=
riggered for the message content. Although the sender endeavours to maintai=
n a computer virus-free network, the sender does not warrant that this tran=
smission is virus-free and will not be liable for any damages resulting fro=
m any virus transmitted.


________________________________
From: git-owner@vger.kernel.org <git-owner@vger.kernel.org> on behalf of Re=
n=E9 Scharfe <l.s.r@web.de>
Sent: 02 August 2018 20:18
To: Jeff King; Junio C Hamano
Cc: =C6var Arnfj=F6r=F0 Bjarmason; git@vger.kernel.org
Subject: [PATCH 6/6] parse-options: automatically infer PARSE_OPT_LITERAL_A=
RGHELP

Parseopt wraps argument help strings in a pair of angular brackets by
default, to tell users that they need to replace it with an actual
value.  This is useful in most cases, because most option arguments
are indeed single values of a certain type.  The option
PARSE_OPT_LITERAL_ARGHELP needs to be used in option definitions with
arguments that have multiple parts or are literal strings.

Stop adding these angular brackets if special characters are present,
as they indicate that we don't deal with a simple placeholder.  This
simplifies the code a bit and makes defining special options slightly
easier.

Remove the flag PARSE_OPT_LITERAL_ARGHELP in the cases where the new
and more cautious handling suffices.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
The patch to add PARSE_OPT_LITERAL_ARGHELP for push --force-with-lease
should be applied before this one.

 builtin/add.c          | 5 ++---
 builtin/pack-objects.c | 2 +-
 builtin/read-tree.c    | 2 +-
 builtin/send-pack.c    | 3 +--
 builtin/shortlog.c     | 3 +--
 builtin/show-branch.c  | 2 +-
 builtin/update-index.c | 2 +-
 builtin/write-tree.c   | 5 ++---
 parse-options.c        | 3 ++-
 9 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 84bfec9b73..ba1ff5689d 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -304,9 +304,8 @@ static struct option builtin_add_options[] =3D {
         OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refres=
h the index")),
         OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip f=
iles which cannot be added because of errors")),
         OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - ev=
en missing - files are ignored in dry run")),
-       { OPTION_STRING, 0, "chmod", &chmod_arg, "(+|-)x",
-         N_("override the executable bit of the listed files"),
-         PARSE_OPT_LITERAL_ARGHELP },
+       OPT_STRING(0, "chmod", &chmod_arg, "(+|-)x",
+                  N_("override the executable bit of the listed files")),
         OPT_HIDDEN_BOOL(0, "warn-embedded-repo", &warn_on_embedded_repo,
                         N_("warn when adding an embedded repository")),
         OPT_END(),
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3a5d1fa317..b2323613bc 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3112,7 +3112,7 @@ int cmd_pack_objects(int argc, const char **argv, con=
st char *prefix)
                          N_("similar to --all-progress when progress meter=
 is shown")),
                 { OPTION_CALLBACK, 0, "index-version", NULL, N_("<version>=
[,<offset>]"),
                   N_("write the pack index file in the specified idx forma=
t version"),
-                 PARSE_OPT_LITERAL_ARGHELP, option_parse_index_version },
+                 0, option_parse_index_version },
                 OPT_MAGNITUDE(0, "max-pack-size", &pack_size_limit,
                               N_("maximum size of each output pack file"))=
,
                 OPT_BOOL(0, "local", &local,
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index ebc43eb805..fbbc98e516 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -133,7 +133,7 @@ int cmd_read_tree(int argc, const char **argv, const ch=
ar *unused_prefix)
                          N_("same as -m, but discard unmerged entries")),
                 { OPTION_STRING, 0, "prefix", &opts.prefix, N_("<subdirect=
ory>/"),
                   N_("read the tree into the index under <subdirectory>/")=
,
-                 PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP },
+                 PARSE_OPT_NONEG },
                 OPT_BOOL('u', NULL, &opts.update,
                          N_("update working tree with merge result")),
                 { OPTION_CALLBACK, 0, "exclude-per-directory", &opts,
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 0b517c9368..724b484850 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -180,8 +180,7 @@ int cmd_send_pack(int argc, const char **argv, const ch=
ar *prefix)
                 { OPTION_CALLBACK,
                   0, CAS_OPT_NAME, &cas, N_("<refname>:<expect>"),
                   N_("require old value of ref to be at this value"),
-                 PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
-                 parseopt_push_cas_option },
+                 PARSE_OPT_OPTARG, parseopt_push_cas_option },
                 OPT_END()
         };

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index f555cf9e4f..3898a2c9c4 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -269,8 +269,7 @@ int cmd_shortlog(int argc, const char **argv, const cha=
r *prefix)
                 OPT_BOOL('e', "email", &log.email,
                          N_("Show the email address of each author")),
                 { OPTION_CALLBACK, 'w', NULL, &log, N_("<w>[,<i1>[,<i2>]]"=
),
-                       N_("Linewrap output"),
-                       PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
+                       N_("Linewrap output"), PARSE_OPT_OPTARG,
                         &parse_wrap_args },
                 OPT_END(),
         };
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index f2e985c00a..9106da1985 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -673,7 +673,7 @@ int cmd_show_branch(int ac, const char **av, const char=
 *prefix)
                 { OPTION_CALLBACK, 'g', "reflog", &reflog_base, N_("<n>[,<=
base>]"),
                             N_("show <n> most recent ref-log entries start=
ing at "
                                "base"),
-                           PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
+                           PARSE_OPT_OPTARG,
                             parse_reflog_param },
                 OPT_END()
         };
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 7feda6e271..293f59247b 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -973,7 +973,7 @@ int cmd_update_index(int argc, const char **argv, const=
 char *prefix)
                         (parse_opt_cb *) cacheinfo_callback},
                 {OPTION_CALLBACK, 0, "chmod", &set_executable_bit, "(+|-)x=
",
                         N_("override the executable bit of the listed file=
s"),
-                       PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
+                       PARSE_OPT_NONEG,
                         chmod_callback},
                 {OPTION_SET_INT, 0, "assume-unchanged", &mark_valid_only, =
NULL,
                         N_("mark files as \"not changing\""),
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index c9d3c544e7..cdcbf8264e 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -24,9 +24,8 @@ int cmd_write_tree(int argc, const char **argv, const cha=
r *unused_prefix)
         struct option write_tree_options[] =3D {
                 OPT_BIT(0, "missing-ok", &flags, N_("allow missing objects=
"),
                         WRITE_TREE_MISSING_OK),
-               { OPTION_STRING, 0, "prefix", &prefix, N_("<prefix>/"),
-                 N_("write tree object for a subdirectory <prefix>") ,
-                 PARSE_OPT_LITERAL_ARGHELP },
+               OPT_STRING(0, "prefix", &prefix, N_("<prefix>/"),
+                          N_("write tree object for a subdirectory <prefix=
>")),
                 { OPTION_BIT, 0, "ignore-cache-tree", &flags, NULL,
                   N_("only useful for debugging"),
                   PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, NULL,
diff --git a/parse-options.c b/parse-options.c
index 7db84227ab..3b874a83a0 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -660,7 +660,8 @@ int parse_options(int argc, const char **argv, const ch=
ar *prefix,
 static int usage_argh(const struct option *opts, FILE *outfile)
 {
         const char *s;
-       int literal =3D (opts->flags & PARSE_OPT_LITERAL_ARGHELP) || !opts-=
>argh;
+       int literal =3D (opts->flags & PARSE_OPT_LITERAL_ARGHELP) ||
+               !opts->argh || !!strpbrk(opts->argh, "()<>[]|");
         if (opts->flags & PARSE_OPT_OPTARG)
                 if (opts->long_name)
                         s =3D literal ? "[=3D%s]" : "[=3D<%s>]";
--
2.18.0
Atos, Atos Consulting, Worldline and Canopy The Open Cloud Company are trad=
ing names used by the Atos group. The following trading entities are regist=
ered in England and Wales: Atos IT Services UK Limited (registered number 0=
1245534), Atos Consulting Limited (registered number 04312380), Atos Worldl=
ine UK Limited (registered number 08514184) and Canopy The Open Cloud Compa=
ny Limited (registration number 08011902). The registered office for each i=
s at Second Floor, Mid City Place, 71 High Holborn, London, WC1V 6EA.  The =
VAT No. for each is: GB232327983.

This e-mail and the documents attached are confidential and intended solely=
 for the addressee, and may contain confidential or privileged information.=
 If you receive this e-mail in error, you are not authorised to copy, discl=
ose, use or retain it. Please notify the sender immediately and delete this=
 email from your systems. As emails may be intercepted, amended or lost, th=
ey are not secure. Atos therefore can accept no liability for any errors or=
 their content. Although Atos endeavours to maintain a virus-free network, =
we do not warrant that this transmission is virus-free and can accept no li=
ability for any damages resulting from any virus transmitted. The risks are=
 deemed to be accepted by everyone who communicates with Atos by email.

--_000_AM0PR02MB371539182CB9D1FD201D1CAF9C230AM0PR02MB3715eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">s/angular brackets/angle brackets=
/</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">I've never seen these called &quo=
t;angular brackets&quot;.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<div id=3D"Signature">
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size: 12pt; colo=
r: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif, EmojiFont, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;">
<div style=3D"font-size:13px; font-family:Tahoma">
<p class=3D"MsoNormal" align=3D"left" style=3D"margin:0cm 0cm 0pt"></p>
<div style=3D"font-size:13px; font-family:Tahoma">
<div></div>
<div align=3D"left"></div>
<p class=3D"MsoNormal" align=3D"left" style=3D"margin:3pt 0cm 0pt"><b><span=
 style=3D"font-size:9pt; font-family:Verdana"><font size=3D"1">Richard Kerr=
y</font></span></b></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"margin:0cm 0cm 0pt"><span st=
yle=3D"font-size:8pt; font-family:Verdana"><font size=3D"1">BNCS Engineer</=
font></span><span style=3D"font-size:8pt; font-family:Verdana"><span style=
=3D"font-size:8pt">, SI SOL Telco &amp; Media Vertical
 Practice</span></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"margin:0cm 0cm 0pt"><span st=
yle=3D"font-size:8pt; font-family:Verdana"><font size=3D"1"></font></span><=
/p>
<span style=3D"font-size:8pt; font-family:Verdana">
<p class=3D"MsoNormal" align=3D"left" style=3D"margin:0cm 0cm 0pt"><span st=
yle=3D"font-size:x-small">M: &#43;44 (0)7812 325518</span><br>
</p>
<p class=3D"MsoNormal" align=3D"left" style=3D"margin:0cm 0cm 0pt"><font si=
ze=3D"1">2nd Floor, MidCity Place, 71 High Holborn, London, WC1V 6EA</font>=
</p>
<p class=3D"MsoNormal" align=3D"left" style=3D"margin:0cm 0cm 0pt"><span st=
yle=3D"font-size:8pt; font-family:Verdana"><a tabindex=3D"0" href=3D"https:=
//webmail.siemens-it-solutions.com/owa/redir.aspx?C=3D9fb20d019e3e4cb99344d=
708709a3177&amp;URL=3Dmailto%3arichard.kerry%40atos.net" target=3D"_blank" =
id=3D"LPNoLP">richard.kerry@atos.net</a></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"margin:0cm 0cm 0pt"><span st=
yle=3D"font-size:8pt; font-family:Verdana"><font size=3D"1" face=3D"Arial">=
<span style=3D"font-size:11pt; font-family:Arial"></span></font></span>&nbs=
p;</p>
<p class=3D"MsoNormal" align=3D"left" style=3D"margin:0cm 0cm 0pt"><font si=
ze=3D"1"><span style=3D"font-size:8pt; font-family:Verdana"></span><span st=
yle=3D"font-size:8pt; font-family:Verdana"></span></font></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"margin:0cm 0cm 6pt"><span st=
yle=3D"font-size:8pt; font-family:Verdana"></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"margin:0cm 0cm 6pt"><span st=
yle=3D"font-size:8pt; font-family:Verdana"></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"margin:0cm 0cm 6pt"><span st=
yle=3D"font-size:8pt; font-family:Verdana"></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"margin:0cm 0cm 6pt"><span st=
yle=3D"font-size:8pt; font-family:Verdana"></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"margin:0cm 0cm 6pt"><span st=
yle=3D"font-size:8pt; font-family:Verdana"></span></p>
<div>
<p class=3D"MsoNormal" align=3D"left" style=3D"margin:5pt 0cm; line-height:=
10pt"><span style=3D"font-size:8pt; font-family:Verdana">This e-mail and th=
e documents attached are confidential and intended solely for the addressee=
; it may also be privileged. If you receive
 this e-mail in error, please notify the sender immediately and destroy it.=
 As its integrity cannot be secured on the Internet, the Atos group liabili=
ty cannot be triggered for the message content. Although the sender endeavo=
urs to maintain a computer virus-free
 network, the sender does not warrant that this transmission is virus-free =
and will not be liable for any damages resulting from any virus transmitted=
.</span><span style=3D"font-family:Verdana"></span></p>
</div>
</span></div>
</div>
</div>
</div>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> git-owner@vger.kernel=
.org &lt;git-owner@vger.kernel.org&gt; on behalf of Ren=E9 Scharfe &lt;l.s.=
r@web.de&gt;<br>
<b>Sent:</b> 02 August 2018 20:18<br>
<b>To:</b> Jeff King; Junio C Hamano<br>
<b>Cc:</b> =C6var Arnfj=F6r=F0 Bjarmason; git@vger.kernel.org<br>
<b>Subject:</b> [PATCH 6/6] parse-options: automatically infer PARSE_OPT_LI=
TERAL_ARGHELP</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Parseopt wraps argument help strings in a pair of =
angular brackets by<br>
default, to tell users that they need to replace it with an actual<br>
value.&nbsp; This is useful in most cases, because most option arguments<br=
>
are indeed single values of a certain type.&nbsp; The option<br>
PARSE_OPT_LITERAL_ARGHELP needs to be used in option definitions with<br>
arguments that have multiple parts or are literal strings.<br>
<br>
Stop adding these angular brackets if special characters are present,<br>
as they indicate that we don't deal with a simple placeholder.&nbsp; This<b=
r>
simplifies the code a bit and makes defining special options slightly<br>
easier.<br>
<br>
Remove the flag PARSE_OPT_LITERAL_ARGHELP in the cases where the new<br>
and more cautious handling suffices.<br>
<br>
Signed-off-by: Rene Scharfe &lt;l.s.r@web.de&gt;<br>
---<br>
The patch to add PARSE_OPT_LITERAL_ARGHELP for push --force-with-lease<br>
should be applied before this one.<br>
<br>
&nbsp;builtin/add.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
 5 &#43;&#43;---<br>
&nbsp;builtin/pack-objects.c | 2 &#43;-<br>
&nbsp;builtin/read-tree.c&nbsp;&nbsp;&nbsp; | 2 &#43;-<br>
&nbsp;builtin/send-pack.c&nbsp;&nbsp;&nbsp; | 3 &#43;--<br>
&nbsp;builtin/shortlog.c&nbsp;&nbsp;&nbsp;&nbsp; | 3 &#43;--<br>
&nbsp;builtin/show-branch.c&nbsp; | 2 &#43;-<br>
&nbsp;builtin/update-index.c | 2 &#43;-<br>
&nbsp;builtin/write-tree.c&nbsp;&nbsp; | 5 &#43;&#43;---<br>
&nbsp;parse-options.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 3 &#43;&#=
43;-<br>
&nbsp;9 files changed, 12 insertions(&#43;), 15 deletions(-)<br>
<br>
diff --git a/builtin/add.c b/builtin/add.c<br>
index 84bfec9b73..ba1ff5689d 100644<br>
--- a/builtin/add.c<br>
&#43;&#43;&#43; b/builtin/add.c<br>
@@ -304,9 &#43;304,8 @@ static struct option builtin_add_options[] =3D {<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OPT_BOOL( 0 , &quot;refres=
h&quot;, &amp;refresh_only, N_(&quot;don't add, only refresh the index&quot=
;)),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OPT_BOOL( 0 , &quot;ignore=
-errors&quot;, &amp;ignore_add_errors, N_(&quot;just skip files which canno=
t be added because of errors&quot;)),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OPT_BOOL( 0 , &quot;ignore=
-missing&quot;, &amp;ignore_missing, N_(&quot;check if - even missing - fil=
es are ignored in dry run&quot;)),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { OPTION_STRING, 0, &quot;chmod&quot;=
, &amp;chmod_arg, &quot;(&#43;|-)x&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; N_(&quot;override the exe=
cutable bit of the listed files&quot;),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PARSE_OPT_LITERAL_ARGHELP=
 },<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OPT_STRING(0, &quot;chmod&quot;, =
&amp;chmod_arg, &quot;(&#43;|-)x&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; N_(&quot;override the executable bit of th=
e listed files&quot;)),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OPT_HIDDEN_BOOL(0, &quot;w=
arn-embedded-repo&quot;, &amp;warn_on_embedded_repo,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; N_(&q=
uot;warn when adding an embedded repository&quot;)),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OPT_END(),<br>
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c<br>
index 3a5d1fa317..b2323613bc 100644<br>
--- a/builtin/pack-objects.c<br>
&#43;&#43;&#43; b/builtin/pack-objects.c<br>
@@ -3112,7 &#43;3112,7 @@ int cmd_pack_objects(int argc, const char **argv,=
 const char *prefix)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 N_(&quot;similar to --all-progress when progress meter is shown&quot;)),<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; { OPTION_CALLBACK, 0, &quot;index-version&quot;, NULL=
, N_(&quot;&lt;version&gt;[,&lt;offset&gt;]&quot;),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; N_(&quot;write the pack index file in the=
 specified idx format version&quot;),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; PARSE_OPT_LITERAL_ARGHELP, option_parse_index_versio=
n },<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 0, option_parse_index_version },<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; OPT_MAGNITUDE(0, &quot;max-pack-size&quot;, &amp;pack=
_size_limit,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; N_(&quot;maximum size of each output pack fi=
le&quot;)),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; OPT_BOOL(0, &quot;local&quot;, &amp;local,<br>
diff --git a/builtin/read-tree.c b/builtin/read-tree.c<br>
index ebc43eb805..fbbc98e516 100644<br>
--- a/builtin/read-tree.c<br>
&#43;&#43;&#43; b/builtin/read-tree.c<br>
@@ -133,7 &#43;133,7 @@ int cmd_read_tree(int argc, const char **argv, cons=
t char *unused_prefix)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 N_(&quot;same as -m, but discard unmerged entries&quot;)),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; { OPTION_STRING, 0, &quot;prefix&quot;, &amp;opts.pre=
fix, N_(&quot;&lt;subdirectory&gt;/&quot;),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; N_(&quot;read the tree into the index und=
er &lt;subdirectory&gt;/&quot;),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP },<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; PARSE_OPT_NONEG },<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; OPT_BOOL('u', NULL, &amp;opts.update,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 N_(&quot;update working tree with merge result&quot;)),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; { OPTION_CALLBACK, 0, &quot;exclude-per-directory&quo=
t;, &amp;opts,<br>
diff --git a/builtin/send-pack.c b/builtin/send-pack.c<br>
index 0b517c9368..724b484850 100644<br>
--- a/builtin/send-pack.c<br>
&#43;&#43;&#43; b/builtin/send-pack.c<br>
@@ -180,8 &#43;180,7 @@ int cmd_send_pack(int argc, const char **argv, cons=
t char *prefix)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; { OPTION_CALLBACK,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0, CAS_OPT_NAME, &amp;cas, N_(&quot;&lt;r=
efname&gt;:&lt;expect&gt;&quot;),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; N_(&quot;require old value of ref to be a=
t this value&quot;),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; parseopt_push_cas_option },<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; PARSE_OPT_OPTARG, parseopt_push_cas_option },<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; OPT_END()<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&nbsp;<br>
diff --git a/builtin/shortlog.c b/builtin/shortlog.c<br>
index f555cf9e4f..3898a2c9c4 100644<br>
--- a/builtin/shortlog.c<br>
&#43;&#43;&#43; b/builtin/shortlog.c<br>
@@ -269,8 &#43;269,7 @@ int cmd_shortlog(int argc, const char **argv, const=
 char *prefix)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; OPT_BOOL('e', &quot;email&quot;, &amp;log.email,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 N_(&quot;Show the email address of each author&quot;)),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; { OPTION_CALLBACK, 'w', NULL, &amp;log, N_(&quot;&lt;=
w&gt;[,&lt;i1&gt;[,&lt;i2&gt;]]&quot;),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; N_(&quot;Linewra=
p output&quot;),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PARSE_OPT_OPTARG=
 | PARSE_OPT_LITERAL_ARGHELP,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; N_(&quot;Lin=
ewrap output&quot;), PARSE_OPT_OPTARG,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
parse_wrap_args },<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; OPT_END(),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
diff --git a/builtin/show-branch.c b/builtin/show-branch.c<br>
index f2e985c00a..9106da1985 100644<br>
--- a/builtin/show-branch.c<br>
&#43;&#43;&#43; b/builtin/show-branch.c<br>
@@ -673,7 &#43;673,7 @@ int cmd_show_branch(int ac, const char **av, const =
char *prefix)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; { OPTION_CALLBACK, 'g', &quot;reflog&quot;, &amp;refl=
og_base, N_(&quot;&lt;n&gt;[,&lt;base&gt;]&quot;),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; N_(&quot;show &lt;n&gt; most recent ref-log entries star=
ting at &quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;base&quot;),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; PARSE_OPT_OPTARG,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; parse_reflog_param },<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; OPT_END()<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
diff --git a/builtin/update-index.c b/builtin/update-index.c<br>
index 7feda6e271..293f59247b 100644<br>
--- a/builtin/update-index.c<br>
&#43;&#43;&#43; b/builtin/update-index.c<br>
@@ -973,7 &#43;973,7 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (pars=
e_opt_cb *) cacheinfo_callback},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; {OPTION_CALLBACK, 0, &quot;chmod&quot;, &amp;set_exec=
utable_bit, &quot;(&#43;|-)x&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; N_(&q=
uot;override the executable bit of the listed files&quot;),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PARSE_OPT_NONEG =
| PARSE_OPT_LITERAL_ARGHELP,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PARSE_OPT_NO=
NEG,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chmod=
_callback},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; {OPTION_SET_INT, 0, &quot;assume-unchanged&quot;, &am=
p;mark_valid_only, NULL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; N_(&q=
uot;mark files as \&quot;not changing\&quot;&quot;),<br>
diff --git a/builtin/write-tree.c b/builtin/write-tree.c<br>
index c9d3c544e7..cdcbf8264e 100644<br>
--- a/builtin/write-tree.c<br>
&#43;&#43;&#43; b/builtin/write-tree.c<br>
@@ -24,9 &#43;24,8 @@ int cmd_write_tree(int argc, const char **argv, const=
 char *unused_prefix)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct option write_tree_o=
ptions[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; OPT_BIT(0, &quot;missing-ok&quot;, &amp;flags, N_(&qu=
ot;allow missing objects&quot;),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE=
_TREE_MISSING_OK),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; { OPTION_STRING, 0, &quot;prefix&quot;, &amp;prefix, N_(&quot;&l=
t;prefix&gt;/&quot;),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; N_(&quot;write tree object for a subdirectory &lt;pr=
efix&gt;&quot;) ,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; PARSE_OPT_LITERAL_ARGHELP },<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; OPT_STRING(0, &quot;prefix&quot;, &amp;prefix, N_(&quot;&lt;=
prefix&gt;/&quot;),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; N_(&quot;write tree object for a subdirectory &lt;prefix&gt;&quot;)),=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; { OPTION_BIT, 0, &quot;ignore-cache-tree&quot;, &amp;=
flags, NULL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; N_(&quot;only useful for debugging&quot;)=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, NULL,=
<br>
diff --git a/parse-options.c b/parse-options.c<br>
index 7db84227ab..3b874a83a0 100644<br>
--- a/parse-options.c<br>
&#43;&#43;&#43; b/parse-options.c<br>
@@ -660,7 &#43;660,8 @@ int parse_options(int argc, const char **argv, cons=
t char *prefix,<br>
&nbsp;static int usage_argh(const struct option *opts, FILE *outfile)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *s;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int literal =3D (opts-&gt;flags &amp;=
 PARSE_OPT_LITERAL_ARGHELP) || !opts-&gt;argh;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int literal =3D (opts-&gt;flags &=
amp; PARSE_OPT_LITERAL_ARGHELP) ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; !opts-&gt;argh || !!strpbrk(opts-&gt;argh, &quot;()&lt;&gt;[=
]|&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (opts-&gt;flags &amp; P=
ARSE_OPT_OPTARG)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (opts-&gt;long_name)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s =3D=
 literal ? &quot;[=3D%s]&quot; : &quot;[=3D&lt;%s&gt;]&quot;;<br>
-- <br>
2.18.0<br>
</div>
</span></font></div>
</div>
</div>
Atos, Atos Consulting, Worldline and Canopy The Open Cloud Company are trad=
ing names used by the Atos group. The following trading entities are regist=
ered in England and Wales: Atos IT Services UK Limited (registered number 0=
1245534), Atos Consulting Limited
 (registered number 04312380), Atos Worldline UK Limited (registered number=
 08514184) and Canopy The Open Cloud Company Limited (registration number 0=
8011902). The registered office for each is at Second Floor, Mid City Place=
, 71 High Holborn, London, WC1V
 6EA.&nbsp; The VAT No. for each is: GB232327983. <br>
<br>
This e-mail and the documents attached are confidential and intended solely=
 for the addressee, and may contain confidential or privileged information.=
 If you receive this e-mail in error, you are not authorised to copy, discl=
ose, use or retain it. Please notify
 the sender immediately and delete this email from your systems. As emails =
may be intercepted, amended or lost, they are not secure. Atos therefore ca=
n accept no liability for any errors or their content. Although Atos endeav=
ours to maintain a virus-free network,
 we do not warrant that this transmission is virus-free and can accept no l=
iability for any damages resulting from any virus transmitted. The risks ar=
e deemed to be accepted by everyone who communicates with Atos by email.<br=
>
</body>
</html>

--_000_AM0PR02MB371539182CB9D1FD201D1CAF9C230AM0PR02MB3715eurp_--
