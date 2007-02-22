From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix 'git commit -a' in a newly initialized repository
Date: Thu, 22 Feb 2007 21:59:33 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702222157000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070222202812.8882.44375.stgit@c165>
 <Pine.LNX.4.63.0702222140360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <alpine.LRH.0.82.0702221550290.27932@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Feb 22 21:59:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKL2S-0005du-4V
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 21:59:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbXBVU7f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 15:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbXBVU7f
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 15:59:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:36688 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751885AbXBVU7e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 15:59:34 -0500
Received: (qmail invoked by alias); 22 Feb 2007 20:59:33 -0000
X-Provags-ID: V01U2FsdGVkX1/19ecsWA31pQVvZRberH6FVUMcpU9I8CCn4s/mFx
	+XqA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <alpine.LRH.0.82.0702221550290.27932@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40391>

Hi,

On Thu, 22 Feb 2007, Nicolas Pitre wrote:

> On Thu, 22 Feb 2007, Johannes Schindelin wrote:
> 
> > On Thu, 22 Feb 2007, Fredrik Kuivinen wrote:
> > 
> > > +		die 'nothing to commit (use "git add file1 file2" to include for commit)'
> > 
> > Would it not make more sense to tell the user about "git add ."?
> 
> Isn't what the patch does?  IMHO it looks just like the empty commit 
> message which is good.

I wanted to get at the "." thing. You know, when I start a project with 
git, there are usually some files there already. Provided I have a 
.gitignore there, I can just say "git add ." and be done.

But maybe that is _not_ common practice?

> > Maybe together with a hint about .gitignore?
> > 
> > This error message is important. The most likely recipients are total 
> > git newsters, and we really should try to help them here.
> 
> Sure.  But to really help newsters it is better _not_ to talk about 
> .gitignore at all.  It certainly won't exist at that point anyway.

Hmm. That is a really good point. Hmmm. I think you're right.

Ciao,
Dscho
