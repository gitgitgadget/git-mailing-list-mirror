From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] guilt(1): fix path to git-sh-setup
Date: Thu, 17 Jul 2008 13:58:13 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0807171357150.3486@wbgn129.biozentrum.uni-wuerzburg.de>
References: <20080716232339.GC22919@ldl.fc.hp.com> <20080717100217.GT32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Chiang <achiang@hp.com>, jeffpc@josefsipek.net,
	git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jul 17 13:59:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJS8m-0002Ot-O6
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 13:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755492AbYGQL6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 07:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754865AbYGQL6R
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 07:58:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:59304 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752531AbYGQL6R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 07:58:17 -0400
Received: (qmail invoked by alias); 17 Jul 2008 11:58:14 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp067) with SMTP; 17 Jul 2008 13:58:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+CjopXLfaCouMl1egUTPqcGuXyL39QjUmT+9wUu0
	at0L4Bv+SXKCxy
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <20080717100217.GT32184@machine.or.cz>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88835>

Hi,

On Thu, 17 Jul 2008, Petr Baudis wrote:

> On Wed, Jul 16, 2008 at 05:23:39PM -0600, Alex Chiang wrote:
> > diff --git a/guilt b/guilt
> > index 50414a4..ba4593a 100755
> > --- a/guilt
> > +++ b/guilt
> > @@ -23,7 +23,7 @@ esac
> >  # we change directories ourselves
> >  SUBDIRECTORY_OK=1
> >  
> > -. git-sh-setup
> > +. `git --exec-path`/git-sh-setup
> 
> Beware of the proverbial "/Program Files/Git" location, however.

Indeed.  And when trying to stray not _too_ far away from the coding style 
of git.git, avoid the backticks, too, like so:

	. "$(git --exec-path)"/git-sh-setup

Ciao,
Dscho
