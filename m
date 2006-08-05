From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-status: colorize status output
Date: Sat, 5 Aug 2006 15:54:11 -0400
Message-ID: <20060805195411.GA4733@sigio.intra.peff.net>
References: <20060805031418.GA11102@coredump.intra.peff.net> <20060805105953.GA5410@moooo.ath.cx> <7vejvve8ci.fsf@assigned-by-dhcp.cox.net> <20060805112851.GA20807@moooo.ath.cx> <7v64h7e7dm.fsf@assigned-by-dhcp.cox.net> <20060805121821.GB20807@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 21:54:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9SDx-0006Un-BZ
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 21:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWHETyO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 15:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWHETyO
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 15:54:14 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:59054 "HELO
	peff.net") by vger.kernel.org with SMTP id S932258AbWHETyN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Aug 2006 15:54:13 -0400
Received: (qmail 8324 invoked from network); 5 Aug 2006 15:53:38 -0400
Received: from unknown (HELO sigio.intra.peff.net) (10.0.0.10)
  by segfault.intra.peff.net with SMTP; 5 Aug 2006 15:53:38 -0400
Received: by sigio.intra.peff.net (sSMTP sendmail emulation); Sat,  5 Aug 2006 15:54:11 -0400
To: Matthias Lederhofer <matled@gmx.net>
Content-Disposition: inline
In-Reply-To: <20060805121821.GB20807@moooo.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24929>

On Sat, Aug 05, 2006 at 02:18:21PM +0200, Matthias Lederhofer wrote:

> I like the colored git status.  Here is a patch to honor isatty(1) and
> pager_in_use (exporting GIT_PAGER_IN_USE) with pager.color.

Doesn't this have different behavior when you use 'git-status' rather
than 'git status'? Maybe rather than a boolean, we would be better off
with a true/false/auto value similar to diff.color.

-Peff
