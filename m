Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A52071F453
	for <e@80x24.org>; Mon,  4 Feb 2019 11:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbfBDLGz (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 06:06:55 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:53188 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729825AbfBDKnM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 05:43:12 -0500
Received: by mail-it1-f193.google.com with SMTP id d11so19966128itf.2
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 02:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E/A2P6h38bSIe8/nHN/76xUFBpLGZIDRuwOtYHY+iPE=;
        b=Fg4iRFSbT65FZBejoSAc9mISkqHvawE7JQ78BKjfyX5nm7j5jnBk4Nkimpqz/DdDQ0
         eYT/PwptKblHpXSOqpoC1sYhvzoKJPEyyU3KkLhiAaU3gRGqlvc3O2F+bxhCBr1ayIsR
         vYvpdGA6nyejF3yL325OTOCk3G7JUq8Xq1ka1RKNWD8fMEAbSB8oCrDzM+UgfJ2+gOki
         gsaDiZ/mmcO5ndgRUNICRPAao/h2P2zULkuy8X3hrbote3gwKVakznKsIMfCheJ+9tCh
         B/rROJeBH4q61SN/SxOLraSrT1UR3cM5FNGJBtVqihkm+vEfmTn5GwLge+9v281nldcX
         Pj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E/A2P6h38bSIe8/nHN/76xUFBpLGZIDRuwOtYHY+iPE=;
        b=bHXyYRXDRrvEx0scJKkOa4AKEWQLCbYC5zhrUjBUXA6P/xi3KTBd9+jLKsJmDWo1/6
         9+e7FwEpNMdTEQAxAAseGtUpjp9tqN9IzN2lgG24/ik0x6JxEtSrWaYt1MpD/nTxaL0i
         +eYpCopG0hSZQjMWjCpFUGB2imbNiHA2pdAPp5EQSfP/npdt2UHUxOGZEbGalGdQcEyU
         a+3vLfGGS5Mb9vBfy2hiy7pCGvDahW1HqdnimYAEAfDSlj15y1eZrF9ujhFrRh5e2ORe
         B1GlOBELzhvkNKtN1RxgI6lVREpnhW1bGpKdWWMlnnkngenG1wJqs54mtYPApc5MfEpo
         BjSg==
X-Gm-Message-State: AHQUAuZdgNj0U4xh83XDEJAxqIT9af9MjtBfa1vp/NxkOk0TIYgls6Z7
        IFTkx1as/NoU/yjpKZd8F8zn72zzvylYaX8gyC/wrw==
X-Google-Smtp-Source: AHgI3IbQsHlPnBJcbFJP/ybpY53ZtqebbHj+U7iQCZ9bYMTPS72iQ5bZ8I/FtyY2/bsNNrWVxQgkBdv+6JXeQVWRVg0=
X-Received: by 2002:a6b:c544:: with SMTP id v65mr23222481iof.118.1549276991907;
 Mon, 04 Feb 2019 02:43:11 -0800 (PST)
MIME-Version: 1.0
References: <1292425376-14550-12-git-send-email-pclouds@gmail.com> <20190204103618.17992-1-avarab@gmail.com>
In-Reply-To: <20190204103618.17992-1-avarab@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 4 Feb 2019 17:42:45 +0700
Message-ID: <CACsJy8BnwRfBZvOq9Yng_n4aqAX0DRG4csbMjVe=9CRWSTajbQ@mail.gmail.com>
Subject: Re: [PATCH] diff-tree doc: correct & remove wrong documentation
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 4, 2019 at 5:36 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> The documentation saying that diff-tree didn't support anything except
> literal prefixes hasn't been true since
> d38f28093e ("tree_entry_interesting(): support wildcard matching",
> 2010-12-15), but this documentation was not updated at the time.
>
> Since this command uses pathspecs like most other commands, there's no
> need to show examples of how the various "cmd <revs> <paths>"
> invocations work.
>
> Furthermore, the "git diff-tree --abbrev 5319e4" example shown here
> never worked. We'd ended up with that through a combination of
> 62b42d3487 ("docs: fix some antique example output", 2011-05-26) and
> ac4e086929 ("Adjust core-git documentation to more recent Linus GIT.",
> 2005-05-05), but "git diff-tree <tree>" was always invalid.

Nice!

I was going to protest "but it does not work!" but I was thinking
ls-tree instead of diff-tree.

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  Documentation/git-diff-tree.txt | 51 +--------------------------------
>  1 file changed, 1 insertion(+), 50 deletions(-)
>
> diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tre=
e.txt
> index 2319b2b192..43daa7c046 100644
> --- a/Documentation/git-diff-tree.txt
> +++ b/Documentation/git-diff-tree.txt
> @@ -31,10 +31,7 @@ include::diff-options.txt[]
>
>  <path>...::
>         If provided, the results are limited to a subset of files
> -       matching one of these prefix strings.
> -       i.e., file matches `/^<pattern1>|<pattern2>|.../`
> -       Note that this parameter does not provide any wildcard or regexp
> -       features.
> +       matching one of the provided pathspecs.
>
>  -r::
>          recurse into sub-trees
> @@ -114,52 +111,6 @@ include::pretty-options.txt[]
>
>
>  include::pretty-formats.txt[]
> -
> -
> -LIMITING OUTPUT
> ----------------
> -If you're only interested in differences in a subset of files, for
> -example some architecture-specific files, you might do:
> -
> -       git diff-tree -r <tree-ish> <tree-ish> arch/ia64 include/asm-ia64
> -
> -and it will only show you what changed in those two directories.
> -
> -Or if you are searching for what changed in just `kernel/sched.c`, just =
do
> -
> -       git diff-tree -r <tree-ish> <tree-ish> kernel/sched.c
> -
> -and it will ignore all differences to other files.
> -
> -The pattern is always the prefix, and is matched exactly.  There are no
> -wildcards.  Even stricter, it has to match a complete path component.
> -I.e. "foo" does not pick up `foobar.h`.  "foo" does match `foo/bar.h`
> -so it can be used to name subdirectories.
> -
> -An example of normal usage is:
> -
> -  torvalds@ppc970:~/git> git diff-tree --abbrev 5319e4
> -  :100664 100664 ac348b... a01513...   git-fsck-objects.c
> -
> -which tells you that the last commit changed just one file (it's from
> -this one:
> -
> -------------------------------------------------------------------------=
-----
> -commit 3c6f7ca19ad4043e9e72fa94106f352897e651a8
> -tree 5319e4d609cdd282069cc4dce33c1db559539b03
> -parent b4e628ea30d5ab3606119d2ea5caeab141d38df7
> -author Linus Torvalds <torvalds@ppc970.osdl.org> Sat Apr 9 12:02:30 2005
> -committer Linus Torvalds <torvalds@ppc970.osdl.org> Sat Apr 9 12:02:30 2=
005
> -
> -Make "git-fsck-objects" print out all the root commits it finds.
> -
> -Once I do the reference tracking, I'll also make it print out all the
> -HEAD commits it finds, which is even more interesting.
> -------------------------------------------------------------------------=
-----
> -
> -in case you care).
> -
> -
>  include::diff-format.txt[]
>
>  GIT
> --
> 2.20.1.611.gfbb209baf1
>


--=20
Duy
