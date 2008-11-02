From: Jeff King <peff@peff.net>
Subject: Re: Using the --track option when creating a branch
Date: Sun, 2 Nov 2008 00:23:59 -0400
Message-ID: <20081102042359.GC5261@coredump.intra.peff.net>
References: <18696.32778.842933.486171@lisa.zopyra.com> <1225343538.10803.9.camel@maia.lan> <18697.41702.241183.408377@lisa.zopyra.com> <18697.42140.459170.891195@lisa.zopyra.com> <4909A7C4.30507@op5.se> <2008-10-30-14-52-52+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Ericsson <ae@op5.se>, Bill Lear <rael@zopyra.com>,
	git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Sun Nov 02 05:25:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwUWe-0007Xp-6m
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 05:25:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbYKBEYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 00:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbYKBEYF
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 00:24:05 -0400
Received: from peff.net ([208.65.91.99]:2244 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902AbYKBEYE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 00:24:04 -0400
Received: (qmail 22465 invoked by uid 111); 2 Nov 2008 04:24:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 02 Nov 2008 00:24:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Nov 2008 00:23:59 -0400
Content-Disposition: inline
In-Reply-To: <2008-10-30-14-52-52+trackit+sam@rfc1149.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99808>

On Thu, Oct 30, 2008 at 02:52:52PM +0100, Samuel Tardieu wrote:

> The current behaviour made me remove the branches I was not actively
> on locally, because I would get errors from "git push" all the time
> saying that I was not up-to-date in those branches.

Not triggering an error on these branches has been discussed a few times
before, but I'm not sure we ever reached a conclusion of what the ideal
behavior would be.

Try this thread:

  http://thread.gmane.org/gmane.comp.version-control.git/85469

which points to a few others. Comments welcome.

-Peff
