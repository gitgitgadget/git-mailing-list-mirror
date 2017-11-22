Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8803C202F2
	for <e@80x24.org>; Wed, 22 Nov 2017 11:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbdKVLUt (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 06:20:49 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:32967 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbdKVLUs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 06:20:48 -0500
Received: from 69-196-158-250.dsl.teksavvy.com ([69.196.158.250]:35476 helo=DESKTOP-1GPMCEJ)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eHT5D-0006Sx-OX; Wed, 22 Nov 2017 06:20:47 -0500
Date:   Wed, 22 Nov 2017 06:19:23 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@DESKTOP-1GPMCEJ
To:     Junio C Hamano <gitster@pobox.com>
cc:     Kevin Daudt <me@ikke.info>, Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] gitcli: tweak "man gitcli" for clarity
In-Reply-To: <xmqq3756txeg.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.LFD.2.21.1711220616230.11319@DESKTOP-1GPMCEJ>
References: <alpine.LFD.2.21.1711211626460.26166@localhost.localdomain> <20171121214552.GB16418@alpha.vpn.ikke.info> <alpine.LFD.2.21.1711220453290.3814@DESKTOP-1GPMCEJ> <xmqq3756txeg.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 22 Nov 2017, Junio C Hamano wrote:

> "Robert P. J. Day" <rpjday@crashcourse.ca> writes:
>
> > git repo with a file called "Gemfile", so i created a branch called
> > "Gemfile", and when i ran:
> >
> >   $ git checkout Gemfile
> >
> > git switched to the branch. so even with the ambiguity, git
> > obviously has some sort of precedence order it checks. so what are
> > the rules here?
>
> 31b83f36 ("Merge branch 'nd/checkout-disambiguation'", 2016-09-26)
> should have made it clear that the "checkout" command has a
> convenience special case.

  ok, then i'm still curious about git examples that actually fail due
to an inability to disambiguate.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
