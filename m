From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] show-branch --reflog: show the reflog message at
 the top.
Date: Sat, 20 Jan 2007 02:19:43 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701200218290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7virf2d190.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701200116280.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v4pqmczqa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701200135500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vr6tqbjt8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 02:19:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H84tZ-0001T9-Tm
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 02:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbXATBTs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 20:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965099AbXATBTr
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 20:19:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:50542 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965105AbXATBTp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 20:19:45 -0500
Received: (qmail invoked by alias); 20 Jan 2007 01:19:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 20 Jan 2007 02:19:44 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr6tqbjt8.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37240>

Hi,

On Fri, 19 Jan 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Fri, 19 Jan 2007, Junio C Hamano wrote:
> >
> >> I still am having a hard time trying to explain what these
> >> commands would do, and why they might be useful:
> >> 
> >> 	git-log --walk-reflogs master..next
> >
> > I had less problems explaining that when walking fell back to walking the 
> > parents.
> >
> > It could even make sense to...
> 
> (meaning that is not what the code does...)
> 
> > Of course, you could always say: if you ask for strange things, you will 
> > get strange things.
> 
> But if you have to say that, doesn't it suggest that accepting
> the option --walk-reflogs when you have anything other than one
> single positive commit in revs.pending leads to end user
> confusion?

How about failing if there are _uninteresting_ commits? So,

	git log --walk-reflogs next master

still works?

Ciao,
Dscho
