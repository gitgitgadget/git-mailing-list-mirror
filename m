From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What will happen to git.git in the near future
Date: Sun, 1 Oct 2006 20:53:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610012052520.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v7iztbldm.fsf@assigned-by-dhcp.cox.net> <7vd59c2vev.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610011132040.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 20:54:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GU6Rr-0001sJ-1z
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 20:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWJASxk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 14:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWJASxk
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 14:53:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:45800 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932196AbWJASxi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Oct 2006 14:53:38 -0400
Received: (qmail invoked by alias); 01 Oct 2006 18:53:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 01 Oct 2006 20:53:37 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610011132040.3952@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28188>

Hi,

On Sun, 1 Oct 2006, Linus Torvalds wrote:

> 	Git.xs: In function 'XS_Git_xs_version':
> 	Git.xs:62: error: 'GIT_VERSION' undeclared (first use in this function)
> 	Git.xs:62: error: (Each undeclared identifier is reported only once
> 	Git.xs:62: error: for each function it appears in.)

We had that discussion in another thread already.

Just rm perl/{Git.{bs,c},Makefile} and remake.

Ciao,
Dscho
