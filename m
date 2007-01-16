From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Tue, 16 Jan 2007 23:42:42 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701162337330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701150144.56793.jnareb@gmail.com>  <7vwt3nxnak.fsf@assigned-by-dhcp.cox.net>
  <Pine.LNX.4.63.0701161206050.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
 <200701161514.47908.jnareb@gmail.com> <dbfc82860701161417r650bc47fva92fa940b4e2cfc0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 23:42:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6x0x-0002Qk-Bn
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 23:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735AbXAPWmp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 17:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbXAPWmp
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 17:42:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:52421 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751735AbXAPWmo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 17:42:44 -0500
Received: (qmail invoked by alias); 16 Jan 2007 22:42:42 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 16 Jan 2007 23:42:42 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Nikolai Weibull <now@bitwi.se>
In-Reply-To: <dbfc82860701161417r650bc47fva92fa940b4e2cfc0@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36976>

Hi,

On Tue, 16 Jan 2007, Nikolai Weibull wrote:

> And, as Johannes already pointed out, it's very disturbing having to 
> dump a configuration file so that it is more easily read by other 
> programs.

I never pointed out such a thing. The configuration file is meant to be 
user-friendly, as the inventor did not mean to have a program like 
git-repo-config.

> That would suggest that the ini-based format for git's configuration 
> file is suboptimal.

Not at all. Again, git's configuration file is meant for human inspection. 
Therefore, an ini-style file is optimal.

And for scripts, we do have git-repo-config. But now some people want to 
be clever and read the whole config file in, to make it easier to have 
gazillions of configuration options for their script.

I was not happy when we introduced more relaxed section titles, and I am 
not happy now that I see what problems we introduced with that.

> Of course, once git is librified (which is still a long-term goal,
> right?), [...]

You are welcome to contribute to that goal! AFAICT nobody is seriously 
working on that.

Ciao,
Dscho
