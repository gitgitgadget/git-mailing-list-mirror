From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Repository backups
Date: Wed, 19 Sep 2007 16:27:53 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709191627040.28395@racer.site>
References: <31e9dd080709190814t6ef8b725w8a8320685e70578b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jason Sewall <jasonsewall@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 17:29:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IY1Tv-0006W4-0R
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 17:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145AbXISP2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 11:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753437AbXISP2p
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 11:28:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:34623 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752953AbXISP2o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 11:28:44 -0400
Received: (qmail invoked by alias); 19 Sep 2007 15:28:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp004) with SMTP; 19 Sep 2007 17:28:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+1f3ooRhq1z6OaOJUoEz/604tecZq1hA6EWjUeTX
	k2/rlQCUxNigfC
X-X-Sender: gene099@racer.site
In-Reply-To: <31e9dd080709190814t6ef8b725w8a8320685e70578b@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58714>

Hi,

On Wed, 19 Sep 2007, Jason Sewall wrote:

> I'd like to build a modest safety net for my various git repositories
> in case of catastrophic failure. Currently, everything is backed up on
> machines in the same building. I'm not expecting the Computer Science
> building to get hit by terrorists and we're in a seismically stable
> place, but there *is* construction nearby...
> 
> Anyway, my university offers a "mass storage" tape-based service that
> is supposedly very safe. We are encouraged to give them single big
> files for backups.
> 
> The temptation to just make bundles of all branch heads is great but
> probably not what I really want - things like reflogs don't get handed
> off with those, if I understand correctly.
> 
> Is there any argument against just making a tar of a bare clone of the
> repo?

If you make a bare clone, you lose reflogs, too.

So I would backup the complete .git/ directory instead.

Hth,
Dscho
