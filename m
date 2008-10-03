From: Jeff King <peff@peff.net>
Subject: Re: Numeric Revision Names?
Date: Fri, 3 Oct 2008 13:37:48 -0400
Message-ID: <20081003173748.GA31526@coredump.intra.peff.net>
References: <19796862.post@talk.nabble.com> <m3d4ihr7as.fsf@localhost.localdomain> <20081003115557.08d80c2f.stephen@exigencecorp.com> <20081003171434.GC30592@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	marceloribeiro <marcelo@sonnay.com>, git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 19:39:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlocI-0005Wt-45
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 19:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097AbYJCRhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 13:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753131AbYJCRhv
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 13:37:51 -0400
Received: from peff.net ([208.65.91.99]:2093 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753069AbYJCRhv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 13:37:51 -0400
Received: (qmail 8011 invoked by uid 111); 3 Oct 2008 17:37:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 03 Oct 2008 13:37:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Oct 2008 13:37:48 -0400
Content-Disposition: inline
In-Reply-To: <20081003171434.GC30592@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97440>

On Fri, Oct 03, 2008 at 01:14:34PM -0400, Jeff King wrote:

> If you are constraining yourself to a central repo, then you could just
> add a receive hook that tags each new commit with a monotonically
> increasing revision number. Clients would get the tags upon fetch.

Oh, nevermind. I'm an idiot and didn't bother reading to the end of your
post, where you clearly attached a hook that does exactly that.

Sorry for the noise.

-Peff
