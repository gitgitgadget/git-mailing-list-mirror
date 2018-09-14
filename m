Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CD131F404
	for <e@80x24.org>; Fri, 14 Sep 2018 21:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbeIOCaJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 22:30:09 -0400
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21804 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbeIOCaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 22:30:09 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1536959635; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=oIwFj+WFhSaXWlps1FYZni6Hn1wYmBOVb+r2+xSOjZM2MjcZpEXH6yYLdbsySMQkGlV5kcHrOV3WHQ64HpxTglFovWu23B6z+sqy7ZeYa84NGALJANMxvbUvvGqcMQsddzxiYpmIsatVZYMoWBZOLGNXGGBDecVa+TOcePbX+S0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1536959635; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=Tnlh3Ol+l+9er6XIUzHhoDwaa/ZPSM9LfKyB3Iqf5S0=; 
        b=Kkui1Ni/cJWtSyQiiLs+99ksvvOZus6WxW2ZsOh1EiXCyW9LnJ8GhvVno1pz8h0RIbWnkE2TIvZBuky/nAUXsEZzOaJubv6P411Lr7n1Rnzp+UNjwcDZRSpeGk7Uo520LMVY8x+qUREuyGCaS9kqYFz9ehQMJUpWW5bItYqyXnk=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=astrangergravity.com;
        spf=pass  smtp.mailfrom=john@astrangergravity.com;
        dmarc=pass header.from=<john@astrangergravity.com> header.from=<john@astrangergravity.com>
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177]) by mx.zohomail.com
        with SMTPS id 1536959633875295.5640525245507; Fri, 14 Sep 2018 14:13:53 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id s12-v6so8618604ljj.0
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 14:13:53 -0700 (PDT)
X-Gm-Message-State: APzg51C5DWexw3KfblLYy1LjNmB5yEC2S2+qElo3aioQshfvFLlig+iy
        dco/1/fFWics4KpQbBr6m2o4ABrYKICqD6Bgz1E=
X-Google-Smtp-Source: ANB0VdZMAWQZZ+8riC1SqNq4mo0GJVjaWcu9SuJqdeCGTChpZ+gMrROt9VmMW//uag2+DD5cAdsF09TeZm8BgEz1pvM=
X-Received: by 2002:a2e:54b:: with SMTP id 72-v6mr9385000ljf.152.1536959632067;
 Fri, 14 Sep 2018 14:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com>
 <20180914190025.GJ55140@syl>
In-Reply-To: <20180914190025.GJ55140@syl>
From:   John Austin <john@astrangergravity.com>
Date:   Fri, 14 Sep 2018 14:13:28 -0700
X-Gmail-Original-Message-ID: <CA+AhR6crT2AoJcoGAGA0_c_XdL-0ozHUXTuDrS67tzrTvRLQZw@mail.gmail.com>
Message-ID: <CA+AhR6crT2AoJcoGAGA0_c_XdL-0ozHUXTuDrS67tzrTvRLQZw@mail.gmail.com>
Subject: Re: Git for games working group
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        larsxschneider@gmail.com, pastelmobilesuit@github.com
Content-Type: text/plain; charset="UTF-8"
X-ZohoMailClient: External
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Taylor,

Great to have your support! I think LFS has done a great job so far
solving the large file issue. I've been working myself on strategies
for handling binary conflicts, and particularly how to do it in a
git-friendly way (ie. avoiding as much centralization as possible and
playing into the commit/branching model of git). I've got to a loose
design that I like, but it'd be good to get some feedback, as well as
hearing what other game devs would want in a binary conflict system.

- John
On Fri, Sep 14, 2018 at 12:00 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> Hi John,
>
> On Fri, Sep 14, 2018 at 10:55:39AM -0700, John Austin wrote:
> > Is anyone interested in contributing/offering insights? I suspect most
> > folks here are git users as is, but if you know someone stuck on
> > Perforce, I'd love to chat with them!
>
> I'm thrilled that other folks are interested in this, too. I'm not a
> video game developer myself, but I am the maintainer of Git LFS. If
> there's a capacity in which I could be useful to this group, I'd be more
> than happy to offer myself in that capacity.
>
> I'm cc-ing in brian carlson, Lars Schneider, and Preben Ingvaldsen on
> this email, too, since they all server on the core team of the project.
>
> Thanks,
> Taylor
>

