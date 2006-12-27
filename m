From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Create 'git gc' to perform common maintenance operations.
Date: Wed, 27 Dec 2006 02:53:30 -0500
Message-ID: <20061227075330.GA23022@spearce.org>
References: <20061227071759.GA23057@spearce.org> <7vr6ul93wz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 27 08:53:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzTbc-0001Ls-9f
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 08:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932982AbWL0Hxk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 02:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932980AbWL0Hxk
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 02:53:40 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55412 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932982AbWL0Hxj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 02:53:39 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GzTba-0004xN-MZ; Wed, 27 Dec 2006 02:53:42 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6A8DD20FB65; Wed, 27 Dec 2006 02:53:31 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr6ul93wz.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35453>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > +The optional configuration variable 'gc.reflogExpireUnreachable'
> > +can be set to indicate how long historical reflog entries which
> > +are not part of the current branch should remain available in
> > +this repository.  These types of entries are generally created as
> > +a result of using `git commit \--amend` or `git rebase` and are the
> > +commits prior to the amend or rebase occuring.  Since these changes
> > +are not part of the current project most users will want to expire
> > +them sooner.  This option defaults to '60 days'.
> 
> Should I update the default expire-unreachable in builtin-reflog
> to match 60 days?

Doh, I meant for git-gc to match the default in 'git-reflog expire'.
Whoops.

I don't care either way.  60 days may be too long for some users,
but for others it may be nice to have.  I think the two defaults
should match just because.  Feel free to edit my patch before
applying to be whatever 'git-reflog expire' uses if you want.

-- 
Shawn.
