From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] show_date(): rename the "relative" parameter to "mode"
Date: Wed, 28 Feb 2007 00:20:14 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702280019340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702271620390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702271339550.12485@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702271356300.12485@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702272322590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vslcrb3l8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Simon Josefsson <simon@josefsson.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 28 00:22:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMBdz-0004qW-PY
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 00:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbXB0XVF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 18:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752603AbXB0XVE
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 18:21:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:41338 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752607AbXB0XUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 18:20:16 -0500
Received: (qmail invoked by alias); 27 Feb 2007 23:20:14 -0000
X-Provags-ID: V01U2FsdGVkX19DKVkH5VZDLTGCkkbkwESP2z+t9ZBzzINCTCXALF
	yqFw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vslcrb3l8.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40842>

Hi,

On Tue, 27 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Side note: one of the reasons I like having more fine-grained date 
> >> flags is that I've occasionally wanted a "show in UTC time" or "show 
> >> everything in *my* local time" option.
> >
> > I found the --relative-date option very useful to that end, if a bit 
> > long to type.
> 
> How about --ago as a synonym, and --my-date for obeying TZ? "show in UTC 
> time" can be had by something like:
> 
> 	$ TZ=UTC git log --my-date

I like both.

> I personally am not very happy that "reflog show @{now}" gives relative 
> date and not the full datestamp.

$ git log -g @{now} 

Ciao,
Dscho
