From: Jeff King <peff@peff.net>
Subject: Re: Getting Commits from One Repository to Another
Date: Thu, 21 May 2009 00:04:51 -0400
Message-ID: <20090521040451.GC8091@sigill.intra.peff.net>
References: <7D9240D0-C8BA-40C6-A89E-8BC7E08B1163@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Big Lebowski <duderino.lebowski@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 06:05:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6zWd-0005Sz-E1
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 06:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbZEUEEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 00:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbZEUEEv
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 00:04:51 -0400
Received: from peff.net ([208.65.91.99]:56754 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750715AbZEUEEu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 00:04:50 -0400
Received: (qmail 12162 invoked by uid 107); 21 May 2009 04:04:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 21 May 2009 00:04:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 May 2009 00:04:51 -0400
Content-Disposition: inline
In-Reply-To: <7D9240D0-C8BA-40C6-A89E-8BC7E08B1163@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119652>

On Wed, May 20, 2009 at 07:37:54PM -0400, Big Lebowski wrote:

> Essentially, when I came on a project, a git repository was made  
> available to me (lets call that 'public_repo'). That repository was put up 
> on an unfuddle account, as an initial check-in; it was not cloned from the 
> repository they were working on (lets call that 'private_repo'). I wrote 
> some code, and pushed it to the repository. Now that I guess they feel 
> comfortable with me, they reveal to me the private_repo.
>
> How do I get my code from public_repo to private_repo?

You could just repeat the push you made to public_repo to private_repo.
Or you could push to private_repo from public_repo, or pull from
public_repo to private_repo. One of the results of git's distributed
nature is that a commit is a commit is a commit. It doesn't matter where
it comes from: pushing or pulling the same commit (i.e., the same sha-1
commit id) will give the same results.

Does that make sense? If not, can you be more specific about the setup
(i.e., which commands were run to create public_repo and your personal
clone)? Without that, it's hard to offer more specific advice.

-Peff
