From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Modifies the default git help message to be grouped by
	topic
Date: Tue, 2 Dec 2008 12:28:49 -0500
Message-ID: <20081202172848.GA19876@coredump.intra.peff.net>
References: <20081202060509.GA48796@agadorsparticus> <20081202172025.GB15826@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 18:30:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7Z4a-0002YQ-Dh
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 18:30:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741AbYLBR2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 12:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754012AbYLBR2v
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 12:28:51 -0500
Received: from peff.net ([208.65.91.99]:4671 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752704AbYLBR2v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 12:28:51 -0500
Received: (qmail 13214 invoked by uid 111); 2 Dec 2008 17:28:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 02 Dec 2008 12:28:50 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Dec 2008 12:28:49 -0500
Content-Disposition: inline
In-Reply-To: <20081202172025.GB15826@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102162>

On Tue, Dec 02, 2008 at 12:20:25PM -0500, Jeff King wrote:

> Sorry to reverse direction after you resubmitted, but my earlier comment
> on "this list shouldn't change frequently" didn't take into account that
> the _synopsis_ might change, which is much more likely. So maybe rather
> than ditching the auto-generation, it makes sense to just hardcode the
> order and categorization, but pull the rest from autogeneration.

Note also that one could of course just use "common:basic" or something
like that in command-list.txt. But to handle arbitrary ordering, we
would have to reorder command-list as appropriate (which currently gets
sorted), or do something awful like common:basic1, common:basic2, etc. I
tried to choose the most straightforward approach that didn't involve
duplication of information.

-Peff
