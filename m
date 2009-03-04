From: Jeff King <peff@peff.net>
Subject: Re: Subject: [PATCH] Push to create
Date: Wed, 4 Mar 2009 00:42:11 -0500
Message-ID: <20090304054211.GA3753@coredump.intra.peff.net>
References: <20090301031609.GA30384@coredump.intra.peff.net> <7v63itbxe7.fsf@gitster.siamese.dyndns.org> <20090301100039.GD4146@coredump.intra.peff.net> <20090301170436.GA14365@spearce.org> <7vwsb7gkvt.fsf_-_@gitster.siamese.dyndns.org> <20090303070937.GB30609@coredump.intra.peff.net> <76718490903022337n79a0c11cw95e80d99cd598d17@mail.gmail.com> <7vtz6bf392.fsf@gitster.siamese.dyndns.org> <20090303082318.GB3158@coredump.intra.peff.net> <76718490903031157o2938d46cl6c33e78cf64ad9d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 06:43:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LejtS-0004pK-91
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 06:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbZCDFmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 00:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbZCDFmS
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 00:42:18 -0500
Received: from peff.net ([208.65.91.99]:40687 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751298AbZCDFmS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 00:42:18 -0500
Received: (qmail 22026 invoked by uid 107); 4 Mar 2009 05:42:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 04 Mar 2009 00:42:17 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Mar 2009 00:42:11 -0500
Content-Disposition: inline
In-Reply-To: <76718490903031157o2938d46cl6c33e78cf64ad9d1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112181>

On Tue, Mar 03, 2009 at 02:57:15PM -0500, Jay Soffian wrote:

> FWIW, I like this proposal. The only issue I have which I think simply
> cannot be reconciled is this: it doesn't do anything to help a user
> that expects "git push --init ssh://..." to "just work". (And here I'm
> assuming push --init just calls init --remote under the covers.) The
> reason is that such a user is probably just using the git supplied by
> their vendor, and thus remote creation is likely disabled by default.
> The best I can come up with is a different error message:
> 
> "Sorry, remote repo creation not allowed. To enable it, blah blah blah"
> 
> So at least the user has a clue that git can help them here, but there
> are security reasons it does not do so by default.

Yeah, the error messages should be more descriptive. Sites that have a
web interface can even do:

  Sorry, remote repo creation must be down through the web interface.
  Please go to http://host/$user/create/$repo.

where the URL can be customized based on the user and repo that made the
request.

Now we just need somebody who cares enough about this feature to work on
it. ;)

-Peff
