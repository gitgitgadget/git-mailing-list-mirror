From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: stgit 0.13 import mbox problems
Date: Thu, 23 Aug 2007 15:23:33 -0400
Message-ID: <20070823192333.GA7269@filer.fsl.cs.sunysb.edu>
References: <20070823092254.GA5976@kroah.com> <20070823180633.GA24530@filer.fsl.cs.sunysb.edu> <20070823184758.GB17601@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
To: Greg KH <greg@kroah.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 21:24:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOIHo-0006jv-99
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 21:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbXHWTXj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 15:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752678AbXHWTXj
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 15:23:39 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:49151 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621AbXHWTXi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 15:23:38 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l7NJNYKA007582;
	Thu, 23 Aug 2007 15:23:34 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l7NJNXYb007580;
	Thu, 23 Aug 2007 15:23:33 -0400
X-Authentication-Warning: filer.fsl.cs.sunysb.edu: jsipek set sender to jsipek@fsl.cs.sunysb.edu using -f
Content-Disposition: inline
In-Reply-To: <20070823184758.GB17601@kroah.com>
User-Agent: Mutt/1.5.16 (2007-07-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56518>

On Thu, Aug 23, 2007 at 11:47:58AM -0700, Greg KH wrote:
> On Thu, Aug 23, 2007 at 02:06:33PM -0400, Josef Sipek wrote:
> > On Thu, Aug 23, 2007 at 02:22:54AM -0700, Greg KH wrote:
> > > Hi,
> > > 
> > > I wanted to see if I could start using stgit instead of quilt, so I
> > > tried to import my current set of kernel patches.
> >  
> > May I suggest you give guilt [1,2] a spin? It uses the same quilt-like
> > patch directory format so things should Just Work(tm).
> 
> Nice, I didn't realize this was still being worked on.
 
Heh, I just noticed this...guilt is younger than stgit - and was created
because of how stgit stores the patches. :)

Josef 'Jeff' Sipek.

-- 
If I have trouble installing Linux, something is wrong. Very wrong.
		- Linus Torvalds
