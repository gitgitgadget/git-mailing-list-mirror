Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC26A1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 10:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751057AbeFCKhx (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 06:37:53 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:42160 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbeFCKhw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 06:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sR/T6/Pe3m67u3RUK6fbWgR2uQYtv8DXK5UQs4SkThI=; b=H8GxGDegXNsl0WOckKEu9LzEU
        RjtpbHgm6D3W/MzxWTJBPBg9vtfD13WBDK+G7ac/fZr3PKD4bcyS4lnMysDj3c+AF1y5gugRqO6E3
        wEeW7crN2YDE8Cr0klmY9cP4Xpxzrw3nJ/gv1wQbBtvn3aR6yGVlE6l4xbOfjHJQPSIWZwo87a8aK
        1UuB0UXLwAgdY+uAqfNUX39BHAq1EMQs3hFGiLLQ0XgbklS4TNrfZcVF6zA86Nf53iqXV9dItbLLj
        AbWNQ7wIDCknUTGISWxyLYWY5XmfyvVx5tMs58Ff4H4uy+/jGJOEZCRlM24m8aKdGwWv9e1j2aUaH
        cqnNVnRNg==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:57962 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fPQOU-0046ll-90; Sun, 03 Jun 2018 06:37:51 -0400
Date:   Sun, 3 Jun 2018 06:35:44 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder.dev@gmail.com>
cc:     Jeff King <peff@peff.net>, Git Mailing list <git@vger.kernel.org>
Subject: Re: how exactly can git config section names contain periods?
In-Reply-To: <20180603103510.21020-1-szeder.dev@gmail.com>
Message-ID: <alpine.LFD.2.21.1806030634200.8966@localhost.localdomain>
References: <alpine.LFD.2.21.1806011606490.11215@localhost.localdomain> <20180601210731.GA20974@sigill.intra.peff.net> <alpine.LFD.2.21.1806030547070.5332@localhost.localdomain> <20180603103510.21020-1-szeder.dev@gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-342081106-1528022146=:8966"
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

--8323328-342081106-1528022146=:8966
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sun, 3 Jun 2018, SZEDER Gábor wrote:

>
>
> > On Fri, 1 Jun 2018, Jeff King wrote:
> >
> > > On Fri, Jun 01, 2018 at 04:14:12PM -0400, Robert P. J. Day wrote:
> > > >   ok, so how on earth would i use "git config" at the command line
> > > > to set a config variable with some arbitrary level of subsections?
> > > > let's try this:
> > >
> > > You don't. There are only three levels: section, (optional)
> > > subsection, and key. If there is a subsection, it consists of
> > > _everything_ between the two outer periods.
>
> <snip>
>
> >   if (for some weird reason) i wanted to define a multi-level
> > subsection,
>
> You can't, there are no multi-level subsections, see above.

  no, i *get* that, what i was asking was if i wanted to simulate or
emulate such a thing ... or is that just getting too weird and there
is no compelling reason to want to go down that road? (which i am
totally prepared to accept.)

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
--8323328-342081106-1528022146=:8966--
