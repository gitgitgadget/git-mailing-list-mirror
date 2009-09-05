From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] status: list unmerged files last
Date: Sat, 5 Sep 2009 05:04:22 -0400
Message-ID: <20090905090422.GA13221@coredump.intra.peff.net>
References: <200909012213.54611.j6t@kdbg.org>
 <7vy6oy9z9r.fsf@alter.siamese.dyndns.org>
 <200909012325.45739.j6t@kdbg.org>
 <7vtyzmxkpr.fsf@alter.siamese.dyndns.org>
 <20090902011513.GA3874@coredump.intra.peff.net>
 <7vmy5egefh.fsf@alter.siamese.dyndns.org>
 <20090902051248.GB12046@coredump.intra.peff.net>
 <20090902124832.GC4012@sirena.org.uk>
 <20090902180050.GB5998@coredump.intra.peff.net>
 <20090902183923.GA10581@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 11:04:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjrCR-0004gZ-BO
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 11:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbZIEJEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 05:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbZIEJEX
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 05:04:23 -0400
Received: from peff.net ([208.65.91.99]:39034 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932530AbZIEJEW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 05:04:22 -0400
Received: (qmail 26210 invoked by uid 107); 5 Sep 2009 09:04:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 05 Sep 2009 05:04:38 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Sep 2009 05:04:22 -0400
Content-Disposition: inline
In-Reply-To: <20090902183923.GA10581@rakim.wolfsonmicro.main>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127806>

On Wed, Sep 02, 2009 at 07:39:23PM +0100, Mark Brown wrote:

> My main wishlist would be to have the same control for the changes to be
> committed for the big merge case, the use case being while resolving
> merges where those changes are those that have been dealt with and the
> remaining (hopefully much fewer) changes are those that still need
> attention.

I think we need to be more concrete than that. What is the "big merge
case"? If there are any unmerged paths?

What exactly should be cut out, and how can it be configured? Should you
have "status.unmerged" to cut out certain things? Which things (of
staged, unstaged, and untracked)? Or should it go the other way, with a
status.showStaged variable which can be set to "always", "never", or
"unmerged" (and probably adding an "unmerged" option to
"status.showUntrackedFiles).

-Peff
