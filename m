From: "Kirby C. Bohling" <kbohling@birddog.com>
Subject: Re: [OT?] git tools at SourceForge ?
Date: Fri, 12 Aug 2005 16:06:11 -0500
Message-ID: <20050812210611.GF13550@birddog.com>
References: <20050812190739.AC222352633@atlas.denx.de> <Pine.LNX.4.63.0508121634570.12816@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wolfgang Denk <wd@denx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 23:06:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3gjY-0007Pn-Fg
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 23:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbVHLVGX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 17:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbVHLVGX
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 17:06:23 -0400
Received: from hermes.birddog.com ([216.81.238.129]:42401 "EHLO
	hermes.birddog.com") by vger.kernel.org with ESMTP id S1750863AbVHLVGW
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 17:06:22 -0400
Received: from hawk.birddog.com (hawk.birddog.com [10.15.4.100])
	by hermes.birddog.com (8.12.10/8.12.10) with ESMTP id j7CL6Htn015379;
	Fri, 12 Aug 2005 16:06:17 -0500
Received: from hawk.birddog.com (localhost.localdomain [127.0.0.1])
	by hawk.birddog.com (8.12.11/8.12.11) with ESMTP id j7CL6CFb015222;
	Fri, 12 Aug 2005 16:06:12 -0500
Received: (from kbohling@localhost)
	by hawk.birddog.com (8.12.11/8.12.11/Submit) id j7CL6Bn4015220;
	Fri, 12 Aug 2005 16:06:11 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0508121634570.12816@iabervon.org>
User-Agent: Mutt/1.4.1i
X-Scanned-By: MIMEDefang 2.15 (www dot roaringpenguin dot com slash mimedefang)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 12, 2005 at 04:46:34PM -0400, Daniel Barkalow wrote:
> On Fri, 12 Aug 2005, Wolfgang Denk wrote:
> 
> > This is somewhat off topic here, so I apologize, but  I  didn't  know
> > any better place to ask:
> > 
> > Has anybody any information if SourceForge is going to provide git  /
> > cogito / ... for the projects they host? I asked SF, and they openend
> > a new Feature Request (item #1252867); the message I received sounded
> > as if I was the first person on the planet to ask...
> > 
> > Am I really alone with this?
> 
> The git architecture makes the central server less important, and it's 
> easy to run your own. Also, kernel.org is providing space to a set of 
> people with a large overlap with git users, since git hasn't been 
> particularly publicized and kernel.org is hosting git.
> 

I don't think he wants sourceforge to host git, I think he'd like
sourceforge to provide access to source trees via git, instead of
cvs.  Read that as, I want to do:

git pull http://www.sourceforge.net/packageName

instead of:

cvs -d pserver:www.sourceforge.net co packageName

	While it might be easy to host your own project, Linus has some
infamous quote I'll paraphrase as "Real men don't make backups, they
upload to public FTP and let other's make backups...".

	I know if I was working on OSS project, I wouldn't be too
heartbroken to let someone else run the security, backup, and
general SA duties for me.  More time to write code that way...

    Kirby
