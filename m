From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git commit won't add an untracked file given on the command
 line
Date: Wed, 19 Nov 2008 10:41:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811191036340.30769@pacific.mpi-cbg.de>
References: <20081118211237.234d8035@crow> <200811182227.20076.fge@one2team.com> <20081118214730.005fc72d@crow> <alpine.DEB.1.00.0811190206170.30769@pacific.mpi-cbg.de> <87tza41pf4.fsf@catnip.gol.com> <alpine.DEB.1.00.0811190238360.30769@pacific.mpi-cbg.de>
 <buomyfwmldj.fsf@dhapc248.dev.necel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Burton <markb@ordern.com>,
	Francis Galiegue <fge@one2team.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Wed Nov 19 10:35:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2jSm-0003yZ-1D
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 10:35:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbYKSJdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 04:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752305AbYKSJdv
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 04:33:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:45133 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751818AbYKSJdu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 04:33:50 -0500
Received: (qmail invoked by alias); 19 Nov 2008 09:33:48 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp055) with SMTP; 19 Nov 2008 10:33:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+SGZ06i9CS2T7McI7ekmRtNWdl1t1GLL06hkzXuc
	IcR2gy80PZTo1H
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <buomyfwmldj.fsf@dhapc248.dev.necel.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101318>

Hi,

On Wed, 19 Nov 2008, Miles Bader wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> I agree, but it would kinda handy to have an exception for files 
> >> explicitly named on the command line.
> >
> > Only if you do not have a clear picture of what the staging area is 
> > about, IMHO.
> 
> That's such a vague statement, I've not sure how to take it.
> 
> I use the staging area a lot, so I think I have a pretty clear idea of 
> what it's "about", but I also often use "commit FILE" or "commit -a" for 
> simple cases; even when splitting a change into multiple commits, it's 
> often more convenient to do "commit FILE..." instead of "add FILE; 
> commit".

What I meant was this: the "commit <file>" paradigm is not what you should 
do most of the time.  In order to work with the staging area efficiently, 
you should make staging and committing two separate steps.

I regularly encounter people who never call "git diff --cached" before 
committing, and guess who introduces all kinds of debug statements and 
other cruft into their commits?  Exactly.

So my point is this: stage first, verify, then commit.  That saves you a 
lot of embarrassment.

Ciao,
Dscho
