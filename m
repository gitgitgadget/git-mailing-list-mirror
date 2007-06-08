From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach filter-branch about subdirectory filtering
Date: Fri, 8 Jun 2007 14:03:06 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706081358060.4059@racer.site>
References: <Pine.LNX.4.64.0706080130000.4046@racer.site> 
 <7vzm3bmfeq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0706080603520.4059@racer.site>
 <46690315.8244CAF7@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 15:06:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HweAU-0005Hi-GL
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 15:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937939AbXFHNGR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 09:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937143AbXFHNGQ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 09:06:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:34523 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S937044AbXFHNGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 09:06:16 -0400
Received: (qmail invoked by alias); 08 Jun 2007 13:06:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 08 Jun 2007 15:06:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ON6hqXSWO7zgQR7uHDSkTfnn97ajUoUrbP3Nhx9
	w3ki4t2LEm6wkO
X-X-Sender: gene099@racer.site
In-Reply-To: <46690315.8244CAF7@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49472>

Hi,

On Fri, 8 Jun 2007, Johannes Sixt wrote:

> Johannes Schindelin wrote:
> > It's just a guess, but now that we come really, really close to having 
> > a concise implementation of git-subproject which will probably soon 
> > propagate to master, and then maint, I gather that more and more 
> > people come and want to split their projects (which they maintained as 
> > one big project) into several subprojects (which they should have been 
> > from the start, but the tool did not easily allow for that).
> 
> I think that --subdirectry-filter needs to become a bit smarter to be 
> really useful for splitting a big project into sub-projects plus a 
> super-project. The reason is that once you have extracted the 
> sub-project(s), you have a hard time to find out which commits to 
> gitlink into the super-project. I don't have a plan how to make it 
> smarter, though.

Yes, it seems a good direction to follow.

I will have to think about it, but I guess that with yet another set of 
files in ../map/ (probably prefixed by the subdirectory name), we should 
even be able to smartly filter a huge project into a super-project 
together with its subprojects.

The command line option would be something like "--split-superproject 
dir1,dir2,dir3", where dir<n> are the subdirectories that are to become 
the subprojects.

Ciao,
Dscho
