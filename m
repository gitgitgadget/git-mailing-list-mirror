Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 931F32035A
	for <e@80x24.org>; Tue, 11 Jul 2017 18:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756054AbdGKSYA (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 14:24:00 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35824 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755511AbdGKSX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 14:23:58 -0400
Received: by mail-pf0-f169.google.com with SMTP id c73so126713pfk.2
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 11:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=V5xfGnicq69WRBB7PLfeI7x9Y1YKj23C9RYNXiuYfjk=;
        b=hvkJ+Eytubtnl9+sRKQ63f8LBnHeugfe0oVYDqD1TZnM5pINggorSMFxe4lj879MDQ
         R+9cnSL/NgmVEV/p716upA1LrZ8SxlEyYu4AzZzCWPvd5IUixOnfKtXp3KMP8aBrtYLy
         bq2UALUGMWV1BDewrmdWcZs0gQWCDITXOimhQNmNPRpWRffMz5T80ayYBiCN2ZBnID/q
         /XlwrDm754ld/aKbg1UwfzyzaeTanbtSFjkXOqjn7OgMEp7alivp65rf8Est/9rQCHUo
         3mYRoVSHF+YRauwLuEFjmu4VwdhtCsRJrjUaNLdqPDXWf7ZoSTELOlFbRS/2+wNEviSI
         r+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=V5xfGnicq69WRBB7PLfeI7x9Y1YKj23C9RYNXiuYfjk=;
        b=f2vH2vl/gifMMfo32f0iOOxX4mEfn1f5mboSbgaZ+Q+oeavq+fRZW8jdNRxE3QdYXF
         Z4KGMrhmSUg63T1qxFS6/VJdrYapMMX8rhJFDwrfHJf+sK38XP9wj0E72cvSxRyRULoP
         TJa5uHjWcn08fp2F8BhPjqw6L1Sejzulq8Gky0epyMfKt2BlDgyW8IAMsqFQN6Ld4T1P
         34tL7l/sZZYiDxa4SD+gs0L3bhBbXYLjgSuyxa1vaU13stz1e2eW2aTcDv0zaP4ZUHQc
         IbBXybiTWkx/fXrCx6IeYrDcrg9rquuRVyfw/ioOGTGYx8jesJfv9JIx41A6ZpoK7jh7
         hOmw==
X-Gm-Message-State: AIVw110P98KXFek1wEmK3vNpB2rrpPzCqaVS2ioiXstGXMbHT3T19UqE
        ah4KSM+hk/iJ2Gn0
X-Received: by 10.99.95.70 with SMTP id t67mr1243048pgb.104.1499797437912;
        Tue, 11 Jul 2017 11:23:57 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:3402:2400:d1c0:8987])
        by smtp.gmail.com with ESMTPSA id l78sm10451pfb.59.2017.07.11.11.23.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 11:23:56 -0700 (PDT)
Date:   Tue, 11 Jul 2017 11:23:55 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/7] api-builtin.txt: document SUPPORT_SUPER_PREFIX
Message-ID: <20170711182355.GH161700@google.com>
References: <cover.1499723297.git.martin.agren@gmail.com>
 <1b08c5f568028645325367d6d6b97b9da17894ff.1499723297.git.martin.agren@gmail.com>
 <20170710225022.GB161700@google.com>
 <CAN0heSq3mxRXdv0WmqqmY1tqPAJH06Eu9xyPWBxY=O1kii1ufw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSq3mxRXdv0WmqqmY1tqPAJH06Eu9xyPWBxY=O1kii1ufw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/11, Martin Ågren wrote:
> On 11 July 2017 at 00:50, Brandon Williams <bmwill@google.com> wrote:
> > On 07/10, Martin Ågren wrote:
> >> Commit 74866d75 ("git: make super-prefix option", 2016-10-07) introduced
> >> SUPPORT_SUPER_PREFIX as a builtin flag without documenting it in
> >> api-builtin.txt. The next patch will add another flag, so document
> >> SUPPORT_SUPER_PREFIX, thereby bringing the documentation up to date with
> >> the available flags.
> >>
> >> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> >> ---
> >>  Documentation/technical/api-builtin.txt | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/Documentation/technical/api-builtin.txt b/Documentation/technical/api-builtin.txt
> >> index 22a39b929..60f442822 100644
> >> --- a/Documentation/technical/api-builtin.txt
> >> +++ b/Documentation/technical/api-builtin.txt
> >> @@ -42,6 +42,10 @@ where options is the bitwise-or of:
> >>       on bare repositories.
> >>       This only makes sense when `RUN_SETUP` is also set.
> >>
> >> +`SUPPORT_SUPER_PREFIX`::
> >> +
> >> +     The builtin supports --super-prefix.
> >> +
> >>  . Add `builtin/foo.o` to `BUILTIN_OBJS` in `Makefile`.
> >>
> >>  Additionally, if `foo` is a new command, there are 3 more things to do:
> >
> > I added SUPER_PREFIX as an implementation detail when trying to recurse
> > submodules using multiple processes.  Now that we have a 'struct
> > repository' my plan is to remove SUPER_PREFIX in its entirety.  Since
> > this won't happen overnight it may still take a bit till its removed so
> > maybe it makes sense to better document it until that happens?
> 
> I could add something about how this is "temporary" although I have no
> idea about the timeframe. ;-)

Its probably better to ensure that things are documented (even if they
are temporary) but you don't need to mark it as such.  And as far as
timeframe, that's my burden to bare ;)

> 
> > Either way I think that this sort of Documention better lives in the
> > code as it is easier to keep up to date.
> 
> Agreed and I believe that's the long-term goal. I could replace this
> preparatory patch with another one where I move api-builtin.txt into
> builtin.h or git.c (and document SUPPORT_SUPER_PREFIX if that's
> wanted). That's probably better, since right now, patch 2/7 adds
> basically the same documentation for the new flag in two places.

I know that sort of migration may be out of the scope of your series
(since its just documentation), though you're more than welcome to do
the work as it would be much appreciated by me and a few other people :)

-- 
Brandon Williams
