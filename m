From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Tue, 10 Oct 2006 01:46:43 -0400
Message-ID: <20061010054643.GA565@coredump.intra.peff.net>
References: <7vy7ro7o3g.fsf@assigned-by-dhcp.cox.net> <20061010053841.42852.qmail@web31815.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 07:47:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXAS1-0001yQ-K2
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 07:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWJJFqr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 01:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWJJFqr
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 01:46:47 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:57505 "HELO
	peff.net") by vger.kernel.org with SMTP id S964893AbWJJFqq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Oct 2006 01:46:46 -0400
Received: (qmail 21108 invoked from network); 10 Oct 2006 01:46:44 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 10 Oct 2006 01:46:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Oct 2006 01:46:43 -0400
To: Luben Tuikov <ltuikov@yahoo.com>
Content-Disposition: inline
In-Reply-To: <20061010053841.42852.qmail@web31815.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28605>

On Mon, Oct 09, 2006 at 10:38:41PM -0700, Luben Tuikov wrote:

> The interesting point here is that people with zero and high
> computer exposure tend to click on the file name to obtain it.
> Only people with some computer exposure start to "think" and
> "figure it out" and fail to intuit to naively point at the
> file name to get the file. 
> 
> So this is 2/3 to 1/3.

2/3 to 1/3 if you're counting categories, but you haven't presented any
evidence that the number of people in each category is the same.

Besides which, I think that people with a high degree of exposure to the
web tend to look for the things that look like buttons or links. The
near-universal sign for links on the web is underlining (and typically
an alternate color). Looking at the repo.or.cz file lists, I see that
none of the files is highlighted but the directories are. What am I to
guess (either by intuition or by "figuring it out") except that there is
some difference between clicking the two? I think we are failing a
consistency test.

-Peff
