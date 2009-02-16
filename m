From: Jeff King <peff@peff.net>
Subject: disallowing push to currently checked-out branch
Date: Sun, 15 Feb 2009 19:04:43 -0500
Message-ID: <20090216000443.GB3503@coredump.intra.peff.net>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <20090215232013.GA11543@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	david@lang.hm
To: Heikki Orsila <shdl@zakalwe.fi>
X-From: git-owner@vger.kernel.org Mon Feb 16 01:06:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYr05-0006nY-E6
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 01:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039AbZBPAEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 19:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753550AbZBPAEq
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 19:04:46 -0500
Received: from peff.net ([208.65.91.99]:35204 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753515AbZBPAEp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 19:04:45 -0500
Received: (qmail 11384 invoked by uid 107); 16 Feb 2009 00:05:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 15 Feb 2009 19:05:05 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Feb 2009 19:04:43 -0500
Content-Disposition: inline
In-Reply-To: <20090215232013.GA11543@zakalwe.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110096>

On Mon, Feb 16, 2009 at 01:20:13AM +0200, Heikki Orsila wrote:

> > * git-push to update the checked out branch will be refused by default
> > 
> >   Make "git push" into a repository to update the branch that is checked
> >   out fail by default.
> > 
> >   http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007
> 
> If this is implemented, it shouldn't, in my opinion, be a default 
> setting. I regularly push to checkout repos when I'm doing cross machine 
> development. However, I could live with a configurable setting as 
> proposed in the given URL. I think Git should not be too cautious about 
> following users instructions. The user knows what is best for him/her ;)

It is already implemented; the proposal is about setting the default.
The plans for 1.6.2 are already to issue a warning and ask the user to
set the config variable to shut it up.

-Peff
