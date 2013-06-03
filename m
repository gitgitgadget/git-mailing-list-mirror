From: Jeff King <peff@peff.net>
Subject: Re: Git status reports untracked on tracked files
Date: Mon, 3 Jun 2013 18:26:18 -0400
Message-ID: <20130603222618.GA26180@sigill.intra.peff.net>
References: <CAO-zUnh4018FSnsXzX4gLw-4AnWsKgEiZ5P4pktjxNokargQwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Karsten Blees <karsten.blees@gmail.com>, git@vger.kernel.org
To: Andrey Kiyanovsky <andrey.kiyanovsky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 00:26:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjdCs-0007hh-Ub
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 00:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759241Ab3FCW0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 18:26:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:35151 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758645Ab3FCW0W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 18:26:22 -0400
Received: (qmail 8454 invoked by uid 102); 3 Jun 2013 22:27:07 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 03 Jun 2013 17:27:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Jun 2013 18:26:18 -0400
Content-Disposition: inline
In-Reply-To: <CAO-zUnh4018FSnsXzX4gLw-4AnWsKgEiZ5P4pktjxNokargQwA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226301>

On Wed, May 29, 2013 at 11:40:56AM +0300, Andrey Kiyanovsky wrote:

> Git version 1.8.1.2. for Windows
> 
> Git config:
> 
> [core]
> 	repositoryformatversion = 0
> 	filemode = false
> 	bare = false
> 	logallrefupdates = true
> 	symlinks = false
> 	ignorecase = true
> 	hideDotFiles = dotGitOnly
> 	compression = 1

In the past there have been some problems with status listings of
untracked files when core.ignorecase is in use. I fixed some cases with
a commit that went into v1.7.8, but some problems remained. Karsten
Blees (cc'd) did some work that went into git v1.8.1.6, but I do not
know off-hand if it would fix your case or not.

Can you try with a more recent version of git?

-Peff
