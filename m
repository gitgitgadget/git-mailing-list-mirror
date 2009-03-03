From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] doc: clarify how -S works
Date: Tue, 3 Mar 2009 12:11:38 -0500
Message-ID: <20090303171138.GA454@coredump.intra.peff.net>
References: <49AD3E78.1050706@sneakemail.com> <20090303152333.GB24593@coredump.intra.peff.net> <20090303154041.GA31265@coredump.intra.peff.net> <7v1vted0d7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Valdemar =?utf-8?B?TcO4cmNoIChMaXN0cyk=?= 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 18:13:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeYB7-0007j9-JB
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 18:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167AbZCCRLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 12:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753015AbZCCRLp
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 12:11:45 -0500
Received: from peff.net ([208.65.91.99]:57559 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014AbZCCRLp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 12:11:45 -0500
Received: (qmail 18166 invoked by uid 107); 3 Mar 2009 17:11:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 03 Mar 2009 12:11:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Mar 2009 12:11:38 -0500
Content-Disposition: inline
In-Reply-To: <7v1vted0d7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112122>

On Tue, Mar 03, 2009 at 08:42:12AM -0800, Junio C Hamano wrote:

> In retrospect, because --pickaxe was designed primarily for Porcelain use,
> it was a mistake for it to have taken a short-and-sweet -S synonym.

Hmm. I actually like the pickaxe behavior and find it useful for
searching. IOW, I consider it a porcelain feature, just perhaps not the
one that some people are expecting.

> >  -S<string>::
> > -	Look for differences that contain the change in <string>.
> > +	Look for differences that introduce or remove an instance of
> > +	<string>. Note that this is different than the string simply
> > +	appearing in diff output; see the 'pickaxe' entry in
> > +	linkgit:gitdiffcore[7] for more details.
> 
> Look for differences that change the number of occurrences of <string>?

Yes, that is technically correct. I was trying to find a wording that
was a little less "this is literally what it does" and more "this is
what you might find it useful for".

But I don't care overly much; I just think what was there was quite
misleading. And I've already provided my paint color, so feel free to
apply mine, use what you wrote above, or whatever. Just don't leave it
as-is. ;)

-Peff
