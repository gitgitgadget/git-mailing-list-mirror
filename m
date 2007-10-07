From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git fetch -- double fetch
Date: Sun, 7 Oct 2007 17:29:38 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710071728570.4174@racer.site>
References: <20071006185759.GE28610@shadowen.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andy Whitcroft <apw@shadowen.org>
X-From: git-owner@vger.kernel.org Sun Oct 07 18:30:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeZ12-0004H2-Hn
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 18:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbXJGQ34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 12:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbXJGQ3z
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 12:29:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:43384 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751588AbXJGQ3z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 12:29:55 -0400
Received: (qmail invoked by alias); 07 Oct 2007 16:29:53 -0000
Received: from unknown (EHLO [172.17.38.182]) [38.99.84.33]
  by mail.gmx.net (mp018) with SMTP; 07 Oct 2007 18:29:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19fq08oFJxfp99CiMRmP0MB1STZh/aNAcMZ+xtKFt
	cLHO9+zBbcS1KK
X-X-Sender: gene099@racer.site
In-Reply-To: <20071006185759.GE28610@shadowen.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60195>

Hi,

On Sat, 6 Oct 2007, Andy Whitcroft wrote:

> I have recently been seeing repeated fetching of some branches.  I feel
> this has happened in at least three of my repos on three distinct
> projects:
> 
> apw@pinky$ git fetch origin
> remote: Generating pack...
> remote: Done counting 5 objects.
> remote: Deltifying 5 objects...
> remote:  100% (5/5) done
> Unpacking 5 objects...
> remote: Total 5 (delta 0), reused 0 (delta 0)
>  100% (5/5) done
> * refs/remotes/origin/master: fast forward to branch 'master' of ssh://git@abat-dev/var/www/git/abat
>   old..new: ce046f0..41c9dde
> * refs/remotes/origin/master: fast forward to branch 'master' of ssh://git@abat-dev/var/www/git/abat
>   old..new: ce046f0..41c9dde

What does "git config --get-all remote.origin.fetch" say?

Ciao,
Dscho
