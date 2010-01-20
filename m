From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git status: do not require write permission
Date: Tue, 19 Jan 2010 19:28:36 -0500
Message-ID: <20100120002836.GA16824@coredump.intra.peff.net>
References: <alpine.DEB.1.00.1001200105230.3164@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 20 01:28:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXOR9-0003KG-8N
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 01:28:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755497Ab0ATA2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 19:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754993Ab0ATA2j
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 19:28:39 -0500
Received: from peff.net ([208.65.91.99]:36663 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460Ab0ATA2j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 19:28:39 -0500
Received: (qmail 28088 invoked by uid 107); 20 Jan 2010 00:33:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 19 Jan 2010 19:33:32 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jan 2010 19:28:36 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1001200105230.3164@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137505>

On Wed, Jan 20, 2010 at 01:06:17AM +0100, Johannes Schindelin wrote:

> Today, git status played violin on my nerves for the very last time.
> There is no good reason, really none, for git status to require
> write permissions.  If the index is not up-to-date, so be it, I
> cannot commit anyway.

I agree it is annoying, but this patch does not apply (and is no longer
needed) on master since the status-is-no-longer-commit-dry-run series
has been merged.

I don't know if it is worth putting your fix onto maint.

-Peff
