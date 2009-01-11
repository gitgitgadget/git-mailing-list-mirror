From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: current git kernel has strange problems during bisect
Date: Sun, 11 Jan 2009 21:51:21 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901112150110.3586@pacific.mpi-cbg.de>
References: <200901111602.53082.borntraeger@de.ibm.com> <200901111607.59054.borntraeger@de.ibm.com> <alpine.DEB.1.00.0901111613250.3586@pacific.mpi-cbg.de> <200901111620.03345.borntraeger@de.ibm.com> <alpine.LFD.2.00.0901111113150.6528@localhost.localdomain>
 <87tz85fuxr.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Sun Jan 11 21:52:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM7I0-0002C5-SM
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 21:52:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250AbZAKUup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 15:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753147AbZAKUuo
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 15:50:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:58826 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752839AbZAKUun (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 15:50:43 -0500
Received: (qmail invoked by alias); 11 Jan 2009 20:50:36 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp043) with SMTP; 11 Jan 2009 21:50:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+pPaENK32pZYX/m2MT94UV37t2VnqUcp3Q32bwD7
	ySTUGVrE3lNSJ7
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <87tz85fuxr.fsf@basil.nowhere.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105224>

Hi,

On Sun, 11 Jan 2009, Andi Kleen wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> >
> > For bisect purposes, if you know you're not chasing down a btrfs issue, 
> > you can do
> >
> > 	git bisect good 34353029534a08e41cfb8be647d734b9ce9ebff8
> 
> Could you perhaps add some standard tag for that commit? That 
> would make it easier than to always find the exact btrfs commit.
> 
> Just an idea.

Well, AFAICT what Linus hinted at is that you do not need such a standard 
tag.  Indeed, you would only clutter the history with such tags, when it 
usually is just a matter of saying "git bisect good" whenever you _know_ 
you are hitting known-good history.

Ciao,
Dscho
