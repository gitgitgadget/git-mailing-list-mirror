Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B368E1F43C
	for <e@80x24.org>; Sat, 11 Nov 2017 19:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbdKKTqY (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 14:46:24 -0500
Received: from imap.thunk.org ([74.207.234.97]:36000 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751810AbdKKTqX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Nov 2017 14:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=F8t9unuG3AjaIFzOAGwUa9tlZ78Q4cFSWB/mEJPNshY=; b=RU4KAZGyyPX4NUIYBwCnTSFUVs
        UnYYdAM8IAgmYkZoML0K+7UWrVSAtFyd5VzcfNuWdnA0OJXRtP9TE53L6kyj6v5ARP0FVB9R/uwAy
        NI2OEAGZ1VbRZt4siJ8lYTyTgsEHRRZyuMsJAhikcITVoRx9Qi3UPQSKqK09jPDQDp94=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1eDbjN-0006HZ-Io; Sat, 11 Nov 2017 19:46:17 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 87BBCC00640; Sat, 11 Nov 2017 14:46:16 -0500 (EST)
Date:   Sat, 11 Nov 2017 14:46:16 -0500
From:   Theodore Ts'o <tytso@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>,
        Stephan Beyer <s-beyer@gmx.net>
Subject: Re: should "git bisect" support "git bisect next?"
Message-ID: <20171111194616.a2hl4dwz5cycuzdh@thunk.org>
References: <alpine.LFD.2.21.1711110639120.5632@localhost.localdomain>
 <CAP8UFD3az17BpB0nA+35p3BP95sBuOY0Yvce3cgbh0L3YH7+rQ@mail.gmail.com>
 <xmqq4lq0ev8g.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4lq0ev8g.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 11, 2017 at 11:38:23PM +0900, Junio C Hamano wrote:
> 
> Thanks for saving me time to explain why 'next' is still a very
> important command but the end users do not actually need to be
> strongly aware of it, because most commands automatically invokes it
> as their final step due to the importance of what it does ;-)

This reminds me; is there a way to suppress it because I'm about to
give a large set of good and bit commits (perhaps because I'm
replaying part of a git biset log, minus one or two lines that are
suspected of being bogus thanks to flaky reproduction), and so there's
no point having git bisect figure the "next" commit to try until I'm
done giving it a list of good/bad commits?

	     	       	      	 	  - Ted
