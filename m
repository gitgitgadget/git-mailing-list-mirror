Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C2F820A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 17:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbeLHRhc (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 12:37:32 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:57126 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbeLHRha (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 12:37:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+uYQUt1NiFoFbZwZu4PbZ+lLotpRA3U+cf/CnjF/oL8=; b=ew6Fjvb2YJzeRkoyGlPFAUxcB
        rrtpfA90t2mlY/Vky0E8AHpMNrdvAnL4R7KUMmTvOhTaWunHDw0O6DIdsHCfe1Afb6pz2dBZRggbO
        iQdrMmiyvdOuMH/alKaaNftoyMOm0OtCW8D1ogADR7IuEv9dG0dPjdXZOfpD2TlVhXKfaBcDF3FHK
        Efg15XP5NCdlohREXZErkwe9mcyTcwQc3EiiiWQYk7u/QKULahKOqOPbcxg8AbZnk4F9zbqavFl3y
        LslA4kBvPNbbDYUZI0+ls0AeqJTcpBIyBT/uo96HjPABjFNrXf+t6PcoEb4cGDDgu4gqIHqkS+v8l
        FDBXXvoOw==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:52096 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1gVgXg-0004i8-60; Sat, 08 Dec 2018 12:37:29 -0500
Date:   Sat, 8 Dec 2018 12:37:25 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: why doesn't "git reset" mention optional pathspec?
In-Reply-To: <CACsJy8AC-anZ=EA3zxWeX8UUNcZiKsQMu8x0eCHAOCUjFWoFuQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1812081236220.32716@localhost.localdomain>
References: <alpine.LFD.2.21.1812081103500.29142@localhost.localdomain> <CACsJy8APyyAWM+L=HU1XM4V+qdTWqjto6x=Q06By8DbgtYfpCA@mail.gmail.com> <alpine.LFD.2.21.1812081232240.32380@localhost.localdomain>
 <CACsJy8AC-anZ=EA3zxWeX8UUNcZiKsQMu8x0eCHAOCUjFWoFuQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sat, 8 Dec 2018, Duy Nguyen wrote:

> On Sat, Dec 8, 2018 at 6:32 PM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> >
> > On Sat, 8 Dec 2018, Duy Nguyen wrote:
> >
> > > On Sat, Dec 8, 2018 at 5:08 PM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> > > >
> > > >
> > > >   from "man git-reset":
> > > >
> > > > SYNOPSIS
> > > >   git reset [-q] [<tree-ish>] [--] <paths>...
> > > >   git reset (--patch | -p) [<tree-ish>] [--] [<paths>...]
> > > >   git reset [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
> > > >
> > > > oddly, the third form says nothing about possible "<paths>", even
> > > > though i'm pretty sure they're valid in that third case (at least
> > > > for "--mixed"). thoughts? is that just an oversight in the man
> > > > page?
> > >
> > > --mixed prints a deprecation warning. I don't think it's worth
> > > making the synopsis more complicated for that. All other modes
> > > reject pathspec.
> >
> >   i just tested this, and i don't see a deprecation warning.
>
> Hmm.. maybe I misread the code. I just tried it
>
> $ ./git reset --mixed HEAD foo
> warning: --mixed with paths is deprecated; use 'git reset -- <paths>' instead.

  weird ... i just tried this two ways, explicitly specifying
"--mixed" and also without (which is the default mode, right?), and i
got the deprecated message with the first but not the second. that
seems ... odd.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
