From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix the MacOS X compile of gitk by pinching po2msg.sh
 from git-gui
Date: Wed, 9 Jan 2008 14:06:54 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801091404040.31053@racer.site>
References: <20080109132953.GA12489@hashpling.org> <alpine.LSU.1.00.0801091339390.31053@racer.site> <20080109135249.GA12869@hashpling.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Wed Jan 09 15:07:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCbaW-0005Ox-Aw
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 15:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbYAIOG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 09:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbYAIOG5
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 09:06:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:42452 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751986AbYAIOG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 09:06:57 -0500
Received: (qmail invoked by alias); 09 Jan 2008 14:06:55 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp049) with SMTP; 09 Jan 2008 15:06:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/dWOMKKgTdRI5yjRlrcwdM2izOILLbKEwRTOSXH8
	xe5JggywE3MYNa
X-X-Sender: gene099@racer.site
In-Reply-To: <20080109135249.GA12869@hashpling.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69994>

Hi,

On Wed, 9 Jan 2008, Charles Bailey wrote:

> On Wed, Jan 09, 2008 at 01:40:46PM +0000, Johannes Schindelin wrote:
> 
> > On Wed, 9 Jan 2008, Charles Bailey wrote:
> > 
> > > --- snip ---
> > 
> > Since gitk and git-gui are separate projects (pulled at irregular 
> > intervals into git.git), your patch looks sane, but would be better 
> > done as a patch against gitk.git.
> 
> I'm sorry, I think I knew this once, but had forgotten.

Oh, my critique was not meant as harsh as it was apparently received: for 
reviewing purposes, your way was perfect, as it shows your intent better 
than the technically correct patch.

All I'm saying is that you should send the (verbose) patch, too, possibly 
referring to the smaller patch in the space between the three dashes and 
the diffstat.

(I would also prefix this patch with "gitk:", instead of writing "of 
gitk", so that people reading the log of git.git get a better idea what 
this is about.)

Ciao,
Dscho
