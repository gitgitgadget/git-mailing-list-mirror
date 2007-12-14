From: Jeff King <peff@peff.net>
Subject: git-browse-help?
Date: Fri, 14 Dec 2007 04:28:30 -0500
Message-ID: <20071214092829.GA22725@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Dec 14 10:29:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J36qn-0005Rl-8Z
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 10:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763762AbXLNJ2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 04:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763682AbXLNJ2e
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 04:28:34 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1331 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761547AbXLNJ2d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 04:28:33 -0500
Received: (qmail 22019 invoked by uid 111); 14 Dec 2007 09:28:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 14 Dec 2007 04:28:31 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Dec 2007 04:28:30 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68272>

The new 'git-browse-help' seems to purely be a helper script for "git
help" (judging from the commit messages and the lack of documentation).
Should it perhaps be "git--browse-help" or "git-help--browse" to follow
our "this is not for users" convention (see add--interactive,
fetch--tool, and rebase--interactive).

I became aware of it because "br" used to tab-complete "branch" but now
doesn't. :) And if we're going to change it, pre-1.5.4 is the time.

-Peff
