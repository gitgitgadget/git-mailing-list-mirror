From: Petr Baudis <pasky@ucw.cz>
Subject: Cogito turbo-introduction
Date: Wed, 15 Feb 2006 02:12:11 +0100
Message-ID: <20060215011210.GG30316@pasky.or.cz>
References: <43F20532.5000609@iaglans.de> <Pine.LNX.4.64.0602140845080.3691@g5.osdl.org> <87k6bxvmj6.wl%cworth@cworth.org> <1139943349.4341.66.camel@evo.keithp.com> <Pine.LNX.4.64.0602141101110.3691@g5.osdl.org> <1139945967.4341.71.camel@evo.keithp.com> <20060214220154.GJ31278@pasky.or.cz> <1139960934.4341.93.camel@evo.keithp.com> <20060215000737.GF9573@pasky.or.cz> <1139963183.4341.117.camel@evo.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 02:11:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9BCZ-00008n-2w
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 02:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422906AbWBOBLY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 20:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422907AbWBOBLY
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 20:11:24 -0500
Received: from w241.dkm.cz ([62.24.88.241]:18817 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1422906AbWBOBLY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 20:11:24 -0500
Received: (qmail 20640 invoked by uid 2001); 15 Feb 2006 02:12:11 +0100
To: Keith Packard <keithp@keithp.com>
Content-Disposition: inline
In-Reply-To: <1139963183.4341.117.camel@evo.keithp.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16199>

I suppose this might be interesting for others (and Google) as well, so
I'm bringing it back to the mailing list...

Dear diary, on Wed, Feb 15, 2006 at 01:26:23AM CET, I got a letter
where Keith Packard <keithp@keithp.com> said that...
> I will see about learning enough cogito to point appropriate people at
> it in place of full-on git exposure.

Actually, everything should be really trivial, since Cogito is very
similar to CVS or SVN in practice. A turbo introduction to Cogito, which
actually proved to be enough to get started fast with the regular work,
was:

	* cg-clone URL to get the stuff
	* cg-commit just like in CVS (but cooler)
	* cg-update just like in CVS (or rather SVN)
	* cg-status to get the status letters produced by cvs update
	  (just like in SVN)
	* cg-diff, cg-log, cg-add, cg-rm just like in CVS (but cooler)

	* After committing for a while, you need to run cg-push
	* Merge commits are perfectly ok, don't mind them; no really,
	  you will get used; in reality, they are cool
	* If you hit conflicts during merge, the software will tell you
	  how to proceed
	* If you need something different / more advanced, look it up
	  in cg-help list (there is actually significantly less Cogito
	  commands to go through than in CVS, yet in most areas Cogito
	  is much more powerful)
	* If you are confused about the distributed concept or want to
	  learn about branching, try Cogito README

I've been trying to design Cogito's UI pretty carefully to really
absolutely minimize the learning curve from CVS/SVN, while also making
it consistent on its own so that people who learn it as their first VCS
will get actually something nice. Well, the users shall judge. ;-)
(At this stage I would probably design few bits of the UI slightly
differently than how they have evolved, but the gripes are pretty
minor.)

In this sense, the good UI goal has indeed higher priority than the
powerfulness goal, but most of the time we hopefully manage to make it
go together well. The significant areas where Cogito is fundamentally
less powerful than GIT itself are:

	* No git-whatchanged -p - this is huge deficiency, and I'm
	  entirely at fault here
	* Consequently, no pickaxe and renames detection - same
	* Recursive merge strategy - not much of a UI problem, it just
	  needs the time and work to get integrated
	* Remote branches handling - Cogito's handling is strictly 1:1
	  while GIT's remotes are much more powerful and allow you to
	  fetch/push many branches at once (and in fact do so by
	  default); I did not invent a good UI for something similarly
	  powerful yet, and it is no high priority for me so far;
	  I think you actually want 1:1 in by far the most common usage
	  pattern
	* No email interface - but you can trivially just fall back to
	  GIT in this area

Note that Cogito's goal is not to reproduce and wrap all GIT commands -
e.g. I have currently no plans to wrap up git-bisect.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
