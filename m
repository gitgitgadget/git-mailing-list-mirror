Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C5A0202A4
	for <e@80x24.org>; Sat,  9 Sep 2017 11:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757397AbdIILjE (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Sep 2017 07:39:04 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:45052 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753489AbdIILjE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2017 07:39:04 -0400
Received: by mail-wm0-f48.google.com with SMTP id 137so11356853wmj.1
        for <git@vger.kernel.org>; Sat, 09 Sep 2017 04:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ajtnUrd0g2XchTIF4XTKxOweGQKmxuRU3PZ0yq/6rrs=;
        b=g0zRbj18VSCYLQf4TYcaFnT3+E6pkOiOmmnHJzz8ANdJqpYHFLqZfnq2tOFUgb2K6a
         NcilEA1ZnP8ltU6MqTaxNAoE3e1QdQQZIHdT7n0nfnSSceJLUggdLVziEKDXXJJP2LOD
         wN6q6PXhZIuYLHa2BRkbXJVH2pO90mQ9Wh2cy/tY39NZd2RPb9wQKz5iu7h0EFD8Rj/q
         rMVz+UuPWAoYwI4Oex1j2hlThP9/3NFPMOZuL+kwb7Sm4ihkSM6Z8qisCewizmHhCxx/
         jBuT/P5yi+Twh0dTBmDgrccx6z1PztGkRFG17lpRT/MRppxxfKTK28d4Ja+EEPDbKXt/
         3EYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ajtnUrd0g2XchTIF4XTKxOweGQKmxuRU3PZ0yq/6rrs=;
        b=o6/kUvnsehatTWocetJswlalSzZPAXypqA/TNyo6m+h4aWwLva/7f4xsMCtmgKq28F
         8Xs6pFGzSEfcXpbwzFjPFR8CLnXX5d90h3Ri+TJpZCnIDnGj/IQa7tLjrqRM2SJRgxgT
         w7I230FAOP9RI+6i4ajZRZhTd8K9Niof+mwl4TaEstyncQxRN0Ps+/ui54lUX6uP4v+X
         wgNu3qYv232KNAYnrOoyVdNo8dsc3fmY8v9tr/MlJ2Ajlh2SpAYtatPhyUa5NR+jk9Zg
         oHU6GaOAENbxxmnUOct56i13lslqy7cgqtTCMwRig/Sx7N6zKty5xiVXWCit17pY8zrF
         Go/w==
X-Gm-Message-State: AHPjjUhjkxCJ+jkzYpsh9TOylJw0U+vnnZhrU/qG3dJLwUbRWV2zMIY8
        JvjeDKHeVJ4AglbonUCjykIDL0HP8JxC
X-Google-Smtp-Source: ADKCNb5okHDgZd+NMSKE0l5uZaGupkdB5zax7PfeCcx4M9uRCLcr4l6c/x8TRV9paVGuZ56PPti9nEud8CklTHSlnFY=
X-Received: by 10.80.135.4 with SMTP id i4mr4575780edb.20.1504957142788; Sat,
 09 Sep 2017 04:39:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.216.197 with HTTP; Sat, 9 Sep 2017 04:39:02 -0700 (PDT)
In-Reply-To: <0696f94d-28c2-1f4b-03ee-16553d97f318@gmail.com>
References: <0696f94d-28c2-1f4b-03ee-16553d97f318@gmail.com>
From:   Yubin Ruan <ablacktshirt@gmail.com>
Date:   Sat, 9 Sep 2017 19:39:02 +0800
Message-ID: <CAJYFCiMV62HXD8++9ThvWWV8VELG89hUf++90TTCrD8ARMk2JA@mail.gmail.com>
Subject: Re: git diff <commit> doesn't quite work as documented?
To:     Olaf Klischat <olaf.klischat@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-09-08 0:31 GMT+08:00 Olaf Klischat <olaf.klischat@gmail.com>:
> oklischat@oklischat:/tmp$ mkdir gittest
> oklischat@oklischat:/tmp$ cd gittest/
> oklischat@oklischat:/tmp/gittest$ git init
> Initialized empty Git repository in /private/tmp/gittest/.git/
> oklischat@oklischat:/tmp/gittest$ echo foo > foo.txt
> oklischat@oklischat:/tmp/gittest$ git add foo.txt
> oklischat@oklischat:/tmp/gittest$ git commit -m foo
> [master (root-commit) 54d55f2] foo
>  1 file changed, 1 insertion(+)
>  create mode 100644 foo.txt
> oklischat@oklischat:/tmp/gittest$ echo bar > bar.txt
> oklischat@oklischat:/tmp/gittest$ git add bar.txt
> oklischat@oklischat:/tmp/gittest$ git commit -m bar
> [master 83b2e74] bar
>  1 file changed, 1 insertion(+)
>  create mode 100644 bar.txt
> oklischat@oklischat:/tmp/gittest$ git tag bar-added
> oklischat@oklischat:/tmp/gittest$ git rm bar.txt
> rm 'bar.txt'
> oklischat@oklischat:/tmp/gittest$ git commit -m 'rm bar'
> [master 3ca4ff9] rm bar
>  1 file changed, 1 deletion(-)
>  delete mode 100644 bar.txt
> oklischat@oklischat:/tmp/gittest$
> oklischat@oklischat:/tmp/gittest$ git checkout bar-added -- bar.txt
> oklischat@oklischat:/tmp/gittest$ git reset HEAD
> oklischat@oklischat:/tmp/gittest$ git status
> On branch master
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
>
>         bar.txt
>
> nothing added to commit but untracked files present (use "git add" to track)
> oklischat@oklischat:/tmp/gittest$ git diff bar-added   # would expect this to show no differences
> diff --git a/bar.txt b/bar.txt
> deleted file mode 100644
> index 5716ca5..0000000
> --- a/bar.txt
> +++ /dev/null
> @@ -1 +0,0 @@
> -bar
> oklischat@oklischat:/tmp/gittest$
> oklischat@oklischat:/tmp/gittest$ git diff bar-added  -- bar.txt   # dito
> diff --git a/bar.txt b/bar.txt
> deleted file mode 100644
> index 5716ca5..0000000
> --- a/bar.txt
> +++ /dev/null
> @@ -1 +0,0 @@
> -bar

Michael J Gruber is correct about the working-dir/working-tree things.
A quick example: add a new file with

    $ echo bzz > bzz.txt

then do "git diff bar-added".

The result is the same, because "bzz.txt" is not in the working-tree.

Yubin

> oklischat@oklischat:/tmp/gittest$
>
>
> `git diff --help' says:
>
> git diff [--options] <commit> [--] [<path>...]
>            This form is to view the changes you have in your working tree relative to the named <commit>.
>
> If that were entirely true, the last two commands shouldn't have shown
> any differences, right?
>
> On closer inspection, it seems that what `git diff <commit>' really
> does is take only those paths in the working directory that are also
> in <commit> and compare the resulting tree against <commit>.
>
> We should add some option to that git diff form to make it really do
> what the docs claim it does.
>
> Or am I missing something?
