From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git log [diff-tree options]...
Date: Mon, 10 Apr 2006 10:22:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604101018530.31612@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v7j5zce7x.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604090950590.9504@g5.osdl.org> <7vbqvabn8f.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604091158310.9504@g5.osdl.org>
 <Pine.LNX.4.63.0604092312340.29136@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0604100000430.30000@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vy7ye9uk8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 10 10:23:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSrfp-0006qz-N2
	for gcvg-git@gmane.org; Mon, 10 Apr 2006 10:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWDJIW7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Apr 2006 04:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWDJIW7
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Apr 2006 04:22:59 -0400
Received: from mail.gmx.de ([213.165.64.20]:63433 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751084AbWDJIW6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Apr 2006 04:22:58 -0400
Received: (qmail invoked by alias); 10 Apr 2006 08:22:55 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp026) with SMTP; 10 Apr 2006 10:22:55 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7ye9uk8.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18586>

Hi,

On Sun, 9 Apr 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Hi,
> >
> > On Sun, 9 Apr 2006, Johannes Schindelin wrote:
> >
> >> On Sun, 9 Apr 2006, Linus Torvalds wrote:
> >> 
> >> >  - keep it - for historical reasons - as a internal shorthand, and just 
> >> >    turn it into "git log --diff -cc"
> >> 
> >> It is "git log --cc", right?
> >
> > Like this?
> 
> I do not think so.  You should default to --cc only there is no
> explicit command line stuff from the user.

Well, my idea was to get rid of the whatchanged script, and deprecate the 
internal whatchanged. IMHO "git log" is much faster typed than "git 
whatchanged", especially if you have no completion installed. I, for one, 
will never ever again use whatchanged.

But you and the list gave me bad marks for that patch, and rightfully so.

Ciao,
Dscho
