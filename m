Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5C141F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 19:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfJaTfR (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 15:35:17 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44177 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfJaTfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 15:35:16 -0400
Received: by mail-ed1-f67.google.com with SMTP id b18so5790923edr.11
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 12:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4qszOq07L1WK2hNVqIqDsHj3rVOm/BvwfbCw96Rc/PQ=;
        b=D+CvZl2tgiFcMzN9mJGgkAxMkB+kueSPOLYyak7wYMvLuBoBtGgm1S52kGsUCQRzXK
         a0Ac2vs/xDqOcbEMYNwh+iqU6EJo4kldzTDJGEalr1Uu/7DEQg0T5WvkjIZ4uKWEM1vn
         ZJnOsA+H3ZWORnAJnvfrW5dHc16vEze5/aL0nQHALddnKIOsUfxiQ/UmdJTYiezrmDow
         lxONbHKAzMJ4mLz+RmvYx9d4d4mnD94VGlPF26hflMqeU9AashovJyDluhmu+s7yhlpB
         nBd6TtgAFG8mZlbUQKSqNAfIx+c9AZxwF1a4uf6Sl2+o6k3TkZ4KfvNu9RwY694daJc2
         Gk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4qszOq07L1WK2hNVqIqDsHj3rVOm/BvwfbCw96Rc/PQ=;
        b=r1kEm6lR3ki3FNOT9gkzxt94t9kEzhai2NDX61zS6kFSpDfT5sZMaDPTVXxVuBJQ4N
         wzMoJodDOMZ07E3FZ3iYHldOrKl1znGo1TdT6oIJ4X8kx5b8c7i3wK3jGdKWG2Uv0p7/
         OQ0zPF+f0b2N77JgwZbOVnwCdGqZsiU1zWBYW6my40vMcDs24IPBn8mhEI4k6+DAg1ko
         35cAPcJ75zkTRmjkT5/wh1NnuHl6nbwMjqjlTLXO9vP7a1naU6cEWNTmgOVdcjc64vkI
         PkdD1n97kzpjZAek9Jd5Vq13c4FGGeMlzP+uHtV03dIrdP1UIAegY7eRKLvbzP0ceWHa
         sjlQ==
X-Gm-Message-State: APjAAAUPM4gdc1VWOBY7qrCLMM/YXga+2TCW9/iuADxYxmXTMNZGunT8
        73IA2NtQFYx5u86izeYvs0R2OFzrlcnvWey9St8=
X-Google-Smtp-Source: APXvYqy48ijVjD90bDNvC0JZuw5vqw+edO4OLOqo5M7S6FXlppYxnhrf+5A/p+iUkf/HGZyk7P+dzi/SIIf4F/tCiPc=
X-Received: by 2002:a17:906:7e48:: with SMTP id z8mr5892674ejr.116.1572550514344;
 Thu, 31 Oct 2019 12:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
 <504f1f7c892c8bfc4774ac5fec912855e74e38a5.1572343246.git.gitgitgadget@gmail.com>
 <CABPp-BEYeCwTKXLTdaORrBGAFYb0X13rMMiQXwXv=UDSBKHnYQ@mail.gmail.com>
In-Reply-To: <CABPp-BEYeCwTKXLTdaORrBGAFYb0X13rMMiQXwXv=UDSBKHnYQ@mail.gmail.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Fri, 1 Nov 2019 08:35:02 +1300
Message-ID: <CACg5j25WCHf8_pMVPeakYx-sdSG+-naPPchqUCesfaNQHVCCNQ@mail.gmail.com>
Subject: Re: [PATCH 04/10] merge: move doc to ll-merge.h
To:     Elijah Newren <newren@gmail.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 31, 2019 at 11:09 AM Elijah Newren <newren@gmail.com> wrote:
>
> Hi Heba,
> Thanks for the contribution.  I know you weren't the original author
> of most this stuff, but I was curious if it really all belonged in
> ll-merge.c and then noticed other issues...

Hi Elijah, thanks a lot for the feedback.
This is my first interaction with the merge API, so I wasn't
completely sure where the intro of the doc needed to go, looks like
ll-merge.h is not the perfect place, is there a top level merge file
where this generic intro would be more suitable and helpful?

> On Tue, Oct 29, 2019 at 11:49 AM Heba Waly via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> [...]
> > diff --git a/ll-merge.h b/ll-merge.h
> > index e78973dd55..ec3617c627 100644
> > --- a/ll-merge.h
> > +++ b/ll-merge.h
> > @@ -7,16 +7,94 @@
> >
> >  #include "xdiff/xdiff.h"
> >
> > +/**
> > + * The merge API helps a program to reconcile two competing sets of
>
> Is this talking about xdiff/xmerge.c, ll_merge.c, merge-recursive.c,
> or builtin/merge.c?  Those are all different level of "merge API" and
> it's not clear.  Perhaps "The Low Level Merge API" or something like
> that since you are moving it into ll-merge.h?

Yea, that's why I'm thinking maybe move this paragraph to another
top-level file?

> > + * improvements to some files (e.g., unregistered changes from the work
> > + * tree versus changes involved in switching to a new branch), reporting
> > + * conflicts if found.
>
> Seems weird to bring up checkout -m without mentioning in by name
> given that it isn't the default checkout behavior.  Would seem more
> natural to mention a merge or rebase case.

I agree with you, can change the example if we agreed on keeping this paragraph.

> > + *   The library called through this API is
> > + * responsible for a few things.
> > + *
> > + *  - determining which trees to merge (recursive ancestor consolidation);
>
> Um, that's done at the merge-recursive.c level, not at the ll-merge.c
> level.  I'm confused why it'd be mentioned here.

you're right.

> > + *  - lining up corresponding files in the trees to be merged (rename
> > + *    detection, subtree shifting), reporting edge cases like add/add
> > + *    and rename/rename conflicts to the user;
>
> All of that is also clearly stuff for merge-recursive.c; I'm not sure
> why it'd be mentioned in the Low-Level merge file.

got it.

> > + *  - performing a three-way merge of corresponding files, taking
> > + *    path-specific merge drivers (specified in `.gitattributes`)
> > + *    into account.
>
> This, however, is ll-merge.c stuff.

So, move the whole paragraph to another file?
because, I think the paragraph is helpful as a whole, and I don't see
the value in dividing it between merge-recursive and ll-merge.
What do you think?

> > + *
> > + * Calling sequence:
> > + * ----------------
> > + *
> > + * - Prepare a `struct ll_merge_options` to record options.
> > + *   If you have no special requests, skip this and pass `NULL`
> > + *   as the `opts` parameter to use the default options.
> > + *
> > + * - Allocate an mmbuffer_t variable for the result.
> > + *
> > + * - Allocate and fill variables with the file's original content
> > + *   and two modified versions (using `read_mmfile`, for example).
> > + *
> > + * - Call `ll_merge()`.
> > + *
> > + * - Read the merged content from `result_buf.ptr` and `result_buf.size`.
> > + *
> > + * - Release buffers when finished.  A simple
> > + *   `free(ancestor.ptr); free(ours.ptr); free(theirs.ptr);
> > + *   free(result_buf.ptr);` will do.
> > + *
> > + * If the modifications do not merge cleanly, `ll_merge` will return a
> > + * nonzero value and `result_buf` will generally include a description of
> > + * the conflict bracketed by markers such as the traditional `<<<<<<<`
> > + * and `>>>>>>>`.
> > + *
> > + * The `ancestor_label`, `our_label`, and `their_label` parameters are
> > + * used to label the different sides of a conflict if the merge driver
> > + * supports this.
> > + */
>
> This part looks good.
>
> > +/**
> > + * This describes the set of options the calling program wants to affect
> > + * the operation of a low-level (single file) merge.
> > + */
> >  struct ll_merge_options {
> > +
> > +    /**
> > +     * Behave as though this were part of a merge between common ancestors in
> > +     * a recursive merge. If a helper program is specified by the
> > +        * `[merge "<driver>"] recursive` configuration, it will be used.
> > +     */
>
> This kind of leaves out the why.  Maybe add "(merges of binary files
> may need to be handled differently in such cases, for example)" to the
> end of the first sentence?

Yes, ok.

> >         unsigned virtual_ancestor : 1;
> > -       unsigned variant : 2;   /* favor ours, favor theirs, or union merge */
> > +
> > +       /**
> > +        * Resolve local conflicts automatically in favor of one side or the other
> > +        * (as in 'git merge-file' `--ours`/`--theirs`/`--union`).  Can be `0`,
> > +        * `XDL_MERGE_FAVOR_OURS`, `XDL_MERGE_FAVOR_THEIRS`,
> > +        * or `XDL_MERGE_FAVOR_UNION`.
> > +        */
> > +       unsigned variant : 2;
> > +
> > +       /**
> > +        * Resmudge and clean the "base", "theirs" and "ours" files before merging.
> > +        * Use this when the merge is likely to have overlapped with a change in
> > +        * smudge/clean or end-of-line normalization rules.
> > +        */
> >         unsigned renormalize : 1;
>
> All looks good.
>
> > +
> >         unsigned extra_marker_size;
>
> No documentation for this one?  Perhaps:
>
> /*
>  * Increase the length of conflict markers so that nested conflicts
>  * can be differentiated.
>  */

sure.

> >         long xdl_opts;
>
> Perhaps document this one with:
>
> /* Extra xpparam_t flags as defined in xdiff/xdiff.h. */

great. thanks!

>
>
> >  };
> >
> > +/**
> > + * Perform a three-way single-file merge in core.  This is a thin wrapper
> > + * around `xdl_merge` that takes the path and any merge backend specified in
> > + * `.gitattributes` or `.git/info/attributes` into account.
> > + * Returns 0 for a clean merge.
> > + */
> >  int ll_merge(mmbuffer_t *result_buf,
> >              const char *path,
> >              mmfile_t *ancestor, const char *ancestor_label,
