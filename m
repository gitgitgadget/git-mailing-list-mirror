From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CR codes from git commands
Date: Tue, 20 Jan 2009 18:08:22 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901201757520.5159@intel-tinevez-2-302>
References: <18805.64312.289059.660023@hungover.brentg.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 18:11:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPK6u-00047S-ML
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 18:09:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757550AbZATRIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 12:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757524AbZATRIc
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 12:08:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:58523 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757069AbZATRIc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 12:08:32 -0500
Received: (qmail invoked by alias); 20 Jan 2009 17:08:29 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp063) with SMTP; 20 Jan 2009 18:08:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+EHoIdEEaEOpUJD2nUdrEXNVK3ZACRSmyHBOhUT2
	goBm6Wd43X+m+G
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <18805.64312.289059.660023@hungover.brentg.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106495>

Hi,

On Tue, 20 Jan 2009, Brent Goodrick wrote:

> I am considering converting from CVS over to using git. I'm currently
> using git version 1.5.6.5 on Debian Linux "testing".

First of all, 1.5.6.5 is from last August, so chances are that the 
behavior you complain about was fixed in the meantime.  We're at 1.6.1 at 
the moment.

> One of the first things I ran into was having to set PAGER to "cat" to 
> avoid the problems when running git from anything other than a terminal.  
> The second thing is that "git pull" (and possibly other commands) are 
> emitting ^M (octal 013) codes on output, possibly caused by the same 
> assumption as causes the problem that is fixed by setting PAGER to 
> "cat".

The only place I can think about where a CR is output is when showing the 
progress of downloading. 

Usually, our code checks if stdout is a tty, and does not show progress.

As a work-around, piping into cat should work, though.

Ciao,
Dscho
