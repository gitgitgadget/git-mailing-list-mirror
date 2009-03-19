From: Jeff King <peff@peff.net>
Subject: Re: git am from scratch
Date: Thu, 19 Mar 2009 16:18:17 -0400
Message-ID: <20090319201817.GE17028@coredump.intra.peff.net>
References: <200903191609.24812.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Thu Mar 19 21:20:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkOii-00062k-DM
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 21:20:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757980AbZCSUS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 16:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756817AbZCSUS2
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 16:18:28 -0400
Received: from peff.net ([208.65.91.99]:45727 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755890AbZCSUS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 16:18:27 -0400
Received: (qmail 3328 invoked by uid 107); 19 Mar 2009 20:18:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 19 Mar 2009 16:18:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2009 16:18:17 -0400
Content-Disposition: inline
In-Reply-To: <200903191609.24812.agruen@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113823>

On Thu, Mar 19, 2009 at 04:09:24PM +0100, Andreas Gruenbacher wrote:

> lates git (e986ceb0): there is a bug in git am when trying to recreate the 
> entire history of a repository:

I don't think this has ever worked in any version of git.

It might be nice to have, since it does come up once in a while, so I
suspect patches would be welcome.

But...

> When the first commit is added by hand instead, git am will import the
> rest of the mbox without problems. This is annoying because it's at
> least not immediately obvious how to recreate the initial commit with
> all the metadata.
> 
> Is this easily fixed?

There are many other ways to do this. Have you tried:

  - simply pulling the old repo into the new one?

  - if they are not connected in real-time, creating a bundle from the
    first and pulling it into the latter?

  - if you want to tweak the commit data during the process, have you
    tried using fast-export/fast-import rather than format-patch/am?

-Peff
