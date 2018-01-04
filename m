Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2E681F404
	for <e@80x24.org>; Thu,  4 Jan 2018 22:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753721AbeADWqb (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 17:46:31 -0500
Received: from mout.gmx.net ([212.227.17.22]:53295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753616AbeADWq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 17:46:29 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M3R1g-1eol623tjM-00r38a; Thu, 04
 Jan 2018 23:46:27 +0100
Date:   Thu, 4 Jan 2018 23:46:27 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Alex Vandiver <alexmv@dropbox.com>
cc:     git@vger.kernel.org, Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 6/6] fsmonitor: Use fsmonitor data in `git diff`
In-Reply-To: <121828fc14bc6f3096d16005feffb58bf68f070a.1514948078.git.alexmv@dropbox.com>
Message-ID: <alpine.DEB.2.21.1.1801042335130.32@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <20180103030456.8181-1-alexmv@dropbox.com> <121828fc14bc6f3096d16005feffb58bf68f070a.1514948078.git.alexmv@dropbox.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:sQVSAXSA/tSkFq3glrEiIvbNhgw5CWEG+Y3HNq1YplHl2vaAtsd
 +MATF4t+e9WLIFwTGC0iGQO6kA4BKIWcJxzjU+HqLDmNiM57sCPQWvSSHtaVrjepfNcLs03
 C42/C08zPhl6uYKpIqS0/uw5xvC7MP1Wp7XT231TUSxfv6UOij1fVwRiXV9Vx47NNGpx91A
 t64hnaq8ztlPEZbu2DXVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ldMIba+afX4=:z7GdeJczrW1AxKqzKIRUxy
 9j7DgQpWzz7JsaiJ4IZSrY5PjY7WmaMNsGJSWY3uO7izD8xnGZtkIN6e3JH5DnvPWFjd+mfrX
 D5HVbTEBwI51p98llWvZGKEQhRr0AeAemqBEKCVl0iUICgWqNPXCGqfhIInQrsUQ1Ir1OWYaH
 6W0kzca9IG493o7k2/rpcJXpE6gQcNZorwbaL0PmoKql3HYyURfVHEiJLzdp39PhvTSSP6s0U
 fyC1wjCSO4PrK6XmFDFzWn6XvAbi+x8niWCnGABEQybwBW/sKE0lQ8XN0njxdxdVdZbNd0QvU
 MB+853MLXUT8IVDJywBzpuNmJ19fGaBcmbWOSRC7HRz6eGY/dZeaIFJXSWUinoOoLjNhDOmeZ
 u6z3CJBSYJoul4esznXWVzjrXj5CqDfW5LZEWwwP/ITbTGMwI8irGVFgLRNluGtxxdMzVqt8i
 drhcqD4N52VYnpQVVzZNmysgCNwUBcKtPkzuTjwd8OuoHpRnSioaKZVau8qmNz81vpWdh6iOn
 FBbxO2rAgG0VaAo1bK+kBAY7WJ/HPe6T9rvzIzYywhL9DWkGOjdVbW8tbH1sB42OQSmXaK1UZ
 TheMFUsO+XxDiAHxrTUcUoFBw4AkDC8FrCpv0mZJDqmAZHXKIlTGJghgi2Ws6XpfSkNL8ePU0
 dt2TiWEzJQguUW9Nqtu8LIPvasQchGNeGeKCyHOWCV9y2y2dsXV8V5E1ljjHxUZCLv9LrA7SY
 VOHmXVmiEXGMcwVMpkDtqlDq17/+vAsjY29divmPwFuLzchfC1djUyNv2naLX456+MUllUl3M
 PS+CSWcAskefCkJMZO+BSOOy8puACZQRXwkaLlXqqlQlSGgKNADF0yQwG9JOb9Q8gdKNG5P
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

On Tue, 2 Jan 2018, Alex Vandiver wrote:

> diff --git a/diff-lib.c b/diff-lib.c
> index 8104603a3..13ff00d81 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -95,6 +95,9 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  
>  	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
>  
> +	if (!(option & DIFF_SKIP_FSMONITOR))
> +		refresh_fsmonitor(&the_index);
> +
>  	if (diff_unmerged_stage < 0)
>  		diff_unmerged_stage = 2;

I read over this hunk five times, and only now am I able to wrap my head
around this: if we do *not* want to skip the fsmonitor data, we refresh
the fsmonitor data in the index.

That feels a bit like an unneeded double negation. Speaking for myself, I
would prefore `DIFF_IGNORE_FSMONITOR` instead, it would feel less like a
double negation then. But I am not a native speaker, so I might be wrong.

> +               if (ce->ce_flags & CE_FSMONITOR_VALID && !(option & DIFF_SKIP_FSMONITOR))
> +                       continue;

Since we do expect this to be called without the DIFF_SKIP_FSMONITOR flag,
I guess it makes sense to order it this way.

I still have troubles to understand why we ignore the fsmonitor data with
`git add`, though... we want to add only modified files, right? I thought
that the fsmonitor data could help performance exactly there (I am
thinking of a certain insanely large code base where a developer might
want to change only one or maybe 3 files out of an entire machine workshop
of files, and with fsmonitor it should be a really fast operation because
it should ignore all but those few files, right?)... Could you maybe try
to help me understand that better?

Thanks,
Johannes
