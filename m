From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation/git-add.txt: Explain --patch option in
 layman terms
Date: Sun, 30 Aug 2009 17:02:31 -0400
Message-ID: <20090830210231.GA4471@coredump.intra.peff.net>
References: <87ocpxb46g.fsf@jondo.cante.net>
 <7vab1hdppb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 23:03:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhrYE-0001BY-C1
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 23:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754114AbZH3VCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 17:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754096AbZH3VCc
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 17:02:32 -0400
Received: from peff.net ([208.65.91.99]:42748 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754094AbZH3VCc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 17:02:32 -0400
Received: (qmail 19060 invoked by uid 107); 30 Aug 2009 21:02:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 30 Aug 2009 17:02:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Aug 2009 17:02:31 -0400
Content-Disposition: inline
In-Reply-To: <7vab1hdppb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127433>

On Sun, Aug 30, 2009 at 01:14:24PM -0700, Junio C Hamano wrote:

> > -	operation to a subset of the working tree. See ``Interactive
> > -	mode'' for details.
> > +	operation to a subset of the working tree. See section
> > +	``INTERACTIVE MODE'' for details.
> 
> Sorry, the change in this hunk does not make *any* sense to me.
> 
> It is not justified with your commit log message, I do not see why you
> have to shout in all CAPS, and there is no such section in the
> documentation.  But the "Interactive mode" section exists and is referred
> to by the original.

I think it is an attempt to match the way docbook renders manpage
headings; it converts headings to all-caps. And there is some precedent;
try grepping for ".EXAMPLES" in Documentation/*.txt.

That being said, the straight asciidoc->html version leaves the
capitalization untouched. However, that actually makes the html version
look quite awkward. Some of the headings are in all-caps and some are
not. So I wonder if we should make them typographically consistent.

(And yes, I totally agree that this hunk was a surprise after reading
the commit message and if anything is done, it should be in a separate
patch).

-Peff
