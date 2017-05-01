Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B263C1F829
	for <e@80x24.org>; Mon,  1 May 2017 00:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2993582AbdEAAKE (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 20:10:04 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35089 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2993573AbdEAAKD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 20:10:03 -0400
Received: by mail-pg0-f68.google.com with SMTP id c2so3547193pga.2
        for <git@vger.kernel.org>; Sun, 30 Apr 2017 17:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Q+Jsv5j1k2j8beU4oVVH9w2E7x7GVOzekKuG7KK/wbY=;
        b=bCMTvh29CNHhlkWHtjWh4xv80DRLymOpv8i1xSgLrsElDuMQJ4D0yrmvvLpXPqRR94
         3QfrEKz6Hb/lNvOKvQvK5mlXPEjp3vQmg2bq12CsYzjEyuA7ZBm+BLb8POgPKLrKMHGH
         M02+hgTYnr3AMYfmBQteodM+EFdlbugzGh3829GpaS4Lgep3YRtlWV13RMxEr78Unk1u
         QFLhrq891ISgIexurb0cDzwxgbBhyWp6GPuPSW5U4sIGF/pQgIk/zcDhnTahkQ+iYrHr
         8BcYjfIE2eXoFlbtvTzNU3bzjCt4qiTkGx+tRFTq669+WNiiHierOc9HrXOtUB1NF+3c
         IMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Q+Jsv5j1k2j8beU4oVVH9w2E7x7GVOzekKuG7KK/wbY=;
        b=bjtRjk1RQnjzGhgOYF6yLmDTyaFbxhmA0P8GLRTyNr65UIncsywlLzQ9DqwGdY90Mz
         Hx9smJXV/e5Uwz/oiDu3S0kE5esIHL+AGWWYNduZ0XE91bjrrnkXdCH4Sr3NJmKHvU9v
         mkI40S0kzCMiNcY+c/PkFcIRViBSUr46b/gTo0r8Pxcpjvex4QEor/9l/3smASrFbnIC
         5n7KfDHJqqBdcN9gD7SgpQTTIr8M5GB0L0j0tHrFwOZTGQ6F4xEz1GzZgBnSt6qsKG5S
         jjyUGQzxZl3KUxICgF4X4XHnf5Cx+BVm/+Qogop34+VCTSmyDPRA6PDCMAWDg7lQt/sI
         eFoA==
X-Gm-Message-State: AN3rC/4Ax8PdItYt6Z9pfBpEFCAnPvPzC5dtokqUq54+MAUaw/diKJrt
        d+uGIiNiNmgmJA==
X-Received: by 10.99.169.10 with SMTP id u10mr23902939pge.26.1493597402088;
        Sun, 30 Apr 2017 17:10:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:216d:aa3e:248d:bf63])
        by smtp.gmail.com with ESMTPSA id f6sm22185492pfe.57.2017.04.30.17.09.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 30 Apr 2017 17:10:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Genz <liebundartig@freenet.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: update SubmittingPatches
References: <1493566941-4122-1-git-send-email-liebundartig@freenet.de>
Date:   Sun, 30 Apr 2017 17:09:59 -0700
In-Reply-To: <1493566941-4122-1-git-send-email-liebundartig@freenet.de>
 (=?utf-8?Q?=22Ren=C3=A9?=
        Genz"'s message of "Sun, 30 Apr 2017 17:42:21 +0200")
Message-ID: <xmqqbmrdl9ns.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Genz <liebundartig@freenet.de> writes:

> -use US English spelling
> -minor wording change for better readability
>
> Helped-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: René Genz <liebundartig@freenet.de>
> ---

Thanks, will apply.  

>  Documentation/SubmittingPatches | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index bc8ad00..558d465 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -51,7 +51,7 @@ If your description starts to get too long, that's a sign that you
>  probably need to split up your commit to finer grained pieces.
>  That being said, patches which plainly describe the things that
>  help reviewers check the patch, and future maintainers understand
> -the code, are the most beautiful patches.  Descriptions that summarise
> +the code, are the most beautiful patches.  Descriptions that summarize
>  the point in the subject well, and describe the motivation for the
>  change, the approach taken by the change, and if relevant how this
>  differs substantially from the prior version, are all good things
> @@ -87,7 +87,7 @@ patches separate from other documentation changes.
>  Oh, another thing.  We are picky about whitespaces.  Make sure your
>  changes do not trigger errors with the sample pre-commit hook shipped
>  in templates/hooks--pre-commit.  To help ensure this does not happen,
> -run git diff --check on your changes before you commit.
> +run "git diff --check" on your changes before you commit.
>  
>  
>  (2) Describe your changes well.
> @@ -111,10 +111,10 @@ Improve...".
>  
>  The body should provide a meaningful commit message, which:
>  
> -  . explains the problem the change tries to solve, iow, what is wrong
> +  . explains the problem the change tries to solve, i.e. what is wrong
>      with the current code without the change.
>  
> -  . justifies the way the change solves the problem, iow, why the
> +  . justifies the way the change solves the problem, i.e. why the
>      result with the change is better.
>  
>    . alternate solutions considered but discarded, if any.
> @@ -122,7 +122,7 @@ The body should provide a meaningful commit message, which:
>  Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
>  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
>  to do frotz", as if you are giving orders to the codebase to change
> -its behaviour.  Try to make sure your explanation can be understood
> +its behavior.  Try to make sure your explanation can be understood
>  without external resources. Instead of giving a URL to a mailing list
>  archive, summarize the relevant points of the discussion.
>  
> @@ -261,7 +261,7 @@ smaller project it is a good discipline to follow it.
>  The sign-off is a simple line at the end of the explanation for
>  the patch, which certifies that you wrote it or otherwise have
>  the right to pass it on as a open-source patch.  The rules are
> -pretty simple: if you can certify the below:
> +pretty simple: if you can certify the below D-C-O:
>  
>          Developer's Certificate of Origin 1.1
