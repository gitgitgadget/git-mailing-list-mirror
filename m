From: Greg KH <greg@kroah.com>
Subject: Re: stgit 0.13 import mbox problems
Date: Thu, 23 Aug 2007 11:42:01 -0700
Message-ID: <20070823184201.GA17601@kroah.com>
References: <20070823092254.GA5976@kroah.com> <b0943d9e0708230319m3242f4a7yb4db1505f0d2e3@mail.gmail.com> <20070823164322.GC5528@kroah.com> <20070823183111.GB15684@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 20:49:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOHk8-0000wU-Hc
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 20:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765044AbXHWStQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 14:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765011AbXHWStQ
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 14:49:16 -0400
Received: from canuck.infradead.org ([209.217.80.40]:56503 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764988AbXHWStO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 14:49:14 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174] helo=localhost)
	by canuck.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1IOHjz-0000BI-M9; Thu, 23 Aug 2007 14:49:12 -0400
Content-Disposition: inline
In-Reply-To: <20070823183111.GB15684@fieldses.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56514>

On Thu, Aug 23, 2007 at 02:31:11PM -0400, J. Bruce Fields wrote:
> On Thu, Aug 23, 2007 at 09:43:22AM -0700, Greg KH wrote:
> > I really do like quilt, but wanted to see how well my current workflow
> > could be by using stgit as I'm constantly rebasing the main kernel
> > version against -git snapshots and sometimes that isn't frequent enough.
> 
> So just want to be able to rebase more than once a day?  Then why not
> just run quilt on top of git?  Pop off all your quilt patches, git pull,
> push them all back on again....

Yes, I can do that, but I already keep the patch set in a different git
tree, so that others can sync up with me at times.

I was just thinking that it might be easier to use stgit and then only
have to use one git tree to do everything, as this is what stgit is for
:)

Just always trying to see if I can make my life easier and help out with
making git better overall...

thanks,

greg k-h
