From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git-fast-import
Date: Tue, 6 Feb 2007 23:55:46 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702062347060.20138@iabervon.org>
References: <20070206023111.GB9222@spearce.org> <45C81C33.6010704@gmail.com>
 <20070206061817.GB10508@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 07 05:55:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEeqW-0001jI-UJ
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 05:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbXBGEzt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 23:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965639AbXBGEzs
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 23:55:48 -0500
Received: from iabervon.org ([66.92.72.58]:4083 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965615AbXBGEzs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 23:55:48 -0500
Received: (qmail 28722 invoked by uid 1000); 6 Feb 2007 23:55:46 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Feb 2007 23:55:46 -0500
In-Reply-To: <20070206061817.GB10508@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38888>

On Tue, 6 Feb 2007, Shawn O. Pearce wrote:

> "Aneesh Kumar K.V" <aneesh.kumar@gmail.com> wrote:
> > >SYNOPSIS
> > >--------
> > >frontend | 'git-fast-import' [options]
> > >
> > 
> > Do we have example frontend  that can be added along with gfi ?
> 
> Not yet.  Some frontends are available here on repo.or.cz:
> 
>   gitweb: http://repo.or.cz/w/fast-export.git
>   clone:  git://repo.or.cz/fast-export.git
> 
> But both lack branch support, for example, so they probably aren't
> nearly as complete as the existing non-gfi based importers.

It might be nice to have a git-fast-export, which could actually be 
potentially useful for generating a repository with systematic differences 
from the original. (E.g., to make a repository of git's Documentation 
directory, with just the commits that affect it)

That might also be a big help to projects that find they should have been 
using more, fewer, or different repositories through their history.

Also, I'd guess that it would be pretty straightforward and easy to 
understand, plus easy to verify correctness on large examples with.

	-Daniel
*This .sig left intentionally blank*
