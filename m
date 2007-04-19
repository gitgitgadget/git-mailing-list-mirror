From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] Cogito is for sale
Date: Thu, 19 Apr 2007 14:46:48 +0200
Message-ID: <20070419124648.GL4489@pasky.or.cz>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com> <20070417104520.GB4946@moonlight.home> <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com> <200704171818.28256.andyparkins@gmail.com> <20070417173007.GV2229@spearce.org> <462521C7.2050103@softax.com.pl> <Pine.LNX.4.64.0704181130150.12094@racer.site> <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 19 14:47:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeW2Y-0006Ov-7Z
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 14:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031235AbXDSMqw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 08:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031239AbXDSMqw
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 08:46:52 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56321 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031235AbXDSMqv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 08:46:51 -0400
Received: (qmail 9129 invoked by uid 2001); 19 Apr 2007 14:46:48 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45014>

On Wed, Apr 18, 2007 at 06:07:55PM CEST, Linus Torvalds wrote:
> Actually, at this stage, I really think cogito just *complicates* git 
> usage. It hasn't been well-supported lately, and asking for help with 
> cogito means that a lot of people can't help you. And you still end up 
> using git commands for anything fancier.

And at this stage, I actually rather agree.

I've been torn apart about this for few weeks now, struggling to get
some time (and strong motivation) to dive through the dusty cogito
patchqueues etc., and wondering what to actually *do* about Cogito.
I have been actually inclined to, hmm, "phase out" Cogito for some time
already, but then always some very nice mail from a Cogito user comes
and throws me in doubts. But this thread pushed me over the edge.  ;-)

I agree that by now, the situation is too confusing and while I'm not
happy with everything in Git, I believe that by now the best way is to
just fix Git. Therefore, I'm announcing that I don't plan to add any (at
least any significant) new features to Cogito. Sorry to all the Cogito
users, it is a hard decision for me, but by now I believe that it is
much more effective to just focus on Git.

If anyone else wants to take over Cogito maintainership, you're most
welcome: let me know, please! The "patch queue" means just filtering
=git mailbox, but I have some WIP code to add the .git/config "remotes"
support to Cogito, if you are interested.

Until someone else steps out to maintain Cogito, I'm not going to
abandon Cogito absolutely. I still plan to dive through the patch queue
as soon as possible and then continue integrating bugfixes and/or
smaller-scale changes necessary for newer Git versions. I'll maybe also
write a trivial more-or-less 1:1 cg->git porcelain wrapper for those
who trained their fingers to 'cg' instead of 'git'; but maybe it's best
just to retrain. ;-)


About git homepage:

The very least I wanted to do at any rate with git.or.cz ASAP is to
switch the crash courses to git-oriented ones too. I think git more or
less got to a reasonable point when this is a sane idea. Do you have any
tips on exactly what zero-level introductory material I should put there
instead of the Cogito crash courses, or should we write new ones
(perhaps based on the current ones)? I probably won't have much time to
write a lot of stuff, but I'll gladly use whatever reasonable anyone
suggests/writes, and I have no qualms to just give well-known people
push access to the homepage repository.

Live and prosper,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
