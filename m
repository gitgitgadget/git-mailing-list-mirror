From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diffcore-rename: cache file deltas
Date: Tue, 25 Sep 2007 17:42:00 -0400
Message-ID: <20070925214200.GA2886@sigill.intra.peff.net>
References: <20070925192941.GA8564@coredump.intra.peff.net> <7vy7eu4eos.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 23:41:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaIAE-0006AL-F3
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 23:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbXIYVls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 17:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbXIYVls
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 17:41:48 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2322 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751312AbXIYVlr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 17:41:47 -0400
Received: (qmail 20500 invoked by uid 111); 25 Sep 2007 21:41:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 25 Sep 2007 17:41:46 -0400
Received: (qmail 2925 invoked by uid 1000); 25 Sep 2007 21:42:00 -0000
Content-Disposition: inline
In-Reply-To: <7vy7eu4eos.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59177>

On Tue, Sep 25, 2007 at 02:29:07PM -0700, Junio C Hamano wrote:

> Very nice.

Thank you.

> True.  But we can rename it to diff_file_filespec_blob() and
> that would perfectly well describe what it does.  Will do so
> when applying if it is Ok to you.

Yes, that is a much better name (assuming s/file/free). Please do change
it.

> >  - The hash_chars() should arguably be tied into
> >    diffcore_populate_filespec, which should have more of a "what
> 
> Both good points, but I agree with you that it is wise to do
> that with a follow-up patch.

I think I will leave it, unless you are excited about the change. I feel
like there is a high chance of introducing some bug, and the benefit is
purely stylistic at this point (i.e., the diff code isn't really
changing much at this point, so I think it should just be left alone).

-Peff
