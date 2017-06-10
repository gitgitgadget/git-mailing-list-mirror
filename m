Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81CCB1FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 11:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbdFJLRr (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 07:17:47 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35428 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751890AbdFJLRq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 07:17:46 -0400
Received: by mail-pg0-f42.google.com with SMTP id k71so33340559pgd.2
        for <git@vger.kernel.org>; Sat, 10 Jun 2017 04:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=57nco4+BSS4zY5zr0nByx/mO759CN+wv0A4xmdYf/v4=;
        b=N8dKUgLj7RdMxAZtYAuN3ezogssVE73/uGP4vqlHr28fxOpIG2hF0WvYDpgsqgUWju
         HDt7bx/A5rh+zfsb/qpGCU4ROq0xry9Z+6ZhTjB3neb58HNd+Joma7GLEvhlQjbXp2k9
         ZZGaQZbZ9Kn44T4jwJ/DKnhnz9wlJ+QN5dJQ+PIJbIXK6E3Rjr7Kvt8d4zqyeZ0e8zYN
         VvDKF+SDsTK9qGPi3gdrFisWr//1spQcbBud2ULuCaVI1QcurItxIZCB+kcBV4mpv7hY
         1d5UM26PYbqhIA79rDdev3TduwyTiwFTtEcitI++6eI4s7koQaiow5ajxbesXBACd5VZ
         FRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=57nco4+BSS4zY5zr0nByx/mO759CN+wv0A4xmdYf/v4=;
        b=D3nQgi78DVLBPt/SRivIj2C7IWUPji7vr6vb1sVE0xGAqwiHGW3Sukkxu5nTvFPQQF
         Huh+F7xdHV6qfGp4sTwJeN9j9ECNyBFTpHHurJZTfyKRyt/v32Y+BInODC+Iq6MxG5R1
         1e1MxIC3+cwrAgBO7/Ch0gaIQmlnIlmuNb65KrUz76lEmDgDeaODKCBWS4n7V9DYrNnr
         dX60c1Q7c2JZZvBoxRGuzW5fxgPDghfN19TRi1qDhMcPZaCHUfydK9b4hz6GT36ZpEaC
         m8ebkAFJSilGu43SHXpr+gVIWORRRPrtvTBnKzCzaO7D+a85fIrC3zK1TqLIvnM4/+gW
         sIdA==
X-Gm-Message-State: AODbwcDSx1ECdcwJG2u8IbYAxJQlBce2LttW7vblaMEF4BpeszVrBxMA
        4/U1e+LVQcZiVg==
X-Received: by 10.84.130.99 with SMTP id 90mr45666363plc.165.1497093466101;
        Sat, 10 Jun 2017 04:17:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d192:93c8:4f75:5879])
        by smtp.gmail.com with ESMTPSA id y29sm3403542pff.50.2017.06.10.04.17.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 10 Jun 2017 04:17:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Torsten =?utf-8?Q?B=C3=B6gers?= =?utf-8?Q?hausen?= 
        <tboegi@web.de>
Subject: Re: [PATCH] doc: fix location of index in worktree scenatio
References: <20170610090719.8429-1-asheiduk@gmail.com>
Date:   Sat, 10 Jun 2017 20:17:44 +0900
In-Reply-To: <20170610090719.8429-1-asheiduk@gmail.com> (Andreas Heiduk's
        message of "Sat, 10 Jun 2017 11:07:19 +0200")
Message-ID: <xmqqmv9g1487.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Heiduk <asheiduk@gmail.com> writes:

> When setting `.gitattributes` in a second worktree, a plain `rm .git/index`
> does not actually delete the index.
>
> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
> ---
>  Documentation/gitattributes.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Right.  

I however have to wonder if we can do the same without futzing
directly with the "index" file as a filesystem entity.  With or
without your update, what is taught in the document feels like
munging a disk block with binary editor to correct a corrupted
filesystem X-<.

For example, can we do this "empty the index" step with things like

    $ git rm --cached .

or

    $ git read-tree --empty

instead?

Thanks.

> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 473648386..4c6b74fa6 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -229,7 +229,7 @@ From a clean working directory:
>  
>  -------------------------------------------------
>  $ echo "* text=auto" >.gitattributes
> -$ rm .git/index     # Remove the index to re-scan the working directory
> +$ rm "$(git rev-parse --git-path index)"  # Remove the index to re-scan the working directory
>  $ git add .
>  $ git status        # Show files that will be normalized
>  $ git commit -m "Introduce end-of-line normalization"
