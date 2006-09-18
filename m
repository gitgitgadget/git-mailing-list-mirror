From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Contributed bash completion support for core Git tools.
Date: Mon, 18 Sep 2006 13:29:58 -0400
Message-ID: <20060918172958.GB31140@spearce.org>
References: <20060918004831.GA19851@spearce.org> <Pine.LNX.4.63.0609181012180.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 18 19:30:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPMwb-0000yq-Ut
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 19:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWIRRaF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 13:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbWIRRaF
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 13:30:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:22477 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750815AbWIRRaC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Sep 2006 13:30:02 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GPMwM-00078l-Gw; Mon, 18 Sep 2006 13:29:54 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DDADA20E48E; Mon, 18 Sep 2006 13:29:58 -0400 (EDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0609181012180.19042@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27252>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> the only gripe I have with it: whenever some options are added, or 
> removed, or renamed, you have to adapt the completion script. That is why 
> I started (ages ago) to auto-generate the completion script from the 
> documentation (of course, this means that the options have to be described 
> consistently in the documentation, which is good in its own).
> 
> Unfortunately, I never got around to finish it, but a preliminary version 
> is in the mailing list archives.

I was torn about putting options into the completion list.  Right now
"-l -b -f" are available for 'git checkout' but I think that was
a bad idea.  There's little point in offering completion for an
option which is a single character.  But that's my opinion and I'm
sure someone else might actually find it useful.

Longer options however such as "--since" or "--pretty=" with its
associated format options, or the merge strategy argument to "-s"
would all be nice to have completion support for.  However I did
not implement these.
 
> However, since your script works well, and I do not have a working script, 
> you clearly won! So, unless some kind soul actually implements my 
> proposal, I am happy with your script.

I was mainly getting tired of copying and pasting or retyping
branch names and remote names.  So that's what I implemented.
(And remote names aren't quite right as they don't tab complete
the ones available in .git/config.)

-- 
Shawn.
