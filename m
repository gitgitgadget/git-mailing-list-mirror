From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 4/9] Discard "deleted" cache entries after using them to
 update the working tree
Date: Fri, 25 Jan 2008 19:54:18 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801251939570.13593@iabervon.org>
References: <alpine.LNX.1.00.0801251820330.13593@iabervon.org> <7v63xh5uo0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 01:54:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIZJv-00053c-N6
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 01:54:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754779AbYAZAyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 19:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752774AbYAZAyY
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 19:54:24 -0500
Received: from iabervon.org ([66.92.72.58]:59160 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752509AbYAZAyX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 19:54:23 -0500
Received: (qmail 7259 invoked by uid 1000); 26 Jan 2008 00:54:18 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Jan 2008 00:54:18 -0000
In-Reply-To: <7v63xh5uo0.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71760>

On Fri, 25 Jan 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > It's likely that this should get merged in some way with Linus's series to 
> > handle the in-core index differently in general. But this is a simple 
> > solution to the problem that's sufficient for this particular series.
> 
> Just to let you know, the early parts of lt/in-core-index series
> are already in 'next', and it will be one of the first topics to
> graduate to 'master' post 1.5.4.
> 
> I think we both understand that this round is sent purely for
> discussion and I won't be picking them up right now nor later
> before the "for possible inclusion" resend you will be making
> post 1.5.4, so it should not matter too much which exact version
> this round is based on.
> 
> It however may be worthwhile for you to plan rebasing your
> future rounds on top of 077c48df8a72b046a2f562fedffa1c3d3a73a4e2
> (read-cache.c: fix a couple more CE_REMOVE conversion).

I've now got a version rebased on that. The conflicts are pretty 
straightforward, and the tests all pass (once I fix the unrelated bug in 
9/9 wrt the lockfile API change).

	-Daniel
*This .sig left intentionally blank*
