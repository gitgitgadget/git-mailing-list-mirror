Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC8791F6BF
	for <e@80x24.org>; Sat,  3 Sep 2016 21:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754101AbcICVaN (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Sep 2016 17:30:13 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:38517 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753962AbcICVaM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2016 17:30:12 -0400
Received: by mail-it0-f41.google.com with SMTP id c198so95589597ith.1
        for <git@vger.kernel.org>; Sat, 03 Sep 2016 14:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redfrontdoor-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IwUcryVAHdCNxbpZGh19+KepTH8oq8ksPwHcfZkVNcY=;
        b=f9oedeISV1vkcZu94Y6HZZJ6I1/xEttmwMzoHOyzH0xh+lBWkdIQPstEFNWvfXWQK6
         KHRw6RcGQHl0cSN08KxQbtZfirLfxUgwKupqtLPzJlH9L01ol7uH5zLAxMXGqYiIreBF
         oe5+YaJeGLp2ogtpo6XYAzkQg8p93yJtLHpZ2ThK9zSK6lpVkWKCQw6xjmxGuPVvagfv
         F4ZKZtXkOlHSBqplGDEPvS2LxV5NEDvmTSbpDwHXQ57H3T4fmwugWl7Kqh20jmDEYweV
         NJIVj3b7ddMOWIBFlCPrrQ9qV6GSbdygFVFBnkxZrAi2JS3fA2ziXk4ifSMTGh4K1f01
         JsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IwUcryVAHdCNxbpZGh19+KepTH8oq8ksPwHcfZkVNcY=;
        b=mjEKpzzhOI+OHyFqKfYFXiMg86GxBkOf2xtEhY+LWG6Xl9qJI/ZyzjNqwHsOQMLSxG
         T1nY4Kc7O4SwP0Tmydm+l4In9RrPd+N8UwVOhcTEe28EgWvB6Ro9FmPWQg8cshBUvbhe
         wg2ts175IKobf8b72g90iX6ZRA0DeZWvQ5+ltTzhHEdluwK2KrmoWUw1bBwEjMzFgpRq
         FAs/9aqtdurqgRpCUExjH5atiIMoDhV2KW1ADXcRyn/Bu5Q1g93EUAxT+5t8nGoYEAXS
         qyeqE69jB3wa52e910XspRSKp0pF7QLXYvLo228DN470a91Afbl52+oBkPR2yoA0+L1D
         6Rfg==
X-Gm-Message-State: AE9vXwNLHLIfWyCMg7FNT6afBUk/LY8moIM418B/NTVpBNu8KN/CiM043a22mTNloOs/M7iRR5TRDtKk+RsWGA==
X-Received: by 10.36.123.212 with SMTP id q203mr13196032itc.13.1472938211664;
 Sat, 03 Sep 2016 14:30:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.36.77 with HTTP; Sat, 3 Sep 2016 14:30:11 -0700 (PDT)
In-Reply-To: <CAGZ79kbOMa5e5pUi+pA1JUSehFYMyCot+ZRWbORgwq2xCqvnZg@mail.gmail.com>
References: <CAHG0eJVk6HF5Mz3wz08sjgL05zB4cAjmZ=FR=jf5G4kh-ChV8A@mail.gmail.com>
 <CAGZ79kbOMa5e5pUi+pA1JUSehFYMyCot+ZRWbORgwq2xCqvnZg@mail.gmail.com>
From:   Ben North <ben@redfrontdoor.org>
Date:   Sat, 3 Sep 2016 22:30:11 +0100
Message-ID: <CAHG0eJUuZc8WFE9pkBgBQ0kikcQj8-bgt0fyeek5QDxDQnsABw@mail.gmail.com>
Subject: Re: Literate programming with git
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

Thanks for the remarks.

>>     https://github.com/bennorth/git-dendrify
>
> [...]  You get an easy top-level overview what
> the community is interested in via e.g.:
>
>     git log --first-parent --oneline
>
> That would be equivalent to showing only
>     * Add printing facility
>
> If you run that command on "* Add printing facility"^2
> you would see the headlines of the section.

That's a nice observation on how to use the existing git tools to view a
structured history with different levels of detail.

> However in gits reality we do not have these nice sections
> building on top of each other, as many people are interested in
> different things and build where they see fit.

Yes, reality isn't always clean!  But each individual contributor can
structure their own branch in a hierarchical way if they think it would
be helpful, before publishing it for review.

> How does the linearify/dendrify work with already non-linear history?

If you attempt to 'linearize' a section of history which isn't of the
required hierarchical form, the tool exits without doing anything.
(Because this is only at the experimenting stage, there may well be
situations where it fails to detect an unexpected structure, but see
also next paragraph.)  Similarly, if you attempt to 'dendrify' a section
of history which isn't purely linear, it refuses.

In any case, the tool only ever creates a new branch so your original
history is unaltered.

Thanks,

Ben.
