From: Jeff King <peff@peff.net>
Subject: Re: Future suggestion's to assist with changes to git.
Date: Thu, 28 Aug 2008 20:06:15 -0400
Message-ID: <20080829000615.GA30453@coredump.intra.peff.net>
References: <alpine.LNX.1.10.0808281646570.18129@suse104.zenez.com> <20080828233045.GE29609@coredump.intra.peff.net> <7vej48d73e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Boyd Lynn Gerber <gerberb@zenez.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 02:07:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYrWM-0004Pz-2P
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 02:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752967AbYH2AGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 20:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753175AbYH2AGS
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 20:06:18 -0400
Received: from peff.net ([208.65.91.99]:3564 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752425AbYH2AGR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 20:06:17 -0400
Received: (qmail 9745 invoked by uid 111); 29 Aug 2008 00:06:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 28 Aug 2008 20:06:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Aug 2008 20:06:15 -0400
Content-Disposition: inline
In-Reply-To: <7vej48d73e.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94226>

On Thu, Aug 28, 2008 at 04:59:17PM -0700, Junio C Hamano wrote:

> That would help compared to doing nothing, but many people who complained
> in the first thread (this is the third one, by the way) was k.org users
> who used a machine somebody else installs the software for them.  Messages
> during installation would not help those people.

I think this can be generalized to "messages from the maintainer of your
systems". In the case of single-user installs, a message from the
package maintainer is appropriate. For a multi-user system, I would
expect a message from the admin to all of the users of the software.

> This is arguable.  People would have get annoying messages thrown into
> their mailbox from their cron jobs, even before the switchover happened,
> which effectively means that we move the whining period from now back to
> the beginning of the deprecation period -- it won't reduce the amount of
> actual whining.

Personally, I would rather have my task succeed with a little extra spew
to stderr than to fail completely. And that would get the people who
were against the change involved in the discussion at a much earlier
point.

-Peff
