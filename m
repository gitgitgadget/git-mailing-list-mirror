From: John Goerzen <jgoerzen@complete.org>
Subject: Re: git-relink doesn't work on bare repos
Date: Tue, 4 Mar 2008 09:19:19 -0600
Message-ID: <200803040919.19641.jgoerzen@complete.org>
References: <slrnfsp5vi.sa5.jgoerzen@katherina.lan.complete.org> <200803040834.14099.jgoerzen@complete.org> <alpine.LSU.1.00.0803041501500.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 04 16:20:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWYwJ-0006Dz-Ft
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 16:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758978AbYCDPT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 10:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758933AbYCDPT0
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 10:19:26 -0500
Received: from gatekeeper.excelhustler.com ([69.44.136.67]:48268 "EHLO
	excelhustler.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757978AbYCDPTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 10:19:25 -0500
Received: from jgoerzen by wile.internal.excelhustler.com with local (Exim 4.68)
	(envelope-from <jgoerzen@complete.org>)
	id 1JWYvH-0005kp-Lc; Tue, 04 Mar 2008 09:19:19 -0600
User-Agent: KMail/1.9.7
In-Reply-To: <alpine.LSU.1.00.0803041501500.22527@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76099>

On Tue March 4 2008 9:03:15 am Johannes Schindelin wrote:
> Hi,
>
> On Tue, 4 Mar 2008, John Goerzen wrote:
> > On Tue March 4 2008 1:09:59 am Sean wrote:
> > > repos follow the general naming convention of ending in .git relink
> > > will work.  That is, if your bare repos are named repo.git rather than
> > > just repo.
> >
> > I never do that because I think it's silly to have to type .git
> > everytime ;-)
>
> Well, it is a convention, and if you choose not to follow it, that's what
> you get.

That's not documented anywhere.

I mean, git is plubming, right?  I should be able to call it myrepo.exe if I 
like, and as long as it has a .git dir with stuff in it, or is bare, it 
should just work.

> > If I give people a git:// url, they already know it's a Git repo, I
> > figure.
>
> So you must use "--git-dir" _everytime_ you are working with Git inside
> the repo.

That's not been my experience.  In fact, I can 'git log' quite happily inside 
a bare repo.  Why on earth should git-relink care what I have named my repo?  
It's not like git clone, push, pull, or anything else cares.

-- John
