From: Greg KH <greg@kroah.com>
Subject: Re: cannot use stable 2.6.25.y tree with HTTP
Date: Wed, 18 Jun 2008 17:58:38 -0700
Message-ID: <20080619005838.GC15630@kroah.com>
References: <200806182037.m5IKboGC012108@pogo.cesa.opbu.xerox.com> <20080619000722.GA14270@kroah.com> <alpine.LFD.1.10.0806181725250.2907@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Klossner <andrew@cesa.opbu.xerox.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 03:01:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K98X8-0003ui-Kj
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 03:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756155AbYFSBA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 21:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756109AbYFSBA2
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 21:00:28 -0400
Received: from casper.infradead.org ([85.118.1.10]:40940 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757771AbYFSBAX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 21:00:23 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174] helo=localhost)
	by casper.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1K98VU-0007Qr-SZ; Thu, 19 Jun 2008 01:00:09 +0000
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806181725250.2907@woody.linux-foundation.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85439>

On Wed, Jun 18, 2008 at 05:26:19PM -0700, Linus Torvalds wrote:
> On Wed, 18 Jun 2008, Greg KH wrote:
> >
> > git developers, do I need to do something to get git-update-server-info
> > to run on kernel.org every time I do a push so that I don't have to do
> > it by hand (and then forget for new releases, like I did above?)
> 
> Just do the hook:
> 
> > I thought I remember a script somewhere telling me what to put into a
> > trigger in the git documentation a long time ago.
> > 
> > Oh, wait, is it just:
> > 	chmod +x my-git.git/hooks/post-update
> > 
> > as the core-tutorial.txt file shows?  Is that all that is needed?
> 
> Indeed.

Great, I've now done that on all -stable trees that I can on kernel.org.

Andrew, please let me know if you have problems with this in the future,
sorry for the mess.

thanks,

greg k-h
