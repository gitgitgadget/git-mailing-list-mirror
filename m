Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8567E1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 20:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbfAHUie (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 15:38:34 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:40839 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbfAHUie (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 15:38:34 -0500
Received: by mail-ot1-f47.google.com with SMTP id s5so4718005oth.7
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 12:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=o1hr9PN/U2B3420j55s4VM8OPv0jOnWqv87jgFnjB00=;
        b=AtdNtkhB5A295Hywc3ZldoOUGggXkQPcCVpHZ8meMoD6IJcCi/NEbbxE9A1Jlb1qLz
         tVC7qyQhWPhEDjGPStrg0GZv0h/jOAwqJCXO2hY6j0//IJPcGcGEmfknNtej1RFO6NQP
         VKgHfpzOE9gzkHSvcmNy3lgOHh8/75HJUNM+8A6aQpvG1mRLhwTH+1+oTM8j4APbEZZp
         fQC/9WGb+RdUgUk7hv9DDuyQ7YpxkiAq5k6skUMJ1eNQVRk09bai2W/IOByvDG0bHZIS
         C1dNTHBZCtDL8BxovcC0gKNXYMjJfw0ZfitQ3lWaw0MF580K3rRfSfoEtE+WcqRLOVsy
         c/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=o1hr9PN/U2B3420j55s4VM8OPv0jOnWqv87jgFnjB00=;
        b=aYFvtOJ99vrCteLjh889lclbFGTtHUrz7LkVS9Pe0OsoYxGR1Fs4u+QzNc3yf8LSGs
         mIKLI8NxKJbI9oK4OqSink/SwJNa6lwguH3SjP3h9h89o5HXDeJEkZnB8i4osN5TlRaa
         wyAgFY/YTg+yxf14jYbFyLArBxIVmuUJK242mLAhgwP3GE4yVfxHkJDNE/vuctSODC5Y
         EG2EFsnYkkZ4I695ayH5iYQxcmvCwxqVHS2zN0SIqUOA3WgpS7QpTbXRejoWllhmSkuD
         oeYmMQNfbNeg5YzqV4wGTDfa+MLHSM8OsWwAUbMo6GbhxIU/h9JIhrgNMYEW1Am3uLgP
         lyDQ==
X-Gm-Message-State: AJcUukdf3ebWfI1ECx6Fu2LyZkSnslFtLJgpD/ktSfhW4Wk8ooXeQYb0
        1duLzNO9hdvQWlV0/8tzdkJTL1llnk9QHsOFV86G/bIy
X-Google-Smtp-Source: ALg8bN7Db4OIzfWeYzqbEDCxf1g6bhk85/KqF5m9t8L6rWmY1eKseRZhCzFixgLM8STNiOSkhyQ8Mv4i+VVhR9Zc2H4=
X-Received: by 2002:a9d:2aea:: with SMTP id e97mr2250176otb.206.1546979913374;
 Tue, 08 Jan 2019 12:38:33 -0800 (PST)
MIME-Version: 1.0
References: <CA+h-Bnuf6u=hkPBcxhMm06FbfkS+jtrozu+inqqmUY1cNkXrWQ@mail.gmail.com>
 <87va2zavu1.fsf@igel.home>
In-Reply-To: <87va2zavu1.fsf@igel.home>
From:   Markus Wiederkehr <markus.wiederkehr@gmail.com>
Date:   Tue, 8 Jan 2019 21:38:21 +0100
Message-ID: <CA+h-BnvN7+ETU-vFxAGDvs0gvXUjAAhMkvTPUxoRTt2Gb4b2ow@mail.gmail.com>
Subject: Re: git rebase: retain original head?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 8, 2019 at 6:43 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Jan 08 2019, Markus Wiederkehr <markus.wiederkehr@gmail.com> wrote:
>
> > Would it be possible to retain this information?
>
> You could use the reflog of the current branch, where it is the second
> entry.

It is not, depending on what happens in the rebase it could be any
entry. That's why I always have to search for the right one, which is
tedious.

Example:

$ git rebase -i root-tag
... (apply one fixup)
$ git reflog
906caf1c (HEAD -> master) HEAD@{0}: rebase -i (finish): returning to
refs/heads/master
4906caf1c (HEAD -> master) HEAD@{1}: rebase -i (pick): qux
85dab37b4 HEAD@{2}: rebase -i (pick): baz
7de7420d2 HEAD@{3}: rebase -i (fixup): bar
9bc0461c0 HEAD@{4}: rebase -i (start): checkout root-tag
a150b73ca HEAD@{5}: commit: foo

Here I have to use HEAD@{5}.

Markus

On Tue, Jan 8, 2019 at 6:43 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Jan 08 2019, Markus Wiederkehr <markus.wiederkehr@gmail.com> wrote:
>
> > During the rebase operation the original head seems to get stored in
> > 'rebase-merge/orig-head'. Unfortunately this references gets removed
> > after the rebase operation completes.
> >
> > Would it be possible to retain this information?
>
> You could use the reflog of the current branch, where it is the second
> entry.
>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."
