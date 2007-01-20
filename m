From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] --walk-reflogs: disallow uninteresting commits
Date: Sat, 20 Jan 2007 10:32:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701201029400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7virf2d190.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701200116280.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v4pqmczqa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701200135500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vr6tqbjt8.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701200218290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v4pqmbhzg.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701200325380.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v64b29naa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 10:32:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8CaD-0000OH-82
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 10:32:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965241AbXATJcT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 04:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965240AbXATJcT
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 04:32:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:58754 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965241AbXATJcS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 04:32:18 -0500
Received: (qmail invoked by alias); 20 Jan 2007 09:32:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 20 Jan 2007 10:32:16 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64b29naa.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37261>

Hi,

On Fri, 19 Jan 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	> I think people may also appreciate timestamps on Reflog headers 
> > 	> you add to the output.
> >
> > 	At the moment, if you ask for @{1} (or leave it out), you will see 
> > 	them enumerated by number. If you ask for @{now}, you will see 
> > 	them identified by date...
> 
> Thanks.  This certainly needs a better documentation -- the attached is
> my try.

;-)

I sort of waited for comments on this behaviour. Maybe it would be better 
to always show the number, _and_ a relative time? I.e.

	Reflog @{2}: master@{17.5 minutes ago} (message)

> By the way, I haven't looked into it, but does this ring a bell?
> 
>     $ git-log --walk-reflogs -1 --pretty=s master@{1.day}
>     commit 72fe6a59890870ed9c3e9e1e6381fc0d7ba75fe4
>     Reflog: master@{Thu, 1 Jan 1970 00:00:00 +0000} ((null))
>     Reflog message: (null)Author: Junio C Hamano <junkio@cox.net>
> 
>         Documentation: Generate command lists.

Not yet. Will look into it.

Ciao,
Dscho
