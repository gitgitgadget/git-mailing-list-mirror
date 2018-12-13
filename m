Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57AD720A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 13:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbeLMNtc (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 08:49:32 -0500
Received: from mout.gmx.net ([212.227.15.15]:32871 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729359AbeLMNtc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 08:49:32 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mey7N-1gn4PR1xYv-00OURz; Thu, 13
 Dec 2018 14:49:28 +0100
Date:   Thu, 13 Dec 2018 14:49:12 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     CB Bailey <cb@hashpling.org>
cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH] Use mailmap by default in log, show and
 whatchanged
In-Reply-To: <20181213120940.26477-1-cb@hashpling.org>
Message-ID: <nycvar.QRO.7.76.6.1812131448540.43@tvgsbejvaqbjf.bet>
References: <20181213120940.26477-1-cb@hashpling.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jzWvaGDqERuwIidFH2xP7mStImB+DBxWUqI3eGhNzl1N2xYu0A4
 WVyKR40qJKzvLeCodSQ+bEAHBLT4hnUFvPvxCZHwhFroAgoI0YAzA0bPnlB7Sv7xLE+aSCO
 UzEVIlP8w6oJi/iTLBRce/ZgOEJLOkEKpa335t1kJrBe0I1uNKlUkBJPRSllmdwylvTfmZc
 0roJLQjo6ZGjcz3CmI9pQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d/6pq/eVhG8=:yjGd83TSeUdfx3AFhkMt3v
 1oLx2Uk9z8vjYukPhgkcLj6BqxrY+ec1V0cc9vsNjRbAfztG46m/cLq1u5PNDtma9TCmppr6H
 48IJ8yJD0Cr6fFNf0TAiYnLXH/5mH96r/XepF13Cv7xGaaG74bx5YwjYHkovuzl0WYGtcg4SG
 QDfPrJvrWx6M07rWHsaWf581ieTyzkMX80E64IBwz/qL6bnmcvd74QutRqWBJkZlG90astmrV
 rljaoEGb2aaxnaJKNZIfZC/xLqwpqGu93uhYt8Zo59uflZwOa1Knl5UUlzUqZ1VTxL11q8MO0
 q8Sc5jDyaJcAi248Y+YsotbItVhz+zGUExGIKKWAQi5hkqBwxj932dvNuWrfsWOqm8E7T6X4P
 vMAd9juBQFSCmH3cdN538coLch/6Fo/xGMC6zqtmbr/ntQxuGX43HDTwvvJSarPzO6Ap/kAQg
 I3MIMSfZkhCIZ5p/5cPOwctYLWKyx5sfRjgDUgAhzp+UoD56SPbAyPBN8OJVgiCpZr2mxEtRo
 RGeE/rXaytPA+BRSHFBGE+DFEaU5NUkpfG9skqrvyt+4L3dhc8CxcduBCttRx7eLh7mnxSzZ3
 LBZP9ePiUeuMOZJSIXd7KhvfwF19dUcQPaOIwDlm7HiClZ5/TUb5vOGG+b4IWnEBcmwDke+gu
 w/SN9Ag2vpbOqTdBs3ZnzHEuEaeUkwNur6cvjpZePGAk4E0ZfK4RNeDj8Ss/dMGCm2ZG7H6sM
 dx4YxTLb0qejhWBi1jwomn4Lhk9ylBP/eC6GorodaMkricnqeRQdFoT64tDVsGQAIqJPdqwrv
 bMF80cbl6Umn6Fb1rRd/9ZY9ew2BLnCC2XBt1PGMMsEiyHaQ2yXc9AIozrh+Qrv7fXbixWjga
 ITwC97oJYhiyP19vzBYGPPGcBd5fjAUV3Zo4ET1EPVYFhPYkUf67th69MajvtrIO6VVKV/r9H
 LawRDQbxwrw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi CB,

On Thu, 13 Dec 2018, CB Bailey wrote:

> From: CB Bailey <cbailey32@bloomberg.net>
> 
> People who have changed their name or email address will usually know
> that they need to set 'log.mailmap' in order to have their new details
> reflected for old commits with 'git log', but others who interact with
> them may not know or care enough to enable this option.
> 
> Change the default for 'git log' and friends to always use mailmap so
> that everyone gets to see canonical names and email addresses.
> 
> Signed-off-by: CB Bailey <cbailey32@bloomberg.net>
> ---
> 
> Related to my patch to make shortlog pass the mailmap into the revision
> walker which may end up being configuratble behavior, I thought I'd
> propose this for discussion.
> 
> For people who change their names during their involvement in a project,
> it can be important that the people with whom they work only see their
> correct name, even when browsing old history.

This makes a ton of sense to me.

Thank you,
Dscho

> 
> I had a dig around in the mailing list archives and couldn't find any
> specific reason not to use a mailmap in log where one is in use. I did
> find this message which suggests that it makes sense to make it the
> default for human-consumed formats. This patch doesn't affect
> "--pretty=raw" formatting.
> 
>  Documentation/config/log.txt |  4 ++--
>  Documentation/git-log.txt    | 12 +++++++++---
>  builtin/log.c                |  2 +-
>  t/t4203-mailmap.sh           | 18 ++++++++++++++++++
>  4 files changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
> index 78d9e4453a..8a01eed46b 100644
> --- a/Documentation/config/log.txt
> +++ b/Documentation/config/log.txt
> @@ -39,5 +39,5 @@ log.showSignature::
>  	linkgit:git-whatchanged[1] assume `--show-signature`.
>  
>  log.mailmap::
> -	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
> -	linkgit:git-whatchanged[1] assume `--use-mailmap`.
> +	If false, makes linkgit:git-log[1], linkgit:git-show[1], and
> +	linkgit:git-whatchanged[1] assume `--no-use-mailmap`.
> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index 90761f1694..7815c9a6cb 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -50,9 +50,11 @@ OPTIONS
>  	commit was reached.
>  
>  --use-mailmap::
> -	Use mailmap file to map author and committer names and email
> -	addresses to canonical real names and email addresses. See
> -	linkgit:git-shortlog[1].
> +--no-use-mailmap::
> +	Use (or don't use) mailmap file to map author and committer names and
> +	email addresses to canonical real names and email addresses. The default
> +	is to use the mailmap file, but this can be overriden with the
> +	`log.mailmap` configuration option. See linkgit:git-shortlog[1].
>  
>  --full-diff::
>  	Without this flag, `git log -p <path>...` shows commits that
> @@ -205,6 +207,10 @@ log.showRoot::
>  	`git log -p` output would be shown without a diff attached.
>  	The default is `true`.
>  
> +log.mailmap::
> +	If `false`, makes `git log` and related commands assume
> +	`--no-use-mailmap`.
> +
>  log.showSignature::
>  	If `true`, `git log` and related commands will act as if the
>  	`--show-signature` option was passed to them.
> diff --git a/builtin/log.c b/builtin/log.c
> index e8e51068bd..41a5eefb20 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -46,7 +46,7 @@ static int default_follow;
>  static int default_show_signature;
>  static int decoration_style;
>  static int decoration_given;
> -static int use_mailmap_config;
> +static int use_mailmap_config = 1;
>  static const char *fmt_patch_subject_prefix = "PATCH";
>  static const char *fmt_pretty;
>  
> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> index 43b1522ea2..efb145c4cd 100755
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -424,6 +424,24 @@ EOF
>  
>  test_expect_success 'Log output with --use-mailmap' '
>  	git log --use-mailmap | grep Author >actual &&
> +	test_cmp expect actual &&
> +# --use-mailmap is the default
> +	git log | grep Author >actual &&
> +	test_cmp expect actual
> +'
> +
> +cat >expect <<\EOF
> +Author: CTO <cto@coompany.xx>
> +Author: claus <me@company.xx>
> +Author: santa <me@company.xx>
> +Author: nick2 <nick2@company.xx>
> +Author: nick2 <bugs@company.xx>
> +Author: nick1 <bugs@company.xx>
> +Author: A U Thor <author@example.com>
> +EOF
> +
> +test_expect_success 'Log output with --no-use-mailmap' '
> +	git log --no-use-mailmap | grep Author >actual &&
>  	test_cmp expect actual
>  '
>  
> -- 
> 2.20.0
> 
> 
