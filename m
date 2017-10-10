Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8038920437
	for <e@80x24.org>; Tue, 10 Oct 2017 19:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756410AbdJJToI (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 15:44:08 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:53705 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752175AbdJJToF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 15:44:05 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:52852 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1e20Rg-0007qY-Ru; Tue, 10 Oct 2017 15:44:04 -0400
Date:   Tue, 10 Oct 2017 15:44:02 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Paul Smith <paul@mad-scientist.net>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: "git rm" seems to do recursive removal even without "-r"
In-Reply-To: <1507637979.8322.33.camel@mad-scientist.net>
Message-ID: <alpine.LFD.2.21.1710101543290.4437@localhost.localdomain>
References: <20171007192902.ma4s47hn6edwldx5@sigill.intra.peff.net>  <alpine.LFD.2.21.1710071531090.15738@localhost.localdomain>  <20171007193805.a2mwzkweonb6ymdk@sigill.intra.peff.net>  <alpine.LFD.2.21.1710071541430.15964@localhost.localdomain> 
 <1507412674.8322.4.camel@mad-scientist.net>  <alpine.LFD.2.21.1710071749240.16818@localhost.localdomain>  <1507473160.8322.12.camel@mad-scientist.net>  <20171008184046.uj7gcutddli54ic3@thunk.org>  <alpine.LFD.2.21.1710081536180.28646@localhost.localdomain>
  <20171008204227.f6wgaobosa6yn62g@thunk.org>  <20171009175225.qn6a3j2th3dxjjn2@sigill.intra.peff.net>  <alpine.LFD.2.21.1710100432220.16182@localhost.localdomain> <1507637979.8322.33.camel@mad-scientist.net>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-317053665-1507664644=:4437"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-317053665-1507664644=:4437
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 10 Oct 2017, Paul Smith wrote:

> On Tue, 2017-10-10 at 04:36 -0400, Robert P. J. Day wrote:
> >   ah, now *that* is a compelling rationale that justifies the
> > underlying weirdness. but it still doesn't explain the different
> > behaviour between:
> >
> >   $ git rm -n 'Makefile*'
> >   $ git rm -n '*Makefile'
>
> I explained that behavior in the email up-thread from this reply:

  yup, sorry i missed it. man, it's been an educational thread.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
--8323328-317053665-1507664644=:4437--
