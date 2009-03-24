From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: branch ahead in commits but push claims all up to date
Date: Tue, 24 Mar 2009 13:13:03 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903241304090.19665@iabervon.org>
References: <7001b7a00903240821v2155d234x6a10c80a3e987acb@mail.gmail.com>  <7001b7a00903240822w70a57349xcc66a02cef62dc70@mail.gmail.com> <43d8ce650903240918q2ffdba44w241e0f378a11fd3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Irene Ros <imirene@gmail.com>, git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 18:15:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmAD8-0006Lt-2E
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 18:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760241AbZCXRNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 13:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758013AbZCXRNJ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 13:13:09 -0400
Received: from iabervon.org ([66.92.72.58]:52838 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756797AbZCXRNH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 13:13:07 -0400
Received: (qmail 1536 invoked by uid 1000); 24 Mar 2009 17:13:03 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Mar 2009 17:13:03 -0000
In-Reply-To: <43d8ce650903240918q2ffdba44w241e0f378a11fd3d@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114474>

On Tue, 24 Mar 2009, John Tapsell wrote:

> 2009/3/24 Irene Ros <imirene@gmail.com>:
> > Hi all,
> >
> > I've been using git for some time now and haven't run into this issue
> > before, perhaps someone else here has:
> >
> > I have a branch that is ahead of its origin by a few commits:
> >
> > $ git status
> > # On branch myBranch
> > # Your branch is ahead of 'origin/myBranch' by 10 commits.
> 
> Tried running: git fetch   ?
> 
> For some weird reason  "git push origin mybranch"  doesn't actually
> update origin/mybranch.  It's more annoying :-)

It should, so long as you're using the native transport and 
origin/mybranch actually tracks mybranch on origin.

"git push" doesn't update it, but the code that implements the native 
transport does update it if it succeeds.

(Actually, I'm not 100% sure that, if you update origin through some other 
channel with exactly the commit that you now have in mybranch locally, and 
then try the push, it will update the local tracking for that branch; is 
that what you've hit?)

	-Daniel
*This .sig left intentionally blank*
