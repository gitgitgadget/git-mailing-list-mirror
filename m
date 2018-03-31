Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 076E61F404
	for <e@80x24.org>; Sat, 31 Mar 2018 19:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751647AbeCaT4p (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 15:56:45 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:44644 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeCaT4o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 15:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zhd7ZygtwtDBSh8Ut3n05Qu9rb5gsPK1Ne/WA9AM9P0=; b=iCrrz6KAJt+z6yshKzm/14xQg
        OsUeLu1AO6TgyV0JnY6keLKpyAXxE4dv/emoZ1uzbi+E5UDGtxYSX/u1emXy70bbAYDsm7Yy2K7U+
        1AXXY/uRtSFrt1qUBzWSGEQ1oTOdiHsRHai4A03Cgzf62Y/0NEE8stFFFJEmFTvNyOfHFlbsaQKlG
        NHyuXNKHkv4vWVsqAi0EvbPW11sgqMXllum2d41Cn1hwf9kLBoYxMR4dXz1Wn1v/PEOOI+MVQ7WcV
        6gJwTmxsxap5rhMKr6yxFTnOu/8p3JVCY50bGFBbGB/Pyit6f/CNg3pUQ+4Yk3BiaVHngDYq871W2
        SDnGpQQFQ==;
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:44168 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1f2Mc9-0002xt-Fo; Sat, 31 Mar 2018 15:56:42 -0400
Date:   Sat, 31 Mar 2018 15:56:36 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [OT] how does "git review --setup" figure out my username?
In-Reply-To: <CACBZZX7wQChuEQeBHQzgg-XsMmmryB4qBXT9K4HxwxaSNe4UWg@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1803311555500.23345@localhost.localdomain>
References: <alpine.LFD.2.21.1803311453250.21368@localhost.localdomain> <CACBZZX7wQChuEQeBHQzgg-XsMmmryB4qBXT9K4HxwxaSNe4UWg@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-368806153-1522526198=:23345"
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-368806153-1522526198=:23345
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 31 Mar 2018, Ævar Arnfjörð Bjarmason wrote:

> On Sat, Mar 31, 2018 at 9:04 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> >
> >   (technically not a git question, but i kind of need to know the
> > answer to this quickly as i'm writing some documentation and this is
> > something i have to explain.)
> >
> >   i cloned a repository (hyperledger fabric) which has a top-level
> > .gitreview file:
> >
> >   [gerrit]
> >   host=gerrit.hyperledger.org
> >   port=29418
> >   project=fabric
> >
> > and, as i read it, if i want to configure to use gerrit, an initial
> > invocation of "git review --setup" should do that for me, which it
> > appears to do, as it adds the following to .git/config:
> >
> >   [remote "gerrit"]
> >         url = ssh://rpjday@gerrit.hyperledger.org:29418/fabric
> >         fetch = +refs/heads/*:refs/remotes/gerrit/*
> >
> > and copies over the commit-msg hook. so far, so good.
> >
> >   but from where does it figure out the username (rpjday) to use when
> > configuring that remote? i have no gerrit configuration in my
> > .gitconfig file. however, i have configured gerrit at the hyperledger
> > end to use my SSH key, which is associated with my linux foundation ID
> > (rpjday) that i registered to start using that repo.
> >
> >   is that where it gets the username from?
>
> I've never used gerrit, but from my skimming of
> https://www.mediawiki.org/wiki/Gerrit/git-review#Setting_up_git-review
> and
> https://www.mediawiki.org/wiki/Gerrit/Tutorial#Configuring_git-review
> it seems (to me) to say that it simply tries if your local loginname
> works on the remote. Is rpjday your loginname on this system?

  yes, but it's just a fluke that i used the same user name in both
places ... what if i hadn't? which one would it have selected?

rday
--8323328-368806153-1522526198=:23345--
