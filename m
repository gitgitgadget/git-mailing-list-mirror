From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git refuses to switch to older branches
Date: Sun, 20 Aug 2006 14:48:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608201447470.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060819202558.GE30022@admingilde.org> <7vac601hbb.fsf@assigned-by-dhcp.cox.net>
 <20060819224457.GB23891@pasky.or.cz> <20060820122128.GG30022@admingilde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 20 14:49:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEmjZ-0003y0-Bm
	for gcvg-git@gmane.org; Sun, 20 Aug 2006 14:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWHTMsh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Aug 2006 08:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWHTMsh
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Aug 2006 08:48:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:8100 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750752AbWHTMsg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Aug 2006 08:48:36 -0400
Received: (qmail invoked by alias); 20 Aug 2006 12:48:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 20 Aug 2006 14:48:35 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060820122128.GG30022@admingilde.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25751>

Hi,

On Sun, 20 Aug 2006, Martin Waitz wrote:

> On Sun, Aug 20, 2006 at 12:44:57AM +0200, Petr Baudis wrote:
> > Dear diary, on Sun, Aug 20, 2006 at 12:39:20AM CEST, I got a letter
> > where Junio C Hamano <junkio@cox.net> said that...
> > > But I would suggest you to be _extremely_ careful if you want to
> > > try this.  I do not have an example offhand, but I would not be
> > > surprised at all if there is a valid use case where it is useful
> > > to have a pattern that matches a tracked file in .gitignore
> > > file.
> > 
> >   *.o and binary blobs of closed-source software.
> 
> but if you want to switch from one branch which has the .o file
> built from source to another branch which has the .o file tracked
> in binary form, wouldn't you want to remove the generated file
> in order to store the tracked one from the new branch?

Not necessarily. Sometimes you have files in your working directory, which 
are not in your repository, you know?

Ciao,
Dscho
