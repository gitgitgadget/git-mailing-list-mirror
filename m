From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-status: colorize status output
Date: Sat, 5 Aug 2006 15:45:13 -0400
Message-ID: <20060805194513.GA4836@sigio.intra.peff.net>
References: <20060805031418.GA11102@coredump.intra.peff.net> <20060805105953.GA5410@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 21:45:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9S5T-0005B1-0n
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 21:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWHETpS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 15:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWHETpR
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 15:45:17 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:44455 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751481AbWHETpQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Aug 2006 15:45:16 -0400
Received: (qmail 7767 invoked from network); 5 Aug 2006 15:44:40 -0400
Received: from unknown (HELO sigio.intra.peff.net) (10.0.0.10)
  by segfault.intra.peff.net with SMTP; 5 Aug 2006 15:44:40 -0400
Received: by sigio.intra.peff.net (sSMTP sendmail emulation); Sat,  5 Aug 2006 15:45:13 -0400
To: Matthias Lederhofer <matled@gmx.net>
Content-Disposition: inline
In-Reply-To: <20060805105953.GA5410@moooo.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24927>

On Sat, Aug 05, 2006 at 12:59:53PM +0200, Matthias Lederhofer wrote:

> Perhaps the default values should not use the same color twice? I'd
> suggest yellow for changed but not updated.  But well, it's no problem
> to change this in my config, I just find it a bit confusing to have
> the same color for different things.

I'm fine with changing the defaults as you suggest. It makes more sense
to me with only two colors (files is a potential mistake or not), but I
added more fine-grained support because it was trivial and I thought
others might want to customize it.

We could, of course, allow even more fine-grained control by matching
file type (added, deleted, modified, etc), but I'm not sure anybody
would want that.

> Is there any way to do isatty() from shell scripts?

As Junio said, test -t. :) Is there interest in me adding that feature?

-Peff
