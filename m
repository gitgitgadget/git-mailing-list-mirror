From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/4] tests: add date printing and parsing tests
Date: Mon, 31 Aug 2009 23:03:28 -0400
Message-ID: <20090901030328.GA24938@coredump.intra.peff.net>
References: <20090831022228.GA4833@coredump.intra.peff.net>
 <20090831023015.GC5507@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 05:04:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiJfD-0007jK-Ri
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 05:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbZIADDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 23:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbZIADDa
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 23:03:30 -0400
Received: from peff.net ([208.65.91.99]:58321 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751751AbZIADDa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 23:03:30 -0400
Received: (qmail 29917 invoked by uid 107); 1 Sep 2009 03:03:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 31 Aug 2009 23:03:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Aug 2009 23:03:28 -0400
Content-Disposition: inline
In-Reply-To: <20090831023015.GC5507@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127517>

On Sun, Aug 30, 2009 at 10:30:15PM -0400, Jeff King wrote:

>   - We confirm that the improvements in b5373e9 and 1bddb25
>     work.

Ugh. I just realized (when explaining how awesome git resurrect was in
another mail) that I managed to bungle these commit hashes (and the one
mentioned in the following patch).

What happened is that I was building on the topic branch and lazily did
a "rebase -i origin" to fix up my patches. I left the first two patches
untouched, of course, but they still ended up with new committer
information.

As my patches are merged to 'next' already, I think it is too late to
fixup the commit message. But for posterity, the correct referenced
commits are 9029055 and 36e4986.

Caveat rebaser.

-Peff
