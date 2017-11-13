Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 587F51F43C
	for <e@80x24.org>; Mon, 13 Nov 2017 09:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751778AbdKMJ4t (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 04:56:49 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:58480 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751549AbdKMJ4t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 04:56:49 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:60854 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eEBU0-0002zS-3f; Mon, 13 Nov 2017 04:56:48 -0500
Date:   Mon, 13 Nov 2017 04:56:22 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Junio C Hamano <gitster@pobox.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] doc: Remove explanation of "--" from several man pages
In-Reply-To: <xmqqlgja8q74.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.LFD.2.21.1711130450570.11083@localhost.localdomain>
References: <alpine.LFD.2.21.1711121600170.7904@localhost.localdomain> <xmqq8tfaak6s.fsf@gitster.mtv.corp.google.com> <alpine.LFD.2.21.1711130357190.10471@localhost.localdomain> <xmqqlgja8q74.fsf@gitster.mtv.corp.google.com>
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

On Mon, 13 Nov 2017, Junio C Hamano wrote:

> "Robert P. J. Day" <rpjday@crashcourse.ca> writes:
>
> >> > diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
> >> > index aa3b2bf2f..0ae2523e0 100644
> >> > --- a/Documentation/git-check-attr.txt
> >> > +++ b/Documentation/git-check-attr.txt
> >> > @@ -36,10 +36,6 @@ OPTIONS
> >> >  	If `--stdin` is also given, input paths are separated
> >> >  	with a NUL character instead of a linefeed character.
> >> >
> >> > -\--::
> >> > -	Interpret all preceding arguments as attributes and all following
> >> > -	arguments as path names.
> >> > -
> >>
> >> This also has a similar issue.  "--" here is not between revs and
> >> pathspecs but is between attributes and pathspecs.
> >
> >   that can already be seen in the SYNOPSIS for that command, it does
> > not require further explanation:
> >
> >   SYNOPSIS
> >        git check-attr [-a | --all | attr...] [--] pathname...
>
> Nah.  With the same logic you could say --all is already on synopsis
> and no need for explanation.

  uh, that's not what i meant. what i *meant* was that the purpose of
"--" was already in the SYNOPSIS (as it appears to be in *all* man
pages) to visually show that it is a separator between the first part
of the command and possible pathnames. i was *not* suggesting that, if
something is in the SYNOPSIS, there is no further need to explain it.

  anyway, i can see this is a losing battle so i'll let it go.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
