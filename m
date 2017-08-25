Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 513DF1F4DD
	for <e@80x24.org>; Fri, 25 Aug 2017 09:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754622AbdHYJKz (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 05:10:55 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.32]:64902 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754607AbdHYJKy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 05:10:54 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1dlAde-000214-8G; Fri, 25 Aug 2017 11:10:50 +0200
Date:   Fri, 25 Aug 2017 11:10:48 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Submodule regression in 2.14?
Message-ID: <20170825091048.GB14872@book.hvoigt.net>
References: <CAGZ79kb-ReME6qbDy-Q12-d=B=f6odUW_D1bAmegP4AY2AyntQ@mail.gmail.com>
 <xmqqd17tei7m.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZdnJ+bATTxKBhsJnKaJWGqcBu3MOQ9eK7m4j3dJPNbTw@mail.gmail.com>
 <xmqq7ey0ddlk.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kap-4k7n48dvBAv2pJjNy2s_LPHS-NdfQD0A-BbWqh4aQ@mail.gmail.com>
 <xmqqpobs9hjy.fsf@gitster.mtv.corp.google.com>
 <20170821160514.GA1618@book.hvoigt.net>
 <CAGZ79kZvcY8hawq1qGfFLm1Ukb-wn8j0e_hN8gF5jrEY20o7YA@mail.gmail.com>
 <20170822153311.GA5697@book.hvoigt.net>
 <CAGZ79kbwJN_XVcAbkyVJTax9F2NR4EO8XjR3U9EH8MLqbAb90Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbwJN_XVcAbkyVJTax9F2NR4EO8XjR3U9EH8MLqbAb90Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 22, 2017 at 11:10:52AM -0700, Stefan Beller wrote:
> On Tue, Aug 22, 2017 at 8:33 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > On Mon, Aug 21, 2017 at 09:42:54AM -0700, Stefan Beller wrote:
> >> On Mon, Aug 21, 2017 at 9:05 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> >> > On Fri, Aug 18, 2017 at 11:51:13PM -0700, Junio C Hamano wrote:
> >>     # You feel the superproject is in the way?
> >>     git worktree add --for-submodule <path/to/sub> ...
> >>     # The new submodule worktree puts the
> >>     # submodule only UX first. so it feels like its own
> >>     # repository, no need for specific flags.
> >
> > I am not sure I understand this one. What would that do? Put a worktree
> > for submodule path/to/sub to ...?
> 
> Yes, and at "..." you would have the UX of the submodule being
> its own repository, no interaction with the superproject.

Are you sure that is what Junio meant? IMO that would be 'git worktree
clone' or 'git worktree checkout', no?  In todays git terminology an
'add' is something that puts data into the repository / the index. That
is why I was/am confused.

Cheers Heiko
