Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A92E2211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 06:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbeLEGUg (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 01:20:36 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42616 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbeLEGUg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 01:20:36 -0500
Received: by mail-vs1-f66.google.com with SMTP id b74so11391730vsd.9
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 22:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZFWLsBl8hN6gAdNH5skTh3d4lZLdAbEoLRd0/hRbZzo=;
        b=OWgoV9Tx4jjRkZClUYhUEsmo+UqIOfi4Otkeeh0WPUtA7hB+0hnneHnG5LPXYmv6bv
         MIUQfTqj2+RVYxHatepNb5p965fwhLNyeYnCNZxjKDWEZsJtAx32+ZmxJqrJYSi1Y4Zs
         XfJROZaWsMb+/alsJyhMAWKouvqa6k1/PnPv0AYj2RbbyZDgdz1Xik32UbNlBB5gkvYI
         +e7Ak4m7il95uD3FINsbuD0jyXMQF7cGYVUtu/cu4mirzd2yMtbT3Dd67w936P+8dczO
         my7O+qLPsLngqGuUxJx9SwXqxh3i6EF8kB7JBsZ5giMLWXWeJERWVD6SpTPCTaaBvmWC
         9cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZFWLsBl8hN6gAdNH5skTh3d4lZLdAbEoLRd0/hRbZzo=;
        b=XD7k94V98fJeOt0ybN0q8AUBzG8TTef6sS0i9j3KT5zJt/4cIhHqhO7Qy3T+8OZdfO
         5Tezb9TrxlPmtAUE37sC1OfUwzxaRNHlqT+WzbG781pK2DziCP9lvZmOV5qtSbTpPJov
         Fxtt3Oi62MZX+XfQZSv8e0F8nTiFMwH1VQsTfUO2GROemVxNrvjlZOXN9IZtN0bqj2oP
         8xUoVSPZMgTRHtyWJA03Lphj02dULhU+Kf6qz2R7MtHi1OEpd4ZQZ9t4ZkgX0qVoc5de
         WLEET2eGQsoOg//iOk9meh6DVnxaHRLejhgLQ2XuRS5pd9gqbrMw9fN7yq6A7OejnZ5A
         ZpMQ==
X-Gm-Message-State: AA+aEWYzxGZHjrR163j1gbbc8hcHisMGvzppB+063mYhs5q97M9zGJt7
        5QY2ax2vO0C2VEW1LlHf8bIbfS+oAaNN7MLep2U=
X-Google-Smtp-Source: AFSGD/UfqtMrBQkOR+Gr+lfpJW5R5MIzpt5AfnlH4yxWnqdmR4E4BHtLF2D28XE7kSDhk8xQWmRCq5WFrYGEysNncUI=
X-Received: by 2002:a67:3c5c:: with SMTP id j89mr10105328vsa.117.1543990834774;
 Tue, 04 Dec 2018 22:20:34 -0800 (PST)
MIME-Version: 1.0
References: <f2ed3730-03f3-ae92-234c-e7500eaa5c33@kdbg.org>
 <20181204231709.13824-1-newren@gmail.com> <xmqqo9a0d3w6.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo9a0d3w6.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 4 Dec 2018 22:20:23 -0800
Message-ID: <CABPp-BG=4K9VCc8zuUm0KTRG5cHPijtvQTK4QXWRVbSFu3o_fQ@mail.gmail.com>
Subject: Re: [PATCH] rebase docs: fix incorrect format of the section
 Behavioral Differences
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 4, 2018 at 7:54 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Gah, when I was rebasing on your patch I adopted your sentence rewrite
> > but forgot to remove the "sometimes".  Thanks for catching; correction:
>
> >
> > -- 8< --
> > Subject: [PATCH v2] git-rebase.txt: update note about directory rename
> >  detection and am
> >
> > In commit 6aba117d5cf7 ("am: avoid directory rename detection when
> > calling recursive merge machinery", 2018-08-29), the git-rebase manpage
> > probably should have also been updated to note the stronger
> > incompatibility between git-am and directory rename detection.  Update
> > it now.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  Documentation/git-rebase.txt | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> > index 41631df6e4..ef76cccf3f 100644
> > --- a/Documentation/git-rebase.txt
> > +++ b/Documentation/git-rebase.txt
> > @@ -569,8 +569,12 @@ it to keep commits that started empty.
> >  Directory rename detection
> >  ~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > -The merge and interactive backends work fine with
> > -directory rename detection.  The am backend sometimes does not.
> > +The merge and interactive backends work fine with directory rename
>
> I am not sure "work fine" a fair and correct label, as rename is
> always heuristic.
>
>     The "directory rename detection" heuristic in "merge" and the
>     "interactive" backends can take what happened to paths in the
>     same directory into account when deciding if a disappeared path
>     was "renamed" and to which other path.  The heuristic produces
>     incorrect result when the information given is only about
>     changed paths, which is why it is disabled when using the "am"
>     backend.
>
> perhaps.

The general idea sounds good.  Does adding a few more details help
with understanding, or is it more of an information overload?  I'm
thinking of something like:

     The "directory rename detection" heuristic in the "merge" and
     "interactive" backends can take what happened to paths in the
     same directory on the other side of history into account when
     deciding whether a new path in that directory should instead be
     moved elsewhere.  The heuristic produces incorrect results when
     the only information available is about files which were changed
     on the side of history being rebased, which is why directory
     rename detection is disabled when using the "am" backend.
