Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F98520248
	for <e@80x24.org>; Sat,  6 Apr 2019 21:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfDFVUD (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 17:20:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39358 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfDFVUC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 17:20:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id j9so11919283wrn.6
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 14:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XTg+wtJCAMgm7EPDdLRXsSMwgdm0pFCth5S6Vkhe29o=;
        b=uWfBh2cJYBT6XFxDiwVRSQWtn28B25ojMiSZOnE9MEA2K9NjdNY/j+HMjyyG39qyE5
         S5qDyJG2uPYWqElntAjeGHx5xsuLCJM4vhsT/7e7iiVCk3veDZCo0k0+TjQOgOgFOpxq
         oSDTvc4wDY2k02CptjIFOwVQ4ElJMZjpvC52dK9Msz5DuFgLrMLj3IETlR4rhur8SpmK
         DHT/7OwyNOe0Lbg1rlHjITrL/8KOGrlXLvClUuYCwOM0Vt4dwGSJTXG7vczfDHkE01Wv
         v5BlNElgvdMmvtNjcpCD6uEtROH+Azz4wQPUrmlES9rlkqBnHOFviD/D7bQlnIMTVTtF
         Illw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XTg+wtJCAMgm7EPDdLRXsSMwgdm0pFCth5S6Vkhe29o=;
        b=svf41DUIGwMlYMne6JTqyTnVy7g4KsvQAxOd8dUbMPdj97HuFtT12MV17kZmuiybNY
         19SIvo9UTeJRQMrf9/laDynB06pHj0XbFP6LjwKA6EeGVhJBFBriz8eMjwR1hv5wEnMB
         KgsKGUX+O5l+o0Rwk+wvD6/xPuWBUJibb9Yh88te3SUVJ11R/6JZsdDkrl0eV+yIwvie
         kEavmj7DrQLPHGuaC5uls1+DwenTQd9Zru6BmnK6xIEowX7On+/403IAKMcxjYMTVv97
         XNGG5T/A0nMuZR3wepOjHM42uYrCA2BYt5kIF9gdZWF3UgcQcO/PZGozW03xNvr5o8cT
         qK9Q==
X-Gm-Message-State: APjAAAVaq84Pmum0kHzc45qxRqueIcQy2sdAZZiSaXD9BxCteJx6Kh+9
        4goXQKGoxttKuuc8poSZiT4=
X-Google-Smtp-Source: APXvYqx8GcY2QEm1JXpWg9sGWE06AFKdO8lu6EeLMEzjzqbtyfCdehD7Uj2w+spz4/2JTtpiaokzFA==
X-Received: by 2002:a5d:4a4d:: with SMTP id v13mr13461726wrs.169.1554585600967;
        Sat, 06 Apr 2019 14:20:00 -0700 (PDT)
Received: from szeder.dev (x4db319c1.dyn.telefonica.de. [77.179.25.193])
        by smtp.gmail.com with ESMTPSA id 192sm9952795wme.13.2019.04.06.14.19.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 14:20:00 -0700 (PDT)
Date:   Sat, 6 Apr 2019 23:19:58 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Paul Schreiber <paulschreiber@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug: subcommand autocomplete fails on 2.21.0
Message-ID: <20190406211958.GE8796@szeder.dev>
References: <E4A677E6-E624-464B-9BC6-AAAE0A77EFFE@gmail.com>
 <20190406174929.GD8796@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190406174929.GD8796@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 06, 2019 at 07:49:29PM +0200, SZEDER Gábor wrote:
> On Sat, Apr 06, 2019 at 12:36:30PM -0400, Paul Schreiber wrote:
> > With git 2.21.0, tab completion no longer works for subcommands.
> > 
> > STEPS TO REPRODUCE
> > 1. install git 2.21.0 from https://git-scm.com/download/mac
> > 2. source /usr/local/etc/bash_completion.d/git-extras (manually, or update your .bashrc/.profile and start a new terminal)
> > 2. git clone https://github.com/tj/git-extras
> > 3. cd git-extras
> > 4. sudo make install
> 
> By the looks of it, this installs five commands whose names start with
> 'del':
> 
>   git-delete-branch
>   git-delete-merged-branches
>   git-delete-submodule
>   git-delete-tag
>   git-delta
> 
> If this is indeed the case, then ...
> 
> > 5. change directory to a git repository
> > 6. type "git del” and press [tab] 
> > 
> > EXPECTED
> > line is changed to "git delete-merged-branches"
> 
> ... this behavior would, in fact, be a bug, because 'del' is the
> unique prefix of those five commands.

Erm, let me rephrase, because this doesn't make sense:

... this behavior would, in fact, be a bug, because 'del' is the
common prefix of those five commands, so it can't be uniquely
completed.

> > ACTUAL
> > [beep]
> 
> And I think this is the right behavior, and on a second TAB it should
> list all commands whose name starts with 'del'.
> 
> > CONFIG
> > macOS 10.13.6 (17G5019) and macOS 10.14 (18E226)
> > git 2.21.0
> > git-extras 4.8.0-dev
> > 
> > REGRESSION
> > Works as expected with git 2.17.0.
> 
