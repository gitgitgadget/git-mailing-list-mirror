From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin-commit: add --date option
Date: Wed, 2 Dec 2009 17:22:57 -0500
Message-ID: <20091202222257.GA9691@coredump.intra.peff.net>
References: <1259627252-21615-1-git-send-email-vmiklos@frugalware.org>
 <20091202192614.GD30778@coredump.intra.peff.net>
 <20091202221232.GF31763@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Dec 02 23:23:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFxbC-0005UG-Tj
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 23:23:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755688AbZLBWWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 17:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755568AbZLBWWv
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 17:22:51 -0500
Received: from peff.net ([208.65.91.99]:56547 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755054AbZLBWWu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 17:22:50 -0500
Received: (qmail 28297 invoked by uid 107); 2 Dec 2009 22:27:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 02 Dec 2009 17:27:25 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Dec 2009 17:22:57 -0500
Content-Disposition: inline
In-Reply-To: <20091202221232.GF31763@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134409>

On Wed, Dec 02, 2009 at 11:12:32PM +0100, Miklos Vajna wrote:

> No, I want to set it to two days ago, for example when I forgot to
> commit at the end of the day and I notice it two days later before I
> start to work on something again.

OK. I think you are being overly meticulous about your commit date, but
that is your right. ;)

> > Also, is there a good reason why GIT_AUTHOR_DATE is not respected in
> > this case?  If not, should we simply be fixing that bug instead?
> 
> GIT_AUTHOR_DATE is respected by --reset-author, just given that we have
> --author already, using environment variables for a user can be
> uncomfortable.

OK, I can agree with that reasoning.

-Peff
