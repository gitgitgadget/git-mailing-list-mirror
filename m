X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: VCS comparison table
Date: Wed, 25 Oct 2006 17:16:18 -0400
Message-ID: <20061025211618.GA30121@coredump.intra.peff.net>
References: <45354AD0.1020107@utoronto.ca> <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE> <vpq4ptz2uh8.fsf@ecrins.imag.fr> <453DAC87.8050203@research.canon.com.au> <Pine.LNX.4.64.0610232318200.3962@g5.osdl.org> <Pine.LNX.4.64N.0610232336010.30334@attu2.cs.washington.edu> <Pine.LNX.4.64.0610240812410.3962@g5.osdl.org> <Pine.LNX.4.64N.0610241300450.8112@attu4.cs.washington.edu> <20061025084810.GA26618@coredump.intra.peff.net> <7v3b9cnlx7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 21:16:36 +0000 (UTC)
Cc: git@vger.kernel.org, bazaar-ng@lists.canonical.com,
	Linus Torvalds <torvalds@osdl.org>,
	Lachlan Patrick <loki@research.canon.com.au>,
	David Rientjes <rientjes@cs.washington.edu>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v3b9cnlx7.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30102>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcq6r-0002SV-HS for gcvg-git@gmane.org; Wed, 25 Oct
 2006 23:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030374AbWJYVQV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 17:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030381AbWJYVQV
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 17:16:21 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:50097
 "HELO peff.net") by vger.kernel.org with SMTP id S1030374AbWJYVQU (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 17:16:20 -0400
Received: (qmail 3077 invoked from network); 25 Oct 2006 17:15:24 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 25 Oct 2006 17:15:24 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Oct
 2006 17:16:18 -0400
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Wed, Oct 25, 2006 at 02:08:20PM -0700, Junio C Hamano wrote:

> the older shell implementation around as reference.  People
> coming to git after 1.3 series certainly do have harder time to
> learn how plumbing would fit together than when git old-timers
> learned it, if that is the area they are interested in, as
> opposed to just using git as a revision tracking system.

I think this is part of the complication of discussion I'm having with
David. There are really two sets of users for git: people who want to
hack scripts based on plumbing, and people who want everything to "just
work." I think it's a good point that as the system matures (movement
to C and growth of complexity), it might become less easy to hack.

>  - Create examples/ hierarchy in the source tree to house these
>    historical implementations as a reference material, or an
>    entirely different branch or repository to house them.

Housing historical implementations seems like it would just lead to
out-of-date and non-functional examples.

>  - Learn the itches David and other people have, that the
>    current git Porcelain-ish does not scratch well, and enrich
>    Documentation/technical with real-world working scripts built
>    around plumbing.

I think this is a better approach. I think it also makes sense to
let people know that it's an acceptable approach to start new features
as shell and then have them mature to C (looking at the current
codebase, and some of Dscho's rantings, one might get the impression
that git isn't accepting new shell scripts).

