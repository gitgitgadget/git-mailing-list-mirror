From: Jeff King <peff@peff.net>
Subject: Re: [question] how can i verify whether a local branch is tracking
	a remote branch?
Date: Sun, 5 Apr 2009 10:44:13 -0400
Message-ID: <20090405144413.GC2076@sigill.intra.peff.net>
References: <4d8e3fd30904050332w394cccbaq5b82d2a53ed357a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 16:46:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqTbn-0001P5-QI
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 16:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbZDEOoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 10:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753449AbZDEOoQ
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 10:44:16 -0400
Received: from peff.net ([208.65.91.99]:56312 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752536AbZDEOoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 10:44:16 -0400
Received: (qmail 16174 invoked by uid 107); 5 Apr 2009 14:44:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 05 Apr 2009 10:44:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Apr 2009 10:44:13 -0400
Content-Disposition: inline
In-Reply-To: <4d8e3fd30904050332w394cccbaq5b82d2a53ed357a3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115670>

On Sun, Apr 05, 2009 at 12:32:29PM +0200, Paolo Ciarrocchi wrote:

> is there a way to verify, using the UI, whether a local branch is
> tracking a remote branch?

Do you mean "whether it is tracking any branch", or "whether the branch
is is tracking is remote"?

If the former, then I think if one of branch.$branch.{merge,rebase}
is set, it is tracking something. The tracked thing is remote unless
branch.$branch.remote is ".".

-Peff
