From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to commit removed file?
Date: Tue, 2 Jan 2007 22:12:33 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701022211100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061231102444.GD26552@mellanox.co.il> <20070102201041.GB10451@mellanox.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 22:13:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1qwc-0006Qm-72
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 22:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755403AbXABVMj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 16:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755409AbXABVMj
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 16:12:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:43862 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754973AbXABVMh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 16:12:37 -0500
Received: (qmail invoked by alias); 02 Jan 2007 21:12:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 02 Jan 2007 22:12:36 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
In-Reply-To: <20070102201041.GB10451@mellanox.co.il>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35817>

Hi,

On Tue, 2 Jan 2007, Michael S. Tsirkin wrote:

> > I'd like to remove a file and commit the removal while
> > leaving out other changes in repository/index.
> > 
> > $git rm kernel_patches/fixes/ib_verbs_warning_fix.patch
> > rm 'kernel_patches/fixes/ib_verbs_warning_fix.patch'
> > 
> > $ git commit kernel_patches/fixes/ib_verbs_warning_fix.patch
> > error: pathspec 'kernel_patches/fixes/ib_verbs_warning_fix.patch' did not match
> > any file(s) known to git.
> > Did you forget to 'git add'?
> > 
> > A similiar thing works with "git add".
> 
> Any ideas? Can this be done with git?

Did you actually try the "--" thing I suggested in 
http://article.gmane.org/gmane.comp.version-control.git/35699/?

Besides, I just tested with current "next": 

$ git commit kernel_patches/fixes/ib_verbs_warning_fix.patch
Created commit 89a5bb5ac16fb8be9b6e061284e191cafb3e4da2
 1 files changed, 0 insertions(+), 22 deletions(-)
 delete mode 100644 a234
