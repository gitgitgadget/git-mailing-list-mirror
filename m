Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D54981F404
	for <e@80x24.org>; Mon, 13 Aug 2018 09:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbeHMM1s (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 08:27:48 -0400
Received: from mout.gmx.net ([212.227.15.19]:49963 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728310AbeHMM1s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 08:27:48 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MfVU3-1fVXwm3YC3-00P7f4; Mon, 13
 Aug 2018 11:46:11 +0200
Date:   Mon, 13 Aug 2018 11:46:18 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 05/21] range-diff: also show the diff between
 patches
In-Reply-To: <20180812214741.GB13316@hank.intra.tgummerer.com>
Message-ID: <nycvar.QRO.7.76.6.1808131135290.71@tvgsbejvaqbjf.bet>
References: <pull.1.v4.git.gitgitgadget@gmail.com> <pull.1.v5.git.gitgitgadget@gmail.com> <9e1e660077d41c479ae46eb07371204c01dff4cd.1533939264.git.gitgitgadget@gmail.com> <20180812214741.GB13316@hank.intra.tgummerer.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UaHFuRrVjJj14A7z7bDYbM6iaxuvHN9nUle8UrVMBngICgtOW+D
 GYamIFwYCfXDK2klaJPdQlgviiBtp5C4GenEBevwEl011kb5PER8to52Tbf+p8bIqDsfdh4
 5rO2jxR6AIA+fsG+wU0L0X3M7OEhcvID8mEcQCIFqq3MjwcCCuczCYJsLipEpdNLCbVGHBu
 mp+eV9dcKjzI3x5v+d35Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SoT9Yqtjy0g=:gLvOVl6zNZNLdeScv6ZyuY
 tKNeuFFNGxTC8OxEcMBtCuAFoj1JpStFAKpJxOP8/0cbH67ESChE3NPoSq1AFBEhaajmDiXQS
 V56coud0uFPhsiPKAhT9Je/igpgnVni9NEmVrxaegm+CojT4VfCrM27qUd8RglwyWfMWT6C/A
 m9qwCUvxT5QEMuQC1i0JaNyWCofTNeHr+dW7MSXX2EjKP3sZkF35YR61U9TjS/i4nSn6C3kPc
 5s2MoXRI/D6qwylW4GkWqalJyc7gH16jHS4Lnj5Il+wrGz2mAav6Vp/Ff0FoCa3tD+WrmYqzP
 a9LjvkJRoeVfHjKQPHNgdkLVNsFPvLgmf3TGHI1YJVMfb2KBFtQIpP85a6zrNBTl4Mk4msrnJ
 tm+tBDi1mzdRILvKl3nFV1sQoOYcalb7H+NqSdxgJRRpgWL+L0B9WX+v6V1eQ24T6L6bGjGZN
 cHL0iPybMToCcHrzJJjjgYfDAH0Mpj4KvuV3K6oA7XGKmfdtnfkdCpjegiZIHm4LFJ4ZgzWq/
 qRsx8K2X6k8FQJ3ARCDy+gFkxLGaDqj2CvAAJH5e2MVOiX2b2MMEgPTM7Wu9werXSpg4iQun+
 GvoVe9Xsdgn35MAxRsLjjRCCTqA2ICqbzxBqL7FsaNep1uSd0NQbA7cIABNjGXoP3T1LH+9TI
 CM6ADuveDVpVuwo7FC3HXwsu/bisXUi5iEAfNnAbRHguHXDdUPAyDSSXd3ZJRPbrB//znPFTG
 8Cdf+A3XqssEKvb6KQ63ZqW1SC14wXy2HK7je894N9uSU1VS/LwAQAMTu6f1YDP5++Fc1VjeV
 RfpkOBM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Sun, 12 Aug 2018, Thomas Gummerer wrote:

> On 08/10, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > [..]
> > 
> > @@ -13,15 +14,38 @@ NULL
> >  int cmd_range_diff(int argc, const char **argv, const char *prefix)
> >  {
> >  	int creation_factor = 60;
> > +	struct diff_options diffopt = { NULL };
> >  	struct option options[] = {
> >  		OPT_INTEGER(0, "creation-factor", &creation_factor,
> >  			    N_("Percentage by which creation is weighted")),
> >  		OPT_END()
> >  	};
> > -	int res = 0;
> > +	int i, j, res = 0;
> >  	struct strbuf range1 = STRBUF_INIT, range2 = STRBUF_INIT;
> >  
> > +	git_config(git_diff_ui_config, NULL);
> > +
> > +	diff_setup(&diffopt);
> > +	diffopt.output_format = DIFF_FORMAT_PATCH;
> > +
> >  	argc = parse_options(argc, argv, NULL, options,
> > +			     builtin_range_diff_usage, PARSE_OPT_KEEP_UNKNOWN |
> > +			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0);
> > +
> > +	for (i = j = 1; i < argc && strcmp("--", argv[i]); ) {
> > +		int c = diff_opt_parse(&diffopt, argv + i, argc - i, prefix);
> > +
> > +		if (!c)
> > +			argv[j++] = argv[i++];
> > +		else
> > +			i += c;
> > +	}
> 
> I don't think this handles "--" quite as would be expected.  Trying to
> use "git range-diff -- js/range-diff-v4...HEAD" I get:
> 
>     $ ./git range-diff -- js/range-diff-v4...HEAD
>     error: need two commit ranges
>     usage: git range-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>
>        or: git range-diff [<options>] <old-tip>...<new-tip>
>        or: git range-diff [<options>] <base> <old-tip> <new-tip>
> 
>         --creation-factor <n>
>                               Percentage by which creation is weighted
>         --no-dual-color       color both diff and diff-between-diffs
> 
> while what I would have expected is to actually get a range diff.
> This happens because after we break out of the loop we don't add the
> actual ranges to argv, but just skip them instead.

Ouch, good point.

> I think something like the following should be squashed in to this
> patch.
> 
> --->8---
> diff --git a/builtin/range-diff.c b/builtin/range-diff.c
> index ef3ba22e29..132574c57a 100644
> --- a/builtin/range-diff.c
> +++ b/builtin/range-diff.c
> @@ -53,6 +53,11 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
>                 else
>                         i += c;
>         }
> +       if (i < argc && !strcmp("--", argv[i])) {
> +               i++; j++;
> +               while (i < argc)
> +                       argv[j++] = argv[i++];
> +       }
>         argc = j;
>         diff_setup_done(&diffopt);

I do not think that is correct. The original idea was for the first
`parse_options()` call to keep the dashdash, for the second one to keep
the dashdash, too, and for the final one to swallow it.

Also, if `i < argc` at this point, we already know that `argv[i]` refers
to the dashdash, otherwise the previous loop would not have exited early.

I went with this simple version instead:

	while (i < argc)
		argv[j++] = argv[i++];

Thanks!
Dscho

> --->8---
> 
> > +	argc = j;
> > +	diff_setup_done(&diffopt);
> > +
> > +	/* Make sure that there are no unparsed options */
> > +	argc = parse_options(argc, argv, NULL,
> > +			     options + ARRAY_SIZE(options) - 1, /* OPT_END */
> >  			     builtin_range_diff_usage, 0);
> >  
> >  	if (argc == 2) {
> > @@ -59,7 +83,8 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
> >  		usage_with_options(builtin_range_diff_usage, options);
> >  	}
> >  
> > -	res = show_range_diff(range1.buf, range2.buf, creation_factor);
> > +	res = show_range_diff(range1.buf, range2.buf, creation_factor,
> > +			      &diffopt);
> >  
> >  	strbuf_release(&range1);
> >  	strbuf_release(&range2);
> > diff --git a/range-diff.c b/range-diff.c
> > index 2d94200d3..71883a4b7 100644
> > --- a/range-diff.c
> > +++ b/range-diff.c
> > @@ -6,6 +6,7 @@
> >  #include "hashmap.h"
> >  #include "xdiff-interface.h"
> >  #include "linear-assignment.h"
> > +#include "diffcore.h"
> >  
> >  struct patch_util {
> >  	/* For the search for an exact match */
> > @@ -258,7 +259,31 @@ static const char *short_oid(struct patch_util *util)
> >  	return find_unique_abbrev(&util->oid, DEFAULT_ABBREV);
> >  }
> >  
> > -static void output(struct string_list *a, struct string_list *b)
> > +static struct diff_filespec *get_filespec(const char *name, const char *p)
> > +{
> > +	struct diff_filespec *spec = alloc_filespec(name);
> > +
> > +	fill_filespec(spec, &null_oid, 0, 0644);
> > +	spec->data = (char *)p;
> > +	spec->size = strlen(p);
> > +	spec->should_munmap = 0;
> > +	spec->is_stdin = 1;
> > +
> > +	return spec;
> > +}
> > +
> > +static void patch_diff(const char *a, const char *b,
> > +			      struct diff_options *diffopt)
> > +{
> > +	diff_queue(&diff_queued_diff,
> > +		   get_filespec("a", a), get_filespec("b", b));
> > +
> > +	diffcore_std(diffopt);
> > +	diff_flush(diffopt);
> > +}
> > +
> > +static void output(struct string_list *a, struct string_list *b,
> > +		   struct diff_options *diffopt)
> >  {
> >  	int i = 0, j = 0;
> >  
> > @@ -300,6 +325,9 @@ static void output(struct string_list *a, struct string_list *b)
> >  			printf("%d: %s ! %d: %s\n",
> >  			       b_util->matching + 1, short_oid(a_util),
> >  			       j + 1, short_oid(b_util));
> > +			if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))
> > +				patch_diff(a->items[b_util->matching].string,
> > +					   b->items[j].string, diffopt);
> >  			a_util->shown = 1;
> >  			j++;
> >  		}
> > @@ -307,7 +335,7 @@ static void output(struct string_list *a, struct string_list *b)
> >  }
> >  
> >  int show_range_diff(const char *range1, const char *range2,
> > -		    int creation_factor)
> > +		    int creation_factor, struct diff_options *diffopt)
> >  {
> >  	int res = 0;
> >  
> > @@ -322,7 +350,7 @@ int show_range_diff(const char *range1, const char *range2,
> >  	if (!res) {
> >  		find_exact_matches(&branch1, &branch2);
> >  		get_correspondences(&branch1, &branch2, creation_factor);
> > -		output(&branch1, &branch2);
> > +		output(&branch1, &branch2, diffopt);
> >  	}
> >  
> >  	string_list_clear(&branch1, 1);
> > diff --git a/range-diff.h b/range-diff.h
> > index 7b6eef303..2407d46a3 100644
> > --- a/range-diff.h
> > +++ b/range-diff.h
> > @@ -1,7 +1,9 @@
> >  #ifndef RANGE_DIFF_H
> >  #define RANGE_DIFF_H
> >  
> > +#include "diff.h"
> > +
> >  int show_range_diff(const char *range1, const char *range2,
> > -		    int creation_factor);
> > +		    int creation_factor, struct diff_options *diffopt);
> >  
> >  #endif
> > -- 
> > gitgitgadget
> > 
> 
