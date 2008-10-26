From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add -p: warn if only binary changes present
Date: Sun, 26 Oct 2008 01:10:13 -0400
Message-ID: <20081026051013.GD21178@coredump.intra.peff.net>
References: <1224884916-20369-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Oct 26 06:11:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtxuU-0000oe-89
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 06:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbYJZFKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 01:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbYJZFKR
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 01:10:17 -0400
Received: from peff.net ([208.65.91.99]:3972 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752118AbYJZFKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 01:10:16 -0400
Received: (qmail 5234 invoked by uid 111); 26 Oct 2008 05:10:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 26 Oct 2008 01:10:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Oct 2008 01:10:13 -0400
Content-Disposition: inline
In-Reply-To: <1224884916-20369-1-git-send-email-trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99152>

On Fri, Oct 24, 2008 at 11:48:36PM +0200, Thomas Rast wrote:

> Current 'git add -p' will say "No changes." if there are no changes to
> text files, which can be confusing if there _are_ changes to binary
> files.  Add some code to distinguish the two cases, and give a
> different message in the latter one.

Having just looked at this code (for potentially handling "git add -p"
of new files), I think this change is sane.

> +			print STDERR "No changes except to binary files.\n";

This wording seems a little awkward to me, though. Maybe

  No changed text files.

?

-Peff
