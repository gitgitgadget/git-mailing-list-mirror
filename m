From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: rebase -p confusion in 1.6.1
Date: Thu, 15 Jan 2009 15:25:45 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901151518520.3586@pacific.mpi-cbg.de>
References: <slrngmu4j5.e1u.sitaramc@sitaramc.homelinux.net> <496F3C99.1040800@drmicha.warpmail.net> <20090115135518.GB10045@leksak.fem-net> <496F44AC.2060607@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org,
	Stephen Haberman <stephen@exigencecorp.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 15:26:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNTAq-0003TE-23
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 15:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758968AbZAOOY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 09:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758769AbZAOOY4
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 09:24:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:47152 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758541AbZAOOY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 09:24:56 -0500
Received: (qmail invoked by alias); 15 Jan 2009 14:24:53 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp033) with SMTP; 15 Jan 2009 15:24:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/dgxNBWGzdj7h2+hDOHMaBdDMo6dPrMoLLFg3NP+
	13m5WjBId2uCTp
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <496F44AC.2060607@drmicha.warpmail.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105819>

Hi,

On Thu, 15 Jan 2009, Michael J Gruber wrote:

> Stephan Beyer venit, vidit, dixit 15.01.2009 14:55:
> 
> >> First of all: git 1.6.0.6 gives you the unchanged graph after using
> >> rebase -i -p.
> > 
> > This is true and it is a far better behavior than now, but I think it's
> > not the expected behavior. (I have written about the behavior I'd expect
> > in another reply to the original mail.)
> 
> Yep, I think -p should preserve only merges in side branches

you mean everything in master..work?

> (and therefore produce what you suggest, and what you get without -p). 
> If it preserves all merges then there is nothing to rewrite here.

The merge _is_ outside of master, so I do not understand what the heck you 
are talking about.

The more I think about it, I think it's possible I broke it with the 
introduction of the "noop".

However, there could be a _different_ test case where the current -p 
handling shows the same error.  Dunno.

Ciao,
Dscho
