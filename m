From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] doc: clarify how -S works
Date: Tue, 3 Mar 2009 12:57:19 -0500
Message-ID: <20090303175719.GC1636@coredump.intra.peff.net>
References: <49AD3E78.1050706@sneakemail.com> <20090303152333.GB24593@coredump.intra.peff.net> <20090303154041.GA31265@coredump.intra.peff.net> <7v1vted0d7.fsf@gitster.siamese.dyndns.org> <20090303171138.GA454@coredump.intra.peff.net> <43d8ce650903030939u73f09171uf4041b6d9824b698@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Peter Valdemar =?utf-8?B?TcO4cmNoIChMaXN0cyk=?= 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 18:59:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeYtJ-00029P-0y
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 18:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbZCCR5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 12:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbZCCR5Y
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 12:57:24 -0500
Received: from peff.net ([208.65.91.99]:34168 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991AbZCCR5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 12:57:24 -0500
Received: (qmail 18726 invoked by uid 107); 3 Mar 2009 17:57:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 03 Mar 2009 12:57:22 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Mar 2009 12:57:19 -0500
Content-Disposition: inline
In-Reply-To: <43d8ce650903030939u73f09171uf4041b6d9824b698@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112137>

On Tue, Mar 03, 2009 at 05:39:38PM +0000, John Tapsell wrote:

> > Yes, that is technically correct. I was trying to find a wording that
> > was a little less "this is literally what it does" and more "this is
> > what you might find it useful for".
> 
> Is there any way to have an option to also match any line containing
> the string?  That might be the best way to document it, as well as
> being very useful:
> 
> -s<string>
>    Look for any additions, removals or changes in any line containing <string>
> -S<string>
>    Look only for any additions or removals of the <string> in any line

Yes, that would be possible (though it is still not foolproof against
moves, as I mentioned elsewhere), and I think it would be simple to
explain the two together.  It just needs somebody to code it.

Unfortunately "-s" is already taken for "no output".

-Peff
