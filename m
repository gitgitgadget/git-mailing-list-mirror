From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] docs/checkout: clarify what "non-branch" means
Date: Wed, 15 Apr 2009 13:58:46 -0400
Message-ID: <20090415175846.GF23332@coredump.intra.peff.net>
References: <20090413110947.GA15647@coredump.intra.peff.net> <20090413112104.GE15982@coredump.intra.peff.net> <7vmyakh5wc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 20:00:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu9PQ-0003Lz-HG
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 20:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083AbZDOR6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 13:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753059AbZDOR6x
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 13:58:53 -0400
Received: from peff.net ([208.65.91.99]:60264 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897AbZDOR6w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 13:58:52 -0400
Received: (qmail 27920 invoked by uid 107); 15 Apr 2009 17:58:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 15 Apr 2009 13:58:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Apr 2009 13:58:46 -0400
Content-Disposition: inline
In-Reply-To: <7vmyakh5wc.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116639>

On Mon, Apr 13, 2009 at 09:31:31AM -0700, Junio C Hamano wrote:

> > I hope this helps a little bit with Mark's confusion. But while writing
> > it, I really think it would be a simpler rule to say "if it's in
> > refs/heads/, then it's a branch" (which is similar to what Mark
> > suggested earlier).
> >
> > So "git checkout refs/heads/master" would be identical to "git checkout
> > master". That would require a code change, though.
> 
> Sorry, but I do not get the logic behind such a change.

It is entirely about simplifying the mental model of "what is a branch"
for the user, and making it easier to explain in the documentation.

I think otherwise your analysis was right: it doesn't really buy much in
practical usage, and it slightly hurts people with crazy branch names
like "refs/heads/refs/heads/foo" (but I consider that unlikely enough
not to worry about).

-Peff
