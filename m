From: Greg KH <greg@kroah.com>
Subject: Re: stgit 0.13 import mbox problems
Date: Thu, 23 Aug 2007 11:47:58 -0700
Message-ID: <20070823184758.GB17601@kroah.com>
References: <20070823092254.GA5976@kroah.com> <20070823180633.GA24530@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Thu Aug 23 20:49:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOHk9-0000wU-2L
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 20:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765090AbXHWStS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 14:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765053AbXHWStS
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 14:49:18 -0400
Received: from canuck.infradead.org ([209.217.80.40]:56506 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764988AbXHWStQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 14:49:16 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174] helo=localhost)
	by canuck.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1IOHk2-0000BK-JD; Thu, 23 Aug 2007 14:49:15 -0400
Content-Disposition: inline
In-Reply-To: <20070823180633.GA24530@filer.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56515>

On Thu, Aug 23, 2007 at 02:06:33PM -0400, Josef Sipek wrote:
> On Thu, Aug 23, 2007 at 02:22:54AM -0700, Greg KH wrote:
> > Hi,
> > 
> > I wanted to see if I could start using stgit instead of quilt, so I
> > tried to import my current set of kernel patches.
>  
> May I suggest you give guilt [1,2] a spin? It uses the same quilt-like
> patch directory format so things should Just Work(tm).

Nice, I didn't realize this was still being worked on.

Hm, is there an "easy" way to take a current tree of quilt patches
(like, say 177 of them) and import them into guilt?  After reading the
guilt documentation I didn't see a way to do it, but I might have missed
something.

Also, this looks exactly like stgit in a way, can anyone point me at the
differences, or is this just two different projects being done by two
different groups/people to do the same thing?  If so, that's fine, just
curious.

thanks,

greg k-h
