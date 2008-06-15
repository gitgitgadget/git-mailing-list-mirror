From: Allan Wind <allan_wind@lifeintegrity.com>
Subject: Re: gc changes permissions of files
Date: Sun, 15 Jun 2008 03:10:57 -0400
Message-ID: <20080615071057.GA15713@lifeintegrity.com>
References: <20080615035917.GA13414@lifeintegrity.com> <alpine.DEB.1.00.0806150551010.6439@racer> <20080615062736.GC14357@lifeintegrity.com> <20080615064133.GE14357@lifeintegrity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 15 09:12:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7mPN-0007ub-K8
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 09:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279AbYFOHK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 03:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753356AbYFOHK7
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 03:10:59 -0400
Received: from aeol.lifeintegrity.com ([209.135.157.90]:52883 "EHLO
	lifeintegrity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032AbYFOHK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 03:10:58 -0400
Received: from vent.lifeintegrity.com (pool-71-174-251-18.bstnma.fios.verizon.net [71.174.251.18])
	by submission.lifeintegrity.com (Postfix) with ESMTP id EFF8ED5C82F;
	Sun, 15 Jun 2008 07:10:57 +0000 (UTC)
Received: by vent.lifeintegrity.com (Postfix, from userid 1000)
	id 6E4DE30436E; Sun, 15 Jun 2008 03:10:57 -0400 (EDT)
Mail-Followup-To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <20080615064133.GE14357@lifeintegrity.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85068>

On 2008-06-15T02:41:33-0400, Allan Wind wrote:
> On 2008-06-15T02:27:36-0400, Allan Wind wrote:
> > I seem to recall that push to the repository also introduces files without
> > group write permission.  Unfortunately it looks something broke when I ran
> > gc.  Any help in getting my repository back up would be appreciated:
> > 
> > allan@vent:~/var/git/www2$ git clone ssh://pawan.localnet./var/lib/git/www.git
> > Initialized empty Git repository in /home/allan/var/git/www2/www/.git/
> > fatal: git-upload-pack: cannot find object 56032c4f35fd39fe4151fca2d010d299a8901101:
> > fatal: The remote end hung up unexpectedly
> > fetch-pack from 'ssh://pawan.localnet./var/lib/git/www.git' failed.
> 
> # git fsck
> dangling commit 2b0da4aabfba6c61baf9f351b2dfbd5a88a8a999
> 
> Re-running this returns the same dangling commit, so fsck does not seem 
> to fix anything.

Looking at the log I see that 56032c4f35fd39fe4151fca2d010d299a8901101 is HEAD on orgin,
and 2b0da4aabfba6c61baf9f351b2dfbd5a88a8a999 is what I tried to commit 
when I got the initially error.  I will catch the howto when git.or.cz 
is back online.  If anyone wants some data before I try to fix my 
repository please let me know soon.


/Allan
