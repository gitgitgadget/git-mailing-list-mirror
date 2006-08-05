From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-status: colorize status output
Date: Sat, 5 Aug 2006 15:51:18 -0400
Message-ID: <20060805195118.GB4836@sigio.intra.peff.net>
References: <20060805031418.GA11102@coredump.intra.peff.net> <20060805105953.GA5410@moooo.ath.cx> <7vejvve8ci.fsf@assigned-by-dhcp.cox.net> <20060805112851.GA20807@moooo.ath.cx> <7v64h7e7dm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 21:51:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9SB9-00063n-Df
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 21:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWHETvU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 15:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWHETvU
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 15:51:20 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:6833 "HELO
	peff.net") by vger.kernel.org with SMTP id S932187AbWHETvU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Aug 2006 15:51:20 -0400
Received: (qmail 8090 invoked from network); 5 Aug 2006 15:50:44 -0400
Received: from unknown (HELO sigio.intra.peff.net) (10.0.0.10)
  by segfault.intra.peff.net with SMTP; 5 Aug 2006 15:50:44 -0400
Received: by sigio.intra.peff.net (sSMTP sendmail emulation); Sat,  5 Aug 2006 15:51:18 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64h7e7dm.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24928>

On Sat, Aug 05, 2006 at 04:42:29AM -0700, Junio C Hamano wrote:

> Not that I can think of, but do people really run "git status"?

I do! :) I actually wrote the vim colorizer first and used it for a
week before realizing it was not sufficient, and that I wanted
git-status output colorized, too. So please consider including the
patch.

> I think Jeff's follow-up "vim colorizer" makes a lot more sense
> than colorizing "git status" output -- it gives reminder during
> the last chance the user has to notice such problems, which is
> while composing the commit log message.

It looks like we have some similar emacs stuff in contrib/. Should I
prepare a short patch to create contrib/vim/?

-Peff
