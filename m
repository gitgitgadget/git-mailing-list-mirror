From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [POLL] Who likes running Git without make install?
Date: Mon, 3 Jul 2006 10:37:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607031037100.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vd5cyt8a3.fsf@assigned-by-dhcp.cox.net> <20060625010202.GX21864@pasky.or.cz>
 <20060625014009.GA21864@pasky.or.cz> <7vac82q6mb.fsf@assigned-by-dhcp.cox.net>
 <20060625152157.GG21864@pasky.or.cz> <7vk674mmyo.fsf@assigned-by-dhcp.cox.net>
 <20060701235906.GE29115@pasky.or.cz> <7vslljrxe0.fsf_-_@assigned-by-dhcp.cox.net>
 <20060703075850.GL29115@pasky.or.cz> <7vmzbrrtz4.fsf@assigned-by-dhcp.cox.net>
 <20060703081725.GM29115@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 10:37:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxJwE-0000so-8A
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 10:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWGCIhr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 04:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWGCIhr
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 04:37:47 -0400
Received: from mail.gmx.net ([213.165.64.21]:50140 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750778AbWGCIhq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 04:37:46 -0400
Received: (qmail invoked by alias); 03 Jul 2006 08:37:45 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 03 Jul 2006 10:37:45 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060703081725.GM29115@pasky.or.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23165>

Hi,

On Mon, 3 Jul 2006, Petr Baudis wrote:

> Dear diary, on Mon, Jul 03, 2006 at 10:08:31AM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> said that...
> > Petr Baudis <pasky@suse.cz> writes:
> > 
> > > Dear diary, on Mon, Jul 03, 2006 at 08:54:47AM CEST, I got a letter
> > > where Junio C Hamano <junkio@cox.net> said that...
> > >> -- >8 --
> > >> INSTALL: a tip for running after building but without installing.
> > >> 
> > >> Signed-off-by: Junio C Hamano <junkio@cox.net>
> > >
> > > Acked-by: Petr Baudis <pasky@suse.cz>
> > >
> > > I can live with this "weak (D3)". 99% of Git users probably use
> > > installed Git instance anyway and most of the rest are likely to be Git
> > > developers testing new code who can do this extra environment setup.
> > 
> > You earlier had to set two environment variables anyway but you
> > have added another.  I do not see what's weak about it.
> 
> I don't usually use the git wrapper so I got away without setting
> GIT_EXEC_PATH yet. ;-)

This is the config.mak I use everywhere:

-- snip --
bindir = $(shell pwd)
template_dir = $(bindir)/templates/blt
GIT_PYTHON_DIR = $(bindir)/compat
-- snap --

No environment variable.

Ciao,
Dscho
