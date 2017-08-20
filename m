Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC87920899
	for <e@80x24.org>; Sun, 20 Aug 2017 23:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753407AbdHTXdG (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 19:33:06 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:34710 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753398AbdHTXdF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 19:33:05 -0400
Received: by mail-qt0-f173.google.com with SMTP id b4so27793298qta.1
        for <git@vger.kernel.org>; Sun, 20 Aug 2017 16:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=O9PDLGAiM/G01x+kIFQQrgec4yN92twgywNQcFRGY10=;
        b=eNzO/ebc/jeQhlrgbaao0vvWUsfNZ1xA0TW25O9WVJ1xLI6o7ztfU8ag8yLIre1Qsh
         QTPMboVCOPPQEWL+z0AFB0SFT5LRk+Uo53sDwE11ieesfdjsDQDQTRMEw1x1NgnIGNH+
         TSqhQYCa0kXNfq7qfSCrvy5rlSZE4nAqEbUxsEWYKrs1SK1lUNL5+pGTCjuafU6uoBAW
         Ra0KNJ93Ile1qSP5MjoCL7pCiTC1IQTlUwwOK1EckJsikrbgXQuc+ERsSdb//LC7tHta
         8cJLoYXtPStY8UNBtR0rRA2RYKkaP1ocLumKdyQ+i+qVoHrykoi8DKZ4yfRXXsu4SD1P
         EGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O9PDLGAiM/G01x+kIFQQrgec4yN92twgywNQcFRGY10=;
        b=aMThxkhiI8jzvFQSxItqJn+KO6X6eXPsb/Y/5L1Xr8tpLDzCkoDZ+1wdqxeMlq4HlK
         YdN5fLIRkbi+gHEjQzi501hMOJJHc6s26/d4WIS4SjIwcnnpHHhd1hkGjkq1MIYm1zO7
         QyQAwrNBSSmRuAAknFVAkczxM9TxqEQr52F+5NzPXJT3OhQEt/gVpUCWU6pGAUk9ZPJM
         fwSX+R5CKN38lNc27oEqlltVvqhZNnOjXN1ZowfatOgxerR1g86muNieoQhls86s+tXC
         b7pGnxa4QqL948Jr8XcnR1Y2UqS93ylJZHos41/mTJjbeSOU6XwWSFZHl6i4d9wDl8Mi
         sKSg==
X-Gm-Message-State: AHYfb5gwsoJrJtVzLeUkwqoIBH68MSltrcxpXxxRNfsiPHOXeGaYhLqx
        +uFVYTnCbs2OCHFAbt2Aqd3+EgSU0A==
X-Received: by 10.200.58.133 with SMTP id x5mr9715440qte.167.1503271985220;
 Sun, 20 Aug 2017 16:33:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.39.151 with HTTP; Sun, 20 Aug 2017 16:32:24 -0700 (PDT)
In-Reply-To: <CACNzp2kao+hu6a2nO=gVaLctzoDauB+xyj=cfQLUdNOXTNKQfQ@mail.gmail.com>
References: <CAH8yC8=i33rtopVt=sgg0k+P4JQO+1EVpPJ+u5CPGEXKvZ+PBA@mail.gmail.com>
 <xmqqbmnba50e.fsf@gitster.mtv.corp.google.com> <CAH8yC8mpPRN2y1k07_Jk9QP88=gpLKNWfV3W0QQwXTWxyL5STQ@mail.gmail.com>
 <20170820091807.l23h44gnjajfv5bn@sigill.intra.peff.net> <CAH5451m58n8mYvt=BC_t2=EAv0HOOdAWrCHCNEPQ3NVjT174nQ@mail.gmail.com>
 <CACNzp2kao+hu6a2nO=gVaLctzoDauB+xyj=cfQLUdNOXTNKQfQ@mail.gmail.com>
From:   Andrew Ardill <andrew.ardill@gmail.com>
Date:   Mon, 21 Aug 2017 09:32:24 +1000
Message-ID: <CAH5451kcb0Y4mm2U804ruqBewB2AV991Hm0_-8ExdEoDTF8DJw@mail.gmail.com>
Subject: Re: Please fix the useless email prompts
To:     Anatolii Borodin <anatoly.borodin@gmail.com>
Cc:     Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Anatoli,

On 21 August 2017 at 07:57, Anatolii Borodin <anatoly.borodin@gmail.com> wrote:
> On Sun, Aug 20, 2017 at 2:40 PM, Andrew Ardill <andrew.ardill@gmail.com> wrote:
>> Maybe I am missing something obvious, but if that's the case then
>> can't we just do the identity check when trying to make new commits,
>> in which case you should be able to pull without setting your
>> identity?
>
> `git pull` is `git fetch + git merge / git rebase` in disguise, so we
> should be ready if git will want to create a merge commit or do a
> rebase automatically (and potentially create new commits with
> `Committer` set to the current user). `git fetch` and `git clone`
> alone, `git branch`, `git checkout` etc don't care about the email (as
> of 2.14.1), even if `user.useConfigOnly` is set to `true`.

Is there any reason `git pull` can't delay that check until the point
where it actually tries to create a new commit? It's fair enough to
error if a new commit needs to be made, and there is no user
configured, but for the use cases discussed here it seems a little
eager to error on the chance that the user will be needed.

It seems nicer for the user if the `git fetch` happens first, and if
the merge is not a fast forward, and there is no user configured, that
the error pops then. I don't know if this idea of "do as much as
possible before erroring" is consistent with any other errors we
handle.

Regards,

Andrew Ardill
