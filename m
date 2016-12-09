Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F3E21FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 12:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932658AbcLIMih (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 07:38:37 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:33210 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932299AbcLIMig (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 07:38:36 -0500
Received: by mail-io0-f174.google.com with SMTP id d9so53710226ioe.0
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 04:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Yv0WLFPtxcZ6gSrYsUfG2zYV3ZVvoDwfDBgp8jHulZA=;
        b=Gw8L0sZjRpOX2l08KDe2puIFPr+EXb8b6AAywuTmIPiH2nTQzDttfw/SK132R7DOWd
         IXXnAai55yhIeKLhiw8M4VQHcEb/y1LF++BRnk7eSScimSGGoq8wNrCWVwx5zAq9liZy
         7xZ3ENDHrF8YmPqcKWNsDCwEk5oZ2JdkS+3J7Ke6rBLNe5loIEiZvxFVGp7o62Z4G9rD
         Shkzb88Q/jwVRGBihEbvZasSs05S+KdYd3b9t6lWS70O967dfu0G6ay0IeHXf+zO6dAI
         LGLj0G6JH7oRl75H6+M23IGL+I6PPX8cI0eHIgik5i/bcJwrRSbd69w8TuoFlOxQtgfw
         0hyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Yv0WLFPtxcZ6gSrYsUfG2zYV3ZVvoDwfDBgp8jHulZA=;
        b=Eie5HzmBNW9d399VXOdLsS7ui21Yv9jSlsN8Pf/gAFwHnjj+6oBO0jnVmiWOlHAPND
         et70Ox/Zsk+whcYhFuyVlCXASA5H3rBRdNwhnv4IXbyhfj945l4RZhvb1FltD9picDDc
         JNcLmrgxqxIvzAuRFLefROomol2Lgdh2oDF9IlDzIab0w6ULFXhcO2okNZ9Fq4LL3ryf
         8yy081k5SaEWTUH31ceEZinIJCtQzSeF9xB7e0+M607OwJJOJhHUTcex2UzqEV8p9Rbc
         MFA5XKs42hy44EA2joFjNTytKvnKX9nt2Te15hVIkDd5TorFqt6fFuGSkuYYiB0GwETA
         czWw==
X-Gm-Message-State: AKaTC01+sgQ+A18GiQf47ZgSJclUvtsoR/W8/F9V8eVGkEGW+xfXEJ5vwVyBL0Nc0CUnrDccF1sMP8Kb3yYL8g==
X-Received: by 10.36.90.72 with SMTP id v69mr6501921ita.74.1481287115810; Fri,
 09 Dec 2016 04:38:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Fri, 9 Dec 2016 04:38:05 -0800 (PST)
In-Reply-To: <3881793.6JIRvg1BPW@ylum>
References: <3881793.6JIRvg1BPW@ylum>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 9 Dec 2016 19:38:05 +0700
Message-ID: <CACsJy8AgbGXvMC0XWSPuBHEveJfJFEYUgghDC1Yc7Eka1Dyd8Q@mail.gmail.com>
Subject: Re: Feature request: read git config from parent directory
To:     dod@debian.org
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 9, 2016 at 2:49 AM, Dominique Dumont <dod@debian.org> wrote:
> Hello
>
> I use the same machine for work and open-source contribution. In both cases, I
> deal with a lot of repositories. Depending on whether I commit for work or
> open-source activities, I must use a different mail address. I used to setup
> work address for each work repo in git local config, but this is no longer
> practical.

Sounds like the same problem I have (and the reason I came up with
conditional include [1]). Would that work for you (check out the
example part in that patch)?

It's not supported yet. I'll need to address a few comments in the
future reroll.

[1] http://public-inbox.org/git/20160712164216.24072-1-pclouds@gmail.com/

> Since I use different directories for work and open-source, would it be
> possible for git to read irs config also from parent directories ? I.e. setup
> git to read config from ./.git/config then ../.gitconfig, ../../gitconfig until
> global ~/.gitconfig.
-- 
Duy
