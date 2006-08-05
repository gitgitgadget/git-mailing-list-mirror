From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-status: colorize status output
Date: Sat, 5 Aug 2006 19:42:40 -0400
Message-ID: <20060805234240.GA11545@coredump.intra.peff.net>
References: <7vejvve8ci.fsf@assigned-by-dhcp.cox.net> <20060805112851.GA20807@moooo.ath.cx> <7v64h7e7dm.fsf@assigned-by-dhcp.cox.net> <20060805121821.GB20807@moooo.ath.cx> <20060805195411.GA4733@sigio.intra.peff.net> <20060805203107.GB16186@moooo.ath.cx> <20060805031418.GA11102@coredump.intra.peff.net> <20060805105953.GA5410@moooo.ath.cx> <20060805194513.GA4836@sigio.intra.peff.net> <20060805202759.GA16186@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Aug 06 01:43:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9VnC-0007YJ-W2
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 01:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbWHEXmn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 19:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932664AbWHEXmn
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 19:42:43 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:8651 "HELO
	peff.net") by vger.kernel.org with SMTP id S932641AbWHEXmn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Aug 2006 19:42:43 -0400
Received: (qmail 20298 invoked from network); 5 Aug 2006 19:42:07 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 5 Aug 2006 19:42:07 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat,  5 Aug 2006 19:42:40 -0400
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060805203107.GB16186@moooo.ath.cx> <20060805202759.GA16186@moooo.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24939>

On Sat, Aug 05, 2006 at 10:27:59PM +0200, Matthias Lederhofer wrote:

> I would suggest that all scripts that use colors have a
> always/auto/never (with boolean fallback) option and also honor
> pager.color if the pager is in use.

I'll send out a patch in a moment.

> I don't see the case where git-status and git status behave
> differently (except for git -p status but git-status does not have an
> option for paging at all).

Sorry, I didn't say what I meant at all. My problem was that one
cannot get color with a pager using git-status (by doing
'git-status | less'). The output is not a tty, but GIT_PAGER_IN_USE is
not set (and of course I cannot use '-p'). However, that is a moot point
with always/auto/never, since in such a case I can just use 'always'.

-Peff
