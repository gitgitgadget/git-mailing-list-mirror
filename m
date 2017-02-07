Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A14621FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 14:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754100AbdBGO7s (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 09:59:48 -0500
Received: from mail-ua0-f172.google.com ([209.85.217.172]:34658 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754007AbdBGO7r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 09:59:47 -0500
Received: by mail-ua0-f172.google.com with SMTP id 35so86338013uak.1
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 06:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Nf2KmQsGJtX3R5VEs9vXY0VZQCypxs2dkCLNJPDivaI=;
        b=mhvxmc//3MInvjQgC398jmHJjfbgVUKDZfCuyDhvgPWL2ORQUyGLFXqO84nGka1v7/
         MSPjrESX09ty8jrCoqpoDfKLlfTJ6xHrfSFYtniFCDKP1g6rRgEr8vtuvokgSB7aKFGB
         Z7uzF4MfoA2LM6wVgiIB9DGBOolQwOCJkNZN1+pDGRgQMOyU9gf0LEvCXAFCEVLL73Gb
         IzpLnccC4J8CHGqgkg4j92SwLTg/l9c751Eo7kyZV4XpQm2lK8Gh8yEh34BfnpqKiAzY
         Iylfk5gZTaRsiWUbFDL8HNLk/ZRVlvtWgri9q0sl7x/FNqxChxx9UZfbKO7mZkTPul5a
         nbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Nf2KmQsGJtX3R5VEs9vXY0VZQCypxs2dkCLNJPDivaI=;
        b=GYKsaEkIapRJRfqzRAwNeqOEM/zGlmrPamOXbaTuMFXGkaOoz2GqeQZ3dFtOWCJBfX
         u5r6QXjLnUaKPjEO2jVwCmNpluW9pQ8Bd2MjpsmkbhBFCWDOsRSeiftN6HqZMcmNBsUb
         OezRQJhn4R+VFZ/c//7GNMLUjscr9v6PCdePaQ1YeG0DRhCxCw8YSLdAEJmF8ieLLxBC
         vtKUupXbacLR5ySjAC0QmkA4CzNZuIg2Yi1fvGCua07sMQADALTV/UognsD7/hejvy8F
         b/6pAEg3e4UccJmGJ7vLlfAC9FNC47qSLl5i40ZrFGgbTY8idd++vqawoipSAoQ4CAjn
         wZ1Q==
X-Gm-Message-State: AIkVDXK9PGFLoIwbtnW+JYA02RoRFNtz3hWPasw92qfM/6coGW/7TgJ08CXMxKeCDhQI7WCwsbaZQx4xfcUnBA==
X-Received: by 10.159.48.85 with SMTP id i21mr8111605uab.73.1486479586828;
 Tue, 07 Feb 2017 06:59:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.34.48 with HTTP; Tue, 7 Feb 2017 06:59:06 -0800 (PST)
In-Reply-To: <CAEXhnECi3LvSA92dSjL5PZ1Lx9p1PWELS04nmfJW=8K9o4T-0Q@mail.gmail.com>
References: <CAEXhnECi3LvSA92dSjL5PZ1Lx9p1PWELS04nmfJW=8K9o4T-0Q@mail.gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Tue, 7 Feb 2017 08:59:06 -0600
Message-ID: <CAJZjrdU3toam4tDwXBu1Q3UAZm-kML3CzMrsMoJ_2jsGJ3vWrQ@mail.gmail.com>
Subject: Re: subtree merging fails
To:     Stavros Liaskos <st.liaskos@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Have you tried using (without -s subtree) -X subtree=path/to/add/subtree/at?

From the man page:

          subtree[=<path>]
               This option is a more advanced form of subtree
strategy, where the strategy
               makes a guess on how two trees must be shifted to match
with each other when
               merging. Instead, the specified path is prefixed (or
stripped from the
               beginning) to make the shape of two trees to match.

On Tue, Feb 7, 2017 at 2:16 AM, Stavros Liaskos <st.liaskos@gmail.com> wrote:
> Following the instructions here:
> https://git-scm.com/book/en/v1/Git-Tools-Subtree-Merging
> will lead to an error.
>
> In particular, if the subtree is merged and then updated, this command
> that is supposed to update the local subtree fails with a fatal:
> refusing to merge unrelated histories error.
>
> $ git merge --squash -s subtree --no-commit rack_branch
>
> A workaround could be using the --allow-unrelated-histories option
>
> $ git merge --squash --allow-unrelated-histories -s subtree
> --no-commit rack_branch
>
> But this completely destroys my project by pushing the subtree
> contents into a completely irrelevant directory in my project (no in
> the subtree).
>
> Any ideas??
>
> https://github.com/git/git-scm.com/issues/896#issuecomment-277587626
