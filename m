Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95E1D20248
	for <e@80x24.org>; Mon, 18 Mar 2019 07:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfCRHJG (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 03:09:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53459 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfCRHJF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 03:09:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id e74so11764749wmg.3
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 00:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=WhqDyGy2nrFEuwD+O610qmFHEcer5iDwqcnnSKw3PK8=;
        b=DBemOdvNBmijIosXub18pt54m8rmfC+Io+SKwt4di21znu7rzOkx40XcjqBi3kUeie
         m9GWv5AvAfvLD0ORS3fkyskQMfRWCc8cBsSmPuCFIcplJNnR9HfOZFC8sHRV7/foFFA2
         sHsl5mSQ/uA0HPZb7KXyKP+GiglzpK4jMzuG+PpRCspN3uR+zCZG+0UfjJurgMOFEidJ
         xY2J/fP1E08W07pyj+/4QkgL1Wyzuk7pS4e5Hn5WJ9TPv44X67EahZGENEJhHamRUeYQ
         E74AERNOAk/UJVp7GgDI6ytRcpeOvNG+ofahDjFsDCJxsJdfYQ+PyZnJKTGkguCUGJ1f
         xqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=WhqDyGy2nrFEuwD+O610qmFHEcer5iDwqcnnSKw3PK8=;
        b=NdoIsHRgbJUrvV1+ut6OAMJVXkkrjupwkyVB+KW/ivw90iuJS5W8LU4SQxJ1iSpLlR
         aZKwzM/ngtefs1Q7DA7+/z5sanXhpO0hHMzUC2+cbuMZhHBDa+IX+FJqqne63LOFWRSf
         CYxdjF67uXWuH99UYHbj8vmpsTBHeSmHeJ3Wg7E4rA3k8OhfsWLKkVb4bVKluxfcw1wX
         GfZaTtbOBU2O92GoR3EiD5JiuiwKU+RRHRPzD2z9Ihy/LtI7BIT0OPJvwgktCu8UooDF
         n3S1n4PRi+U5LjODjFV34L2zYEE7BrDDlVHoe4QG1Pb5xlMaLWbPOC7w2DAy5zrjOZm7
         YJHQ==
X-Gm-Message-State: APjAAAX/Tghx84b4K2JLUOPXaG+AifRmsjEa5OmXdEvwIzplq9ieX/Wf
        G6clyjumU6ihT/iyifheIpQ=
X-Google-Smtp-Source: APXvYqwgWYtsyghwVc8Nm/PY3zBgK0cHagnQ8HSF35g8h6+vQ5BFtE54OnRsUl5U5Bs1opQ1aYJg9Q==
X-Received: by 2002:a05:600c:20d:: with SMTP id 13mr867404wmi.27.1552892943857;
        Mon, 18 Mar 2019 00:09:03 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id h10sm14347244wmf.2.2019.03.18.00.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 00:09:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alexander Blesius <alexander+git@blesius.eu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: fix typos in man pages
References: <6e00f5fc-13a3-a9b9-d964-f787ae194a73@blesius.eu>
Date:   Mon, 18 Mar 2019 16:09:02 +0900
Message-ID: <xmqq7ecw1wxd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alexander Blesius <alexander+git@blesius.eu> writes:

> Signed-off-by: Alexander Blesius <alexander+git@blesius.eu>
> ---
>  Documentation/git-worktree.txt  | 4 ++--
>  Documentation/gitattributes.txt | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index cb86318f3e..fa5ec7a5dc 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -213,8 +213,8 @@ refs of one working tree from another.
>   In general, all pseudo refs are per working tree and all refs starting
>  with "refs/" are shared. Pseudo refs are ones like HEAD which are
> -directly under GIT_DIR instead of inside GIT_DIR/refs. There are one
> -exception to this: refs inside refs/bisect and refs/worktree is not
> +directly under GIT_DIR instead of inside GIT_DIR/refs. There is one
> +exception to this: refs inside refs/bisect and refs/worktree are not
>  shared.
>   Refs that are per working tree can still be accessed from another
> diff --git a/Documentation/gitattributes.txt
> b/Documentation/gitattributes.txt

Oops.  Like-wrapped patch.  Please make sure your MUA does not
corrupt your patch before sending a patch the next time.  With a
small change like this, I can manually type the change and pretend
as if I applied the patch, so no need to resend this particular one.

Thanks again.

> index 9b41f81c06..908d9a3009 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -314,8 +314,8 @@ stored as UTF-8 internally. A client without
> `working-tree-encoding`
>  support will checkout `foo.ps1` as UTF-8 encoded file. This will
>  typically cause trouble for the users of this file.
>  +
> -If a Git client, that does not support the `working-tree-encoding`
> -attribute, adds a new file `bar.ps1`, then `bar.ps1` will be
> +If a Git client that does not support the `working-tree-encoding`
> +attribute adds a new file `bar.ps1`, then `bar.ps1` will be
>  stored "as-is" internally (in this example probably as UTF-16).
>  A client with `working-tree-encoding` support will interpret the
>  internal contents as UTF-8 and try to convert it to UTF-16 on checkout.
