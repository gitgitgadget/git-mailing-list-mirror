Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB46C1F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 02:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfJZC07 (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 22:26:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42441 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfJZC06 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 22:26:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id f14so2800272pgi.9
        for <git@vger.kernel.org>; Fri, 25 Oct 2019 19:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oMYW1yXMJpfG75u8mMfdrp3HrSTqQMZofnKr3M+vSjY=;
        b=UyMifQEv2Scc/D3iu7tvw880rd6i7Hpk2oCtXCKkPQrvc1kN3vMmICu55eN1un9wdP
         YfXPxnVNFsH1SFsWhvM93O9HlOf4DCT3r6KYpw3NzXOcDqIkhdOsTAf5v6aeOFDhE1qp
         QzUd0fJz4cf8K52s2yX8zgNbWfqgAT3aWFJ8cQmzARokQ5SBREQlVKbTq+ZTQBA0mMJB
         Q1MsoFGBRrCnrQjZAFKO+zSF+7R4737zdtUzPTV6i8nXokFqpkM25dNtvL/HNMV1hlH1
         ttokVxb1/9wnbizVDlhZ99+3Gr4PtrSo/vOgumhzyJjF11sgaEEdpP0sYeYgeEGCem0O
         s2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oMYW1yXMJpfG75u8mMfdrp3HrSTqQMZofnKr3M+vSjY=;
        b=awl0zez5kJRVSwCylaWhrl7dNTTuOKxJRWArfZDsrg7cillLC1VKCrUICTzKUOab0b
         9ZTGctcmP3ubQjzbq1CebwFeDR+8KJC8uJIg44xbXNK8x3npPUqhR+GSQHSrMZng7/rT
         B6fMKsej/3wU849vRsbHuZVM3MMF0Hhk15buRaAibAkMBHlIhzKtl+al0pZtCmWIpozt
         9eorasNO2XJI3LvN6R0Y12ZkHjmhVRW1r+sXj8hAyoMJfWdBof42v3CgDeN4FU+K74Z/
         meHXcZlnWxEDhnYlzpGgHg05WliBA4ucIbbIsUGpYmLihGpIK0p1XwCsiAkEpMUUdKti
         AnVA==
X-Gm-Message-State: APjAAAW/LG0srn50kuI7gbzhwURXqdoAnVCRpC0OExqyoVXWHTUN2xpa
        CxmCKmQcFufFjfZqAuARyz8=
X-Google-Smtp-Source: APXvYqwMLfabWT4eXcUnDKs2FPXBKB/zsfmD7MafMvjqCDjPS/67IU+tUC21N0ItoAbcw8YuNL8I1A==
X-Received: by 2002:aa7:9842:: with SMTP id n2mr8050122pfq.258.1572056817934;
        Fri, 25 Oct 2019 19:26:57 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id c128sm4148114pfc.166.2019.10.25.19.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 19:26:57 -0700 (PDT)
Date:   Fri, 25 Oct 2019 19:26:55 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Mihail Atanassov <m.atanassov92@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation/git-bisect.txt: add --no-ff to merge
 command
Message-ID: <20191026022655.GF39574@google.com>
References: <20191025222032.3399-1-m.atanassov92@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025222032.3399-1-m.atanassov92@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Mihail Atanassov wrote:

> The hotfix application example uses `git merge --no-commit` to apply
> temporary changes to the working tree during a bisect operation. In some
> situations this can be a fast-forward and `merge` will apply the hotfix
> branch's commits regardless of `--no-commit` (as documented in the `git
> merge` manual).
>
> In the pathological case this will make a `git bisect
> run` invocation to loop indefinitely between the first bisect step and
> the fast-forwarded post-merge HEAD.
>
> Add `--no-ff` to the merge command to avoid this issue, and make a note
> of it for the reader.
>
> Signed-off-by: Mihail Atanassov <m.atanassov92@gmail.com>
> ---
>  Documentation/git-bisect.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Good catch.  Thanks for fixing it.

> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
> index 4b45d837a7..58b5585874 100644
> --- a/Documentation/git-bisect.txt
> +++ b/Documentation/git-bisect.txt
> @@ -412,8 +412,10 @@ $ cat ~/test.sh
>  #!/bin/sh
>  
>  # tweak the working tree by merging the hot-fix branch
> -# and then attempt a build
> +# and then attempt a build. Note the `--no-ff`: `git merge`
> +# will otherwise still apply commits if the current HEAD can be
> +# fast-forwarded to the hot-fix branch.

Hmm.  I think the comment might put a bit too much emphasis on the
"how" instead of the "why".  Is it necessary to describe why --no-ff
is used at all here?  After all, a reader wondering about it is likely
to check "git help merge", which says

	Fast-forward updates do not create a merge commit and
	therefore there is no way to stop those merges with
	--no-commit.  Thus, if you want to ensure your branch is not
	changed or updated by the merge command, use --no-ff with
	--no-commit.

So I'd be tempted to leave the comment ending with "and then attempt a
build".

Alternatively: the wording says "will still apply commits", but the
reader might not think of a merge as applying patches (that's closer
to what cherry-pick does.  Is there some alternative wording that
would convey the intent more clearly?

> -if	git merge --no-commit hot-fix &&
> +if	git merge --no-commit --no-ff hot-fix &&

Good.

Thanks and hope that helps,
Jonathan
