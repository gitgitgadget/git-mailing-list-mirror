Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71C1F1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 06:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeGTHDm (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 03:03:42 -0400
Received: from mail-yb0-f182.google.com ([209.85.213.182]:35787 "EHLO
        mail-yb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbeGTHDm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 03:03:42 -0400
Received: by mail-yb0-f182.google.com with SMTP id x15-v6so4238362ybm.2
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 23:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ofP9Tze5ECYxbeEUJJGk5svN2YJ6SMM5A0xlBA7zyyk=;
        b=PzgEMR/CIONPUt2Vtzcyvx8KpdpBSjTq+8B94eLSQgYz6bndsFxAu7+GoabX9vv6wk
         oAB9ADb99n60DRLNtnd4v3F0szqJnn7bfseuCssOOR/ScHy3q5K4u1XtghJ8kcHqOKm5
         Dsa+lQPN1HX3HztGBH11uRGsh+ArdaTwo9G9n/fn9xdvnapPLk7xEdNEtSGV2HH+N3Dg
         vWvguc6EmF1HFG+m34vuILNIn2Pp26NlmqzR0eosCkDUFunA6sCxI+S8GvAPks+3BqCl
         Fg0xGLU8YqDVGvnJD5ViNLqAKYC+PiBHjdl3S2oXsXMyD1fH+lADu8SO7Gsles1jZzbL
         bGHg==
X-Gm-Message-State: AOUpUlFWNlXcG/3ujT3oxBIWNmGAwHqXcT5ReS+ftAGl/1Mco0lvcXSh
        uLkYIdfC4BL5h9S4NxJAeKEgaTJeVyJa8e8BHLc=
X-Google-Smtp-Source: AAOMgpcBnnoUnfnWlyF76jD2w2BtVZ4rLNXOiemoYSz3bmGtotgtruc31Dh6vO7M+5eiRmWtub4PuC4Py0zFUz6wltA=
X-Received: by 2002:a25:488a:: with SMTP id v132-v6mr330857yba.263.1532067425188;
 Thu, 19 Jul 2018 23:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8=oruFBtkndQ0p9N4s23SMvjjrAC_E7zzKRSVbjEwL0FQ@mail.gmail.com>
In-Reply-To: <CAH8yC8=oruFBtkndQ0p9N4s23SMvjjrAC_E7zzKRSVbjEwL0FQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 20 Jul 2018 02:16:53 -0400
Message-ID: <CAPig+cQgXSFKEj4=CsYBTzPkC_JHfu-=bJv17iLe+Ou1ZXvsTg@mail.gmail.com>
Subject: Re: No rule to make target `git-daemon'
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 9:37 PM Jeffrey Walton <noloader@gmail.com> wrote:
> I'm working from the 2.18 tarball on Solaris 11.3 x86_64. I'm catching
> the following when building from sources. This appears to be a new
> issue. It was not present in 2.17.1.
>
>     gmake: *** No rule to make target `git-daemon'.  Stop.
>     gmake: *** Waiting for unfinished jobs....
>     Failed to build Git

Unable to reproduce this problem. Is your Makefile corrupt or
truncated or something?
