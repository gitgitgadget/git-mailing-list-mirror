From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: What's cooking in git.git (Feb 2009, #05; Mon, 16)
Date: Tue, 17 Feb 2009 23:28:14 +0100
Message-ID: <20090217222814.GA19085@diku.dk>
References: <7vfxid8phr.fsf@gitster.siamese.dyndns.org> <20090217193027.GA16093@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 17 23:29:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZYRo-0000OF-Sn
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 23:29:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbZBQW2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 17:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752876AbZBQW2V
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 17:28:21 -0500
Received: from mgw2.diku.dk ([130.225.96.92]:42032 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752631AbZBQW2U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 17:28:20 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id CFE1319BB69;
	Tue, 17 Feb 2009 23:28:18 +0100 (CET)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 14219-14; Tue, 17 Feb 2009 23:28:17 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id AAD2519BB72;
	Tue, 17 Feb 2009 23:28:14 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id A82E56DF84F; Tue, 17 Feb 2009 23:26:13 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 8256C39AA06; Tue, 17 Feb 2009 23:28:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090217193027.GA16093@coredump.intra.peff.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110458>

Jeff King <peff@peff.net> wrote Tue, Feb 17, 2009:
> On Mon, Feb 16, 2009 at 11:57:36PM -0800, Junio C Hamano wrote:
> > * jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
> >  + blame: show "previous" information in --porcelain/--incremental
> >    format
> >  + git-blame: refactor code to emit "porcelain format" output
> > 
> > This gives Porcelains (like gitweb) the information on the commit _before_
> > the one that the final blame is laid on, which should save them one
> > rev-parse to dig further.  The line number in the "previous" information
> > may need refining, and sanity checking code for reference counting may
> > need to be resurrected before this can move forward.
> > 
> > I thought recent tig discussion may blow new life into it, but is this
> > unneeded?  If so I'd rather revert it (or discard after 1.6.2).
> 
> I never got a chance to look closely at this patch series;

Sorry, me neither. Generally, I am all for pushing as much as possible
into git, and was also happy to see a recent patch making it possible to
launch an editor. Especially, since tig would then benefit if a better
heuristic comes along. Unfortunately, I won't be able to offer to do
what I think is a request for someone to polish it off.

> So a blame implementation might help other callers, but I don't think
> there is much motivation from tig's point of view.

Yeah, tig will be stuck with (falling back to) diff-tree anyway.

-- 
Jonas Fonseca
