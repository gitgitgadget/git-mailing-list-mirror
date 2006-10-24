From: "Matthew D. Fuller" <fullermd@over-yonder.net>
Subject: Re: VCS comparison table
Date: Tue, 24 Oct 2006 11:34:58 -0500
Message-ID: <20061024163458.GH17019@over-yonder.net>
References: <20061022074513.GF29927@artax.karlin.mff.cuni.cz> <200610221105.26421.jnareb@gmail.com> <845b6e870610220256u39d3d06wefd4f71851670812@mail.gmail.com> <87zmbozau2.wl%cworth@cworth.org> <20061022185350.GW75501@over-yonder.net> <Pine.LNX.4.64.0610231018410.3962@g5.osdl.org> <20061023222131.GB17019@over-yonder.net> <Pine.LNX.4.64.0610231534010.3962@g5.osdl.org> <20061024002622.GC17019@over-yonder.net> <Pine.LNX.4.63.0610240853160.10841@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 18:36:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcPF5-0004DE-Ri
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 18:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWJXQfB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 12:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWJXQfA
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 12:35:00 -0400
Received: from ns.centralmiss.com ([206.156.254.79]:18653 "EHLO
	optimus.centralmiss.com") by vger.kernel.org with ESMTP
	id S932441AbWJXQfA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 12:35:00 -0400
Received: from draco.over-yonder.net (adsl-072-148-013-213.sip.jan.bellsouth.net [72.148.13.213])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by optimus.centralmiss.com (Postfix) with ESMTP id 22C4828431;
	Tue, 24 Oct 2006 11:34:59 -0500 (CDT)
Received: by draco.over-yonder.net (Postfix, from userid 100)
	id 835CD61C52; Tue, 24 Oct 2006 11:34:58 -0500 (CDT)
To: David Lang <dlang@digitalinsight.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0610240853160.10841@qynat.qvtvafvgr.pbz>
X-Editor: vi
X-OS: FreeBSD <http://www.freebsd.org/>
User-Agent: Mutt/1.5.11-fullermd.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29986>

On Tue, Oct 24, 2006 at 08:58:56AM -0700 I heard the voice of
David Lang, and lo! it spake thus:
> 
> one key difference is that with bzr you have to do this chopping by
> creating the branches at the time changes are done,

HUH?  Why on earth do you think that?

To do this in a git data model, you point at 2 (or 3, or 4, or...)
revisions, anywhere in the revision-space universe.  You derive back a
DAG of the history from each of them by recursing over parent links.
You figure out where (if anywhere) those DAG's intersect.  And based
on that, you alter what and how you display; including or excluding
certain revs, changing the angles of lines or columnation of dots in a
graph, etc.

To do it in a bzr data model, you would follow *EXACTLY* the same
steps.  As in, you do EXACTLY (a), then EXACTLY (b), then...


> what people are saying is that it doesn't easily support a truely
> distributed workflow. this is a very different statement.

And it's one that carries around a lot of unstated assumptions about
what "truely distributed" means, which *I*'m certainly not
understanding, because any meaning I can apply to the term doesn't
lead me to the conclusions it does you.  Certainly, depending on your
workflow, certain parts of the UI are of lesser utility than they are
in mine, down to and including zero.  And it's probably certain that
some parts of the UI aren't up to handling various workflows, too,
including OUR workflow.  That's kinda what "in development" means...

But that's a very different statement from the claim that they CAN'T
be without changes to the conceptual model underneath.  Just because a
UI is built around maintaining the fiction of a mainline doesn't mean
the system requires it.  All you'd have to do to abandon it is write a
different log formatter that didn't show revnos and didn't nest merge
commits, and change (or add an option to) 'merge' to fast-forward if
possible.  The difference between the views on how the pieces should
fit together really IS just that fine.


-- 
Matthew Fuller     (MF4839)   |  fullermd@over-yonder.net
Systems/Network Administrator |  http://www.over-yonder.net/~fullermd/
           On the Internet, nobody can hear you scream.
