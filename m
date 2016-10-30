Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CD2C20193
	for <e@80x24.org>; Sun, 30 Oct 2016 22:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753122AbcJ3WLd (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Oct 2016 18:11:33 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34869 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751741AbcJ3WLc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2016 18:11:32 -0400
Received: by mail-qt0-f193.google.com with SMTP id m48so256447qta.2
        for <git@vger.kernel.org>; Sun, 30 Oct 2016 15:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AIJsvoBe8fRuUpGWUBr7fcPKQKG3xglEe1JBZh7C21w=;
        b=woR0FN4nHKEjIPriKqYLGlFXoz0spT3DEgieYmcw7mjPtba5JGCApTTgvl2rH266rY
         DiDjRcNjGFWjZuiRBp5wzWhSG7U8LQ8yTq2SBp3zSh5eNFLsCuWJfR47DdRfXJ4365sV
         mYGaebUpK6/6JQ+4uJT8sL6vbWEEQZfSEBI/MIZqQiY7S3MNYKQcdD8WEHZaRh0SQMix
         2ju+UoH3pbXh2k5tTX56YOQYSGA68YgjSx3ZLy2EgBS+qgFyktXozO+uWEVdkfUEOhTH
         JgLHxtyI2n5/+mtQIkQtSRuHEDnvm9BgI5AiBL5A33nkqR1s+nDiN42r+PX5SgJYUcQZ
         v3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AIJsvoBe8fRuUpGWUBr7fcPKQKG3xglEe1JBZh7C21w=;
        b=Znq/+gQ0hq6fwpKidzvFoCYzOFkhryBbhgJv25ETsfp6lj94LSfY2OoprHY8vwvtpn
         0TLpwy4AvSQyID1TRuSnIqFChpLGhyNxWwM2SAc7oOksyQbm8u8deUZhcCXYFfLPPtki
         xp4RSHs/iALj3YGZP8jkAIj0pHXhvrrQ6vxXghLKkYtp1MOt5bRK0ni/rS559pCFdH3g
         L0WVdDXpSGvjixXQLQNjpDe4/433jhxWVff1lZNOMwCDA2nzXjPPwdR5+taJ42CiMfQo
         EstGyLg8vK855fFDokF+3v+6Idr0Jp+QRmkMTZDS5LH8xSwQ4NWXsShsrv6SUzLuuYzq
         NkcA==
X-Gm-Message-State: ABUngvfX4xvEI8Ch6EBMED++UOMFdoKJVf61YlhPuTwqTIZq+vMh3ZqnD989wXc9wWLECYdDK3T6j/nEomVGYA==
X-Received: by 10.237.34.83 with SMTP id o19mr22370962qtc.15.1477865491364;
 Sun, 30 Oct 2016 15:11:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.210.3 with HTTP; Sun, 30 Oct 2016 15:11:10 -0700 (PDT)
In-Reply-To: <20161030211227.4gqovv7mt7mtnpy7@sigill.intra.peff.net>
References: <alpine.DEB.2.10.1610292153300.60842@buzzword-bingo.mit.edu>
 <CACBZZX4SnJj6ZYK-Ha3EtiWUf_n=+LZ=UeS=7vxgsj8s=bi3Sg@mail.gmail.com>
 <alpine.DEB.2.10.1610301503280.60842@buzzword-bingo.mit.edu>
 <223121D101D844DEBF086AC40A5AF4CB@PhilipOakley> <20161030211227.4gqovv7mt7mtnpy7@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 30 Oct 2016 23:11:10 +0100
Message-ID: <CACBZZX6ArQdG202n-SouwDhoTE1LF=69mKjWQv8HPKJ+K_0fJQ@mail.gmail.com>
Subject: Re: [PATCH] git-sh-setup: Restore sourcability from outside scripts
To:     Jeff King <peff@peff.net>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Anders Kaseorg <andersk@mit.edu>,
        Junio C Hamano <gitster@pobox.com>, 842477@bugs.debian.org,
        Git Mailing List <git@vger.kernel.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

,On Sun, Oct 30, 2016 at 10:12 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Oct 30, 2016 at 08:09:21PM -0000, Philip Oakley wrote:
>
>> > It is documented (Documentation/git-sh-setup.txt), and this is not the
>> > internal Documentation/technical section of the documentation, so my
>> > default assumption would be that everything shown there is intended as
>> > public.  I only bring this up as a question because it was apparently
>> > allowed to break.  If I=E2=80=99m wrong and it isn=E2=80=99t public, o=
ther patches are
>> > needed (to the documentation and to its users in contrib).
>> >
>> But the Documenation does say ::
>>
>> - This is not a command the end user would want to run. Ever.
>>
>> - This documentation is meant for people who are studying the Porcelain-=
ish
>> scripts and/or are writing new ones.
>> --
>
> Historically speaking, porcelain-ish scripts were carried both in and
> out of git.git. These days what we consider porcelain is usually carried
> in-tree, but I don't think it's unreasonable for people building their
> own scripts to want to make use of git-sh-setup. And we've generally
> tried to retain backwards compatibility in the functions it provides,
> even to out-of-tree scripts.
>
> So I think it is worth applying the fix at the start of this thread to
> keep that working.
>
> As for a documentation change for "do not use this for out-of-tree
> scripts", I am mildly negative, as I don't think that matches historical
> practice.

I don't see why we shouldn't have some stable shellscript function API
if that's needed either.

I just wanted to point out that currently git-sh-setup isn't
documented as such. So at least a follow-up patch to the documentation
seems in order.

This did break in v2.10.0, and it's taken a couple of months to notice
this, so clearly it's not very widely used, which says something about
the cost-benefit of maintaining this for external users.

It's probably worthwhile to split off git-sh-setup into git-sh-setup &
git-sh-setup-internal along with a documentation fix. A lot of what
it's doing (e.g. git_broken_path_fix(), and adding a die() function)
is probably only needed internally by git itself. The
git-sh-setup-internal should be the thing sourcing "git-sh-i18n", I
don't see how anyone out-of-tree could make use of that. Surely nobody
needs to re-emit the exact message we shipped with our *.po files.
