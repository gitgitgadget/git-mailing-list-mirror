Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA0A11F42D
	for <e@80x24.org>; Wed, 23 May 2018 08:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754186AbeEWIVo (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 04:21:44 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:44418 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754155AbeEWIVk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 04:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tQmyE+UECP+ShplMp67n8j3Mr1oG9R3At/ltmznIgjI=; b=plSmGIenU6ft23W4xU0i+D2wV
        XWNaXTL3WYVTia/Z+KQ4hcKddm+AkgKaAxeoct2MABf+5PoqpIfThsAUg8n1uIWy3mDvE1PrZ4MXJ
        MCSrfi2IEnjPrcXTNe6edYMNThyAEdObsHL0RHnmOzzt9lF8v5Cc7jut9eKMGtT1o4DGsLu7ePMzQ
        vJmmyAzS10OZ1gWjs4uPFPcyUeymO8cNlvW8Y8z1wPIXkCo8WZOP2X78X+KIYSD1XtFkV/KNsvZK9
        Ur3dK+iw/SfXHREGBVVePWuCOw8cArtB/HKlA/Kc8+cyRCxjQHIZ6yXp4/PF20o+2MAGvNOpjPY7+
        /R/EdBs0A==;
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:44608 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fLP1e-009CHl-53; Wed, 23 May 2018 04:21:39 -0400
Date:   Wed, 23 May 2018 04:20:01 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: which files are "known to git"?
In-Reply-To: <20180521175335.GC10623@aiede.svl.corp.google.com>
Message-ID: <alpine.LFD.2.21.1805230406050.16917@localhost.localdomain>
References: <alpine.LFD.2.21.1805210717040.9926@localhost.localdomain> <CABPp-BH0bw3m5Ubz2+-XyFGwoHD96sAaSen9-SHQSBqMS-9u5w@mail.gmail.com> <alpine.LFD.2.21.1805211335250.21160@localhost.localdomain> <20180521175335.GC10623@aiede.svl.corp.google.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1176924943-1527063603=:16917"
X-OutGoing-Spam-Status: No, score=-0.2
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

--8323328-1176924943-1527063603=:16917
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 21 May 2018, Jonathan Nieder wrote:

> Robert P. J. Day wrote:
> > On Mon, 21 May 2018, Elijah Newren wrote:
>
> >> Hi Robert,
> >>
> >> I had always assumed prior to your email that 'known to Git'
> >> meant 'tracked' or 'recorded in the index'...
> >
> >   i *know* i've been in this discussion before, but i don't
> > remember where, i *assume* it was on this list, and i recall
> > someone (again, don't remember who) who opined that there are two
> > categories of files that are "known to git":
>
> My understanding was the same as Elijah's.
>
> I would be in favor of a patch that replaces the phrase "known to
> Git" in Git's documentation with something less confusing.

  ironically, the 2nd edition of o'reilly's "version control with git"
uses the phrases "known to Git" and "unknown to Git" on p. 378 (and
nowhere else that i can see):

"Furthermore, for the purposes of this [git clean] command, Git uses a
slightly more conservative concept of under version control.
Specifically, the manual page uses the phrase “files that are unknown
to Git” for a good reason: even files that are mentioned in the
.gitignore and .git/info/exclude files are actually known to Git. They
represent files that are not version controlled, but Git does know
about them. And because those files are called out in the .gitignore
files, they must have some known (to you) behavior that shouldn’t be
disturbed by Git. So Git won’t clean out the ignored files unless you
explicitly request it with the -x option."

  that phrase even occurs in git-produced diagnostic messages such as:

  dir.c: error("pathspec '%s' did not match any file(s) known to git.",

in any event, perhaps the phrase "known to Git" has some value, as
long as it's defined very precisely and used consistently, which it
obviously isn't right now.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
--8323328-1176924943-1527063603=:16917--
