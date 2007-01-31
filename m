From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Wed, 31 Jan 2007 00:09:42 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701302331440.20138@iabervon.org>
References: <87odognuhl.wl%cworth@cworth.org> <Pine.LNX.4.64.0701301853300.20138@iabervon.org>
 <Pine.LNX.4.64.0701302052230.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jan 31 06:09:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HC7j8-0000WK-RF
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 06:09:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666AbXAaFJo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 00:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752181AbXAaFJo
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 00:09:44 -0500
Received: from iabervon.org ([66.92.72.58]:1995 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752172AbXAaFJn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 00:09:43 -0500
Received: (qmail 23002 invoked by uid 1000); 31 Jan 2007 00:09:42 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Jan 2007 00:09:42 -0500
In-Reply-To: <Pine.LNX.4.64.0701302052230.3021@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38229>

On Tue, 30 Jan 2007, Nicolas Pitre wrote:

> On Tue, 30 Jan 2007, Daniel Barkalow wrote:
> 
> >   warning: you are now browsing the history without a local branch. You 
> >   will not be able to commit changes unless you create a new local branch 
> >   with "git checkout -b <new_branch_name>".
> 
> This isn't true.  You can commit on top of a detached head.  In fact you 
> can do almost anything.

"Commits you make will not be attached to permanent state unless you 
create a local branch"? I'm not sure how the feature turned out to work, 
but I know that (a) you're fine if you don't make any commits and (b) the 
behavior is more like what happens with anonymous checkouts of other 
people's repositories in non-distributed SCMs, so people will tend to
underestimate what they can do with this, rather than overestimating it 
and getting into trouble.

I suppose it's reasonable to warn at commit time, if we ended up going 
with allowing commits like normal.

	-Daniel
*This .sig left intentionally blank*
