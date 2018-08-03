Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41A411F597
	for <e@80x24.org>; Fri,  3 Aug 2018 10:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732555AbeHCMe7 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 3 Aug 2018 08:34:59 -0400
Received: from smtppost.atos.net ([193.56.114.166]:29738 "EHLO
        smtppost.atos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730783AbeHCMe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 08:34:59 -0400
Received: from mail3-ext.my-it-solutions.net (mail3-ext.my-it-solutions.net) by smarthost4.atos.net with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 2958_3f7f_62e3717a_07c0_41a6_b61b_aeb605f9a966;
        Fri, 03 Aug 2018 12:39:11 +0200
Received: from mail3-int.my-it-solutions.net ([10.92.32.10])
        by mail3-ext.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id w73AdCqC026255
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Fri, 3 Aug 2018 12:39:12 +0200
Received: from DEERLM99ETQMSX.ww931.my-it-solutions.net ([10.86.142.102])
        by mail3-int.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id w73AdCfG028951
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Fri, 3 Aug 2018 12:39:12 +0200
Received: from DEFTHW99ETTMSX.ww931.my-it-solutions.net (10.86.142.101) by
 DEERLM99ETQMSX.ww931.my-it-solutions.net (10.86.142.102) with Microsoft SMTP
 Server (TLS) id 14.3.389.1; Fri, 3 Aug 2018 12:39:11 +0200
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (10.86.142.137)
 by hybridsmtp.it-solutions.atos.net (10.86.142.101) with Microsoft SMTP
 Server (TLS) id 14.3.389.1; Fri, 3 Aug 2018 12:39:11 +0200
Received: from AM0PR02MB3715.eurprd02.prod.outlook.com (52.133.63.148) by
 AM0PR02MB3796.eurprd02.prod.outlook.com (52.134.80.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Fri, 3 Aug 2018 10:39:10 +0000
Received: from AM0PR02MB3715.eurprd02.prod.outlook.com
 ([fe80::7990:3106:8ac2:3ff9]) by AM0PR02MB3715.eurprd02.prod.outlook.com
 ([fe80::7990:3106:8ac2:3ff9%2]) with mapi id 15.20.1017.010; Fri, 3 Aug 2018
 10:39:10 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 6/6] parse-options: automatically infer
 PARSE_OPT_LITERAL_ARGHELP
Thread-Topic: [PATCH 6/6] parse-options: automatically infer
 PARSE_OPT_LITERAL_ARGHELP
Thread-Index: AQHUKpWnel6c5NPVeUau1/pUmDvXeKSt1cpS
Date:   Fri, 3 Aug 2018 10:39:10 +0000
Message-ID: <AM0PR02MB37155300E283E58E3614E1899C230@AM0PR02MB3715.eurprd02.prod.outlook.com>
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
x-microsoft-exchange-diagnostics: 1;AM0PR02MB3796;6:Ux7uDP0HEHeeKGc111O/IG4KOcRLWRjAQ5NcpJ4ybe2fjKoDiXvttFR3Yaa0bkuuMakjt/AtZDZgNf20dNhXw52VDSFN1LcSm6u4CsNVYnn14OppDSneVxidKJhRb1uO+nHkF6oD/xS1F7h1RREqWylkTdPWWUASa0agn5U0AnS/pmxxbq51zN7XSgcz2lzV9eQBRjNhVtPXzaQ29L544YgyZQknt/K4vQ5n8ai8gr7++FN1qstGw30Zpb+8028mCzWRmnLNYyxIux9swrYf6E3eiepm8S/pmFR/STCHddNw1NpBQBO68Rr1yFQhDkNFZq3RLyK0t6KlZV+o4Q8kfdq6tvgxwKbpJiJ/6ojonh+pBd2MIzAN7rH1G9COjaI3wBJ4DWzTsGfGqQR3De+neHInVu8TidXk0DtWXS07HXMQvLswqCNGt4KmaqhgeweJYbpdAcNAT0FOXIt8vcfocQ==;5:8IeDaJ8svKA7BoqRvAJ666xM/QXw5rCXd+onRUgCeL31yWx3RWtq6HLNJ9owwbXk2ZNYCHhtJGCk9pWeVINsDct7pDA6k7u+DoxG05myBoyJgoGPtC242mYyWDhx6fwCQxXjAMDZm6vTCtQZZXpnDhJROQTHNNHxkNfd4rjgzqg=;7:IgJNMHqznLiT8veR0VMM/EARnZmOIRSut418pDF5BVj5ZUFUNhItSm6uQBz+g2+MmyJ9IdUL8dwFGOXUOiCc/RrgR3BeDrUSUgWMFavhaijJKJt6277zWxBzBau/4FzHvR+uukVgVaxJs+5/4hKWkAfCab6F8zimqVkm/BhQSdzk4eXaExUeKhyGpfJ+KLrfRkyI7NtbLet1MQqB4qvBNmKdlR5uVkzd79qiclDtlXAYnFPv4uMGHSzJpB2XupqK
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a4851482-a85e-4fc2-5b60-08d5f92d58ee
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR02MB3796;
x-ms-traffictypediagnostic: AM0PR02MB3796:
x-microsoft-antispam-prvs: <AM0PR02MB37960DF2EA862A7023B013709C230@AM0PR02MB3796.eurprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(164563717011359)(9452136761055)(788757137089)(245156298449039);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM0PR02MB3796;BCL:0;PCL:0;RULEID:;SRVR:AM0PR02MB3796;
x-forefront-prvs: 0753EA505A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(136003)(199004)(189003)(86362001)(99286004)(53546011)(316002)(476003)(105586002)(7696005)(6116002)(6436002)(3846002)(6916009)(97736004)(93886005)(2906002)(26005)(106356001)(229853002)(9686003)(186003)(6506007)(76176011)(486006)(5640700003)(102836004)(55016002)(478600001)(5660300001)(6246003)(66066001)(74316002)(305945005)(5024004)(14454004)(11346002)(446003)(2351001)(2501003)(14444005)(256004)(33656002)(2900100001)(25786009)(81156014)(1730700003)(53936002)(5250100002)(8936002)(81166006)(68736007)(8676002)(7736002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR02MB3796;H:AM0PR02MB3715.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: atos.net does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yOkqI8UcMX3Gn18om6K9fr0nSE6ksE5ejxARIppMgoLlz9X43MUYD0NmSulAJA+UCpFJhy855LeRrBmMYrJ7D0PQDWdxaatzJpcKkqvCnyPieeMtQenLJKA0o741E85X6FT5T0b9PfeHsNKWs4OHmOCdA/1GELrKIX+YEB7XNNruTuQe7iXUAkgxfqhFPb/Xa5bHkmYLRZs9NceHmBT7kJ3+pXZYkBxIxWTyMvkj7FABDkPyXFsMEOyVSSz0J40UJxdFsKJlOepwPhcj06U5cPTn2WseUmaxvfA9jbu5MQaLRflpLJTGmNa2LNuHDwuXqp7VmRmcPbOUDpsT6EMsj9a7TLM0WuxZ5nRvM7ZVrdM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a4851482-a85e-4fc2-5b60-08d5f92d58ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2018 10:39:10.3053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB3796
X-OriginatorOrg: atos.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


s/angular brackets/angle brackets/

I've never seen these called "angular brackets".  Maybe a non-native English speaker issue.



Regards,
Richard.

PS. Please excuse my sending this twice, I don't seem to have default settings that are compatible with the list.




Richard Kerry
BNCS Engineer, SI SOL Telco & Media Vertical  Practice
M: +44 (0)7812 325518
2nd Floor, MidCity Place, 71 High Holborn, London, WC1V 6EA
richard.kerry@atos.net



 This e-mail and the documents attached are confidential and intended solely for the addressee; it may also be privileged. If you receive  this e-mail in error, please notify the sender immediately and destroy it. As its integrity cannot be secured on the Internet, the Atos group liability cannot be triggered for the message content. Although the sender endeavours to maintain a computer virus-free  network, the sender does not warrant that this transmission is virus-free and will not be liable for any damages resulting from any virus transmitted.




From: git-owner@vger.kernel.org <git-owner@vger.kernel.org> on behalf of René Scharfe <l.s.r@web.de>
Sent: 02 August 2018 20:18
To: Jeff King; Junio C Hamano
Cc: Ævar Arnfjörð Bjarmason; git@vger.kernel.org
Subject: [PATCH 6/6] parse-options: automatically infer PARSE_OPT_LITERAL_ARGHELP


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
@@ -304,9 +304,8 @@ static struct option builtin_add_options[] = {
         OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
         OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
         OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
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
@@ -3112,7 +3112,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
                          N_("similar to --all-progress when progress meter is shown")),
                 { OPTION_CALLBACK, 0, "index-version", NULL, N_("<version>[,<offset>]"),
                   N_("write the pack index file in the specified idx format version"),
-                 PARSE_OPT_LITERAL_ARGHELP, option_parse_index_version },
+                 0, option_parse_index_version },
                 OPT_MAGNITUDE(0, "max-pack-size", &pack_size_limit,
                               N_("maximum size of each output pack file")),
                 OPT_BOOL(0, "local", &local,
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index ebc43eb805..fbbc98e516 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -133,7 +133,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
                          N_("same as -m, but discard unmerged entries")),
                 { OPTION_STRING, 0, "prefix", &opts.prefix, N_("<subdirectory>/"),
                   N_("read the tree into the index under <subdirectory>/"),
-                 PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP },
+                 PARSE_OPT_NONEG },
                 OPT_BOOL('u', NULL, &opts.update,
                          N_("update working tree with merge result")),
                 { OPTION_CALLBACK, 0, "exclude-per-directory", &opts,
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 0b517c9368..724b484850 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -180,8 +180,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
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
@@ -269,8 +269,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
                 OPT_BOOL('e', "email", &log.email,
                          N_("Show the email address of each author")),
                 { OPTION_CALLBACK, 'w', NULL, &log, N_("<w>[,<i1>[,<i2>]]"),
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
@@ -673,7 +673,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
                 { OPTION_CALLBACK, 'g', "reflog", &reflog_base, N_("<n>[,<base>]"),
                             N_("show <n> most recent ref-log entries starting at "
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
@@ -973,7 +973,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
                         (parse_opt_cb *) cacheinfo_callback},
                 {OPTION_CALLBACK, 0, "chmod", &set_executable_bit, "(+|-)x",
                         N_("override the executable bit of the listed files"),
-                       PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
+                       PARSE_OPT_NONEG,
                         chmod_callback},
                 {OPTION_SET_INT, 0, "assume-unchanged", &mark_valid_only, NULL,
                         N_("mark files as \"not changing\""),
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index c9d3c544e7..cdcbf8264e 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -24,9 +24,8 @@ int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
         struct option write_tree_options[] = {
                 OPT_BIT(0, "missing-ok", &flags, N_("allow missing objects"),
                         WRITE_TREE_MISSING_OK),
-               { OPTION_STRING, 0, "prefix", &prefix, N_("<prefix>/"),
-                 N_("write tree object for a subdirectory <prefix>") ,
-                 PARSE_OPT_LITERAL_ARGHELP },
+               OPT_STRING(0, "prefix", &prefix, N_("<prefix>/"),
+                          N_("write tree object for a subdirectory <prefix>")),
                 { OPTION_BIT, 0, "ignore-cache-tree", &flags, NULL,
                   N_("only useful for debugging"),
                   PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, NULL,
diff --git a/parse-options.c b/parse-options.c
index 7db84227ab..3b874a83a0 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -660,7 +660,8 @@ int parse_options(int argc, const char **argv, const char *prefix,
 static int usage_argh(const struct option *opts, FILE *outfile)
 {
         const char *s;
-       int literal = (opts->flags & PARSE_OPT_LITERAL_ARGHELP) || !opts->argh;
+       int literal = (opts->flags & PARSE_OPT_LITERAL_ARGHELP) ||
+               !opts->argh || !!strpbrk(opts->argh, "()<>[]|");
         if (opts->flags & PARSE_OPT_OPTARG)
                 if (opts->long_name)
                         s = literal ? "[=%s]" : "[=<%s>]";
--
2.18.0

Atos, Atos Consulting, Worldline and Canopy The Open Cloud Company are trading names used by the Atos group. The following trading entities are registered in England and Wales: Atos IT Services UK Limited (registered number 01245534), Atos Consulting Limited (registered number 04312380), Atos Worldline UK Limited (registered number 08514184) and Canopy The Open Cloud Company Limited (registration number 08011902). The registered office for each is at Second Floor, Mid City Place, 71 High Holborn, London, WC1V 6EA.  The VAT No. for each is: GB232327983.

This e-mail and the documents attached are confidential and intended solely for the addressee, and may contain confidential or privileged information. If you receive this e-mail in error, you are not authorised to copy, disclose, use or retain it. Please notify the sender immediately and delete this email from your systems. As emails may be intercepted, amended or lost, they are not secure. Atos therefore can accept no liability for any errors or their content. Although Atos endeavours to maintain a virus-free network, we do not warrant that this transmission is virus-free and can accept no liability for any damages resulting from any virus transmitted. The risks are deemed to be accepted by everyone who communicates with Atos by email.
