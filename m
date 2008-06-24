From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Tue, 24 Jun 2008 09:59:47 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806240954150.2926@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org> <20080623164917.GA25474@sigill.intra.peff.net> <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org> <20080623171505.GB27265@sigill.intra.peff.net>
 <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org> <20080623183358.GA28941@sigill.intra.peff.net> <alpine.LFD.1.10.0806231137070.2926@woody.linux-foundation.org>
 <20080623195314.GA29569@sigill.intra.peff.net> <alpine.LFD.1.10.0806231307070.2926@woody.linux-foundation.org> <20080624053504.GB19224@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 24 19:04:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBBw7-0007La-6t
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 19:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbYFXRDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 13:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752188AbYFXRDJ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 13:03:09 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54008 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751409AbYFXRDI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jun 2008 13:03:08 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5OGxmRF017370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 Jun 2008 09:59:49 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5OGxlBR028946;
	Tue, 24 Jun 2008 09:59:47 -0700
In-Reply-To: <20080624053504.GB19224@sigill.intra.peff.net>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.851 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86086>



On Tue, 24 Jun 2008, Jeff King wrote:
> 
> You seem to have a bunch of _other_ problems with parse_options. And
> that is fine, but they have nothing whatsoever to do with anything I've
> said. So don't "sky wizard" _me_ about those problems. ;P

I have a _single_ problem I have with parse_options(), namely that it was 
painful to convert in pieces. It may well be that builtin-blame.c was one 
of the more painful cases, but it really was a _single_ issue.

I also had a _single_ fix for it.

I never had "other" problems.

What happened was that you and Dscho and others then tried to pick that 
_single_ issue apart, because the solutions _you_ wanted (tying all the 
parsing together in one place) couldn't handle it as one issue and one 
problem. Your solutions always looked at just some small part of it.

So no, I never introduced any other problems in the discussion at all. I 
had a single issue, and a single solution. You were the one who then 
argued against it and had *another* solution that fractured the problem 
up, and didn't actually solve _any_ of my original issues.

Do you see now?

So yes, we're arguing at cross purposes, but that's because you're 
constantly taking up a totally different and totally uninteresting 
position that has nothing what-so-ever to do with the original problem.

And then you talk about how things "ought to be" in your world, to make 
your solution relevant at all.

And I'm trying to tell you that "ought to be" has no relevance, because 
you're not even looking at the problem!

			Linus
