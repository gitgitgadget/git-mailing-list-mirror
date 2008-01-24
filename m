From: Jeff King <peff@peff.net>
Subject: Re: CVS import: Changing/cleaning authors and committers
Date: Thu, 24 Jan 2008 11:37:19 -0500
Message-ID: <20080124163719.GA17283@coredump.intra.peff.net>
References: <1424F1B0-7342-4436-9B4A-72D985DDA161@manchester.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Robert Haines <rhaines@manchester.ac.uk>
X-From: git-owner@vger.kernel.org Thu Jan 24 17:37:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI55O-000612-4I
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 17:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbYAXQhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 11:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbYAXQhX
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 11:37:23 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4465 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752515AbYAXQhW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 11:37:22 -0500
Received: (qmail 15178 invoked by uid 111); 24 Jan 2008 16:37:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 24 Jan 2008 11:37:20 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2008 11:37:19 -0500
Content-Disposition: inline
In-Reply-To: <1424F1B0-7342-4436-9B4A-72D985DDA161@manchester.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71632>

On Thu, Jan 24, 2008 at 03:12:08PM +0000, Robert Haines wrote:

> I was wondering if it would be able to go through and change all that to:
>
> author Name <email@address>
> etc
>
> Is this something that can be retrospectively done? Is it something that 
> can be done during cvsimport? Is it even doable?

David already answered the second question, and it is probably simpler
to just redo the import with -A unless there is some complication with
that (like you no longer have access to the CVS files).

However, to answer your first question: it can be fixed after the fact
by rewriting history within the git repository; see git-filter-branch.

-Peff
