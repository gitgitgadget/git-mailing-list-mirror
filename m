From: Jeff King <peff@peff.net>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 10:12:22 -0400
Message-ID: <20061020141222.GA17497@coredump.intra.peff.net>
References: <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca> <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <4536EC93.9050305@utoronto.ca> <87lkncev90.wl%cworth@cworth.org> <453792A8.1010700@utoronto.ca> <878xjc2qeb.wl%cworth@cworth.org> <453803E6.2060309@utoronto.ca> <87ods727pn.wl%cworth@cworth.org> <45382120.9060702@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>, Linus Torvalds <torvalds@osdl.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 16:13:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gav6r-0004WX-CG
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 16:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbWJTOMZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 10:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbWJTOMZ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 10:12:25 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:29414 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751712AbWJTOMZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 10:12:25 -0400
Received: (qmail 25588 invoked from network); 20 Oct 2006 10:12:23 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 20 Oct 2006 10:12:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Oct 2006 10:12:22 -0400
To: Aaron Bentley <aaron.bentley@utoronto.ca>
Content-Disposition: inline
In-Reply-To: <45382120.9060702@utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29473>

On Thu, Oct 19, 2006 at 09:06:40PM -0400, Aaron Bentley wrote:

> What's nice is being able see the revno 753 and knowing that "diff -r
> 752..753" will show the changes it introduced.  Checking the revo on a
> branch mirror and knowing how out-of-date it is.

I was accustomed to doing such things in CVS, but I find the git way
much more pleasant, since I don't have to do any arithmetic:
  diff d8a60^..d8a60
(Yes, I am capable of performing subtraction in my head, but I find that
a "parent-of" operator matches my cognitive model better, especially
when you get into things like d8a60^2~3).

Does bzr have a similar shorthand for mentioning relative commits?

-Peff
