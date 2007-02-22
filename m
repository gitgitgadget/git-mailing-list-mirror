From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Fix 'git commit -a' in a newly initialized repository
Date: Thu, 22 Feb 2007 16:09:55 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702221605080.27932@xanadu.home>
References: <20070222202812.8882.44375.stgit@c165>
 <Pine.LNX.4.63.0702222140360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <alpine.LRH.0.82.0702221550290.27932@xanadu.home>
 <Pine.LNX.4.63.0702222157000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 22 22:10:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKLCS-0000l2-Cr
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 22:10:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbXBVVJ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 16:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751895AbXBVVJ4
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 16:09:56 -0500
Received: from relais.videotron.ca ([24.201.245.36]:51949 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbXBVVJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 16:09:56 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDV00KR0USJFLE0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 22 Feb 2007 16:09:55 -0500 (EST)
In-reply-to: <Pine.LNX.4.63.0702222157000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40392>

On Thu, 22 Feb 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Thu, 22 Feb 2007, Nicolas Pitre wrote:
> 
> > On Thu, 22 Feb 2007, Johannes Schindelin wrote:
> > 
> > > On Thu, 22 Feb 2007, Fredrik Kuivinen wrote:
> > > 
> > > > +		die 'nothing to commit (use "git add file1 file2" to include for commit)'
> > > 
> > > Would it not make more sense to tell the user about "git add ."?
> > 
> > Isn't what the patch does?  IMHO it looks just like the empty commit 
> > message which is good.
> 
> I wanted to get at the "." thing. You know, when I start a project with 
> git, there are usually some files there already. Provided I have a 
> .gitignore there, I can just say "git add ." and be done.
> 
> But maybe that is _not_ common practice?

Well... If you're that acquainted with GIT to perform the above, I'm 
sure a message like "use "git add file1 file2" to include for commit" 
won't leave you puzzled.  ;-)


Nicolas
