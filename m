From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/5] git-add: add ignored files when asked explicitly.
Date: Tue, 26 Dec 2006 23:48:37 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612262348260.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vbqlskz2u.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612251443230.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vslf3khsc.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612261632360.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v1wmmfpfw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 26 23:48:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzL6B-0006Rq-CY
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 23:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932832AbWLZWsj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Dec 2006 17:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932837AbWLZWsj
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 17:48:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:45689 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932832AbWLZWsj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Dec 2006 17:48:39 -0500
Received: (qmail invoked by alias); 26 Dec 2006 22:48:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 26 Dec 2006 23:48:37 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wmmfpfw.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35432>

Hi,

On Tue, 26 Dec 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > Most people do
> >> >
> >> > 	$ git add *.o
> >> >
> >> > instead, where bash expands the expression. Maybe this new behaviour 
> >> > should be hidden between a "-f" option?
> >> 
> >> When would anybody do "git add *.o"?
> >
> > Not exactly "git add *.o", but when I see in git-status that there are 
> > only a couple of files which are untracked, and I want them added, I 
> > lazily do "git add *".
> 
> I changed it to warn and refuse and made it only add under -f
> flag.

Thanks!

Ciao,
Dscho
