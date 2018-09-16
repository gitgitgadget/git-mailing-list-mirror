Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B82BC1F404
	for <e@80x24.org>; Sun, 16 Sep 2018 10:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeIPPhu (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Sep 2018 11:37:50 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:41682 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeIPPhu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Sep 2018 11:37:50 -0400
Received: by mail-pl1-f174.google.com with SMTP id b12-v6so6081699plr.8
        for <git@vger.kernel.org>; Sun, 16 Sep 2018 03:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zVGbRgJvlvbMB1Vd5YOdId32Szu2HcX5aK0dR9WzDBU=;
        b=r7pkfNEvTF4nSOQFrXVpGek+bV6w+fc7VysGtACU+rR57nadFWRM8XfG5bxlXvZ/x2
         Wxn/YUVj8b0FpF68b5I32QBopFc2TeALijAjNjGquSKzpzGIGYRQPo+eu1UzZqivTPzd
         JXc7iyi6h41bJ3FmboQ1LTyQgCWCLiOMHCWc6YiDvsKYTaVCFmPHeWXhZqapkLRgeDj2
         DC39FucuBtNUBwWNy5UchqUetsJ7JLi4LNQSiWtk8oKgZ5KduCakjD+43JxQhz4hgQ5x
         7FbL5lKNZvpufKcR1rVn5oEBismsMKPR/W2EbSOmO+97/3M8gel6nPBdcouN/QMrwxX/
         2yIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zVGbRgJvlvbMB1Vd5YOdId32Szu2HcX5aK0dR9WzDBU=;
        b=mFee8Manikv91oha7FQ0G+nSsjAtnY6PFhdS6yDYT1cL984FRjvUFtVR8tkyNWDtyn
         RIchxzC4XEkgZy0f6qHs0y+MxTrEda7ewZbHtnTl0dyqK1fAoYhIHLFrpQW/32bbzK2I
         SmlaUCCkKx/OBlNO+PSDdxyduMgH8x2hFrIMWObP8xuU1yGtUW8KVv9AArJ2+Mt7nJXq
         KQ8fcjOUzkehLr7slUY+WKMzrMJurL+kviSVQef1MZqbJwBlba2KK6AYcagOx+JE/9Np
         k4A4pgW2Z7/XN+lHJvSDB2rK0N+1lOhrLqYWxZNhhAsG+XFr0Nt9YSe3K3tzjMQqY42P
         EZZQ==
X-Gm-Message-State: APzg51B0rf+7XY7vE4lrpm50wU7BAzOlNqBGdexfpo75FRV5G41gtcIC
        9f546BmMN0XTGS2vMD/WG2C4ePar3oo=
X-Google-Smtp-Source: ANB0VdY6QWnMsJapQyQ4uVnsTZVTuA/+/cUzN1v1oplgEpZ8wt7cP4QHKKjG9VzzZYa7TXNuSTTzDw==
X-Received: by 2002:a17:902:9a48:: with SMTP id x8-v6mr20192898plv.72.1537092924411;
        Sun, 16 Sep 2018 03:15:24 -0700 (PDT)
Received: from gmail.com (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id r64-v6sm17645281pfk.157.2018.09.16.03.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Sep 2018 03:15:23 -0700 (PDT)
Date:   Sun, 16 Sep 2018 03:15:20 -0700
From:   David Aguilar <davvid@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, git@sfconservancy.org
Subject: Re: Git trademark status and policy
Message-ID: <20180916101520.GC18517@gmail.com>
References: <20170202022655.2jwvudhvo4hmueaw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170202022655.2jwvudhvo4hmueaw@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, Feb 02, 2017 at 03:26:56AM +0100, Jeff King wrote:
> 
>   - Commands like "git-foo" (so you run "git foo") are generally OK.
>     This is Git's well-known extension mechanism, so it doesn't really
>     imply endorsement (on the other hand, you do not get to complain if
>     you choose too generic a name and conflict with somebody else's use
>     of the same git-foo name).
> 
>   - When "git-foo" exists, we've approved "Git Foo" as a matching
>     project name, but we haven't decided on a general rule to cover this
>     case.  The only example here is "Git LFS".

The "Git Cola" project[1][2] provides two fully-featured Git porcelains,
"git-cola" and "git-dag".  The DAG tool is never referred to as a
separate project, so shouldn't be a concern trademark wise.

The project dates back to 2007, while the "Git Cola" name dates back to 2008.
FTR, the name "Cola" is also a shout-out to Linux (comp.os.linux.announce).

Can we continue to use the name "Git Cola" going forward?


> So that's more or less where we're at now.  In my opinion, a few open
> questions are:
> 
>   3. Was granting "Git LFS" the right call? I think the project is a good
>      one and has worked well with the greater Git community. But I think
>      the name has implied some level of "officialness". We obviously
>      need to allow "git-lfs" as a name. But should the policy have said
>      "you can call this LFS, and the command is git-lfs, but don't say
>      'Git LFS'". I'm not sure.
> 
>      One option would have been to ask "git-foo" to prefer "Foo for Git"
>      instead of "Git Foo" in their branding (it's too late now for "Git
>      LFS", so this is a hypothetical question for future requests now).
> 
> -Peff

In my (biased) opinion, granting "Git LFS" was the right call.

As long as the project is clearly a separate, but primarily Git-centric,
project then it seems like the right approach to allow "Git Foo" for
open source projects that contribute positively to the Git ecosystem.

Lastly, due to time constraints, the Git Cola logo is a tweaked version
of the Git logo, which may convey a level of "officialness" that might
be unwanted.  We can work on a replacement if desired.

Part of keeping the logo/visual identity close to core Git is because
the tool was always meant to be strongly tied to Git's unique features.
It's probably the same reason why the git-lfs branding uses similar
orange/red palettes -- to convey cohesiveness.  I would prefer to keep
the visual identity as-is (including the logo).

Can we continue to use the derivative logo for the time being until a
replacement is produced?  Alternatively, can we keep the logo as-is?


cheers,

[1] https://git-cola.github.io/
[2] https://github.com/git-cola/git-cola
-- 
David
