From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: RCS keyword expansion
Date: Thu, 11 Oct 2007 21:21:03 +0200
Message-ID: <20071011192103.GD2804@steel.home>
References: <Pine.LNX.4.64.0710111542420.23849@ds9.cixit.se> <86fy0hvgbh.fsf@blue.stonehenge.com> <Pine.LNX.4.62.0710111953460.7441@perkele.intern.softwolves.pp.se>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Oct 11 21:21:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig3au-0004us-Mh
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 21:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176AbXJKTVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 15:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753080AbXJKTVG
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 15:21:06 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:34121 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628AbXJKTVF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 15:21:05 -0400
Received: from tigra.home (Fa9eb.f.strato-dslnet.de [195.4.169.235])
	by post.webmailer.de (mrclete mo8) (RZmta 13.4)
	with ESMTP id f00c78j9BGWjpm ; Thu, 11 Oct 2007 21:21:03 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 44348277AE;
	Thu, 11 Oct 2007 21:21:03 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 1C06DC50A; Thu, 11 Oct 2007 21:21:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0710111953460.7441@perkele.intern.softwolves.pp.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2hcNrESpw=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60626>

Peter Karlsson, Thu, Oct 11, 2007 19:55:05 +0200:
> >That's not a job for a source code manager to do.  It's a job for your 
> >build/install tool.
> 
> Since there is no build step involved (my web site is just a CVS checkout 
> at the moment), it's a job for the checkout step. I'd really want to avoid 
> having a separate copy of the web site just so that I can do a "make 
> install".

That's confusing. If your web site is just a checkout, what is the
"make install" for? If it is a repo, you have the version information
anyway, and at all times.

And if this extra step is indeed present, why can't the "make install"
just save the HEAD somewhere for later reference?

> That would sort of negate the savings in disk space I hope seeing 
> by moving from CVS to Git.

You'll find you have plenty of savings for anything.
