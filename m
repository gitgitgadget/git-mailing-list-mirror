From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Bring parse_options to the shell
Date: Fri, 2 Nov 2007 18:21:17 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711021818480.4362@racer.site>
References: <1194016162-23599-1-git-send-email-madcoder@debian.org>
 <20071102151453.GB27505@artemis.corp> <alpine.LFD.0.999.0711020844310.3342@woody.linux-foundation.org>
 <20071102160925.GC27505@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, gitster@pobox.com,
	git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Nov 02 19:22:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io19z-0001nS-KU
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 19:22:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756059AbXKBSWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 14:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755897AbXKBSWH
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 14:22:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:40971 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755165AbXKBSWH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 14:22:07 -0400
Received: (qmail invoked by alias); 02 Nov 2007 18:22:04 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 02 Nov 2007 19:22:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ABOBcG3rAAEzzWosHN0PcrzSFmGRUCVROUOTNWi
	RzerBMMn5LVLIb
X-X-Sender: gene099@racer.site
In-Reply-To: <20071102160925.GC27505@artemis.corp>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63150>

Hi,

On Fri, 2 Nov 2007, Pierre Habouzit wrote:

> On Fri, Nov 02, 2007 at 03:51:13PM +0000, Linus Torvalds wrote:
> 
> > That command [rev-parse] was written exactly to parse a command line. 
> > This is really cheesy, and doesn't really work right (it splits up 
> > numbers too), but you get the idea..
> 
>   I get the idea, though parse-options is not incremental at all, this 
> could probably be done, but would complicate the API (we would need to 
> allocate a state object e.g.). And parseoptions checks that options 
> getting an argument have one, checks that options exists and so on. It 
> looks like to me that it's not easy to plumb into rev-parse without 
> being a brand new independant mode.
> 
>   We can do that, if we don't want yet-another-git-builtin/command, but 
> in the spirit it'll remain a brand new "thing".
> 
>   Though I'd be glad to hear about what others think about it.

Yeah, rev-parse's only purpose in life is to help scripts.  (Even if it is 
used sometimes -- even by myself -- to turn symbolic names into SHA-1s.)

IMHO it makes tons of sense to put the functionality into that command, 
even if it is not incremental.

Ciao,
Dscho
