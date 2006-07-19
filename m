From: Petr Baudis <pasky@suse.cz>
Subject: Git BOF notes
Date: Thu, 20 Jul 2006 01:01:55 +0200
Message-ID: <20060719230155.GJ13776@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jul 20 01:02:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3L3M-00005L-V2
	for gcvg-git@gmane.org; Thu, 20 Jul 2006 01:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbWGSXB7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Jul 2006 19:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbWGSXB6
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Jul 2006 19:01:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:7822 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932562AbWGSXB6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jul 2006 19:01:58 -0400
Received: (qmail 3168 invoked by uid 2001); 20 Jul 2006 01:01:55 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24012>

  Hi,

  a short summary of the Git BOF on OLS which finished just a short
while ago. We got to hear how Len Brown is doing things and where Git
gets in the way for him as well as interesting questions and comments
from several other people. The main highlights as I feel them (mixed
randomly with my personal blabbering) are that:

  (i) We should somehow separate the lowlevel Git commands from the
highlevel ones meant for user consumption. There's too many of them
and it is confusing for the users. Similarity with BitKeeper was pointed
out (and I refrained from mentioning GNU Arch).

  (ii) We should document the workflows better. Currently there is a
huge variety of workflows spread accross the Git user community,
probably stemming from the fact that the UI evolved so fast while
already "on the fly". Of course it shows that the Git tools are
really flxible and versatile, but it might also mean that we are not
abstracting some operations enough, or not selling the easier user
interface better. Anyway, new users might find the current mix of
workflows used across the community somewhat intimidating. This also
means that....

  (iii) ...we should spread the word about StGIT more (because StGIT
is cool and often does just what people want to do with Git and it's
clumsy), more so because...

  (iv) ...we should support mutating history better (I think this is the
most important point). There is a kind of conflict here:

	* Fundamentally, Git considers history to be immutable,
	  especially if you publish it.
	* The kernel workflow encourages the opposite - the subsystem
	  maintainers are rebasing all the time as well as just
	  generally retouching their history (typos, fixing bugs in
	  the patches etc).

  This problem can be separated to two areas:

	* Support for the history mutation. We have some nice tools
	  in Git for rebasing, but it would be nice to support the
	  other modifications easier as well. I suggested having
	  a tool you just tell a commit id and it will let you modify
	  the author info, the associated patch or fold another patch
	  in... Also, using StGIT obviously hlps a lot here.

	* Support for distributing and following the mutated history.
	  I'm actually not sure about the level of Git support for
	  this, Cogito supports cg-updating to a mutated history
	  if you have no local changes.

  Please feel free to add things if I have missed anything.

  Happy hacking,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
