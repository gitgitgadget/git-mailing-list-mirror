From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git-status: colorize status output
Date: Sat, 5 Aug 2006 22:31:07 +0200
Message-ID: <20060805203107.GB16186@moooo.ath.cx>
References: <20060805031418.GA11102@coredump.intra.peff.net> <20060805105953.GA5410@moooo.ath.cx> <7vejvve8ci.fsf@assigned-by-dhcp.cox.net> <20060805112851.GA20807@moooo.ath.cx> <7v64h7e7dm.fsf@assigned-by-dhcp.cox.net> <20060805121821.GB20807@moooo.ath.cx> <20060805195411.GA4733@sigio.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 22:31:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9Snh-0003aU-Ep
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 22:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWHEUbK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 16:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWHEUbJ
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 16:31:09 -0400
Received: from moooo.ath.cx ([85.116.203.178]:652 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751489AbWHEUbI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Aug 2006 16:31:08 -0400
To: Jeff King <peff@peff.net>
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060805195411.GA4733@sigio.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24933>

Jeff King <peff@peff.net> wrote:
> On Sat, Aug 05, 2006 at 02:18:21PM +0200, Matthias Lederhofer wrote:
> 
> > I like the colored git status.  Here is a patch to honor isatty(1) and
> > pager_in_use (exporting GIT_PAGER_IN_USE) with pager.color.
> 
> Doesn't this have different behavior when you use 'git-status' rather
> than 'git status'? Maybe rather than a boolean, we would be better off
> with a true/false/auto value similar to diff.color.
I don't see the case where git-status and git status behave
differently (except for git -p status but git-status does not have an
option for paging at all).
