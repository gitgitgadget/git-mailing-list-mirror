From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: New features in gitk
Date: Fri, 2 Nov 2007 18:17:47 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711021814270.4362@racer.site>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com> 
 <alpine.LFD.0.999.0710272229430.30120@woody.linux-foundation.org> 
 <18212.13862.637991.30536@cargo.ozlabs.ibm.com> 
 <alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org> 
 <18217.41899.54812.227152@cargo.ozlabs.ibm.com> 
 <alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org> 
 <18218.63946.772767.179841@cargo.ozlabs.ibm.com>
 <e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
 <alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 02 19:19:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io16d-0000op-61
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 19:18:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755433AbXKBSSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 14:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754029AbXKBSSg
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 14:18:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:59991 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752648AbXKBSSf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 14:18:35 -0400
Received: (qmail invoked by alias); 02 Nov 2007 18:18:34 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 02 Nov 2007 19:18:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+beSoSoa2bmX+3f4Lp4ggMcqjMHxuQIogZ48JEl5
	tqSDWbyGMGp2Cb
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63149>

Hi,

On Fri, 2 Nov 2007, Linus Torvalds wrote:

> On Fri, 2 Nov 2007, Marco Costalba wrote:
> > 
> > I have tried to overcome --topo-order in qgit but I found it very 
> > difficult, too much for me.
> > 
> > Lazily drawing the layout it doesn't mean that you lazy load the data 
> > from git, indeed you load all the git-log output as soon as it 
> > arrives.
> 
> Would it be more palatable if I tried to write some 
> visualization-specific front-end that acted kind of like "git rev-list", 
> but would have some way of "resetting" its output?

Heh, Shawn and I were discussing this when we met in San Jose earlier this 
month.  The application we had in mind was a common backend for graphical 
representation of the commit graph, which could be used by git gui to show 
(part of) the history.  The ultimate goal was a graphical rebase -i.

I would have _loved_ to implement this.  Alas, as it appears my choice of 
job was less than brilliant, and even when I have some spare moments at 
the end of the day, I watch movies to forget the day, instead of 
implementing this fascinating and useful feature.

Ciao,
Dscho
