From: Jeff King <peff@peff.net>
Subject: Re: Centralized repository
Date: Sun, 25 Feb 2007 01:04:00 -0500
Message-ID: <20070225060400.GB17031@coredump.intra.peff.net>
References: <EF7846A2-C573-4018-B399-EBBEEE2812A4@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: bob <kranki@mac.com>
X-From: git-owner@vger.kernel.org Sun Feb 25 07:04:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLCUk-00051T-4o
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 07:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933668AbXBYGEN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 01:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933669AbXBYGEM
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 01:04:12 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3104 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933668AbXBYGEE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 01:04:04 -0500
Received: (qmail 26631 invoked from network); 25 Feb 2007 01:04:14 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 25 Feb 2007 01:04:14 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Feb 2007 01:04:00 -0500
Content-Disposition: inline
In-Reply-To: <EF7846A2-C573-4018-B399-EBBEEE2812A4@mac.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40535>

On Sat, Feb 24, 2007 at 09:14:27PM -0500, bob wrote:

> Anyway, for this one repository, I would really like GIT to support  
> the CVS/SVN central repository system.  The rest of the time, I am  
> quite happy with GIT's distributed system even though all of my  
> repositories are really just for me.

For a while I was running git with an 80-gig repository of media files.
I found it useful to network mount the central git repo (I used SMB),
and clone to the local machine using alternates (i.e., "git clone -s
/net/mounted/git /local/git").  It should work as a normal git repo,
except that all object accesses will transparently go over the network,
which obviously slows things down a bit (but no slower than CVS!).

You should be able to pack at your size of repo (I obviously couldn't,
but I was working with a few very large files, so the overhead wasn't
too bad).

HTH,
-Peff
