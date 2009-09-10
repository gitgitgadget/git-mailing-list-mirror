From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What's cooking in git.git (Sep 2009, #02; Mon, 07)
Date: Thu, 10 Sep 2009 13:55:28 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0909101317230.28290@iabervon.org>
References: <7vtyzexnhm.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0909101206540.28290@iabervon.org> <alpine.DEB.1.00.0909101852080.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 10 19:55:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mlnrr-0004ku-Lh
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 19:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbZIJRz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 13:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752146AbZIJRzZ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 13:55:25 -0400
Received: from iabervon.org ([66.92.72.58]:60768 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751070AbZIJRzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 13:55:25 -0400
Received: (qmail 20386 invoked by uid 1000); 10 Sep 2009 17:55:28 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Sep 2009 17:55:28 -0000
In-Reply-To: <alpine.DEB.1.00.0909101852080.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128128>

On Thu, 10 Sep 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Thu, 10 Sep 2009, Daniel Barkalow wrote:
> 
> > I'm pretty sure that there were no objections to 'Make the 
> > "traditonally-supported"...' patch,
> 
> Well, there were.  By me.
> 
> There is a reason why you call the series "foreign" vcs helpers.  And 
> that's because it would be very wrong to pretend that they are the rule, 
> and the current URL schemes the exception.  Very wrong, indeed.

The current URL scheme *is* an "exception" to the "rule" that all remotes 
are foreign, or the current "rule" that all remotes are ssh-style. Any 
patterns that we currently support are handled by recognizing a particular 
pattern (starts with "git://", starts with "rsync://", starts with 
"https://", is a local file, is a local directory, etc), so they're all 
special cases. They're further special cases by virtue of the fact that 
the code to handle them is in the git distribution.

	-Daniel
*This .sig left intentionally blank*
