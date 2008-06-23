From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 19:41:10 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806231940100.6440@racer>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <20080623082223.GA12130@artemis.madism.org> <alpine.DEB.1.00.0806231312130.6440@racer> <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org> <alpine.DEB.1.00.0806231756340.6440@racer>
 <20080623172612.GD27265@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 23 20:44:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAr1O-0005b0-80
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 20:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120AbYFWSnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 14:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753933AbYFWSnO
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 14:43:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:58337 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752216AbYFWSnN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 14:43:13 -0400
Received: (qmail invoked by alias); 23 Jun 2008 18:43:10 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp061) with SMTP; 23 Jun 2008 20:43:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/xPKQINXzx2INoYmHkzWf/t/Mse7Tpqkgtc2Y3GV
	lo009GbnyizbPd
X-X-Sender: gene099@racer
In-Reply-To: <20080623172612.GD27265@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85903>

Hi,

On Mon, 23 Jun 2008, Jeff King wrote:

> On Mon, Jun 23, 2008 at 06:04:48PM +0100, Johannes Schindelin wrote:
> 
> > > > Thinking about the recursive approach again, I came up with this 
> > > > POC:
> > > 
> > > "recursive" is pointless.
> > 
> > Nope, it is not.
> 
> AIUI, one difference between your approach and Pierre's is that he is 
> suggesting (and I have suggested this in the past, too) a big 
> DIFF_OPTIONS macro that you stick in the options table for each command. 
> Whereas you are allowing for subtables accessible via pointers.
> 
> Your approach should yield a much leaner text size

Yes, this is the only difference between Pierre's current approach and my 
POC.

> > Heck, we could just as easily introduce PARSE_OPT_IGNORE_UNKNOWN.
> 
> We could even send it to the list with message-id
> 
>   http://mid.gmane.org/1213758236-979-2-git-send-email-shawn.bohrer@gmail.com
> 
> and then Junio and I could complain that the concept is broken.

Heh.  I thought I saw it, but a quick search did not reveal it, and I 
really don't have time to work on this, unfortunately.

Thanks,
Dscho
