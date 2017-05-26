Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F17920A04
	for <e@80x24.org>; Fri, 26 May 2017 08:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425761AbdEZItH (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 04:49:07 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:35259 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425741AbdEZItD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 04:49:03 -0400
Received: by mail-io0-f170.google.com with SMTP id f102so5744685ioi.2
        for <git@vger.kernel.org>; Fri, 26 May 2017 01:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Y+RexnpDTkdo8a92qaRh2hGiLye08zPTaCRgccFe45E=;
        b=b39THQt+sKGT9vw1poewJ2wbmoOY5epQFKyS66Qp2n2zOxRIlkQBHNxiC3w3FayiHH
         JjyjAoR1i/iEN65/OAy8nRLXYc8lvdRxij9IsKvrFe0Q5MYyyg2SqTfrvwB4jQd7571Q
         kbebMXOew96mx4Ae8JvrBMQ5SIN7sWPq0loZALTNpaDvMzgPWPJaFfdcGOVo4PQgNlXQ
         KPUWJwzEUrfBRJvfeQGOWG5GsvGZ3hrc22rcE7RnCCeztsQcB47ImoM3tBmFKfgevBbr
         QCV7ecqbAVFPIzIxOrOROz7GwfgNdxgKgR1R8I1CiEqJ4TUihTkPzU5q08CcDdxnNNvM
         ocZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Y+RexnpDTkdo8a92qaRh2hGiLye08zPTaCRgccFe45E=;
        b=Qs8Nc3aFLa5nSlc2zD4/vCFgRSMjXtjhvRjgJyG3UWx4ZyurU9Vveg1GMvKe3tfoZt
         sub5LUkBTpuk34q8bxW3xH1dOt+7FNGdu6XosJXjCBA5t090jdstgg1bQXCV6MyZmbTd
         FGl0axMeqdqzQCLP2Pl8UtxkW5Hg+buYNygZWbyUhYJtmm5aFYN8RpDLo66tyJjpndXb
         f0EPHUH9DytsYQ0kB7nbtyqn2XgIq6KYte9A+s/uMCwdTZAbtvNrWbK/F8ruteHlBg4x
         SRr5XP4+WfninzksTle+aeoVlbQfQ0L4fCK5C4Ky7chCqeY4dWK0WHdMYHSHr+FGDCC6
         BnGQ==
X-Gm-Message-State: AODbwcAg3mylgTiP2cI/U8N3CRNJ3Hs4kF4kLDEP2ExLycjtjMNWLqkz
        +SEVBAVU7Cth2LJhgcZdVUUVwFAhZg==
X-Received: by 10.107.138.21 with SMTP id m21mr663315iod.80.1495788542233;
 Fri, 26 May 2017 01:49:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Fri, 26 May 2017 01:48:41 -0700 (PDT)
In-Reply-To: <CAHd499B+cyN=3XDqr7KgHSpyHLwi6bS=P_4beoS5fSkFhapAtw@mail.gmail.com>
References: <CAHd499B+cyN=3XDqr7KgHSpyHLwi6bS=P_4beoS5fSkFhapAtw@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 26 May 2017 10:48:41 +0200
Message-ID: <CACBZZX6Y6OTd5Dh8d1gKuMQBStgbbEW+kstK6kUFGfAzqWyoTQ@mail.gmail.com>
Subject: Re: Hide decorations in git log
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 24, 2017 at 4:22 PM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> Is it possible to hide decorated refs in `git log` even if they are
> reachable from the refs I'm actually interested in seeing the logs of?
>
> For example, if I do `git log --graph --decorate --oneline --branches
> 'feature/*'`, I'd like to *only* see refnames that match the glob
> pattern. However, you'll see tags and other branches that do not match
> the glob if they are reachable from the result set.
>
> This is purely a visual thing, and shouldn't impact the search results
> I'd think.
>
> This is especially useful in cases where I do --simplify-by-decoration
> to get a better understanding of the topology of just a couple of
> select branches. Without some sort of "decoration exclusion", I am
> getting ton of results including tags, etc which obfuscates the
> information I'm really interested in.

I don't think there's a way to do this, but it could be added. The
glob just matches the refs now, the decoration happens as an unrelated
step which doesn't care about the glob.
