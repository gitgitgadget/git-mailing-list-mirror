From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] remote HEAD improvements
Date: Wed, 11 Feb 2009 19:17:17 -0500
Message-ID: <20090212001717.GA30231@coredump.intra.peff.net>
References: <1234332083-45147-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 01:19:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXPI6-0008E6-4P
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 01:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708AbZBLARU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 19:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753348AbZBLARU
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 19:17:20 -0500
Received: from peff.net ([208.65.91.99]:54463 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753248AbZBLART (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 19:17:19 -0500
Received: (qmail 4216 invoked by uid 107); 12 Feb 2009 00:17:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 11 Feb 2009 19:17:37 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Feb 2009 19:17:17 -0500
Content-Disposition: inline
In-Reply-To: <1234332083-45147-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109548>

On Wed, Feb 11, 2009 at 01:01:20AM -0500, Jay Soffian wrote:

> 1) Teaches git remote a new "sethead" verb:
> 
>   To set a remote HEAD explicitly:
>   $ git remote sethead <name> <branch>
> 
>   To set a remote HEAD to match the upstream repo:
>   $ git remote sethead <name> -a
> 
>   To delete a remote HEAD:
>   $ git remote sethead <name> -d

I like these semantics a lot. I will do worse than bikeshed, though, and
say that I don't like the color you painted it without even proposing a
color of my own. Which is to say, I think "sethead" is not the best
name. But I like it better than the alternatives I've seen, so maybe it
is OK.

Perhaps it is just the run-together word that makes it worse. Something
like "set-head" might be better (I guess I couldn't resist suggesting a
color, after all).

I have a few comments, which I will post in reply to the individual
patches.

-Peff
