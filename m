From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [HALF A PATCH] Teach the '--exclude' option to 'diff
 --no-index'
Date: Fri, 20 Feb 2009 21:04:27 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902202104120.6302@intel-tinevez-2-302>
References: <499E92FD.8000900@alum.mit.edu> <cf17659db8a4f7fe9d878984effcdd8d6417c862.1235138849u.git.johannes.schindelin@gmx.de> <20090220145331.GA3515@coredump.intra.peff.net> <alpine.DEB.1.00.0902201555490.6302@intel-tinevez-2-302>
 <m3skm9rm6h.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 21:06:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LabdL-0001RU-BO
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 21:06:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbZBTUEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 15:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752813AbZBTUEf
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 15:04:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:50798 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752742AbZBTUEe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 15:04:34 -0500
Received: (qmail invoked by alias); 20 Feb 2009 20:04:29 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp011) with SMTP; 20 Feb 2009 21:04:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/3Fd4i0MD3QZbfLQfZWhR+OqTlyM+KC5hVBzvQUB
	cjgIlQZoDuij5Z
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <m3skm9rm6h.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110885>

Hi,

On Fri, 20 Feb 2009, Jakub Narebski wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > On Fri, 20 Feb 2009, Jeff King wrote:
> > 
> > > But more seriously, how would a user expect this to interact with 
> > > .gitignore? I know gitignore is about ignoring untracked files, but I 
> > > can't help but feel the two have something in common. But maybe not. I'm 
> > > sick today and my brain is not working very well.
> > 
> > I think that the -x option with regular (not --no-index) diff would be 
> > a little different.  .gitignore is for "git add" time, while "git diff" 
> > happily ignores .gitignore.
> > 
> > Besides, the -x option only works on the basenames (as I implemented it; 
> > no idea if GNU diff works the same way, but from Michael's patch it looks 
> > like it does).
> 
> Info: (diff.info.gz)diff Options
> 
> `-x PATTERN'
> `--exclude=PATTERN'
>      When comparing directories, ignore files and subdirectories whose
>      basenames match PATTERN.  *Note Comparing Directories::.

Thanks for the clarification!

Ciao,
Dscho
