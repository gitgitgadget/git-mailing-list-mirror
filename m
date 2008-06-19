From: Greg KH <greg@kroah.com>
Subject: Re: cannot use stable 2.6.25.y tree with HTTP
Date: Wed, 18 Jun 2008 17:07:22 -0700
Message-ID: <20080619000722.GA14270@kroah.com>
References: <200806182037.m5IKboGC012108@pogo.cesa.opbu.xerox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Andrew Klossner <andrew@cesa.opbu.xerox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 02:09:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K97iU-0007lK-SZ
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 02:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755560AbYFSAIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 20:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755553AbYFSAIf
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 20:08:35 -0400
Received: from casper.infradead.org ([85.118.1.10]:54801 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835AbYFSAIf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 20:08:35 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174] helo=localhost)
	by casper.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1K97hP-0006ok-S5; Thu, 19 Jun 2008 00:08:24 +0000
Content-Disposition: inline
In-Reply-To: <200806182037.m5IKboGC012108@pogo.cesa.opbu.xerox.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85429>

On Wed, Jun 18, 2008 at 01:37:50PM -0700, Andrew Klossner wrote:
> Hi Greg,
> 
> At the risk of being a pest, I'm following up on my note of last week
> about how the stable-2.6.25.y tree is frozen at 2.6.25.4 when accessed
> via HTTP.  That's the only protocol I can use, and so I cannot pull
> the newer versions.  Is there any hope of fixing this?
> 
> % git pull -v
> >From http://www.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.25.y
>  = [up to date]      master     -> origin/master
> Already up-to-date.
> 
> % ls .git/refs/tags/v2.6.25.*
> .git/refs/tags/v2.6.25.1  .git/refs/tags/v2.6.25.3
> .git/refs/tags/v2.6.25.2  .git/refs/tags/v2.6.25.4

Argh, this is getting annoying.

git developers, do I need to do something to get git-update-server-info
to run on kernel.org every time I do a push so that I don't have to do
it by hand (and then forget for new releases, like I did above?)

I thought I remember a script somewhere telling me what to put into a
trigger in the git documentation a long time ago.

Oh, wait, is it just:
	chmod +x my-git.git/hooks/post-update

as the core-tutorial.txt file shows?  Is that all that is needed?

thanks,

greg k-h
