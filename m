Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 018811F404
	for <e@80x24.org>; Tue, 14 Aug 2018 21:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeHNX55 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 19:57:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40257 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbeHNX55 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 19:57:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id e13-v6so9795273pff.7
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 14:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fF6M1JkvAwftQ5xLGKb57AsS7sTPhF+ZOx9y5ApP+uw=;
        b=N2SVqWxYwQutfZCfagLSfyMPcyZEwMGFshOF3REYR3Jk5g9I6pGLy70D8n/t5wITz9
         FPeyAOJiKH+Orx6IOvJpxhqgZSHntrjsiuSUyh+yspmg7NOvmAx/EpMUwaJeBwHiQVsn
         eivAxx7Mc3juvB04/YSl0SdzN8qOxIBoA8T+wHScf5RQUDjntc5wOeUGrdA5fe+DADMC
         OvjLcSzGeekYkWfcGfwR6PG9E8wtiLLWfHfOZgjvotCUVNLRaUjE3XgIEDni328yLCnO
         lTxzu7eFsuBTUpzm2JKAC0W/B7jyrRVBCX9/ltLaTN2XSoK2ST3EmgWOSZCQraj85fAc
         524Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fF6M1JkvAwftQ5xLGKb57AsS7sTPhF+ZOx9y5ApP+uw=;
        b=RrGghozxLIWVXBsnWczx3r1BGZO27pl3HUN3NoF8IVuw+5hdyHAOGi2z/Fv76MSq4B
         cAfafDYAGCtMZXCqhLPR3GOgAuDiCsByz46O9lalXvtLOtuYDneUruW6Yecp/EehR7yz
         XVIt3ZRQjNEOhR6CWT7oW8H73P76KKj3VTFx+acmyMG70HbB3+liMgrfs3H6rKeBVV2U
         fGUl5AKy5tSz4udD2553O2wvfbXJVWnfRnEhuL1n5VSEdEYZVIR6azEX40RSCOUCMwJr
         caTXEBAB9q1PR70/m2K7ceApxyPjEuwKnWTpFu16p9wNgTjEilRCLeDk4qIi5vlCYDXt
         7Ryg==
X-Gm-Message-State: AOUpUlE+AJ0cVCxx80Q+F3hyi4tjbgbyd29GGKfa4JoUij0XC0MAZ03t
        44tqGdLPHRSt64LR4uFVJUO6ZjP2DQQ=
X-Google-Smtp-Source: AA+uWPyCV/b+/CUV2bRGwlx6FGKu575tKJjBRrzrKi/m/Z7mjbkGegHzndKwFbr4QdIDMZkv4z3GuQ==
X-Received: by 2002:a63:cb04:: with SMTP id p4-v6mr22014130pgg.197.1534280935647;
        Tue, 14 Aug 2018 14:08:55 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id e11-v6sm37807992pfh.16.2018.08.14.14.08.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 14:08:54 -0700 (PDT)
Date:   Tue, 14 Aug 2018 14:08:53 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: Syncing HEAD
Message-ID: <20180814210853.GB86804@google.com>
References: <CAP8UFD0_jpKdcDvNx5CYnmyDMagE_O-E7cef5VthaT_w-=4xsA@mail.gmail.com>
 <CAGZ79kZo3TK7O0bb+mKOkeLkp=rFHfFwGS6oispcvHwCEEh=LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZo3TK7O0bb+mKOkeLkp=rFHfFwGS6oispcvHwCEEh=LA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/14, Stefan Beller wrote:
> On Tue, Aug 14, 2018 at 1:09 PM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > Hi,
> >
> > When cloning with --mirror, the clone gets its HEAD initialized with
> > the value HEAD has in its origin remote. After that if HEAD changes in
> > origin there is no simple way to sync HEAD at the same time as the
> > refs are synced.
> >
> > It looks like the simplest way to sync HEAD is:
> >
> > 1) git remote show origin
> > 2) parse "HEAD branch: XXX" from the output of the above command
> > 3) git symbolic-ref HEAD refs/heads/XXX
> >
> > It looks like it would be quite easy to add an option to `fetch` to
> > sync HEAD at the same time as regular refs are synced because every
> > fetch from an origin that uses a recent Git contains something like:
> >
> > 19:55:39.304976 pkt-line.c:80           packet:          git< YYYYYYYY
> > HEAD\0multi_ack thin-pack side-band side-band-64k ofs-delta shallow
> > deepen-since deepen-not deepen-relative no-progress include-tag
> > multi_ack_detailed no-done symref=HEAD:refs/heads/test-1
> > agent=git/2.18.0
> >
> > which in this example shows that HEAD is a symref to refs/heads/test-1
> > in origin.
> >
> > Is there a reason why no such option already exists? Would it makes
> > sense to add one? Is there any reason why it's not a good idea? Or am
> > I missing something?
> 
> I think it is a great idea to add that. IIRC there was some talk when
> designing protocol v2 on how fetching of symrefs could be added later
> on in the protocol, which is why I cc'd Brandon who did the work there.

Actually the functionality for fetching symrefs already exists (when
using protocol v2 of course).  Despite this functionality existing its
not being used right now.

When performing a v2 fetch the first thing that a client does is request
the list of refs (by doing an ls-refs request).  The output from ls-refs
(if asked) will included information about each ref including if they
are a symref and what ref they resolve to.  So really we just need to
plumb that information through fetch to actually update HEAD, or even
update other symrefs which exist on the server.

> 
> > I am asking because GitLab uses HEAD in the bare repos it manages to
> > store the default branch against which the Merge Requests (same thing
> > as Pull Requests on GitHub) are created.
> >
> > So when people want to keep 2 GitLab hosted repos in sync, GitLab
> > needs to sync HEADs too, not just the refs.
> >
> > I think this could be useful to other setups than GitLab though.
> 
> As said, I can see how that is useful; I recently came across some
> HEAD bug related to submodules, and there we'd also have the application.
> 
>     git clone --recurse-submodules file://...
> 
> might clone the submodules that are in detached HEAD, which is totally
> not a long term viable good HEAD, so a subsequent fetch might want
> to change the detached HEAD in submodules or re-affix it to branches.
> 
> Unrelated/extended: I think it would be cool to mirror a repository even
> more, e.g. it would be cool to be able to fetch (if configured as allowed)
> the remote reflog, (not to be confused with you local reflog of the remote).
> I think that work would be enabled once reftables are available, which you
> have an eye on?

-- 
Brandon Williams
