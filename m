Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F05B81F453
	for <e@80x24.org>; Thu, 14 Feb 2019 07:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392438AbfBNHYJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 02:24:09 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33216 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfBNHYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 02:24:09 -0500
Received: by mail-pl1-f195.google.com with SMTP id y10so2691142plp.0
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 23:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p6tjRmrgBNE7w3ngCd0s2utteA+SNajnrCQ09oxdqUA=;
        b=b7KR78SJyJk9KNxuEHqfZTxzgjOl6Il4REYXVMc9yJY4aFQAN4fKupY11/L4X4gPkS
         8xEnbQhJS+ITDK3xPM6uyvxhTBqTiCxV86cT03aXHTOpVOCu6QsC2Un7p3oGwIPB9PUY
         MmSUkX/Sml6Ki6zUxYFVPsH5nAf3uKL00DRyADyYxuGO1CF5FcwddWUsbiidGysDxBZZ
         c+peqr+nvT1kYXR9LEFWGOIFxbExrWHDcVefcT70diqtNhdz8OPvfvorikfdl6KqYz7x
         QEOJCRrWAJrvprxjGJcmSmXkB9DBvJeP7p0bbjdN6819MooaN45fIhfFcq3pJUN6/g4w
         M/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p6tjRmrgBNE7w3ngCd0s2utteA+SNajnrCQ09oxdqUA=;
        b=I28Atf7mUub+qZsPAkJqcBe/wO/G8cjIFkgQ+5BaH3OrXL8zE8/iEDu41FaVZ2SQCM
         xJ8ViUL2liB7ZJDNYczuzIHdabw5VJ9xWTAUPf4fVREec2gW1EO1N2LV395pJkPZqcP5
         Sj1nPYArWSNg9+ZpWhNosN6K6LunXb1zXFO1MH/TYnBtWnWA4FO6X4Al1tYile4BjQkI
         DU4eKpr0Phw5zBYl7aGnyeCE+D/xXnYummBcxJ+8NnOPO1gr5KXRUXyWwb8B8UzP2uN8
         BuVX0w+1/aY8ovkjb0QaOeg2H8OQ6gWIe0YriucgYYQ4jAnXPrBFH49pcRoM7eXuiKK/
         M90A==
X-Gm-Message-State: AHQUAubtT6G1nuToDXHCFUqkmLbsR/EaJkMExEFOy2ZqVk4y0Fb0dDI1
        pA0QXMgghp6d0gYQ4KzLPLo=
X-Google-Smtp-Source: AHgI3Ia3Xp1BOE7xXtNTOEPMBl8ZIkgEOe3KGUhcLW5Dnk+gBKlXiRt1nhwGaUvld2/B2R38fveTkA==
X-Received: by 2002:a17:902:bcc6:: with SMTP id o6mr2634842pls.39.1550129048517;
        Wed, 13 Feb 2019 23:24:08 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id z13sm1666951pgf.84.2019.02.13.23.24.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 23:24:07 -0800 (PST)
Date:   Wed, 13 Feb 2019 23:24:05 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH v2 3/3] submodule: document default behavior
Message-ID: <20190214072405.GA24259@archbookpro.localdomain>
References: <0b62f65a8016c41b96aa6caead366e1ed9dda333.1549944164.git.liu.denton@gmail.com>
 <cover.1549965172.git.liu.denton@gmail.com>
 <d8785cdd01503f2a7b9a6fbc19105c41a9a04046.1549965172.git.liu.denton@gmail.com>
 <xmqqzhqzbki3.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzhqzbki3.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 13, 2019 at 10:39:48AM -0800, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> > diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> > index 65a952fb96..2fdf9f4cf3 100644
> > --- a/Documentation/git-submodule.txt
> > +++ b/Documentation/git-submodule.txt
> > @@ -9,6 +9,7 @@ git-submodule - Initialize, update or inspect submodules
> >  SYNOPSIS
> >  --------
> >  [verse]
> > +'git submodule' [--quiet] [--cached]
> >  'git submodule' [--quiet] 'add' [<options>] [--] <repository> [<path>]
> >  'git submodule' [--quiet] 'status' [--cached] [--recursive] [--] [<path>...]
> >  'git submodule' [--quiet] 'init' [--] [<path>...]
> > @@ -28,6 +29,9 @@ For more information about submodules, see linkgit:gitsubmodules[7].
> >
> >  COMMANDS
> >  --------
> > +With no arguments, the default command is 'status'.  Several subcommands are
> > +available to perform operations on the submodules.
>
> I am not sure if "default is status" is really true.
>
>    $ git submodule status --recursive
>    $ git submodule --recursive
>    usage: git submodule [--quiet] ...
>       or: ...
>    $ git submodule -- sha1collisiondetection
>    usage: git submodule [--quiet] ...
>       or: ...
>
> If 'status' were truly the default, wouldn't the form without any
> subcommand take any option and parameter the 'status' subcommand
> would accept?

This is very similar to git-remote. Its default command is 'show' but
doing something like 'git remote -n' fails, even though
'git remote show -n' succeeds.

Would it make sense to revise this back to

	With no arguments, shows the status of existing submodules.

which was the phrasing I used in v1? (If this is the case, I'd also like
to drop the first patch of this series.)

Thanks,

Denton
