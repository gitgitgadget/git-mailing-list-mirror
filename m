From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Builtin "git remote"
Date: Fri, 29 Feb 2008 02:13:45 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802290211460.22527@racer.site>
References: <alpine.LSU.1.00.0802290144130.22527@racer.site> <7vwsoofrue.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 29 03:15:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUum4-0000d7-Vz
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 03:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269AbYB2COV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 21:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbYB2COV
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 21:14:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:43936 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753142AbYB2COU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 21:14:20 -0500
Received: (qmail invoked by alias); 29 Feb 2008 02:14:18 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp041) with SMTP; 29 Feb 2008 03:14:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Gol9rIQjG1rxiEVfn0FavGhaB/qWnqdK250bBzE
	bLIjysbWhgQe7l
X-X-Sender: gene099@racer.site
In-Reply-To: <7vwsoofrue.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75496>

Hi,

On Thu, 28 Feb 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > It also demonstrates that format-patch --cover-letter should default 
> > to -M for the diffstat (search for "git-remote.perl"...).
> 
> It probably should inherit the settings for the primary part.
> You did generate the series with -M, especially [PATCH 4/5],
> didn't you?

Yes, I did.

> > Johannes Schindelin (5):
> >       path-list: add functions to work with unsorted lists
> >       parseopt: add flag to stop on first non option
> >       Test "git remote show" and "git remote prune"
> >       Make git-remote a builtin
> >       builtin-remote: prune remotes correctly that were added with --mirror
> 
> Also I wish the default indentation were not that deep, and also
> line-wrapped at around 72-76 columns.

Right.

I still have a few patches in my personal tree to implement "git-fmt", and 
I think that it should be easy to rework them into something usable for 
this purpose (4-character indent for the first line, 8-character for every 
subsequent one).

Also, it might be a good idea to teach "git log" to use these wrapping 
functions, as there are still regular contributors, even to Git itself, 
who seem to be unwilling to use <=76 characters/line.

Ciao,
Dscho

