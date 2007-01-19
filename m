From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git ls-files -o under .git/ prints all repository files
Date: Fri, 19 Jan 2007 16:00:48 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701191600020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87r6trsu7n.wl@mail2.atmark-techno.com>  <7vwt3jjywc.fsf@assigned-by-dhcp.cox.net>
  <45B07875.9030506@fs.ei.tum.de>  <81b0412b0701182357l3a6d44fel58da50c7895fb6b4@mail.gmail.com>
  <45B0C7E6.4020509@op5.se> <1169214414.18684.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Alex Riesen <raa.lkml@gmail.com>,
	Simon 'corecode' Schubert <corecode@fs.ei.tum.de>,
	Junio C Hamano <junkio@cox.net>,
	Yasushi SHOJI <yashi@atmark-techno.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 16:01:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7vEe-0002e2-Io
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 16:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932845AbXASPAw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 10:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbXASPAw
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 10:00:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:56679 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932869AbXASPAv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 10:00:51 -0500
Received: (qmail invoked by alias); 19 Jan 2007 15:00:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 19 Jan 2007 16:00:50 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Matthias Kestenholz <lists@spinlock.ch>
In-Reply-To: <1169214414.18684.25.camel@localhost.localdomain>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37186>

Hi,

On Fri, 19 Jan 2007, Matthias Kestenholz wrote:

> On Fri, 2007-01-19 at 14:30 +0100, Andreas Ericsson wrote:
> > Alex Riesen wrote:
> > > On 1/19/07, Simon 'corecode' Schubert <corecode@fs.ei.tum.de> wrote:
> > >> >
> > >>
> > >> % cd .hg && hg status -A .
> > >> abort: path contains illegal component: .hg
> > >>
> > >> I think this is a sensible thing to do.
> > > 
> > > No, it isn't. It is not unlikely to have repo in repo
> > > (and some people already have them).
> > > Mercurial is wrong here.
> > 
> > For managing repos inside repos (onion repos?) I think it should
> > be safe to abort if we're not at top-level.
> > 
> 
> 
> Why not check for /.git/ somewhere inside the current working directory 
> (pwd) ? That's the way mercurial does it currently, and I think that is 
> a sane thing to do _if_ you want to protect the user from his own 
> stupidity.

There are valid reasons why you might want to have a (possibly 
temporary) repository _inside_ the GIT_DIR. You'd break these cases.

Ciao,
Dscho
