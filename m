From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: Finding file revisions
Date: Thu, 28 Apr 2005 18:34:59 +0200
Message-ID: <1114706099.4212.25.camel@localhost.localdomain>
References: <200504271251.00635.mason@suse.com>
	 <200504271423.37433.mason@suse.com>
	 <Pine.LNX.4.58.0504271506290.18901@ppc970.osdl.org>
	 <200504280745.05505.mason@suse.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 18:31:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRBti-00069U-EP
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 18:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbVD1QfJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 12:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbVD1QfJ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 12:35:09 -0400
Received: from soundwarez.org ([217.160.171.123]:35484 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262163AbVD1QfA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 12:35:00 -0400
Received: from dhcp-113.off.vrfy.org (c196135.adsl.hansenet.de [213.39.196.135])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by soundwarez.org (Postfix) with ESMTP id 7B1F419C78;
	Thu, 28 Apr 2005 18:34:59 +0200 (CEST)
To: Chris Mason <mason@suse.com>
In-Reply-To: <200504280745.05505.mason@suse.com>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-04-28 at 07:45 -0400, Chris Mason wrote:
> On Wednesday 27 April 2005 18:19, Linus Torvalds wrote:
> > On Wed, 27 Apr 2005, Chris Mason wrote:
> > > So, new prog attached.  New usage:
> > >
> > > file-changes [-c commit_id] [-s commit_id] file ...
> > >
> > > -c is the commit where you want to start searching
> > > -s is the commit where you want to stop searching
> >
> > Your script will do some funky stuff, because you incorrectly think that
> > the rev-list is sorted linearly. It's not. It's sorted in a rough
> > chronological order, but you really can't do the "last" vs "cur" thing
> > that you do, because two commits after each other in the rev-list listing
> > may well be from two totally different branches, so when you compare one
> > tree against the other, you're really doing something pretty nonsensical.
> 
> One more rev that should work as you suggested Here's the example output 
> from a cogito changeset with merges.  I print the diff-tree lines once for each 
> matching parent and then print the commit once.  It's very primitive, but
> hopefully some day someone will make a gui with happy clicky buttons
> for changesets and filerevs.

Not really happy clicky, but ... :)

Look at the (history) link:
  http://ehlo.org/~kay/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=fb3b4ebc0be618dbcc2326482a83c920d51af7de

Kay

