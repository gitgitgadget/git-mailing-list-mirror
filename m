From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: warning: no common commits - slow pull
Date: Tue, 26 Feb 2008 18:45:55 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802261832550.19665@iabervon.org>
References: <200802102007.38838.lenb@kernel.org> <20080211035501.GB26205@mit.edu> <200802151643.30232.lenb@kernel.org> <200802261438.17014.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Theodore Tso <tytso@mit.edu>,
	git@vger.kernel.org
To: Len Brown <lenb@kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 27 00:46:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU9VJ-0004K0-Mu
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 00:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbYBZXp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 18:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbYBZXp6
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 18:45:58 -0500
Received: from iabervon.org ([66.92.72.58]:36598 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751122AbYBZXp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 18:45:57 -0500
Received: (qmail 2959 invoked by uid 1000); 26 Feb 2008 23:45:55 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Feb 2008 23:45:55 -0000
In-Reply-To: <200802261438.17014.lenb@kernel.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75192>

On Tue, 26 Feb 2008, Len Brown wrote:

> On Friday 15 February 2008, Len Brown wrote:
> > it happened again.
> > 
> > this morning I pulled linus' tree up through 
> > 4ee29f6a52158cea526b16a44ae38643946103ec
> > 
> > then during the day, linus declared "rc2".
> > 
> > and now I pulled linus' tree again,
> > which has a HEAD now of 
> > 
> > 101142c37be8e5af9b847860219217e6b958c739
> > 
> > and the pull sucked down 172 MB even though the uncompressed
> > diff between the two is 0.3 MB.
> > 
> > -Len
> > 
> > [lenb@d975xbx2 linus (master)]$ git pull
> > remote: Counting objects: 649, done.
> > remote: Compressing objects: 100% (106/106), done.
> > remote: Total 513 (delta 417), reused 503 (delta 407)
> > Receiving objects: 100% (513/513), 116.67 KiB, done.
> > Resolving deltas: 100% (417/417), completed with 103 local objects.
> > warning: no common commits
> > remote: Counting objects: 710725, done.
> > remote: Compressing objects: 100% (125738/125738), done.
> > remote: Total 710725 (delta 589584), reused 704450 (delta 584029)
> > Receiving objects: 100% (710725/710725), 172.71 MiB | 1073 KiB/s, done.
> > Resolving deltas: 100% (589584/589584), done.
> > From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
> >  * [new tag]         v2.6.25-rc2 -> v2.6.25-rc2
> > Updating 4ee29f6..101142c
> > Fast forward
> >  Makefile                               |    4 +-
> ...
> > [lenb@d975xbx2 linus (master)]$            
> > [lenb@d975xbx2 linus (master)]$ git --version
> > git version 1.5.4.1.122.gaa8d
> 
> It still happens with latest git. (linus has declared -rc3 this time)
> unfortunately for me, i'm not on broadband this time so it is extremely painful --
> to the point that i simply can't update this tree until i get home.

The workaround, so far as I know, is to hit ^C and do it again; the second 
time it will fetch 1 object (the actual tag) instead of 700000. If that's 
not the case, I'm even more confused about what's going on. And if you 
notice Linux tagging something before you pull, it would be great if you 
could capture the contents of .git/refs/ before you pull and send it to me 
if it does this.

	-Daniel
*This .sig left intentionally blank*
