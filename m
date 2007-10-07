From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: git fetch -- double fetch
Date: Sun, 7 Oct 2007 22:44:33 +0100
Message-ID: <20071007214433.GA30833@shadowen.org>
References: <20071006185759.GE28610@shadowen.org> <Pine.LNX.4.64.0710071728570.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 07 23:45:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iedva-0007K3-H9
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 23:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755772AbXJGVog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 17:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755472AbXJGVog
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 17:44:36 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:4309 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754841AbXJGVof (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 17:44:35 -0400
Received: from 85-210-7-254.dsl.pipex.com ([85.210.7.254] helo=localhost.localdomain)
	by hellhawk.shadowen.org with esmtpa (Exim 4.50)
	id 1IedvN-0005a4-RV; Sun, 07 Oct 2007 22:44:34 +0100
Received: from localhost ([127.0.0.1] helo=pinky)
	by localhost.localdomain with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1IedvN-0000SK-DT; Sun, 07 Oct 2007 22:44:33 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710071728570.4174@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Received-SPF: none
X-SPF-Guess: neutral
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60224>

On Sun, Oct 07, 2007 at 05:29:38PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 6 Oct 2007, Andy Whitcroft wrote:
> 
> > I have recently been seeing repeated fetching of some branches.  I feel
> > this has happened in at least three of my repos on three distinct
> > projects:
> > 
> > apw@pinky$ git fetch origin
> > remote: Generating pack...
> > remote: Done counting 5 objects.
> > remote: Deltifying 5 objects...
> > remote:  100% (5/5) done
> > Unpacking 5 objects...
> > remote: Total 5 (delta 0), reused 0 (delta 0)
> >  100% (5/5) done
> > * refs/remotes/origin/master: fast forward to branch 'master' of ssh://git@abat-dev/var/www/git/abat
> >   old..new: ce046f0..41c9dde
> > * refs/remotes/origin/master: fast forward to branch 'master' of ssh://git@abat-dev/var/www/git/abat
> >   old..new: ce046f0..41c9dde
> 
> What does "git config --get-all remote.origin.fetch" say?

apw@pinky$ git config --get-all remote.origin.fetch
+refs/heads/master:refs/remotes/origin/master
+refs/heads/*:refs/remotes/origin/*
apw@pinky$

I don't think that I did anything to this config, I think that is what
the clone setup for me.

-apw
