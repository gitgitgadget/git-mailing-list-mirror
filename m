From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add commit.status, --status, and --no-status
Date: Tue, 8 Dec 2009 01:04:15 -0500
Message-ID: <20091208060415.GC9951@coredump.intra.peff.net>
References: <20091206131217.GA12851@sigill.intra.peff.net>
 <1260225927-33612-1-git-send-email-jh@jameshoward.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "James P. Howard, II" <jh@jameshoward.us>
X-From: git-owner@vger.kernel.org Tue Dec 08 07:04:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHtBQ-00037k-4G
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 07:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935638AbZLHGEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 01:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935632AbZLHGEM
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 01:04:12 -0500
Received: from peff.net ([208.65.91.99]:52541 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935626AbZLHGEL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 01:04:11 -0500
Received: (qmail 7958 invoked by uid 107); 8 Dec 2009 06:08:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 08 Dec 2009 01:08:49 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Dec 2009 01:04:15 -0500
Content-Disposition: inline
In-Reply-To: <1260225927-33612-1-git-send-email-jh@jameshoward.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134820>

On Mon, Dec 07, 2009 at 05:45:27PM -0500, James P. Howard, II wrote:

> This commit provides support for commit.status, --status, and
> --no-status, which control whether or not the git status information
> is included in the commit message template when using an editor to
> prepare the commit message.  It does not affect the effects of a
> user's commit.template settings.

Thanks, this looks very cleanly done. The only complaint I would make is
that it should probably include a simple test case.

-Peff
