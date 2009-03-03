From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Subject: [PATCH] Push to create
Date: Tue, 3 Mar 2009 10:41:06 -0800
Message-ID: <20090303184106.GH14365@spearce.org>
References: <20090301100039.GD4146@coredump.intra.peff.net> <20090301170436.GA14365@spearce.org> <7vwsb7gkvt.fsf_-_@gitster.siamese.dyndns.org> <20090303070937.GB30609@coredump.intra.peff.net> <7vy6vnf3aw.fsf@gitster.siamese.dyndns.org> <20090303080603.GA3158@coredump.intra.peff.net> <7v63irf21u.fsf@gitster.siamese.dyndns.org> <20090303082706.GC3158@coredump.intra.peff.net> <7v1vtff1op.fsf@gitster.siamese.dyndns.org> <20090303092301.GE32284@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 03 19:43:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeZaN-0003Jj-E4
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 19:43:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbZCCSlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 13:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753367AbZCCSlI
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 13:41:08 -0500
Received: from george.spearce.org ([209.20.77.23]:42453 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341AbZCCSlI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 13:41:08 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 26C1638211; Tue,  3 Mar 2009 18:41:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090303092301.GE32284@mit.edu>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112145>

Theodore Tso <tytso@mit.edu> wrote:
> On Tue, Mar 03, 2009 at 12:30:46AM -0800, Junio C Hamano wrote:
> > Jeff King <peff@peff.net> writes:
> > 
> > > But I think that coincides with what I was trying to say in my original
> > > response to the series, which is "this issue is complex, and we need to
> > > hear from the people who would really want this exactly what it is they
> > > want".
> > 
> > And we haven't heard from them at all, unless you and/or Shawn are
> > interested.  After all we may not have to worry about this at all ;-)
> 
> Junio, I assume you saw Scott James Remnant blog posts, "Git Sucks"?
> 
>        http://www.netsplit.com/2009/02/17/git-sucks/

Funny, this very blog post is talking about why I think remote
creation should be under git push, not "git init --remote".

IMHO, maybe we also should change the error message that receive-pack
produces when the path its given isn't a Git repository.  Its really
not very human friendly to say "unable to chdir or not a git archive".
Hell, we don't even call them archives, we call them repositories.

-- 
Shawn.
