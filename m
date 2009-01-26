From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Common ancestor in merge diffs?
Date: Mon, 26 Jan 2009 14:06:48 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901261402120.19665@iabervon.org>
References: <alpine.LNX.1.00.0901261318030.19665@iabervon.org> <alpine.DEB.1.00.0901261958320.25749@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 26 20:13:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRWp9-0006n1-Vr
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 20:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234AbZAZTGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 14:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753417AbZAZTGv
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 14:06:51 -0500
Received: from iabervon.org ([66.92.72.58]:55579 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752905AbZAZTGu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 14:06:50 -0500
Received: (qmail 27089 invoked by uid 1000); 26 Jan 2009 19:06:48 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Jan 2009 19:06:49 -0000
In-Reply-To: <alpine.DEB.1.00.0901261958320.25749@intel-tinevez-2-302>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107251>

On Mon, 26 Jan 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 26 Jan 2009, Daniel Barkalow wrote:
> 
> > I was just doing an annoying merge (I'd reorganized code while other 
> > people made changes to it), and I kept having the problem that it was hard 
> > to figure out what each side had done. Is there some way to ask git for 
> > the diffs between the common ancestor (which is unique in my case, so it's 
> > actually useful) and each of the sides of the merge?
> 
> How about
> 
> 	git diff HEAD...MERGE_HEAD
> 
> and
> 
> 	git diff MERGE_HEAD...HEAD
> 
> ?  I might have misunderstood, though.

That's definitely helpful information (and I'd forgotten about it; I was 
only thinking of the index). It would be helpful to get it in --cc form, 
though, rather than as two independant diffs. And it seems somewhat 
wasteful or something to not use the information in the index, although 
it's hard to get worked up about with git being blindingly fast anyway.

	-Daniel
*This .sig left intentionally blank*
