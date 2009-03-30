From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-gui: make "Git GUI Here" Explorer extension more
 robust
Date: Mon, 30 Mar 2009 10:03:31 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0903301001090.7534@intel-tinevez-2-302>
References: <200903300030.03733.markus.heidelberg@web.de> <alpine.DEB.1.00.0903300243050.6454@intel-tinevez-2-302> <200903300851.43164.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 30 10:06:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoCUW-0008JZ-UV
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 10:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbZC3IDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 04:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752527AbZC3IDg
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 04:03:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:35125 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752202AbZC3IDf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 04:03:35 -0400
Received: (qmail invoked by alias); 30 Mar 2009 08:03:32 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp049) with SMTP; 30 Mar 2009 10:03:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+cel48wxmc5oGwukcPwcKCmF3agcnuNYHHyR1Z6J
	WzV04d+jj6/8Zd
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <200903300851.43164.markus.heidelberg@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115102>

Hi,

On Mon, 30 Mar 2009, Markus Heidelberg wrote:

> Johannes Schindelin, 30.03.2009:
> 
> > On Mon, 30 Mar 2009, Markus Heidelberg wrote:
> > 
> > > Starting git-gui via Windows Explorer shell extension caused 
> > > problems when not started from the project directory, but from a 
> > > directory within the project: starting the Explorer from the git-gui 
> > > menu "Explore Working Copy" didn't work then.
> > > 
> > > Starting git-gui via Explorer shell extension from the .git 
> > > directory didn't work at all.
> > > 
> > > To make these things possible, "cd .." until we see .git/
> > 
> > How does this interact with GIT_WORK_TREE?
> 
> Not sure. What's the use case for a globally set GIT_WORK_TREE, how is 
> it used?

You can call git gui with a non-global GIT_WORK_TREE by something like 
this, even on Windows (which your patch does not special case, anyway):

	$ GIT_WORK_TREE=/bla/blub git gui

> > And with bare repositories?
> 
> Git-gui doesn't seem to work with bare repositories, I get
> "Cannot use funny .git directory: ."
> when started on the command line.

Oh?  I thought there was some discussion recently that was explicitely 
about git gui with bare repositories.  But I have to time-share my brain 
these days, so my memory might well show some bit flips.

Ciao,
Dscho
