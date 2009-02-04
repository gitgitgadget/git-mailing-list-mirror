From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin-remote: make rm operation safer in mirrored
	repository
Date: Wed, 4 Feb 2009 11:18:25 -0500
Message-ID: <20090204161825.GA9428@sigill.intra.peff.net>
References: <76718490902040756m1f5c6f37o45865c51ad1a2e6d@mail.gmail.com> <1233763567-6155-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 17:19:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUkTj-0005K6-Tb
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 17:19:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075AbZBDQS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 11:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753540AbZBDQS3
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 11:18:29 -0500
Received: from peff.net ([208.65.91.99]:54401 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753522AbZBDQS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 11:18:29 -0500
Received: (qmail 30241 invoked by uid 107); 4 Feb 2009 16:18:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 04 Feb 2009 11:18:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Feb 2009 11:18:25 -0500
Content-Disposition: inline
In-Reply-To: <1233763567-6155-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108392>

On Wed, Feb 04, 2009 at 11:06:07AM -0500, Jay Soffian wrote:

> "git remote rm <repo>" is happy to remove non-remote refs (and their
> reflogs in the case of branches). This may be okay if the repository truely is a mirror, but if the
> user had done "git remote add --mirror <repo>" by accident and was just
> undoing their mistake, then they are left in a situation that is difficult to
> recover from.
> 
> After this commit, "git remote rm" skips over non-remote refs. The user is
> advised on how remove branches using "git branch -d", which itself has nice
> safety checks wrt to branch removal lacking from "git remote rm". Non-remote
> non-branch refs are skipped silently.
> 
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>

I like it.

Acked-by: Jeff King <peff@peff.net>

-Peff
