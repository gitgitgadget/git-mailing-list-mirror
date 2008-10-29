From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Implement git-staged, an alias for 'git diff --cached'.
Date: Tue, 28 Oct 2008 21:05:34 -0400
Message-ID: <20081029010534.GA8833@sigill.intra.peff.net>
References: <1225237145-95435-1-git-send-email-dsymonds@gmail.com> <1225238368-98594-1-git-send-email-dsymonds@gmail.com> <20081029003931.GA7291@sigill.intra.peff.net> <20081029010107.GB12065@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed Oct 29 02:06:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuzWM-0006gf-UZ
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 02:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998AbYJ2BFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 21:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbYJ2BFi
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 21:05:38 -0400
Received: from peff.net ([208.65.91.99]:3263 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752998AbYJ2BFh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 21:05:37 -0400
Received: (qmail 25031 invoked by uid 111); 29 Oct 2008 01:05:36 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.19)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 28 Oct 2008 21:05:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Oct 2008 21:05:34 -0400
Content-Disposition: inline
In-Reply-To: <20081029010107.GB12065@leksak.fem-net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99345>

On Wed, Oct 29, 2008 at 02:01:07AM +0100, Stephan Beyer wrote:

> I'm still not understanding, what it's for.
> Usability? Because doing
> 	git config --global alias.staged 'diff --cached'
> is lame?

You are missing some of the context, which is that we just had a big
in-person debate about how the staged nomenclature is confusing. We call
things "cached", "staged", and "index", depending on the command.

So this is an attempt to rectify that.

-Peff
