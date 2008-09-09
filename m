From: Jeff King <peff@peff.net>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Tue, 9 Sep 2008 16:50:03 -0400
Message-ID: <20080909205003.GA3397@coredump.intra.peff.net>
References: <20080909132212.GA25476@cuci.nl> <m3zlmhnx1z.fsf@localhost.localdomain> <20080909194354.GA13634@cuci.nl> <20080909195930.GA2785@coredump.intra.peff.net> <7vljy159v7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Stephen R. van den Berg" <srb@cuci.nl>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 22:51:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdAB8-0004Af-BE
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 22:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754940AbYIIUuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 16:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754324AbYIIUuG
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 16:50:06 -0400
Received: from peff.net ([208.65.91.99]:1416 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754007AbYIIUuF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 16:50:05 -0400
Received: (qmail 20740 invoked by uid 111); 9 Sep 2008 20:50:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 09 Sep 2008 16:50:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Sep 2008 16:50:03 -0400
Content-Disposition: inline
In-Reply-To: <7vljy159v7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95428>

On Tue, Sep 09, 2008 at 01:42:52PM -0700, Junio C Hamano wrote:

> As for "by the way ... was used to make this commit": this is git.  So how
> you arrived at the tree state you record in a commit *does not matter*.

But it _does_ matter, which is why we have commit messages to explain
how you arrived at this tree state.

Now, that being said:

> After reading the discussion so far, I am still not convinced if this is a
> good idea, nor this time around it is that much different from what the
> previous "prior" link discussion tried to do.

For the record, I am not convinced it is a good idea either; I was
hoping to steer it in a direction where somebody could say "and now this
is the useful thing we can do now that we could not do before." If the
ultimate goal is to put links to other commits into history viewers,
then the commit message is a reasonable place to do so. The only thing I
see improving with a header is that it makes more sense for pruning and
object transfer.

-Peff
