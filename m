From: Theodore Tso <tytso@mit.edu>
Subject: Re: "Producting Open Source Software" book and distributed SCMs
Date: Tue, 1 May 2007 11:23:42 -0400
Message-ID: <20070501152342.GB26093@thunk.org>
References: <200704300120.42576.jnareb@gmail.com> <Pine.LNX.4.64.0705011057130.29859@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 01 17:24:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiuD9-0008Bb-EX
	for gcvg-git@gmane.org; Tue, 01 May 2007 17:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031041AbXEAPXz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 11:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031045AbXEAPXz
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 11:23:55 -0400
Received: from thunk.org ([69.25.196.29]:60534 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030619AbXEAPXx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 11:23:53 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HiuJP-0007eC-Ay; Tue, 01 May 2007 11:30:43 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HiuCc-0002Oo-H3; Tue, 01 May 2007 11:23:42 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705011057130.29859@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45948>

On Tue, May 01, 2007 at 11:35:54AM +0200, Johannes Schindelin wrote:
> > [...]
> > 
> >   Because a fork is bad for everyone (for reasons examined in detail in 
> >   the section called "Forks" in Chapter 8, Managing Volunteers, 
> >   http://producingoss.com/producingoss.html#forks), the more serious the 
> >   threat of a fork becomes, the more willing people are to compromise to 
> >   avoid it.
> 
> This is a lousy argument, IMHO.
> 
> Why are forks bad? They are not. But if you "learnt" that merges are hard, 
> they are.
> 
> It is a pity that so many people were trained in CVS, and keep thinking 
> some of the lectures were true, when they are no longer.
> 
> Forks are good. In fact, we all "forked" with CVS as soon as we began 
> hacking. Everybody who claims to never have started over from a fresh 
> checkout, or from an "update -C"ed state, is probably lying, or a bad 
> developer. Thinking about it, I believe that the difference between 
> forking and branching is philosophical, not technical. You can always 
> merge a fork.

There's a confusion going on here between a "fork" meaning a branch in
the SCM sense of the word, and a "Project Fork" where there are two
camps competing for developers and users.  So for example, having
kerenl developers develop using branches which are then merged into
the -mm tree and then into Linus tree --- Good.  In the
suspend-to-disk world, where we have *three* separate implementations,
with two in the mainline tree, and one very popular one, suspend2,
with features that niether of the in-mainline implementations have,
and with Pavel constantly casting aspersions at Nigel because he's
splitting the development effort --- Not So Good.

I prefer to use the term "branch" to talk about a SCM and development
series, and to use the term "fork" to talk about the political/project
issues.  So for example, even though Ingo Molnar's CONFIG_PREEMPT_RT
patchset has been a very long-running thing, it is constantly getting
rebased against the kernel, and there is no expectation that this
would replace the mainline kernel.  That makes a code branch, and not
a fork.

So my suggestion is to let branches be branches, and to reserve fork
for when there is an attempt to compete for developer and user
attention.  That is more or less the general understanding of the two
terms, and trying to confuse the two only leads to confusion and a
general muddying of the waters.

Regards,

					- Ted
