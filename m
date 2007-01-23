From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Deleting remote branches with git-branch and reflog questions
Date: Tue, 23 Jan 2007 23:06:07 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701232303040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701231259.27719.andyparkins@gmail.com> <45B6076F.5060503@op5.se>
 <200701231314.53361.andyparkins@gmail.com> <7v1wllo2p6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0701231649520.3011@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 23:07:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9Tnr-0006Qk-Os
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 23:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965537AbXAWWGX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 17:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965551AbXAWWGX
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 17:06:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:45827 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965518AbXAWWGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 17:06:09 -0500
Received: (qmail invoked by alias); 23 Jan 2007 22:06:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 23 Jan 2007 23:06:08 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0701231649520.3011@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37578>

Hi,

On Tue, 23 Jan 2007, Nicolas Pitre wrote:

> On Tue, 23 Jan 2007, Junio C Hamano wrote:
> 
> > And we might want to allow reflogs on detached HEAD someday,
> > although I personally think it goes against what detached HEAD
> > is -- it is of a very temporary nature.
> 
> Didn't we agree already that reflog with detached head was simply 
> insane?

Maybe you did. I did not agree on that.

Also I have yet to see a valid reason against tracking HEAD.

(Yes, it is better to think about that first, be restrictive, and if it 
turns out to make sense, allow that -- rather than allow it, decide that 
it does not make sense, and then forbid it.)

Ciao,
Dscho
