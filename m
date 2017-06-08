Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FEEA1F8CF
	for <e@80x24.org>; Thu,  8 Jun 2017 10:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751123AbdFHKZ0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 06:25:26 -0400
Received: from mout.gmx.net ([212.227.15.18]:63360 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750786AbdFHKZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 06:25:25 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MVe87-1dMXgX1XGZ-00Z2pY; Thu, 08
 Jun 2017 12:25:18 +0200
Date:   Thu, 8 Jun 2017 12:25:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Brandon Williams <bmwill@google.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/9] Use the early config machinery to expand aliases
In-Reply-To: <20170607182614.GF110638@google.com>
Message-ID: <alpine.DEB.2.21.1.1706081223130.171564@virtualbox>
References: <cover.1496851544.git.johannes.schindelin@gmx.de> <3b916e1f5055486795c784d55704b4720598f1a9.1496851544.git.johannes.schindelin@gmx.de> <20170607182614.GF110638@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1NOmDqLe9Qf7Ftge12deGV/ZU1qaDIJ2gA7D1D25xbnlusluemf
 4JJme0pU/6lMU1GclYapdyUBpIgYyrvTFBLd9D3VpTH6jyEVBoVREYimHHkgPmqFz120onF
 AbfBkE5w5OAThgMv++uzCkHmVUm5W4+pX90pvK7n1WP0+26LF14OuoDzQafK5iS9vBZeC3H
 uUeXvDuYQwqga5MjOi2bA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+wxIT1YhaWc=:P7ZH29ZWIMnra+c5gGqSN8
 nysks0diFJrZSk2+45cfI33Oqd5N0AI3daJ8sMfvbJkAIi+ZAjt/g8yOrpxhoj9/BEOyMLBWI
 dUisa8vOjnEbV1u1JNGrvq0EPFD6GelmOndAs3vVjOLRmjK77GfcJ7kDfT4JZfEbA6mNRgsVP
 9f8r3xVz8JxXAyYUAyWC5V+ac75lwtXtlnjtbwYMam7qzMtNZZkxr/p8PaTwgmuIYc/rfukjU
 2zYQvFXpQ1Y0XwX0+a6Bkw0JozQm2Xcf4AjTnozI/pc8Y8ZjyASoxOjtpvOEHxuofro9yMCks
 lJ80sUIwv6mtU1zRl4RXxhA55fjxGEGtUqet3CIgeH8XLp4WEwS485L4mknmplNBPk9L9lAVx
 vvl0zcKls7wBvG+5AwlIO+g43+ErLrBSO7WI+N/21FRJyIq7s6zAZkWMSTltC2XCqN+S3+lWp
 bvEy1VLFfirqCSBKqJoiC5YW2t3YnRZk2kMObIKoEc7oC++R0JMLI46a6FwC8ZZSG2EO6zu3L
 6zjVqV16Ra/TYa5QN96XvKfJiQz5ZVg01Lw3SW5w9qfdZMwxxmVRIx1moY1V6d1zqovkm+nfG
 +AEbvEVNu21qXWZ0dxadm8fNj8FuqJVIK+9xScfrypAtDJmS1fqm3gBGDcbOoJ4zzxq1AfMtS
 b4F8QxG4IpJhsXWzAcK4Ml5qKNqIaNtzMEawk0o+cT2NGOjTJJpbXfeAo38PPV1gIAU2m+YkZ
 Ge6zoE3v7yu/Gq4GmOHM71xLmoYg90HyYJw+eIiW/yutza0ju0GaI+bQU0ALPHyhfreDibjuM
 4WqlG8H
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On Wed, 7 Jun 2017, Brandon Williams wrote:

> I like seeing chunks of old code being deleted :D

Me, too. In particular as hacky code as this one. It caused quite a couple
of gray hairs here.

> On 06/07, Johannes Schindelin wrote:
> 
> > @@ -245,36 +201,37 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
> >  
> >  static int handle_alias(int *argcp, const char ***argv)
> >  {
> > +	struct strbuf worktree_dir = STRBUF_INIT;
> >  	int envchanged = 0, ret = 0, saved_errno = errno;
> >  	int count, option_count;
> >  	const char **new_argv;
> >  	const char *alias_command;
> >  	char *alias_string;
> > -	int unused_nongit;
> > -
> > -	save_env_before_alias();
> > -	setup_git_directory_gently(&unused_nongit);
> >  
> >  	alias_command = (*argv)[0];
> > -	alias_string = alias_lookup(alias_command, NULL);
> > +	alias_string = alias_lookup(alias_command, &worktree_dir);
> >  	if (alias_string) {
> >  		if (alias_string[0] == '!') {
> >  			struct child_process child = CHILD_PROCESS_INIT;
> >  
> > +			if (worktree_dir.len)
> > +				setup_git_directory();
> 
> So if there is a worktree then we run the setup code explicitly.  I
> assume that is to ensure that all envvars are setup properly before
> running the alias.  Just interesting to note that the actual value of
> worktree_dir is never used, its just used essentially as a boolean
> indicator of there being a worktree/gitdir/repository.  I'm not
> suggesting to change from what you have here, its just food for thought.

Indeed.

That is what I tried to indicate by this paragraph in the commit message:

	Rather than just chdir()ing into the indicated directory in case of an
	alias expanding to a shell command, we simply set up the .git/ directory
	so that e.g. GIT_PREFIX is set as expected.

