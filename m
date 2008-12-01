From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Modified the default git help message to be grouped by
	topic
Date: Mon, 1 Dec 2008 13:32:59 -0500
Message-ID: <20081201183258.GB24443@coredump.intra.peff.net>
References: <20081201173037.GA41967@agadorsparticus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 19:34:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7DbH-0008DY-Jc
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 19:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbYLASdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 13:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbYLASdC
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 13:33:02 -0500
Received: from peff.net ([208.65.91.99]:2648 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382AbYLASdB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 13:33:01 -0500
Received: (qmail 28656 invoked by uid 111); 1 Dec 2008 18:33:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 01 Dec 2008 13:33:00 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Dec 2008 13:32:59 -0500
Content-Disposition: inline
In-Reply-To: <20081201173037.GA41967@agadorsparticus>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102076>

On Mon, Dec 01, 2008 at 09:30:37AM -0800, Scott Chacon wrote:

> It's difficult to process 21 commands (which is what is output
> by default for git when no command is given).  I've re-grouped
> them into 4 groups of 5 or 6 commands each, which I think is
> clearer and easier for new users to process.

I like it (and I think the categorizations look reasonable, which is
something that I recall caused some discussion at the GitTogether).

The only downside I see is that we're now >24 lines.

> This won't automatically update with the common-commands.txt file,
> but I think it is easier to parse for the command you may be looking
> for.

Personally, I don't see a big problem. This is not a list that should
change very frequently, and there is extra information here that would
be annoying to encode in the list. But since the "common" flag in
command-list.txt and the common-cmds.h file would no longer be used,
they should probably be removed.

-Peff
