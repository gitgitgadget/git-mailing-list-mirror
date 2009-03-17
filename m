From: Jeff King <peff@peff.net>
Subject: Re: Not pushing all branches?
Date: Tue, 17 Mar 2009 04:24:57 -0400
Message-ID: <20090317082457.GG18475@coredump.intra.peff.net>
References: <alpine.DEB.2.00.0903130846410.17450@perkele.intern.softwolves.pp.se> <43d8ce650903130125m6335d189obbcdb86ec9036083@mail.gmail.com> <7v4oxxgpil.fsf@gitster.siamese.dyndns.org> <874oxwgbcr.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Tue Mar 17 09:26:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjUdP-0006iN-36
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 09:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701AbZCQIZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 04:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753703AbZCQIZI
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 04:25:08 -0400
Received: from peff.net ([208.65.91.99]:39035 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752817AbZCQIZH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 04:25:07 -0400
Received: (qmail 2886 invoked by uid 107); 17 Mar 2009 08:25:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 17 Mar 2009 04:25:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Mar 2009 04:24:57 -0400
Content-Disposition: inline
In-Reply-To: <874oxwgbcr.fsf@catnip.gol.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113437>

On Sat, Mar 14, 2009 at 10:08:20AM +0900, Miles Bader wrote:

> e.g., "git diff REMOTE_BRANCH" to see what updates are pending if I
> merge...  Also, it would be nice to have a more concise way to say
> "git merge REMOTE_BRANCH".
> 
> I'm not sure "-" seems like the best syntax though... maybe it's a bit
> _too_ short.
> 
> [Is there a general standard syntax for "keywords" in git, e.g., to
> distinguish them from branch/rev names?  I mean, if the standard syntax
> were "@foo", then one could imagine "git diff @remote" or something.]

I think all-caps is the closest we get. E.g., you probably don't want to
name a branch MERGE_HEAD, ORIG_HEAD, FETCH_HEAD, etc. But it's purely
advisory; you _can_ make such branches and then deal with the ensuing
"ambiguous ref" messages.

-Peff
