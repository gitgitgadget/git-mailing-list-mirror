From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Git-aware Issue Tracking?
Date: Wed, 20 Aug 2008 22:25:40 +0200
Message-ID: <200808202225.43331.robin.rosenberg.lists@dewire.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com> <20080820152305.GJ10544@machine.or.cz> <20080820164409.GH3483@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>,
	Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 20 22:28:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVuHx-0005rU-GB
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 22:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266AbYHTU1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 16:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754842AbYHTU1O
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 16:27:14 -0400
Received: from av11-1-sn2.hy.skanova.net ([81.228.8.183]:54209 "EHLO
	av11-1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbYHTU1N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 16:27:13 -0400
Received: by av11-1-sn2.hy.skanova.net (Postfix, from userid 502)
	id 6C39F38F24; Wed, 20 Aug 2008 22:27:11 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av11-1-sn2.hy.skanova.net (Postfix) with ESMTP
	id 51D9938F0D; Wed, 20 Aug 2008 22:27:11 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 0FBD137E44;
	Wed, 20 Aug 2008 22:27:10 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080820164409.GH3483@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93036>

onsdagen den 20 augusti 2008 18.44.09 skrev Shawn O. Pearce:
> Petr Baudis <pasky@suse.cz> wrote:
> > On Wed, Aug 20, 2008 at 07:13:26AM -0700, Shawn O. Pearce wrote:
> > > I've thought about starting a code.google.com project just to use
> > > the issue tracking system there.
> > 
> > I have been thinking about issue tracking for some of my projects too,
> > but I'm wondering, does anyone have a comprehensive picture of the state
> > of the Git-supporting issue tracking tools, especially those that keep
> > the tracked issues in a Git repository as well?
> > 
> > 	http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#head-73b23f376ebd0222d1e4b08f09158172aa34c24f
> > 
> > has three, but two of them are in Ruby, which is rather discouraging.
> > But Cil (in Perl) is already "self-hosting", so it might be well usable?
> 
> Cil is interesting.  I'm concerned about keeping the state in tree
> with the repository though in a distributed development team.
> 
> If I mark the status of an issue in a branch that isn't ready
> for mainline how do I share that status update with everyone else?
> I have to put it into a branch somewhere, no big deal.  repo.or.cz is
> pretty good at publishing things.
> 
> But do that now for 5 developers working on 10 or 20 different
> branches at once.  We'll have status updates all over the place
> and Marek's desire to see what we are each working on (to reduce
> wasted effort and perhaps help each other out more) still isn't met.
> 
> This is the number one reason a DIT (distributed issue tracker)
> isn't available.  Nobody has solved the hard technical problem of
> making it easy to distribute the state changes, yet still provide
> a reasonably current global view of the issue status.

Actually his name is Mik Kersten, the main figure behind Mylyn.
Mylyn is a plugin for Eclipse that actually does this. It connects to 
bugzilla, trac and som other trackers and caches changes locally
until it connect to the website and syncrhronize. It does a lot more,
than that. The objectives partially overlap what Git does. Having
Mylin and Git work together would be very sweet indeed.

> Perhaps running Cil in its own egit-cil.git repository would get
> us what we neeed.  I looked at the code and its pretty clean,
> but I didn't see how merges of the .cil database work.

-- robin
