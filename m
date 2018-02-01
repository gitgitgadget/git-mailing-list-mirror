Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0AA81F576
	for <e@80x24.org>; Thu,  1 Feb 2018 06:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751252AbeBAGhf (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 01:37:35 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:52131 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbeBAGhe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 01:37:34 -0500
Received: by mail-wm0-f47.google.com with SMTP id r71so3604986wmd.1
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 22:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zWypC0Wv834T7kGjv/q7a/oaNU2NlCWKt8R5zJ0ilSM=;
        b=Kc8zI3tHpKjHXJiOfAbXIKvSEhlrWtCV4FwxIxIvyLDeKGy2K9jFVPEyAX9uucycwq
         4M/oH7cKZs+nPeBtH8HT/Q5HpMA3yPfZK9fniKqf2U7w2nIhDJ4O/QDvOo03kdVlaYgw
         oZlpDK/6/xIOIBvXsqbJ5dXFb0CNQNYMJ+r7PDwlqQAVGLQLj+MRwTXXHoN8UpYR1t5c
         2b8pUp0pgklMiElqIg56fFdMi1ZHKEzYvYG+FkpfXzPkIK+unThSEzcpJQgR/zt/i0Fq
         0luI7snBEpC9zwrJxO5VBpCiRKjhM3Zp+I8SzoxjXLxlAeJlpShMv6ogCrBeLcVJVjSH
         VmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zWypC0Wv834T7kGjv/q7a/oaNU2NlCWKt8R5zJ0ilSM=;
        b=F6iJrCH4v2EdROEhDha+/a1sXlR7/2pGgYVvhi6hhAk5tXHHBLhIly8Yy/IcnKIkjl
         cKaIbHfKKhRh7Jtt6R2kOozaie/aXO6ELVLpET61epHqU446E8GsytVD6q/Z45LW4/fV
         dPQfoj1j1PfNh/nTeY6ZDkjNYwJUz+/kZ/+tib91OFVo2hhEvt3a/Lt4jZd/xLmR/elB
         pFCDrAGPytRX9Dt/3+9bDfaZxfmoDco2+K4/6NjL7Nso1dqf3/2SfIvz10eYJThDaj/0
         Oiz/86nFkVTHul6bx/ymjaVKAQzNxi8dVNEXcG8lGPaEVVyHyFMEMWZE0c+u5HgXNJlk
         HFaA==
X-Gm-Message-State: AKwxytfirF/8H2FI0P2cmNfjcYHE3zOCW7mHff0g/Z8zetTn5zm75Ad0
        bZT+k0f93UJqeQLZ9g04RQntgh4xrf8A5Sr2500=
X-Google-Smtp-Source: AH8x224PZSawIJ7qIZpbQjiXxM5/7OD4Kg96uVW3udh5/d2wntf5HsDHTi7R6jduiRLHMlim/2/KID+7q29gsyChsl4=
X-Received: by 10.80.191.71 with SMTP id g7mr59682043edk.246.1517467053353;
 Wed, 31 Jan 2018 22:37:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.177.180 with HTTP; Wed, 31 Jan 2018 22:37:12 -0800 (PST)
In-Reply-To: <nycvar.QRO.7.76.6.1801311424270.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <cover.1517266437.git.johannes.schindelin@gmx.de> <xmqqo9lbrput.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1801311424270.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 31 Jan 2018 22:37:12 -0800
Message-ID: <CA+P7+xor7xf5WPSeT+p4cGiaCnAazGHFHg5ago=fWVe9d2sk+w@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] rebase -i: offer to recreate merge commits
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 31, 2018 at 5:29 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> I think I may want to introduce a bigger change, still. I forgot who
> exactly came up with the suggestion to use `merge -C <original-commit>
> <to-merge>` (I think it was Jake), and I reacted too forcefully in
> rejecting it.
>

I believe someone else suggested it, but I replied that I liked it.

> This design had been my original design in the Git garden shears, and I
> did not like it because it felt clunky and it also broke the style of
> <command> <commit>.
>

I agree it's a bit weird it breaks the style of "<command> <commit>",
but on some level merge does this anyways as it's the first one to
take more than one argument.

> But the longer I think about this, the more I come to the conclusion that
> I was wrong, and that the -C way is the way that leaves the door open to
> the pretty elegant `-c <commit>` (imitating `git commit`'s option to
> borrow the commit message from elsewhere but still allowing to edit it).
>

The other reason I liked this, is that it matches merge syntax on the
command line, so users don't need to learn a special new syntax for
the todo file.

> And it also leaves open the door to just write `merge <to-merge>` and have
> the sequencer come up with a default merge message that the user can then
> edit.

I like that we could completely forgo the -C and -c in order to allow
the normal default merge commit message that is auto generated as
well.

>
> I'll probably refrain from implementing support for -m because I do not
> want to implement the dequoting.
>

Yea, I don't think that is necessary either.

Thanks,
Jake

> Ciao,
> Dscho
