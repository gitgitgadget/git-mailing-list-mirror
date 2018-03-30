Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91DD71F404
	for <e@80x24.org>; Fri, 30 Mar 2018 22:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeC3Waj (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 18:30:39 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:47047 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752282AbeC3Wai (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 18:30:38 -0400
Received: by mail-lf0-f49.google.com with SMTP id j68-v6so14007017lfg.13
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 15:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/z33WBiavaIw586IhKnGela0ItKYxZiepgaG9VvLDHQ=;
        b=Lz22yMnJvSt1T1ghjAhS2zJ/906+BvAACkgyeFZnPnjCB67OMmU4y03nbclFMNfj/U
         663d4OEa/g1E99Ya5oAF7c0KSNRdo6UwCxtZw9EMBTDH4A/FksNVZ7umciVlXi8M7fuS
         CIqmSePsLGTxR+D+5bb+Ntw3g68ZpJgGVW2lVQJJiK7id+Gm9nqOUpTY+khGVhUCq0bs
         Uc9wJ8OYu1foGmpfmdfu4AM5xPsk7zU336bZ0RGmdqrexsvu2tBZgByxBY0YctKwRnGq
         ATbwIrnCzvvNEZBNaLO617j+TMQXv7xXIt2OZyQIQEhC/L6E7sQq+4zFawDT0OKRFh0m
         zdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/z33WBiavaIw586IhKnGela0ItKYxZiepgaG9VvLDHQ=;
        b=VTIA4lTo4v04NAy6dE2wfzR4EAsVYBHssR873Bst/+mrTfWYOUSSjtgeXP9+eOaVC7
         lqJZcYPASMXBCnQ+VGEuDe9e7yUXLHS5LNfUl5PeXvkOgDOmtMBe/OgVlhxWqadCf3KY
         AR6eB68KM8kMrZCiInDmG893kEuM59BVrBbG41XXc4taHHVnKV73AwT60tPUWMLgC+wT
         RkINT8xwXwRZq6Bxg6u5J4NyXHmw3ARoAT5vYth1SsqrL/J6NOOYqOh3JaUQAjuz9naE
         PuJH2PFr465cBqHbeblTTs1QxPsvS040QjjgJQ5iXGpgKtQSumoUe5hDpm4wRrtZwDVG
         br1A==
X-Gm-Message-State: ALQs6tC6nLamp4rHdluQhWO7xoqyNG97W12sTVIWDhBj/mU9gc8hAE7t
        CZLdK1zVW+A7psDKPwyEGUWqz8gq08aUk8voncw/fQ==
X-Google-Smtp-Source: AIpwx48GllfgvYe/DDBWLPy5PHR35FURgwfJNHAbHuJNp7gb+hypfp1fkJZaIcb3EcXNj7aEW/1uAGdWv3nTzyRXMiE=
X-Received: by 2002:a19:c1c8:: with SMTP id r191-v6mr336187lff.45.1522449036594;
 Fri, 30 Mar 2018 15:30:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9690:0:0:0:0:0 with HTTP; Fri, 30 Mar 2018 15:30:15
 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1803301231430.5026@qfpub.tvgsbejvaqbjf.bet>
References: <cover.1522190580.git.wink@saville.com> <nycvar.QRO.7.76.6.1803301231430.5026@qfpub.tvgsbejvaqbjf.bet>
From:   Wink Saville <wink@saville.com>
Date:   Fri, 30 Mar 2018 15:30:15 -0700
Message-ID: <CAKk8isqA6Ru05kRJ+xiVHEkzPgH24cKUZbbgw2tEnw4rhafDQw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] bdl-lib.sh: add bash debug logger
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2018 at 3:34 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Wink,
>
> On Tue, 27 Mar 2018, Wink Saville wrote:
>
>> Add bdl-lib.sh which provides functions to assit in debugging git
>> shell scripts and tests.
>
> Interesting idea. It is Bash-only, though... (and it is not a secret that
> I want to discourage using Unix shell scripts in Git's production code,
> they are a decent way to prototype things, but they fall short of being
> robust and portable in practice, and don't get me started on speed
> issues).
>
> So rather than spending time on making it easier to debug shell scripts, I
> would love to see us going into the direction of a consistent C source
> code. I still believe that we can get there, and that the benefits are
> worth the (huge) effort.
>
> Ciao,
> Johannes

I totally agree the code base should use primarily one language!

But that's not the case now and "bdl" gave me insight into the workings
of rebase--interactive and I found little guidance on how to debug
or learn the code base. So I thought I'd see if there was interest
in what I'd done.

If I were to make it non-bash specific would there be any interest?

-- Wink
