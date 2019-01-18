Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99F8F1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 09:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfARJsQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 04:48:16 -0500
Received: from mout.gmx.net ([212.227.17.20]:40667 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfARJsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 04:48:16 -0500
Received: from [10.49.182.9] ([95.208.59.217]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MgbvP-1gYhQr2NGh-00O1Lv; Fri, 18
 Jan 2019 10:47:54 +0100
Date:   Fri, 18 Jan 2019 10:47:36 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Barret Rhoden <brho@google.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2 2/3] blame: add the ability to ignore commits and
 their changes
In-Reply-To: <20190117202919.157326-3-brho@google.com>
Message-ID: <nycvar.QRO.7.76.6.1901181038540.41@tvgsbejvaqbjf.bet>
References: <20190107213013.231514-1-brho@google.com> <20190117202919.157326-1-brho@google.com> <20190117202919.157326-3-brho@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:p+O9L2ZFfRk/cUfJIu5uvOLg+NP+SDStf3TccCZQ35dLx+AOgev
 BmCWrG5DLbC/AGcUaTJTV/CtQKuFTEsvXRH9bhchoomf7jh4BjBlTkxZQBoLMY1EpmvSxGJ
 I3mq1t5UlgC6IJzHOY3ZpujE/A7n8vriyNGESreMtC1t7ZcwjjKaWBdpZfoYeAy/MqFRUB/
 shOYDP1kO0N555WTD4cDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T8t8sXzFdJU=:K0EA0Dq6V3KuYC8cPximu2
 efm1QKhMmpH/7whPoVoYrLRaa2i9AwKUWdZGGuzUydjFudbrw/mfaMKNo7loDPAcJqbzTutMk
 msYOwM8OWc9pUbyfNAJ9vSc1fIs9Qsb2bDOwZpBXTSHdxgsTeMl1GxO6KfDx7AHUCw3HOkaBs
 h1SdcYQADFKdk1Sf1ikv94SqOeS/qyJfwuY24u3vZQj/N8yyjbHl/BEHmLM7SgLqbwH3laC5g
 4a4akSRi6w/Gweg0c6d0DI2bbE8wCxuWRP7Hnad5ts/UJNWLbRwubFk5xk0fa/vlIBM2R5G2R
 DD4czwedzt8LoyZEvdoZhcNNzosIlhnKtrfEy6qipy93cS/16lGtaxCMvFf9/1yqrupbujBeo
 BzA/SG3qAFVni0CifNO7fjzkLsXaW5uCYwd87tGw8eoWNvR5rAFKo9bu1B9RvADLZNRcxYt/C
 fGhofktREVEHW8c98C3AUUy9M8dficNDKZGf8bM3NRyZR72iMscfsUeyDhXBKkkY7uJARQkY2
 eae19nyZMjssKUVvXP0QlYF3f4yFZIx2wuW25GLn4UXzT1YRaDS5toMvf8LA/QfhGSLLlZfZ1
 ldjkiHD3mrbFp4kahy7742N1od3ueHyYNytY/eaLx5BqsDdZIECifaj1Jtrd2cxrK51RKzANj
 5hrkTUnhwWaSgXze8ghIKdNgl2acgALuU1j83k4blcgxyxHtMDPntepwxSYVmodRUY+sjVYtY
 zYLI5diqc6/5NpXM9PYX0otcLdC2Gv26ZEr/UanBq/qBskxrJIBZ1jfNLuq/N+6FvqCn7owJc
 1Vpt3L5C3owGuniFWGBQEBQLnpeO/Ne1rLk3D6gEPgGH060/89a0u6MVlEWNelUH1OpSPYLLW
 KzWqqxFoi0Dke+bZkrMQ2PSzb+ujIwti56BH3H2CfcOGQkg23l55VeOhEmr1cmAe4sjtW0veL
 XKcvQgbeO6g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Barret,

On Thu, 17 Jan 2019, Barret Rhoden wrote:

> [...]
> 
> Users can ignore a revision with --ignore-rev=rev, which may be
> repeated.  They can specify a file of full SHA-1 hashes of revs (one per
> line) with the blame.ignoreRevFile config option.  They can also specify
> a file with --ignore-rev-file=file, which overrides the config option.

This sounds like that is already the case in Git, but the truth is: this
patch *introduces* that feature. Maybe start the paragraph with "With this
patch, ..."?

I cannot speak for the correctness of the changes to blame.c, others on
the Cc: list are already much more familiar with that code, so I'll leave
it to them to comment on that.

However, I am missing a regression test for this behavior, the best idea
would be likely to add t/t8013-blame-ignore-revs.sh (copy-edit it from
t/t8009-blame-vs-topicbranches.sh, maybe).

And there is another thing:

> diff --git a/builtin/blame.c b/builtin/blame.c
> index 6d798f99392e..2f9183fb5fbd 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -52,6 +52,7 @@ static int no_whole_file_rename;
>  static int show_progress;
>  static char repeated_meta_color[COLOR_MAXLEN];
>  static int coloring_mode;
> +static const char *ignore_revs_file;

... this...

>  
>  static struct date_mode blame_date_mode = { DATE_ISO8601 };
>  static size_t blame_date_width;
> @@ -695,6 +696,8 @@ static int git_blame_config(const char *var, const char *value, void *cb)
>  		parse_date_format(value, &blame_date_mode);
>  		return 0;
>  	}
> +	if (!strcmp(var, "blame.ignorerevsfile"))
> +		return git_config_pathname(&ignore_revs_file, var, value);

... this...

>  	if (!strcmp(var, "color.blame.repeatedlines")) {
>  		if (color_parse_mem(value, strlen(value), repeated_meta_color))
>  			warning(_("invalid color '%s' in color.blame.repeatedLines"),
> @@ -806,6 +826,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  		OPT_BIT('s', NULL, &output_option, N_("Suppress author name and timestamp (Default: off)"), OUTPUT_NO_AUTHOR),
>  		OPT_BIT('e', "show-email", &output_option, N_("Show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
>  		OPT_BIT('w', NULL, &xdl_opts, N_("Ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
> +		OPT_STRING_LIST(0, "ignore-rev", &ignore_rev_list, N_("rev"), N_("Ignore <rev> when blaming")),
> +		OPT_STRING(0, "ignore-revs-file", &ignore_revs_file, N_("file"), N_("Ignore revisions from <file>")),

... and this change limit the user to specifying a single file, for no
good reason. Worse: specifying two different files via two
`--ignore-revs-file` parameters will only heed the latter and skip the
former without any warning.

A better idea IMHO would be to use an OPT_STRING_LIST() for
`--ignore-revs-file`, too, and to allow for multiple
`blame.ignoreRevsFile` config entries (with our usual trick of handling an
empty setting by resetting the list of paths that were accumulated so
far, see e.g. how `credential.helper` is handled).

Ciao,
Johannes

>  		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),
>  		OPT_BIT(0, "color-by-age", &output_option, N_("color lines by age"), OUTPUT_SHOW_AGE_WITH_COLOR),
>  
> @@ -995,6 +1017,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  	sb.contents_from = contents_from;
>  	sb.reverse = reverse;
>  	sb.repo = the_repository;
> +	build_ignorelist(&sb, &ignore_rev_list);
> +	string_list_clear(&ignore_rev_list, 0);
>  	setup_scoreboard(&sb, path, &o);
>  	lno = sb.num_lines;
>  
> -- 
> 2.20.1.321.g9e740568ce-goog
> 
> 
