Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 051C62027C
	for <e@80x24.org>; Mon, 29 May 2017 07:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750893AbdE2HwT (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 03:52:19 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:35418 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbdE2HwS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 03:52:18 -0400
Received: by mail-it0-f50.google.com with SMTP id c15so23159393ith.0
        for <git@vger.kernel.org>; Mon, 29 May 2017 00:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ijbqpz6tCSbH8D52StD+UtJJWMvQCx69UYIMhBPHwvs=;
        b=HX1EcOhjIZKmDFFYtfPMO/iV39XwxVmwp1MwJaqf6QxPRT/hRFj7Ions9LrjHoglI7
         BOVUvm3qlvaqzR+QC1or1o6TPfN5nUMFpc/yr/0h7EjlQXS1uICAdvBihkyaBzCXLeu1
         Qvc3rB/uUsdkLCPs5k1fQ0bIr9E9aguWsoe/c4c/P2shx1wr3BXuAr8wtpJ/iSpx0EwI
         rbnyf/K1Fs5rYjsg0U2H9aRnnAT+iVqc2pBXQZFvnwq8+KHChtMAB38Zsb8OKTRPtZZB
         EBtb0+8zVbRfUDu/N7HCJKZS6/RdSt2+PrCudzHnYLIhmu0NQWWDv22RPoM4OaeST/G2
         ymuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ijbqpz6tCSbH8D52StD+UtJJWMvQCx69UYIMhBPHwvs=;
        b=fyTTPOAsYyEpkQiXztL/rNuDwtnd2VM2SlAlJYkal+/Nv7RVmgTmT1Ke0NLLtcEs85
         C0KyEsGyu1jLRI0dG6FNBB68LesNWwL5+e2qz/2D0ixFGoJSkFYV6+8cpzp+N3Y1Nw6w
         hXEq+b5O5sFp9H8DVEIgwiwk5EQiVuxX6pa1S4cOmiiIq36klwy6KCMQghAsR9rIz4eD
         hf6w7YX38mrBs0jfp6xgyMcBbHlsbHJegj0psb6QvQ/H1YPvIZGysTxE4Ub+vUdu5wum
         TjT/8TNP5VtezRlbLhK1PMdYQCYhikzNAzV1tNGlVwOKcVUuN82nyyE1T8xB2EgfGT/3
         0/9w==
X-Gm-Message-State: AODbwcDaiSluHr9D18Wlpn0jRn4Glc91gGEnN6zMugQeNHHQezRd7OMo
        PVXNZ2CD1TDu5BDYes9zpaRSFFwp4g==
X-Received: by 10.36.254.68 with SMTP id w65mr13615778ith.51.1496044337969;
 Mon, 29 May 2017 00:52:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Mon, 29 May 2017 00:51:37 -0700 (PDT)
In-Reply-To: <xmqq1sr889lb.fsf@gitster.mtv.corp.google.com>
References: <xmqq1sr889lb.fsf@gitster.mtv.corp.google.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Mon, 29 May 2017 03:51:37 -0400
Message-ID: <CAJZjrdXwUiGt9fe=TF2MWq_kdCzWVijB6UqRig+Uf4tzxebV5g@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2017, #08; Mon, 29)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 29, 2017 at 2:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * sl/clean-d-ignored-fix (2017-05-24) 6 commits
>   (merged to 'next' on 2017-05-29 at 837c255ae8)
>  + clean: teach clean -d to preserve ignored paths
>  + dir: expose cmp_name() and check_contains()
>  + dir: hide untracked contents of untracked dirs
>  + dir: recurse into untracked dirs for ignored files
>  + t7061: status --ignored should search untracked dirs
>  + t7300: clean -d should skip dirs with ignored files
>
>  "git clean -d" used to clean directories that has ignored files,
>  even though the command should not lose ignored ones without "-x".
>  This has been corrected.
>
>  Will merge to 'master'.

I noticed the merge commit message (and branch name) don't make
mention of the changes to git status --ignored. I forgot to mention it
when the last cooking email when out, but was that intended?

I think at the very least, if the branch name isn't updated to reflect
that status --ignored is being changed, something like the following
should be appended to the merge commit message:

    "git status --ignored" previously did not list ignored files in
untracked directories without -uall, contrary to the documented
behavior of the --ignored flag (that all ignored files would be
listed). This has also been corrected.
