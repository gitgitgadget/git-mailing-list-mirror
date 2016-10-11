Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F36B41F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 15:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753548AbcJKP47 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 11:56:59 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36730 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753111AbcJKP46 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 11:56:58 -0400
Received: by mail-lf0-f68.google.com with SMTP id b75so4457006lfg.3
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 08:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=9eez3PGfy7AceGOOHsrnP3O24fozgL3+kRtxbiZMsBc=;
        b=mWJJSjcv8znrXChKhgoOYpyinPM27/r78OFe86ZrXagEfz1HpA2ChHdlGy0ix9xjM+
         Ni+Jdm77qYqE5Tcio+PMEm5W+RxLZEgLXDdnTeC/48e3+PpTKo4aGnAJ4VVt7z/7PRWu
         nR7FDAtnWzhWdANl/bZ1/bla/XYpDMwSWVnc67J2Q/N1+ITg1a1MeoY7tWsNQkv0UmUz
         I/U7CPeRbVnb3BAB/dc7XsB9HYJb0g4wt2U3gUtH1CrjeMJVrijfiNXKVGi08nlHpW24
         KmlcQEwyg4bNviaox/2X+xUEbALyB0Q85GRYJY17/TkmIOANBmrJD+pWTWnkRsrIw9U0
         ioGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=9eez3PGfy7AceGOOHsrnP3O24fozgL3+kRtxbiZMsBc=;
        b=hNcwwG3qCdR+KyseVeJErnQGMa6tmDRQoHRK5TJGM+8soi1KIDFkE6bGN5cpJ8/vZ6
         lfLpwnppeDQEiEapZdkrgC6tUZkcpLAG0chLOdWedKvbS47eSjfGNiygwTt5q2xBpHhQ
         OMjxibct4BHOWqtqBZMB5e9BNn6D9Tchl101GeI/YLQSmgJAfujWFrcJOlhi8IKgkCaT
         kxIQ/E4ZPyn0qbOJ0bcCWD2XVhg0FcJluKFKncYM/ul37CDs9n/h30148C8rT6R1HaMS
         DowYVKGyIO+vY40uCy8n+fdBqDPC31CtKjHDO17+vThB2/CPu1l4+fa0mpUdHFfWNF2Y
         6Tjw==
X-Gm-Message-State: AA6/9RlEL0gyDLFQOehRW5kaqeiqlq+LETF5Mm5MUc7LE2olLZWcmrn2j2RTAMVO9NrIBw==
X-Received: by 10.25.27.69 with SMTP id b66mr1706495lfb.36.1476201416516;
        Tue, 11 Oct 2016 08:56:56 -0700 (PDT)
Received: from [192.168.1.26] (adaq66.neoplus.adsl.tpnet.pl. [83.11.252.66])
        by smtp.googlemail.com with ESMTPSA id g7sm1230197ljg.44.2016.10.11.08.56.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Oct 2016 08:56:55 -0700 (PDT)
Subject: Re: git merge deletes my changes
To:     Paul Smith <paul@mad-scientist.net>,
        Eduard Egorov <Eduard.Egorov@icl-services.com>,
        "'git@vger.kernel.org'" <git@vger.kernel.org>
References: <AM4PR03MB1636BE3423E2BC4F0E998159DBDB0@AM4PR03MB1636.eurprd03.prod.outlook.com>
 <AM4PR03MB1636EA0DEB4C8095F04AB92ADBDB0@AM4PR03MB1636.eurprd03.prod.outlook.com>
 <1476121942.15746.99.camel@mad-scientist.net>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <94ff5fb3-6957-8983-4aa7-e1d5e2692e82@gmail.com>
Date:   Tue, 11 Oct 2016 17:56:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1476121942.15746.99.camel@mad-scientist.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 10.10.2016 o 19:52, Paul Smith pisze:
> On Mon, 2016-10-10 at 10:19 +0000, Eduard Egorov wrote:
>> # ~/gitbuild/git-2.10.1/git merge -s subtree --squash ceph_ansible
>>
>> Can somebody confirm this please? Doesn't "merge -s subtree" really
>> merges branches?
> 
> I think possibly you're not fully understanding what the --squash flag
> does... that's what's causing your issue here, not the "-s" option.
> 
> A squash merge takes the commits that would be merged from the origin
> branch and squashes them into a single patch and applies them to the
> current branch as a new commit... but this new commit is not a merge
> commit (that is, when you look at it with "git show" etc. the commit
> will have only one parent, not two--or more--parents like a normal merge
> commit).
> 
> Basically, it's syntactic sugar for a diff plus patch operation plus
> some Git goodness wrapped around it to make it easier to use.

Actually this is full merge + commit surgery (as if you did merge with
--no-commit, then deleted MERGE_HEAD); the state of worktree is as if
it were after a merge.

> 
> But ultimately once you're done, Git has no idea that this new commit
> has any relationship whatsoever to the origin branch.  So the next time
> you merge, Git doesn't know that there was a previous merge and it will
> try to merge everything from scratch rather than starting at the
> previous common merge point.
> 
> So either you'll have to use a normal, non-squash merge, or else you'll
> have to tell Git by hand what the previous common merge point was (as
> Jeff King's excellent email suggests).  Or else, you'll have to live
> with this behavior.

The `git subtree` command (from contrib) allows yet another way: it
squashes *history* of merged subproject (as if with interactive rebase
'squash'), then merges this squash commit.

Now I know why this feature is here...
-- 
Jakub Narębski

