From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 30 Dec 2006 13:54:09 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612301350580.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vtzzfp86x.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612291853210.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612292219280.18171@xanadu.home>
 <Pine.LNX.4.63.0612301217010.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <45965A82.8030903@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 30 13:54:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0djC-0003Bc-9V
	for gcvg-git@gmane.org; Sat, 30 Dec 2006 13:54:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754382AbWL3MyM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 07:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754383AbWL3MyM
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 07:54:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:60519 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754379AbWL3MyL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 07:54:11 -0500
Received: (qmail invoked by alias); 30 Dec 2006 12:54:09 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp013) with SMTP; 30 Dec 2006 13:54:09 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Raimund Bauer <ray007@gmx.net>
In-Reply-To: <45965A82.8030903@gmx.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35619>

Hi,

On Sat, 30 Dec 2006, Raimund Bauer wrote:

> * Johannes Schindelin wrote, On 30.12.2006 12:22:
> > (Of course, the correct thing would not be "git reset --hard", but rather
> > "git diff --ours | git apply -R; git reset", but that's a tad long, no?)
> Then maybe introduce "git reset --ours" which does exactly that?

That is possible.

But does it make sense? 

It is a volatile state, and errors are too easy. So I think it makes sense 
to have to _ask_ for such a state.

(Having said that, I think that it actually might make sense for bisecting 
an error where you _need_ a local patch to get it running to begin with.)

Ciao,
Dscho
