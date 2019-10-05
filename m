Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EDA31F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 00:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbfJEAkm (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 20:40:42 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33239 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfJEAkm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 20:40:42 -0400
Received: by mail-vs1-f68.google.com with SMTP id p13so5307855vso.0
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 17:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=decljxdSTfDt1dS4CUpx6OCHe7eA8LoaS0TE5ex6drI=;
        b=W0tae3tl3dyGAOfKeQqN0VvHUc6EQbzUy2ll4qmyqQ6IVPEaD/MmxGDi8MzJ6IjS64
         GX/B10LSwgxgkWXQsOS/g/KslQIOG/fzJ0/aNzimG8Mkl1HCHlaD/R9mUlpjqibCgevN
         qP+C6TqaBtv2V2c9hfv+mI7oHQxylzT1QBusOOSy2heUtlo9TZLKJowtJdOLAtYLl0Cw
         IAWHgsyq6vEwNyIMd5pIGk7O8e2wodsLSVkaoflhcJxCDBqlY+tziafQDSuh8IemS9F5
         NULKRXG14clY6gnDoNNLpC6JdKDwiySKeau7bUPFplQo5lzVLjpgGetmiTBPQigK1uRQ
         IXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=decljxdSTfDt1dS4CUpx6OCHe7eA8LoaS0TE5ex6drI=;
        b=ZFaoKm+ocno2m184x9aKOHp6tOqQBQ0aM7SpIScwGy0lcGLkTfvMYi3g8uDr6NLq04
         HHVJvi2lv4fnm/acfN+rFr+vgsQou5xU35WExQx83bjRW4QBCUqO8j1Opil4Tz3EW/EL
         q4GdLXY3+f12uRSxuuf53dlJYUy+VqXvFszy23EJfxjRg3JC/JTI4uWdBmpLC4gxfoA4
         hRV4GtY9mQBzXEFrHzXuXC6VKRANkD/DXR1VJfwI4N3VRrrSDFEX9EabWNE6zSz/gBpX
         q3m9Ey2P4/WpTmxCVqyJ4JPw/FnN+2Hk8OMadQSUQEkezOWn3295Z1ZUAXYmrdOmxi3u
         KeKg==
X-Gm-Message-State: APjAAAVsxYwnb2Cu+yBKkTO+HzsNfNoOlttDOxK18c6ytUfy/gv3Cvh6
        CNK7TXbHa93Bj4CiTt7HcuQBoDpn22szeSBNLiAUG42aamA=
X-Google-Smtp-Source: APXvYqwiodaRwInQTideWOGtpInw8CJt9emio1JbdQqNf6qkw/ujhF90RkXfTbt+zfh2i7VzMQLJ6Lbp2VxqB7SRuys=
X-Received: by 2002:a67:f502:: with SMTP id u2mr9593675vsn.117.1570236039653;
 Fri, 04 Oct 2019 17:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqsgoabes8.fsf@gitster-ct.c.googlers.com> <972f4674-ed00-7113-24eb-f59f1b751690@gmail.com>
In-Reply-To: <972f4674-ed00-7113-24eb-f59f1b751690@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 Oct 2019 17:40:28 -0700
Message-ID: <CABPp-BE+D-GFJaucgCCsBA8E7nQAxc0vNE92HaCpOTQrUp=mPA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2019, #01; Thu, 3)
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 4, 2019 at 4:49 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Junio
>
> On 03/10/2019 06:04, Junio C Hamano wrote:
> > Here are the topics that have been cooking.  Commits prefixed with
> > '-' are only in 'pu' (proposed updates) while commits prefixed with
> > '+' are in 'next'.  The ones marked with '.' do not appear in any of
> > the integration branches, but I am still holding onto them.
> > [...]
> >
> >
> > * pw/rebase-i-show-HEAD-to-reword (2019-08-19) 3 commits
> >   - sequencer: simplify root commit creation
> >   - rebase -i: check for updated todo after squash and reword
> >   - rebase -i: always update HEAD before rewording
> >   (this branch is used by ra/rebase-i-more-options.)
> >
> >   "git rebase -i" showed a wrong HEAD while "reword" open the editor.
> >
> >   Will merge to 'next'.
>
> That's great, thanks
>
> >
> > * ra/rebase-i-more-options (2019-09-09) 6 commits
> >   - rebase: add --reset-author-date
> >   - rebase -i: support --ignore-date
> >   - sequencer: rename amend_author to author_to_rename
> >   - rebase -i: support --committer-date-is-author-date
> >   - sequencer: allow callers of read_author_script() to ignore fields
> >   - rebase -i: add --ignore-whitespace flag
> >   (this branch uses pw/rebase-i-show-HEAD-to-reword.)
> >
> >   "git rebase -i" learned a few options that are known by "git
> >   rebase" proper.
> >
> >   Is this ready for 'next'.
>
> Nearly, but not quite I think cf [1]. Also I'm still not convinced that
> having different behaviors for --ignore-whitespace depending on the
> backend is going to be helpful but maybe they are close enough not to
> matter too much in practice [2].

Sorry I should have chimed in sooner; I can speak to the second point.
I would say that in practice it doesn't matter a lot; in most cases
the two overlap.  Both am's --ignore-whitespace and merge's
-Xignore-space-change are buggy (in different ways) and should be
fixed, but I'd consider them both to be buggy in edge cases.  I
recommended earlier this summer that Rohit submit the patches without
first attempting to fix apply or xdiff, and kept in my TODO list
that'd I'd go in and fix xdiff later if Rohit didn't have extra time
for it.  I did a little digging back then to find out the differences
and suggested some text to use to explain them and to argue that they
shouldn't block this feature:

"""
am's --ignore-space-change (an alias for am's --ignore-whitespace; see
git-apply's description of those two flags) not only share the same
name with diff's --ignore-space-change and merge's
-Xignore-space-change, but the similarity in naming appears to have
been intentional with am's --ignore-space-change and merge's
-Xignore-space-change being designed to have the same functionality
(see e.g. the commit messages for f008cef4abb2 ("Merge branch
'jc/apply-ignore-whitespace'", 2014-06-03) and 4e5dd044c62f
("merge-recursive: options to ignore whitespace changes",
2010-08-26)).  For the most part, these options do provide the same
behavior.  However, there are some edge cases where both apply's
--ignore-space-change and merge's -Xignore-space-change fall short of
optimal behavior, and in different ways.  In particular,
--ignore-space-change for apply will handle whitespace changes in the
context region but not in the region the other side modified, and
-Xignore-space-change will delete whitespace changes even when the
other side had no changes (thus treating both sides as unmodified).
Fixing these differences in edge cases is left for future work; this
patch simply wires interactive rebase to also understand
--ignore-whitespace by translating it to -Xignore-space-change.
"""

I've got another email with even more detail if folks need it.
