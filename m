From: Josef Wolf <jw@raven.inka.de>
Subject: Re: How to sync two svn repositories via git?
Date: Thu, 2 Apr 2009 12:36:59 +0200
Message-ID: <20090402103659.GB28619@raven.wolf.lan>
References: <20090401223052.GA28619@raven.wolf.lan> <49D46C2B.3080100@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 02 12:41:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpKMi-0002Dy-Fo
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 12:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759573AbZDBKkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 06:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757747AbZDBKkM
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 06:40:12 -0400
Received: from quechua.inka.de ([193.197.184.2]:48509 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757246AbZDBKkL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 06:40:11 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1LpKLA-0007Tf-GW; Thu, 02 Apr 2009 12:40:08 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 0C6EA2CBDE; Thu,  2 Apr 2009 12:36:59 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <49D46C2B.3080100@drmicha.warpmail.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115454>

On Thu, Apr 02, 2009 at 09:41:31AM +0200, Michael J Gruber wrote:
> Josef Wolf venit, vidit, dixit 02.04.2009 00:30:
[ ... ]
> > The first step I'd like to do is to "mirror" the manual merges that were
> > done between the subversion repositories in the past:
> > 
> >     git checkout svn-first
> >     git merge -s ours --log commit-of-the-first-merge-in-svn-second
> > 
> >     git checkout svn-second
> >     git merge -s ours --log commit-of-the-first-merge-in-svn-first
> > 
> > This seems to work, but git-gui shows conflicts.  How can I get conflicts
> > when I use the "-s ours" merge strategy?
> 
> What do git status and git diff (--stat, --combined) say?

Umm, that's somewhat odd.

Directly after the merge commands, gitk says there are local modifications.
Then I run "git status" which says the working directory is clean.  Then
I re-run gitk, which _now_ shows no local modifications any more.
