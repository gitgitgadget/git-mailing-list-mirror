From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Fix 'git commit -a' in a newly initialized repository
Date: Thu, 22 Feb 2007 15:54:37 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702221550290.27932@xanadu.home>
References: <20070222202812.8882.44375.stgit@c165>
 <Pine.LNX.4.63.0702222140360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 22 21:54:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKKxe-0003ju-Gg
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 21:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbXBVUyj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 15:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbXBVUyj
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 15:54:39 -0500
Received: from relais.videotron.ca ([24.201.245.36]:12624 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbXBVUyi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 15:54:38 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDV002PNU31H100@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 22 Feb 2007 15:54:38 -0500 (EST)
In-reply-to: <Pine.LNX.4.63.0702222140360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40389>

On Thu, 22 Feb 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Thu, 22 Feb 2007, Fredrik Kuivinen wrote:
> 
> > +		die 'nothing to commit (use "git add file1 file2" to include for commit)'
> 
> Would it not make more sense to tell the user about "git add ."?

Isn't what the patch does?  IMHO it looks just like the empty commit 
message which is good.

> Maybe 
> together with a hint about .gitignore?
> 
> This error message is important. The most likely recipients are total git 
> newsters, and we really should try to help them here.

Sure.  But to really help newsters it is better _not_ to talk about 
.gitignore at all.  It certainly won't exist at that point anyway.


Nicolas
