From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Builtin "git remote"
Date: Fri, 29 Feb 2008 11:21:46 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802291118540.22527@racer.site>
References: <alpine.LSU.1.00.0802290144130.22527@racer.site> <7vwsoofrue.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802282104500.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Feb 29 12:23:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV3KT-0002gn-6u
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 12:23:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756401AbYB2LWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 06:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756555AbYB2LWX
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 06:22:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:46654 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753026AbYB2LWW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 06:22:22 -0500
Received: (qmail invoked by alias); 29 Feb 2008 11:22:20 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp011) with SMTP; 29 Feb 2008 12:22:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18eFbYDu5Ae7T/j/DSZeiUPoByYir5+zMiURCeiW+
	cckenc/RIh1FF7
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802282104500.19665@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75523>

Hi,

On Thu, 28 Feb 2008, Daniel Barkalow wrote:

> On Thu, 28 Feb 2008, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > It also demonstrates that format-patch --cover-letter should default to -M
> > > for the diffstat (search for "git-remote.perl"...).
> > 
> > It probably should inherit the settings for the primary part.
> > You did generate the series with -M, especially [PATCH 4/5],
> > didn't you?
> 
> Obviously not the output_format, but everything else, I assume? Easy 
> enough to pass the main diff options into make_cover_letter() and use 
> them to initialize the diff options there.

Nice.

> > > Johannes Schindelin (5):
> > >       path-list: add functions to work with unsorted lists
> > >       parseopt: add flag to stop on first non option
> > >       Test "git remote show" and "git remote prune"
> > >       Make git-remote a builtin
> > >       builtin-remote: prune remotes correctly that were added with --mirror
> > 
> > Also I wish the default indentation were not that deep, and also
> > line-wrapped at around 72-76 columns.
> 
> Only for the cover letter, and not shortlog in general, I assume? It 
> should be easy to set the struct shortlog fields to whatever suits your 
> taste. Making it configurable (without getting tangled in other option 
> parsing) is trickier, though.

It is not really well documented, but with -w, you _can_ drive shortlog to 
do that.  In the API, you have to set the members wrap_lines = 1, in1 = 
first_indent, in2 = indent, wrap = width in struct shortlog.

I suggest the values 4,8,76, respectively.

Ciao,
Dscho

