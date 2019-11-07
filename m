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
	by dcvr.yhbt.net (Postfix) with ESMTP id 58BDF1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 04:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733066AbfKGEqV (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 23:46:21 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:40592 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfKGEqV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 23:46:21 -0500
Received: by mail-ot1-f48.google.com with SMTP id m15so889898otq.7
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 20:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S/LwhqaxFGUeaR/bofu0CPd1cfuF5axISOICXGSZHg4=;
        b=tPzBgQff5H5jKOJa9CN9nvxB+53Kd5BZEvdg/MKD9KsoeSsaDXs6ZANBPbZMl9ulnX
         hdQFshb9TMipkK29PsK7Iww7UGsOGeTBylxNIWJQRMl0rW6U+K1Rbx3ZDGPXYw+/z7L8
         f8K7XmkjNouwSWhtci/LYI7waAXQj20Yo8Y7HurzwRUKz/4n53MG8kgCtTJ9ikCl6S3S
         Xnm94jGDSoZg7YKp4CsMFagT7zvI7R5eFdq2vJVMxqRY0gTZ81QvzZXoLRUNV8kPEjGw
         xM2/Gvq69O+/QRwAH9LrNnvlcgeMePlz2ZSfR8fTs1Z9jIP5kajpFO8YuoKZS/Dur5bx
         /7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S/LwhqaxFGUeaR/bofu0CPd1cfuF5axISOICXGSZHg4=;
        b=DyPTJFp/xcogHNeo0/zCG3cza4ayNcmFOfTRhsdIRK7wsNaOM+qZmBbzhwINyBIuUu
         89E0QqZuMDexUqC8dM4iMSY3uyD0fK+CW2YplW6ngEcgUNSZn0XbnrX3HrS8xCWYyfid
         7iqp83/8KENZLJxWhuwgyEQMX65aN6BfLFv3n9QwhQwEMyiix70ipaGa4T1vcryj74Ue
         PuZw4tKWrTgjMpaPbzYuFsBcdsnBhP+07YLq5jHVsn7+48bjWO+1ymFzm5vrkRgEJPMc
         CTUtHenOFjrL9GCQalwTqCAfOxAQ4FO23nRRbZVuIWK+E0yjrulGKZCa83za0lg09QhI
         mRag==
X-Gm-Message-State: APjAAAWXrBRqgCK3zKIF9KOz9ANdj1hkHiYbJh4Ekol1Mby9NDLdqBJ4
        cKZ7b8uu9/NQVtjDVFmOIsx+zQ+5Zy2bTGY+ifN76g6S5L4=
X-Google-Smtp-Source: APXvYqyDqe55Qi8Bhd9Xthk3JfZZ0RjjE+WU7ssGl8P5tSMEzKZqTD24RTCr6FD0KzLOxu4qLb+jMqYyfWe4PGHgeAU=
X-Received: by 2002:a9d:6285:: with SMTP id x5mr1181116otk.267.1573101979964;
 Wed, 06 Nov 2019 20:46:19 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LSU.2.21.1911041704520.3956@fossies.org>
 <20191105171107.27379-1-newren@gmail.com> <alpine.LSU.2.21.1911061026130.15790@fossies.org>
In-Reply-To: <alpine.LSU.2.21.1911061026130.15790@fossies.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 6 Nov 2019 20:46:09 -0800
Message-ID: <CABPp-BH=XxwJod8XpXYzpmXuo2-8LBozQGH4eEps_r4C798+ag@mail.gmail.com>
Subject: Re: Some misspelling errors in the git release 2.24.0
To:     Fossies Administrator <Jens.Schleusener@fossies.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 6, 2019 at 3:08 AM Fossies Administrator
<Jens.Schleusener@fossies.org> wrote:
>
> Hi Elijah,
>
> > On Mon, Nov 4, 2019 at 8:14 AM Fossies Administrator <Jens.Schleusener@fossies.org> wrote:
> >>
> >> Hi Elijah,
> >>
> >>> On Mon, Nov 4, 2019 at 7:07 AM Fossies Administrator
> >>> <Jens.Schleusener@fossies.org> wrote:

> > So, I used your codespell program
>
> That seems to be a misunderstanding: I'm not the author of the codespell
> program but I only use that program to detect spelling errors and point to
> their existence while offering the option to inspect the context of the
> probably misspelled words in a fast and comfortable way via a Web page.

Oops, sorry for the misunderstanding; thanks for clearing it up.

[...]
> Some of the according FPs are excluded by Fossies generally, some other
> obvious FPs are excluded by Fossies specifically for each FOSS project
> (see always the bold item "Codespell configuration" with a link to
> "Project-specific additions" or to "(no project-specific adaptions yet
> done)" that shows all the excluded words and directories/files).
[...]
> As one can see on the page
>
>   https://fossies.org/linux/misc/git-2.24.0.tar.xz/codespell_conf_info.html
>
> there are already done some according attempts.

Ah, thanks for the pointer.  Could you add t/t9150/svk-merge.dump and
t/t9151/svn-mergeinfo.dump the the list of files to exclude?  Both
have the 'hapenning' typo, but both are a dump of some repository and
editing it means recomputing sha1sums and whatnot for tests that just
isn't worth it.  I thought maybe I could get away with correcting
those spelling errors but backed out once I saw further knock-on
effects.

Thanks for the report and the background and corrections!

Elijah
