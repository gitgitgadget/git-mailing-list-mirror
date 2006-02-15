From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cogito turbo-introduction
Date: Wed, 15 Feb 2006 02:32:36 +0100
Message-ID: <20060215013236.GN31278@pasky.or.cz>
References: <Pine.LNX.4.64.0602140845080.3691@g5.osdl.org> <87k6bxvmj6.wl%cworth@cworth.org> <1139943349.4341.66.camel@evo.keithp.com> <Pine.LNX.4.64.0602141101110.3691@g5.osdl.org> <1139945967.4341.71.camel@evo.keithp.com> <20060214220154.GJ31278@pasky.or.cz> <1139960934.4341.93.camel@evo.keithp.com> <20060215000737.GF9573@pasky.or.cz> <1139963183.4341.117.camel@evo.keithp.com> <20060215011210.GG30316@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 02:32:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9BWS-0004EM-LQ
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 02:32:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422793AbWBOBbt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 20:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422911AbWBOBbs
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 20:31:48 -0500
Received: from w241.dkm.cz ([62.24.88.241]:9601 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1422793AbWBOBbs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 20:31:48 -0500
Received: (qmail 23578 invoked by uid 2001); 15 Feb 2006 02:32:36 +0100
To: Keith Packard <keithp@keithp.com>
Content-Disposition: inline
In-Reply-To: <20060215011210.GG30316@pasky.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16201>

Dear diary, on Wed, Feb 15, 2006 at 02:12:11AM CET, I got a letter
where Petr Baudis <pasky@ucw.cz> said that...
> In this sense, the good UI goal has indeed higher priority than the
> powerfulness goal, but most of the time we hopefully manage to make it
> go together well. The significant areas where Cogito is fundamentally
> less powerful than GIT itself are:
> 
> 	* No git-whatchanged -p - this is huge deficiency, and I'm
> 	  entirely at fault here
> 	* Consequently, no pickaxe and renames detection - same
> 	* Recursive merge strategy - not much of a UI problem, it just
> 	  needs the time and work to get integrated
> 	* Remote branches handling - Cogito's handling is strictly 1:1
> 	  while GIT's remotes are much more powerful and allow you to
> 	  fetch/push many branches at once (and in fact do so by
> 	  default); I did not invent a good UI for something similarly
> 	  powerful yet, and it is no high priority for me so far;
> 	  I think you actually want 1:1 in by far the most common usage
> 	  pattern

(And you can pretty easily script/alias multi-branch fetches, it just
won't be as super-efficient as if you would fetch/push at once.)


The above is though not to say that Cogito is strict subset of GIT!
Cogito has many cool things GIT doesn't have. ;-) To pick some random
examples:

	* cg-clean
	* cg-commit - packed with convenience stuff, from multiple -m's
	  to --review
	* cg-init's initial commit
	* resumable cg-clone
	* cg-fetch's cute progressbars ;-)
	* things which are rather thin wrappers automating sequence of
	  few commands, nevertheless providing much convenience
	  (cg-admin-setuprepo, cg-admin-uncommit, cg-seek, cg-export...)

(Perhaps some of this GIT can already do, I don't watch the core
porcelain that closely.)

> Note that Cogito's goal is not to reproduce and wrap all GIT commands -
> e.g. I have currently no plans to wrap up git-bisect.

To explain, that's not because I consider git-bisect to be bad, but the
very opposite - because it is so cool and I couldn't really add much
value by adding it to Cogito. When Cogito will have good tutorial
documentation (I think it already has _very_ good reference
documentation - please prove me wrong so that we can improve it
further), I will just happily reference people to those GIT core
commands.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
