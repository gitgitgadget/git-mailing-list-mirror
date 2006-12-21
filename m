From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] hooks/pre-commit: add example to add Signed-off-by line
 to message
Date: Thu, 21 Dec 2006 09:26:49 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612210925400.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0611291219190.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <200612201604.12498.andyparkins@gmail.com>
 <Pine.LNX.4.63.0612201717490.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmz5ifpbv.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612201835570.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vejqufonm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 09:27:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxJGR-0004Ix-DQ
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 09:26:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422832AbWLUI0x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 03:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422857AbWLUI0w
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 03:26:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:46231 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422832AbWLUI0v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 03:26:51 -0500
Received: (qmail invoked by alias); 21 Dec 2006 08:26:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 21 Dec 2006 09:26:49 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vejqufonm.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35025>

Hi,

On Wed, 20 Dec 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Why SQUASH_MSG?  Doesn't it confuse git-explain when it wants to
> >> detect that you are in the middle of a squash merge?
> >
> > Yes, it confuses git-explain. Which did not existed when I concocted the 
> > first (broken) version of this patch. There are only two ways to give 
> > commit message templates AFAICT: misusing SQUASH_MSG and misusing 
> > MERGE_MSG.
> 
> I wonder...
> 
> # An example hook script to check the commit log message.
> # Called by git-commit with one argument, the name of the file
> # that has the commit message.  The hook should exit with non-zero
> # status after issuing an appropriate message if it wants to stop the
> # commit.  The hook is allowed to edit the commit message file.

Yes, I missed that.

Ciao,
Dscho
