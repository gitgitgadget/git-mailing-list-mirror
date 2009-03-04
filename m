From: Theodore Tso <tytso@mit.edu>
Subject: Re: Subject: [PATCH] Push to create
Date: Wed, 4 Mar 2009 12:58:30 -0500
Message-ID: <20090304175830.GA6305@mit.edu>
References: <20090301170436.GA14365@spearce.org> <7vwsb7gkvt.fsf_-_@gitster.siamese.dyndns.org> <20090303070937.GB30609@coredump.intra.peff.net> <7vy6vnf3aw.fsf@gitster.siamese.dyndns.org> <20090303080603.GA3158@coredump.intra.peff.net> <7v63irf21u.fsf@gitster.siamese.dyndns.org> <20090303082706.GC3158@coredump.intra.peff.net> <7v1vtff1op.fsf@gitster.siamese.dyndns.org> <20090303092301.GE32284@mit.edu> <alpine.DEB.1.00.0903031118280.6399@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 04 19:01:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LevP3-0005x8-00
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 19:01:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757069AbZCDR6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 12:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755156AbZCDR6m
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 12:58:42 -0500
Received: from THUNK.ORG ([69.25.196.29]:54793 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757052AbZCDR6l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 12:58:41 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1LevMX-0000zC-9r; Wed, 04 Mar 2009 12:58:33 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1LevMU-0002JO-31; Wed, 04 Mar 2009 12:58:30 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0903031118280.6399@intel-tinevez-2-302>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112234>

On Tue, Mar 03, 2009 at 11:39:16AM +0100, Johannes Schindelin wrote:
> Only in this case, I would rephrase it to: "Is a usability wart really 
> serious when the guy does not even bother to report it where it can be 
> fixed?"
> 
> It is much harder work to come up with solutions, and that is what I am 
> interested in.  So I'll try very hard to ignore everything else.

Well, I think there is a point hiding behind all of his whining, which
is that if you aren't joining a big established project, but are
rather the maintainer of an existing project that wants to move over
to git, or someone who is starting a new project, and decides to use
git because they've heard it's all the rage --- but the tutorials and
the documentation don't do that great of a job pointing people to the
right place.

For example, the git tutorial's "Using got for collaboration" assumes
that Alice and Bob have accounts on the same system.  C'mon!
Time-sharing systems are so.... 1970's.  Granted that arranging SSH
access is non-trivial, but there are plenty of web sites that offer
free git hosting services: repo.or.oz, gitorious, Github, and now
Sourceforge.  The tutorial should at least point people at the git
hosting sites.

One of the advantages that bzr has is that it is integrated fairly
tightly with Launchpad, which has its own bzr hosting service.  So the
documentation is easier, and with Launchpad's integration into bzr's
UI, a bzr user can publish a branch in a single command line (assuming
they are a registered launchpad user and have an account on launchpad):

	bzr push lp:~userid/project-name/branch-name

It's going to be hard for git to be able to match this usability,
given that we need to do something that works with multiple hosting
facilities, and not just tie ourselves to a single system like
gitorious, Github, or Sourceforge.  (Although I could imagine some
kind of plugin/hook system where once the plugin for a particular git
hosting facility was installed, git could be much more tightly
integrated with a particular hosting service.)

At the very least, though, it should be relatively easy to update our
documentation to at least acknowledge the many and varied free git
hosting services; it's not like we need to tell people that the only
way to share repositories involves setting up an ssh or Apache server.

					- Ted


P.S.  For more details about the bzr/Launchpad integration, see:

http://doc.bazaar-vcs.org/bzr.dev/en/tutorials/using_bazaar_with_launchpad.html
