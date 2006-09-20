From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 23:53:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609202350160.19042@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060920080308.673a1e93@localhost.localdomain>
 <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz>
 <Pine.LNX.4.63.0609201801110.19042@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060920160756.GP8259@pasky.or.cz> <Pine.LNX.4.64.0609200915550.4388@g5.osdl.org>
 <Pine.LNX.4.64.0609200920290.4388@g5.osdl.org> <20060920163437.GC23260@spearce.org>
 <Pine.LNX.4.63.0609202321390.19042@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060920212747.GB24415@spearce.org> <Pine.LNX.4.63.0609202333320.19042@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vodtafc4g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 20 23:53:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQA0O-0004nW-Nx
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 23:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWITVxR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 17:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWITVxR
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 17:53:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:41674 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932187AbWITVxR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 17:53:17 -0400
Received: (qmail invoked by alias); 20 Sep 2006 21:53:15 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 20 Sep 2006 23:53:15 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodtafc4g.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27416>

Hi,

On Wed, 20 Sep 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I'd rather set another config variable with --shared, which tells git to 
> > refuse receiving non-fast-forwards. This could be a sensible setting in 
> > other setups than shared ones after all. Thoughts?
> 
> If this option is meant to forbid fixing up an screw-up by doing
> "git-push --force", I do not quite like it.
> 
> It sounds as if arguing that "rm -fr" is dangerous so presence
> of -f and -r at the same time should imply -i option.  I think
> the right answer is not making -i implied, but train the user to
> understand what -fr means before using it.

I think it is more like being nice, and disallowing "rm -rf" via FTP, 
forcing the user to do it locally.

In a shared repository I really, really, I mean: really, do not want to 
mess a branch up that others pull from. And if I have to fix something, I 
_can_ do it locally. (Plus the hassle reminds me of giving the pullers a 
heads-up.)

Ciao,
Dscho
