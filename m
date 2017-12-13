Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A0D01F406
	for <e@80x24.org>; Wed, 13 Dec 2017 05:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750916AbdLMFgz (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 00:36:55 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:41445 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbdLMFgy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 00:36:54 -0500
Received: by mail-wm0-f41.google.com with SMTP id g75so2636456wme.0
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 21:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rk2WuONphvRS7M0Nhm/sIzzKmYP20bwp+QsP/h8bYOc=;
        b=AnALGfZd/AdsTvqujTulyxb6QCkkyQ9sPOevm3YQjRG68CUEbE2HKoPBIHVHAX6qYZ
         9Fl8PawKZkFxiW/96uijRluEL62+D/zE/kR5kryVuPMdbgpWEjE1/sJ5RQ9dgt/tf50G
         eO5zDeUT6iV607jF6bAp+9+i4ofziCsxjuDmr0Oa3hot/WFnKvURNsFjmlaBVwyLk/h0
         e0Y6vOld+Ja0/D/mD3FSOUZQMI3u3IB+MG3ot8gpdOvabXankeeKDAK3s/U68XIBsuXC
         kRZOpw+MfLKM+NQIRKB3snhKL6NZ/zs8ove0jKWFn9gqUdZsbTq4gH/K3MGFtHKHTkTH
         ME1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rk2WuONphvRS7M0Nhm/sIzzKmYP20bwp+QsP/h8bYOc=;
        b=eLGNmnPn3iyY+r8Ooh02qIhwRIxXVXhLTCj1U74iOBagguO+kU89a2RzQSFGSZlBfq
         qC4TqHP2CDq0wy7xQJv/bAaoPC/FBELMZnX6J6lc3wyzPgFueCHKJfdRjzHFNLTCJci+
         9+awmD+xOKlQQeDBcmxPBbRxCMpfPdFJf6AOOTAB7ORh1ro6QCYYVvX4K2HNR3nap12f
         iI2AuJ1QNlr6LAy2mNzSI2X9vzsGWuYFsFWLOwpDmYQYQDUVwBiZwpZqD50rC7VWShaK
         1QQpvkP7quTvo9YPYIIcY789Umv+Q3A6b8dltsHsq8n9zdMH8tJfTItU9RBc7Ohv1BTa
         T8QA==
X-Gm-Message-State: AKGB3mI17B02cqXjFkFLKTY9vloB7DJixydCDki1Y94JTahfzrGyt8QR
        0KTtNdVYNSneTFiNfC8z0ExxhtKO0fvFg0T3PIY=
X-Google-Smtp-Source: ACJfBovEv2zAyWGQTjKMlYvmlzPYGnhZQpibu56iN2sz2N4rUQKC0LTUY0ESAh3wn+3Q1gemrEF7fhFQ/BjUrh+sQWw=
X-Received: by 10.80.149.152 with SMTP id w24mr6132961eda.76.1513143413294;
 Tue, 12 Dec 2017 21:36:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Tue, 12 Dec 2017 21:36:32 -0800 (PST)
In-Reply-To: <20171212152009.GS3693@zaya.teonanacatl.net>
References: <1513077862-165-1-git-send-email-jacob.keller@gmail.com> <20171212152009.GS3693@zaya.teonanacatl.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 12 Dec 2017 21:36:32 -0800
Message-ID: <CA+P7+xqZAYqTHjfbTSDG8Uj4Sdj3Ja6xxFYBfS=P92XiBMvLmA@mail.gmail.com>
Subject: Re: [PATCH] doc: clarify usage of XDG_CONFIG_HOME config file
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 12, 2017 at 7:20 AM, Todd Zullinger <tmz@pobox.com> wrote:
> Hi Jacob,
>
> Jacob Keller wrote:
>> The documentation for git config and how it reads the user specific
>> configuration file is misleading. In some places it implies that
>> $XDG_CONFIG_HOME/git/config will always be read. In others, it implies
>> that only one of ~/.gitconfig and $XDG_CONFIG_HOME/git/config will be
>> read.
>>
>> Improve the documentation explaining how the various configuration files
>> are read, and combined.
>>
>> Instead of referencing each file individually, reference each type of
>> location git will check. When discussing the user configuration, explain
>> how we switch between one of three choices. Ensure to note that only one
>> of the three choices is used.
>
> Perhaps it would read a little easier as "Make it clear ..."
> rather than "Ensure to note that ..." ?
>
>> +Note that git will only ever use one of these files as the global user
>> +configuration file at once. Additionally if you sometimes use an older version
>> +of git, it is best to only rely on `~/.gitconfig` as support for the others was
>> +added fairly recently.
>
> Is it really accurate to say these were added fairly
> recently?  It looks like XDG_CONFIG_HOME was added in
> 21cf322791 ("config: read (but not write) from
> $XDG_CONFIG_HOME/git/config file", 2012-06-22) and
> 0e8593dc5b ("config: write to $XDG_CONFIG_HOME/git/config
> file when appropriate", 2012-06-22) which are in 1.7.12.
>
> Would it be better to say something like "if you sometimes
> use a version of git prior to 1.7.12" here?
>

I copied this from the original and didn't look to see how accurate it
was. I'd be ok with dropping it now that we've had support for such a
long time.

Thanks,
Jake

> Or maybe we can drop "Additionally ..." altogether now?
> Someone using a 5 year old git version sometimes will
> hopefully know to check the documentation for that older
> version.
>
> --
> Todd
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Now don't say you can't swear off drinking; it's easy. I've done it a
> thousand times.
>     -- W.C. Fields
>
