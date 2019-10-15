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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A5ED1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 15:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733278AbfJOPRU (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 11:17:20 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:44939 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733070AbfJOPRU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 11:17:20 -0400
Received: by mail-vk1-f196.google.com with SMTP id j21so4410782vki.11
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 08:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AiCUtlUDF0p28EPTsaCv5VaGJhRHVO0526ASsKcwMt8=;
        b=LcnVu/G60ayvKoZ3AzFknwFjJtKFZyi3xYblPpnBbVZ/2O11lUu9gVgyaXqp+fXZVh
         KsBWRXO/NKEa0ms7RUXDWI7WpaJad7cvF6ff9uU5n6aE4J2r+G2WvZnoYt93ptu+axVM
         v6zNb77oK0RNYXP+JIKyySWeo+uNe1Wx13JA1OkLoxtAaihcRfv9/Wus/KiaLw195ZSA
         +a7G+QaWsvyMVKZ+fMgOD6qtk67i5aWLizkXSbplTjp3fGnrj0SUTWrAqQjJvBTXFgZC
         kqJSYSoDT9RGT1umEgF3fPyPg2GDabthldNBKM6o45E3VlJMoJ7mpUjybtBSk/OrFIMn
         h4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AiCUtlUDF0p28EPTsaCv5VaGJhRHVO0526ASsKcwMt8=;
        b=C26FrKwtuWRu4CVFBm3dp8OIMzy0/614wQ0D0TXoKJaQ9L+w+ujCj34V3FcNN5f9pQ
         onDBmzw7d/5AQf1ztRa1sfpdGIzNx6M3gh8QeZBxJdY0RJPgzEmFoagIq+jVk0/oyNk+
         LSJ76eYDfosN+Mm4lmUg2q/7Io7K6b1HTOtWkkcgBTsSeKQBs3hSoLSG5h5NInJQlbrP
         IwoPiXlA8K4cI6vzBOEOjG0+yW1mBHL9xBl1tFrk21MTv1qHMRnZEnfB+fu77nEk+vAv
         hqqYHxDnxS1TctLnIjAKkLCmUIQFxnTV8qUprA61CEAc+rnpOlMgJ3yBNe4vUt1Xri0E
         YP/w==
X-Gm-Message-State: APjAAAXcqJGjmwqzRlApz+kD56XTvhYceFE70AyzMiTO9yFu3ayEqfxG
        oTtuhcR9fUsEurGgKDq0p6v0H+ysWYZnjnlyCCM=
X-Google-Smtp-Source: APXvYqxTWWmrwT3q/hETIwd0ATRmY+YRqkNHS1W/3Qw4Luk+kRhSPrG8Qz3gjweQY4A5TMJnizegCxSqX29jv8Z3qfo=
X-Received: by 2002:a1f:b2d6:: with SMTP id b205mr19164553vkf.90.1571152638624;
 Tue, 15 Oct 2019 08:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh84abmjm.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh84abmjm.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 15 Oct 2019 08:17:06 -0700
Message-ID: <CABPp-BHnSG+PtnU=jKHW2_hfLtBK1Sib_W+nqY08gGj8yHGCgw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2019, #04; Tue, 15)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 15, 2019 at 2:04 AM Junio C Hamano <gitster@pobox.com> wrote:
> * en/fast-imexport-nested-tags (2019-10-04) 8 commits
>   (merged to 'next' on 2019-10-07 at 3e75779e10)
>  + fast-export: handle nested tags
>  + t9350: add tests for tags of things other than a commit
>  + fast-export: allow user to request tags be marked with --mark-tags
>  + fast-export: add support for --import-marks-if-exists
>  + fast-import: add support for new 'alias' command
>  + fast-import: allow tags to be identified by mark labels
>  + fast-import: fix handling of deleted tags
>  + fast-export: fix exporting a tag and nothing else
>
>  Updates to fast-import/export.

Thanks!

> * en/merge-recursive-directory-rename-fixes (2019-10-12) 2 commits
>   (merged to 'next' on 2019-10-15 at ebfdc3ff7b)
>  + merge-recursive: fix merging a subdirectory into the root directory
>  + merge-recursive: clean up get_renamed_dir_portion()
>
>  A few glitches in the heuristic in merge-recursive to infer file
>  movements based on movements of other files in the same directory
>  have been corrected.
>
>  Will merge to 'master'.

I'm surprised this one was merged straight down to next; perhaps I
should have highlighted my plans a bit clearer in the thread?  I did
mention (at the end of an email) at [1], that

"Oh, and I think there's another place in the code that needs to be
tweaked to make sure we handle renaming subdirectories into the root
directory that I missed (and just wasn't tested by this testcase), so
I'll check into it and if so fix the code and add another testcase,
and include the fixups I agreed to above and send out a v2.  Probably
won't get to it until the middle of next week, though."

So, I guess I'll submit a fixup patch on top instead, either later
today or tomorrow.

Also, a very minor point but "glitches" may be misleading; it suggests
(to me at least) a malfunction rather than a failure to trigger, and
it's really only the special case of renaming/merging of a directory
into the root directory that the previous heuristics failed to detect.
The rest of the fixes were make-the-code-clearer (there were a couple
places in the code that were technically correct but quite misleading
and hard to reason about).

[1] https://public-inbox.org/git/CABPp-BFNCLJnt4NgFKVxURBGD1Z00gastc5q4ZPjcHmwS=kuFw@mail.gmail.com/
