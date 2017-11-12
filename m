Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2236B1F42B
	for <e@80x24.org>; Sun, 12 Nov 2017 09:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752901AbdKLJWg (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 04:22:36 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:33308 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752012AbdKLJWe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 04:22:34 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:55270 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eDoTJ-0002wL-VY; Sun, 12 Nov 2017 04:22:34 -0500
Date:   Sun, 12 Nov 2017 04:21:53 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Junio C Hamano <gitster@pobox.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v3] bisect: mention "view" as an alternative to
 "visualize"
In-Reply-To: <xmqqefp4ca6r.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.LFD.2.21.1711120421270.29376@localhost.localdomain>
References: <alpine.LFD.2.21.1711110838060.9569@localhost.localdomain> <xmqqefp4ca6r.fsf@gitster.mtv.corp.google.com>
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

On Sun, 12 Nov 2017, Junio C Hamano wrote:

> "Robert P. J. Day" <rpjday@crashcourse.ca> writes:
>
> >  To see the currently remaining suspects in 'gitk', issue the following
> > -command during the bisection process:
> > +command during the bisection process (the subcommand `view` can, in all
> > +cases, be used as an alternative to `visualize`):
>
> I'd drop ", in all cases," if I were writing this.
>
> If it were very common that some "synonyms" are only usable in
> certain limited cases, singling this out and explicitly saying that
> "'view', unlike many other 'synonyms', is truly a synonym to
> visualize in all cases" would make sense and would help readers, but
> I do not think that is the case.  An alternative by definition
> should be usable "in all cases", so I do not think the phrase helps
> the readers at all.
>
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > index fdd984d34..52f68c922 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -1162,7 +1162,7 @@ _git_bisect ()
> >  {
> >  	__git_has_doubledash && return
> >
> > -	local subcommands="start bad good skip reset visualize replay log run"
> > +	local subcommands="start bad good skip reset visualize view replay log run"
>
> This change makes the end user experience a lot worse, I am afraid.
>
> People used to be able to say "bisect vi<TAB>" and I'd imagine that
> many are used to type exactly that.  Now they get two choices and
> have to say 's' (or 'e') before hitting another <TAB>.

  good points, i'll re-roll and re-submit.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
