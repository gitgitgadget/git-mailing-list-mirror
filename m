From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git integration with monodevelop
Date: Fri, 14 Nov 2008 15:55:59 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811141553020.30769@pacific.mpi-cbg.de>
References: <491AAE6D.8030304@op5.se> <491AF20D.4070600@kde.ru> <491AF768.3010607@op5.se> <491B02FF.2060204@kde.ru> <491BD532.9090200@op5.se> <alpine.DEB.1.00.0811141429040.30769@pacific.mpi-cbg.de> <491D82F3.2090807@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Evgeniy Ivanov <powerfox@kde.ru>,
	Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Nov 14 15:49:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0zzH-0007bI-2F
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 15:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbYKNOsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 09:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbYKNOsP
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 09:48:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:54157 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751295AbYKNOsO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 09:48:14 -0500
Received: (qmail invoked by alias); 14 Nov 2008 14:48:12 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp065) with SMTP; 14 Nov 2008 15:48:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19pBUFmewxpNc/ZOTRYp+iQa/W6y4Y/eV5a2peSor
	0TXUAtfncW8GUm
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <491D82F3.2090807@op5.se>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100981>

Hi,

On Fri, 14 Nov 2008, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
> > Hi,
> > 
> > On Thu, 13 Nov 2008, Andreas Ericsson wrote:
> > 
> > > Evgeniy Ivanov wrote:
> > >
> > > > But this is the same things Shawn has suggested to my mentor and 
> > > > me at the beginning of SoC...
> > > Oh? I didn't know libgit2 started as a SoC project.
> > 
> > It did not.  It started as a request from GitHub, and following 
> > discussion, at the GitTogether '08.
> > 
> > There _was_ a SoC project last year, libgit-thin, but the problem as 
> > far as GitHub is concerned was that it was a tear-down approach: it 
> > took git.git and tried to make a small library of it, and by this 
> > approach was bound to the GPL.
> > 
> 
> Oh. I was under the impression that libgit2 would also be able to reuse 
> code from git.git, since there was that huge license thread a couple of 
> months ago. Did I misinterpret that thread, and everything in libgit2 
> has to be implemented from scratch?

You misinterpreted.

A lot can be reused, because the original authors agree to let the code be 
relicensed (including Shawn and me, for example).  But a few others have 
raised concerns with everything non-GPL (and that includes GPL+gcc 
exception), and even stated explicitely that they are not okay with their 
code being reused (or adapted) to something as permissive as BSD, for 
example.

However, let's not revive the license wars.  The topic is kinda boring.

Ciao,
Dscho
