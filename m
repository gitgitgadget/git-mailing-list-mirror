Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F606208E9
	for <e@80x24.org>; Thu,  2 Aug 2018 12:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732047AbeHBOHY (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 10:07:24 -0400
Received: from mout.web.de ([212.227.15.3]:49159 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728797AbeHBOHY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 10:07:24 -0400
Received: from [192.168.178.36] ([79.237.249.67]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LxJVq-1fzndk2mok-016u3Y; Thu, 02
 Aug 2018 14:16:22 +0200
Subject: Re: [PATCH] push: comment on a funny unbalanced option help
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
 <87k1p9u860.fsf@evledraar.gmail.com>
 <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
 <87h8kdu3ay.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <30a6105c-4cb7-b52f-0b0a-c4504b90a5b1@web.de>
Date:   Thu, 2 Aug 2018 14:16:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87h8kdu3ay.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5nmS5jWBD7l8Dcz9xcZaYfQpEO7K8nCI9ito6NGhTFrYJhV1F6O
 I53ThY2R+ceziyjRJEO03q8JyUbeqWKVCyjRBDmPTHlRgrR4vfMhDn8wkqlKGkNlIEj4ZDt
 5/buLuJ5Qv2IIEIvnIg4UygpAdRutxSAWKG1VSf0UPgX5xyR4bA9BUvIr7esjzshC8Iwln/
 bj+/xnotDm863DtACEs8g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MHSmEZ23h3Q=:RFIwckKpFoZq9szoDwKZda
 CfqCWFxjReu5RT2+uPjDNGINPHLLIubpsQiMkNRm2o032lbjuh52I3PBhYhYfiIMeEXM5bCbH
 CQZJq8ocgwjBhekv8qOB8CVEjGDaVXh/1KRY80v12PyPxn3EceRUny2LpmQBKt0mQydXd67m5
 df9s9yW87GLUK6PnkETp+DpItOCYaRyafYC5aFh/+z/HKg8d7arFMX8jPAGWqb6t5EjQNRGFt
 3iyrkbjhel/ycM1/hl6C8NMAPkehNFCsdy6tfoM29tzp85If57mH5yAum/TsKu4B5PMiffEcx
 AVwRxozS7OUId2mcUoNrCSOnl8IvveECLEwr8W4X1E1p/rS8Nwv/2ug68gx/IqANj0+3PKq0w
 gO07FMozN5YYrWNk71PZodwHTGZxlTekmxBhlQmgfzsC801IFhj8IMKtGgT+2aXGfv903KqUz
 dxE6t7PCXCcAALZ7Hx4iggqbM91lbvYR8sPBzupdpzRiP+Iygn09E+wRjHEgeA0ZyF85T/RjH
 xfHEwoAsPyACH4zLaX11MFY7RkvJ1OhQ7dwi75Tcw7gxqQIeFfLfrA8hBiloZcHsGcqDN8FGn
 SzoWr8z6lIWV2r7ji+Mef0rCuEte8tIvreicmWhXDVH6PAXT/REEmzCTeOLbTqSF0ISlUcIjI
 DlPqK/pnf3UhdPdP5peXFQ8sYPBM41kw7OmQRWBAOMnnFwNHJ31EC7DarKJ8NlHWAU8UtnG2N
 DiVYADYVuCnOY8FG1p5ZVsvmMVSPBhB3N8ZUKBPBRBMJdbYUhkhA/8JhrmqTIl8Di169XFCf8
 ndXgDTx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.08.2018 um 00:31 schrieb Ævar Arnfjörð Bjarmason:
> But looking at this again it looks like this whole thing should just be
> replaced by:
> 
>      diff --git a/builtin/push.c b/builtin/push.c
>      index 9cd8e8cd56..b8fa15c101 100644
>      --- a/builtin/push.c
>      +++ b/builtin/push.c
>      @@ -558,9 +558,10 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>                      OPT_BIT( 0,  "porcelain", &flags, N_("machine-readable output"), TRANSPORT_PUSH_PORCELAIN),
>                      OPT_BIT('f', "force", &flags, N_("force updates"), TRANSPORT_PUSH_FORCE),
>                      { OPTION_CALLBACK,
>      -                 0, CAS_OPT_NAME, &cas, N_("refname>:<expect"),
>      +                 0, CAS_OPT_NAME, &cas, N_("<refname>:<expect>"),
>                        N_("require old value of ref to be at this value"),
>      -                 PARSE_OPT_OPTARG, parseopt_push_cas_option },
>      +                 PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
>      +                 parseopt_push_cas_option },
>                      { OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules, "check|on-demand|no",
>                              N_("control recursive pushing of submodules"),
>                              PARSE_OPT_OPTARG, option_parse_recurse_submodules },
> 
> I.e. the reason this is confusing is because the code originally added
> in 28f5d17611 ("remote.c: add command line option parser for
> "--force-with-lease"", 2013-07-08) didn't use PARSE_OPT_LITERAL_ARGHELP,
> which I also see is what read-tree etc. use already to not end up with
> these double <>'s, see also 29f25d493c ("parse-options: add
> PARSE_OPT_LITERAL_ARGHELP for complicated argh's", 2009-05-21).

We could check if argh comes with its own angle brackets already and
not add a second pair in that case, making PARSE_OPT_LITERAL_ARGHELP
redundant in most cases, including the one above.  Any downsides?
Too magical?

-- >8 --
Subject: [PATCH] parse-options: automatically infer PARSE_OPT_LITERAL_ARGHELP

Avoid adding an extra pair of angular brackets if the argh string
already contains one.  Remove the flag PARSE_OPT_LITERAL_ARGHELP in the
cases where the new automatic handling suffices.  This shortens and
simplifies option definitions with special argument help strings a bit.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/read-tree.c    | 2 +-
 builtin/show-branch.c  | 2 +-
 builtin/update-index.c | 2 +-
 builtin/write-tree.c   | 5 ++---
 parse-options.c        | 3 ++-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index ebc43eb805..fbbc98e516 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -133,7 +133,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			 N_("same as -m, but discard unmerged entries")),
 		{ OPTION_STRING, 0, "prefix", &opts.prefix, N_("<subdirectory>/"),
 		  N_("read the tree into the index under <subdirectory>/"),
-		  PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP },
+		  PARSE_OPT_NONEG },
 		OPT_BOOL('u', NULL, &opts.update,
 			 N_("update working tree with merge result")),
 		{ OPTION_CALLBACK, 0, "exclude-per-directory", &opts,
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index f2e985c00a..9106da1985 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -673,7 +673,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		{ OPTION_CALLBACK, 'g', "reflog", &reflog_base, N_("<n>[,<base>]"),
 			    N_("show <n> most recent ref-log entries starting at "
 			       "base"),
-			    PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
+			    PARSE_OPT_OPTARG,
 			    parse_reflog_param },
 		OPT_END()
 	};
diff --git a/builtin/update-index.c b/builtin/update-index.c
index a8709a26ec..22749fc2c7 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -969,7 +969,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			N_("<mode>,<object>,<path>"),
 			N_("add the specified entry to the index"),
 			PARSE_OPT_NOARG | /* disallow --cacheinfo=<mode> form */
-			PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
+			PARSE_OPT_NONEG,
 			(parse_opt_cb *) cacheinfo_callback},
 		{OPTION_CALLBACK, 0, "chmod", &set_executable_bit, N_("(+/-)x"),
 			N_("override the executable bit of the listed files"),
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index c9d3c544e7..cdcbf8264e 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -24,9 +24,8 @@ int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
 	struct option write_tree_options[] = {
 		OPT_BIT(0, "missing-ok", &flags, N_("allow missing objects"),
 			WRITE_TREE_MISSING_OK),
-		{ OPTION_STRING, 0, "prefix", &prefix, N_("<prefix>/"),
-		  N_("write tree object for a subdirectory <prefix>") ,
-		  PARSE_OPT_LITERAL_ARGHELP },
+		OPT_STRING(0, "prefix", &prefix, N_("<prefix>/"),
+			   N_("write tree object for a subdirectory <prefix>")),
 		{ OPTION_BIT, 0, "ignore-cache-tree", &flags, NULL,
 		  N_("only useful for debugging"),
 		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, NULL,
diff --git a/parse-options.c b/parse-options.c
index 7db84227ab..fadfc6a833 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -660,7 +660,8 @@ int parse_options(int argc, const char **argv, const char *prefix,
 static int usage_argh(const struct option *opts, FILE *outfile)
 {
 	const char *s;
-	int literal = (opts->flags & PARSE_OPT_LITERAL_ARGHELP) || !opts->argh;
+	int literal = (opts->flags & PARSE_OPT_LITERAL_ARGHELP) || !opts->argh ||
+		(opts->argh[0] == '<' && strchr(opts->argh, '>'));
 	if (opts->flags & PARSE_OPT_OPTARG)
 		if (opts->long_name)
 			s = literal ? "[=%s]" : "[=<%s>]";
-- 
2.18.0
