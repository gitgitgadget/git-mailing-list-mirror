From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Sun, 21 Jan 2007 23:52:49 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701212348070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <7v3b6439uh.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701212234520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <ep0qc6$bph$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 23:52:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8lYU-00017G-Ge
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 23:52:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbXAUWwv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 17:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751753AbXAUWwv
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 17:52:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:50916 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751748AbXAUWwu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 17:52:50 -0500
Received: (qmail invoked by alias); 21 Jan 2007 22:52:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 21 Jan 2007 23:52:49 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ep0qc6$bph$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37357>

Hi,

On Sun, 21 Jan 2007, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> > On Sun, 21 Jan 2007, Junio C Hamano wrote:
> 
> >> * Reflog
> >> 
> >>  - Reflog records the history of where the tip of each branch
> >>    was at each moment.
> > 
> > It might make sense to reformulate that:
> > 
> >       Reflog records the history from the view point of the local 
> >       repository. In other words, regardless of the real history,
> >       the reflog shows the history as seen by one particular repository
> >       (this enables you to ask "what was the current revision in _this_
> >       repository, yesterday at 1pm?").
> 
> I think that _both_ sentences are right. Reflog records history of where the
> tip of each branch was at each moment, logging also what command was used
> to move tip of branch (was it commit, amending commit, rebase, reset, or
> creating branch anew, git-am or pull).
> 
> But where tip of each branch was is purely local matter. What is global
> is DAG of commits, refs are always as seen by one particular repository.

What I meant was: people not familiar with git development will probably 
not understand the shorter, concise statement. They will not know off-hand 
that there is a difference between the history of development, and the 
history, as seen from the local repository's viewpoint.

So of course, both sentences are right.

Your point -- that reflog also records the action -- is less important 
IMHO. It is just meta-data of the local view.

To your second point: the global history remains global, of course. But 
this is what you _usually_ refer to, when talking about the development 
history, anyway. Therefore, to motivate reflogs, you should point out the 
differences between local and global history.

And this means to at least _mention_ the word "local".

Ciao,
Dscho
