From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Expand ~ and ~user in core.excludesfile,
 commit.template
Date: Tue, 17 Nov 2009 03:56:03 -0500
Message-ID: <20091117085603.GB4928@coredump.intra.peff.net>
References: <1258366060-27966-1-git-send-email-Matthieu.Moy@imag.fr>
 <20091117073426.GB4007@coredump.intra.peff.net>
 <vpqpr7hpm5b.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Karl Chen <quarl@quarl.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Nov 17 09:56:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAJrK-0004rU-K5
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 09:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243AbZKQIz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 03:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753084AbZKQIz6
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 03:55:58 -0500
Received: from peff.net ([208.65.91.99]:57883 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752697AbZKQIz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 03:55:58 -0500
Received: (qmail 22211 invoked by uid 107); 17 Nov 2009 08:59:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 17 Nov 2009 03:59:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Nov 2009 03:56:03 -0500
Content-Disposition: inline
In-Reply-To: <vpqpr7hpm5b.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133080>

On Tue, Nov 17, 2009 at 09:53:52AM +0100, Matthieu Moy wrote:

> Yes. "user" in the sentence is either the user running Git or the same
> string as "user" in "~user". I'm not against your proposal, but I'm
> afraid we're making the sentence uselessly heavy, since, as you say,
> this ~ and ~user convention is widely spread, and I hardly imagine
> someone interpreting the sentence as "if you say ~foo, it will expand
> to the home directory of bar".

I didn't think it would expand ~foo to the home directory of bar. I
thought that it might _only_ accept ~bar, and not ~foo.

If I'm the only one confused, then we can drop it. But if not, I don't
think it is much more work to be precise.

-Peff
