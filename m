Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F2271FF72
	for <e@80x24.org>; Mon, 23 Oct 2017 06:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbdJWGcb (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 02:32:31 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:58116 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751144AbdJWGca (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 02:32:30 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:34520 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1e6Vai-0004S2-KJ; Mon, 23 Oct 2017 01:48:00 -0400
Date:   Mon, 23 Oct 2017 01:47:56 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Junio C Hamano <gitster@pobox.com>
cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 0/3] deprecate git stash save
In-Reply-To: <xmqqwp3md5jp.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.LFD.2.21.1710230147240.32043@localhost.localdomain>
References: <20171019183304.26748-2-t.gummerer@gmail.com> <20171022170409.8565-1-t.gummerer@gmail.com> <xmqqwp3md5jp.fsf@gitster.mtv.corp.google.com>
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

On Mon, 23 Oct 2017, Junio C Hamano wrote:

> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
> > Interdiff below:
>
> Thanks.  Looks much more polished.
>
> >
> > diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> > index 89b6a0e672..8be661007d 100644
> > --- a/Documentation/git-stash.txt
> > +++ b/Documentation/git-stash.txt
> > @@ -86,7 +86,9 @@ The `--patch` option implies `--keep-index`.  You can use
> >
> >  save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
> >
> > -	This option is deprecated in favour of 'git stash push'.
> > +	This option is deprecated in favour of 'git stash push'.  It
> > +	differs from "stash push" in that it cannot take pathspecs,
> > +	and any non-option arguments form the message.
>
> Every time I saw this line, I misread s/form/from/ and got
> confused.

  "constitute"?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
