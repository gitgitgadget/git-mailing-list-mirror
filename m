From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT RFC] Mavenized JGit
Date: Wed, 4 Jun 2008 00:27:03 -0400
Message-ID: <20080604042703.GQ12896@spearce.org>
References: <7bfdc29a0806030742r77b79786n92a5ce6a0aba7726@mail.gmail.com> <200806031856.11060.robin.rosenberg.lists@dewire.com> <20080603225418.GP12896@spearce.org> <200806040130.41654.robin.rosenberg.lists@dewire.com> <7bfdc29a0806032052w39010711q27e5257ef559908a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Git Mailing List <git@vger.kernel.org>
To: Imran M Yousuf <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 06:28:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3kbT-00027m-Ip
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 06:28:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbYFDE1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 00:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbYFDE1J
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 00:27:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58083 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbYFDE1I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 00:27:08 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K3kaX-00042V-BZ; Wed, 04 Jun 2008 00:27:05 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C48F120FBAE; Wed,  4 Jun 2008 00:27:03 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7bfdc29a0806032052w39010711q27e5257ef559908a@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83743>

Imran M Yousuf <imyousuf@gmail.com> wrote:
> The first version I mavenized JGit I moved the source code, but I
> thought that would come in for more criticism :), thus I chose the
> symlink option. Please let me know if a move based mavenizing would be
> welcomed or not.

[please don't top-post on this list]

I'd rather us moving the code into a subdirectory than require
a symlink.  For Eclipse this is easy to change the directory that
the code is in, we just have to edit the .classpath to move the
source folder lower in the tree.

But this shows one reason why I don't use Maven I think.  The
fact that we need a "java" directory to hold our java code.
What if another build system wants a different name?  Grumble.

For the most part git-merge-recursive can handle a merge through
this sort of rename.  But we'd like to do this sort of thing at
some relatively stable point in time to try and minimize the impact
it has.
 
> On Wed, Jun 4, 2008 at 5:30 AM, Robin Rosenberg
> <robin.rosenberg.lists@dewire.com> wrote:
> > onsdagen den 4 juni 2008 00.54.18 skrev Shawn O. Pearce:
> >> I don't think there is a Cygwin based version of the JVM.  That would
> >> be a very interesting beast.
> > Looks like it could be possible to build it under Cygwin.
> > http://download.java.net/jdk7/docs/build/README-builds.html#cygwin

-- 
Shawn.
