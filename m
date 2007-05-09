From: Petr Baudis <pasky@suse.cz>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Wed, 9 May 2007 15:07:04 +0200
Message-ID: <20070509130704.GR4489@pasky.or.cz>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org> <vpqbqgxak1i.fsf@bauges.imag.fr> <Pine.LNX.4.64.0705070146140.4167@racer.site> <vpqd51duklo.fsf@bauges.imag.fr> <Pine.LNX.4.64.0705071301230.4167@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 09 15:07:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hllsu-0008T7-TE
	for gcvg-git@gmane.org; Wed, 09 May 2007 15:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbXEINHI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 09:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755568AbXEINHI
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 09:07:08 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55899 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753317AbXEINHG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 09:07:06 -0400
Received: (qmail 19269 invoked by uid 2001); 9 May 2007 15:07:04 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705071301230.4167@racer.site>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46711>

  Hi,

On Mon, May 07, 2007 at 01:05:44PM CEST, Johannes Schindelin wrote:
> On Mon, 7 May 2007, Matthieu Moy wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > Just another reason to hate CVS. Because it trained people to do that. If 
> > > it was not for the training by CVS, I would have strongly opposed to the 
> > > introduction of the "-m" switch to commit. It _encourages_ bad commit 
> > > messages.
> > 
> > Well, this really depends on the use-case, size of commit, ...
> 
> Okay, so I use "-m" myself sometimes.

  I'm maybe somewhat standing out of the crowd, but I sometimes use -m
for *very* long commit messages - just using separate -m parameters for
paragraphs and writing on; I tend to find it much more natural than
spawning an editor. Only when I find later that I've made an ugly typo
in the middle of 250-characters commandline or I figure out that I
should add some figure to the message, I throw in -e at the end and add
the final touches.

..snip..
> Commit messages, BTW, are somewhat of an artform. You cannot imagine how 
> slow I am writing them, because they should be helpful not only for the 
> reviewer, but also for the casual git-blame user, who wants to find out 
> the rationale of a change.

  But I agree that commit messages are somewhat of an artform, and
just finding a good headline can be quite difficult sometime. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
