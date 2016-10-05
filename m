Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 351301F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 16:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752784AbcJEQ62 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 12:58:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33768 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751972AbcJEQ61 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 12:58:27 -0400
Received: by mail-wm0-f67.google.com with SMTP id p138so25478992wmb.0
        for <git@vger.kernel.org>; Wed, 05 Oct 2016 09:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=xXEqEZRYJm4LdWUnB8tFzVMDdfjRE/MYCQMdqbA8nbY=;
        b=b78DQ6P8A1pkQlqOl6c0ag1Knk0y5/km3AOaZxnqPX9FyNy7dewZhiU/ExPk3q4E6T
         2avDzYeZ75ukLoY6A13XP9yK2Onkhl4wKDFqa9Q3LMUbiR1i59uBwgGMWZbckOayXrOW
         Ql6ovB2FFlo7S7lFYGgAEIzwqhKpS1uDhesPkdJr0fpR/RP5B66Hvptdbmq7/NVGTypf
         cTijKPI1cykd8/X2ipH8ouRHV2K4ap0DnhgUimF+rmJyOZ5yDija75b5I2ZcP977MWYg
         VQM3AQ0yGZquzvzGQKwryAOC4YApjtssGseRx8tMXAhgdKOuddtrF+/0Fj+Ikzx43j1k
         poXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=xXEqEZRYJm4LdWUnB8tFzVMDdfjRE/MYCQMdqbA8nbY=;
        b=SNY82BfXffp06x7n5nZoNGTSlHhWKjyyLE7df5B8xtailw4e7cOK3Qk9MjGERLIY+Z
         pNx+Z9p+Mn2nu+WKPm9Ek4qhmmrV5XjdA4p12X2D60c8l4SPQExKYXoJkoJMnRW2SdKT
         S+XKufhm+eBs5y+MGDjEBwMjz5TQyrFe9bSzOP1+iFZ53s4Cru0Nb36R/RisF5HMFrJa
         Tji/VO3dGjTzcv25WzO9FM1kZATVIXWJ3rsvwxaM62fsbSADz/yLJRVwVJperw5T80vw
         Im2s3wi6XcyYEdg+b9Y9q1MqL6yeveThDq0hmdtIh3SCRjygw20xk4kVB6VJ2ivggCGk
         bdNA==
X-Gm-Message-State: AA6/9RmtIUcG5J/s4qv51n5FWyXdCUJKOvU11UQl7nozs868fhGW8OCD1JpEUqhN1r5UIA==
X-Received: by 10.194.115.38 with SMTP id jl6mr8612137wjb.28.1475686705703;
        Wed, 05 Oct 2016 09:58:25 -0700 (PDT)
Received: from [192.168.1.26] (acte13.neoplus.adsl.tpnet.pl. [83.11.58.13])
        by smtp.googlemail.com with ESMTPSA id g203sm3661067wme.2.2016.10.05.09.58.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Oct 2016 09:58:24 -0700 (PDT)
Subject: Re: [PATCH 5/6] Documentation/git-merge.txt: improve short
 description in DESCRIPTION
To:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org
References: <cover.1475678515.git.sorganov@gmail.com>
 <e74ae8afc1bfc4cd9161ccaa56d926a89439551e.1475678515.git.sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <e03a84ad-9aa6-8ada-5828-7b28f76baaaf@gmail.com>
Date:   Wed, 5 Oct 2016 18:58:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <e74ae8afc1bfc4cd9161ccaa56d926a89439551e.1475678515.git.sorganov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 05.10.2016 o 16:46, sorganov@gmail.com pisze:
> From: Sergey Organov <sorganov@gmail.com>
> 
> Old description had a few problems:
> 
> - sounded as if commits have changes
> 
> - stated that changes are taken since some "divergence point"
>   that was not defined.
> 
> New description rather uses "common ancestor" and "merge base",
> definitions of which are easily discoverable in the rest of GIT
> documentation.

This is a step in a good direction, but it has a few issues.

> 
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  Documentation/git-merge.txt | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index cc0329d..351b8fc 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -16,11 +16,16 @@ SYNOPSIS
>  
>  DESCRIPTION
>  -----------
> -Incorporates changes from the named commits (since the time their
> -histories diverged from the current branch) into the current
> -branch.  This command is used by 'git pull' to incorporate changes
> -from another repository and can be used by hand to merge changes
> -from one branch into another.
> +
> +Incorporates changes that lead to the named commits into the current
> +branch, and joins corresponding histories. The best common ancestor of
> +named commits and the current branch, called "merge base", is
> +calculated, and then net changes taken from the merge base to
> +the named commits are applied.

The first sentence is all right; it reads better than the original
without the introduced part in parentheses.  The only minor issue
is with "joins corresponding histories" - it is a good description,
but may imply that the branch we are merging vanishes: it doesn't.
But all in all, it is a good change.

Second sentence has some problems.  First, while it is a good idea
to use well defined term "merge base", I think writing "since the
time their histories diverged" or "(which is the point where histories
diverged)" would be a good plain language description; it was removed
entirely in the proposal.

Second, while "common ancestor" and "least common ancestor" are well
defined in mathematics of graphs, "best common ancestor" isn't...
but this is what git-merge-base(1) documentation uses.

Also, the "best common ancestor" doesn't need to be only one.  There
might be many such ancestors... though Git would generate then a
virtual best common ancestor thanks to recursive merge strategy.
And usually there is only one "best common ancestor", that is a single
merge base.  So this may need clarification, but it is not much of
a problem.

Third, and most important, is that "net changes taken from the merge
base to the named commits are applied" is simply not true.  The
`git merge` command does not reapply changes - that is what rebase
and cherry-pick do.  The merge operation uses 3-way merge strategy
(diff3) between merge-base, current branch, and merged commit.
That is, it finds differences between differences, and "applies"
that.

See "A Formal Investigation of Diff3" paper by Sanjeev Khanna,
Keshav Kunal, and Benjamin C. Pierce:
  http://www.cis.upenn.edu/~bcpierce/papers/diff3-short.pdf

I'm not sure how to explain it succintly.  Perhaps

  net changes between merge base to the current (merged into)
  branch and named commits are integrated

There is description of trivial 3-way merge somewhere in Git docs,
though in very unobvious place; we can link it.

> +
> +This command is used by 'git pull' to incorporate changes from another
> +repository, and can be used by hand to merge changes from one branch
> +into another.

Rather "can be used by 'git pull'", or "is used by 'git pull' (unless
configured otherwise)"...

Separating this information makes a very good sense.  Thanks.

>  
>  Assume the following history exists and the current branch is
>  "`master`":
> @@ -31,11 +36,11 @@ Assume the following history exists and the current branch is
>      D---E---F---G master
>  ------------
>  
> -Then "`git merge topic`" will replay the changes made on the
> -`topic` branch since it diverged from `master` (i.e., `E`) until
> -its current commit (`C`) on top of `master`, and record the result
> -in a new commit along with the names of the two parent commits and
> -a log message from the user describing the changes.
> +Then "`git merge topic`" will replay the changes made on the `topic`
> +branch since it diverged from `master` (i.e., `E`) until its current
> +commit (`C`) on top of `master`, and record the result in a new commit
> +along with references to the two parent commits and a log message from
> +the user describing the changes.

What the happened here!?!  Please do not rewrap documentation, especially
not without changes!

>  
>  ------------
>  	  A---B---C topic
> 
-- 
Jakub Narębski

