From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 1/3] Introduce config variable "diff.primer"
Date: Sun, 25 Jan 2009 17:11:42 -0500
Message-ID: <20090125221141.GA17490@coredump.intra.peff.net>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu> <1232904657-31831-2-git-send-email-keith@cs.ucla.edu> <alpine.DEB.1.00.0901251916010.14855@racer> <alpine.GSO.2.00.0901251033160.12651@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Sun Jan 25 23:14:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRDE4-0008SE-Eh
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 23:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbZAYWLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 17:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbZAYWLo
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 17:11:44 -0500
Received: from peff.net ([208.65.91.99]:46241 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848AbZAYWLn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 17:11:43 -0500
Received: (qmail 28456 invoked by uid 107); 25 Jan 2009 22:11:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 25 Jan 2009 17:11:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Jan 2009 17:11:42 -0500
Content-Disposition: inline
In-Reply-To: <alpine.GSO.2.00.0901251033160.12651@kiwi.cs.ucla.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107110>

On Sun, Jan 25, 2009 at 10:44:25AM -0800, Keith Cascio wrote:

> The name "primer" is open to discussion, of course.  But I like it.
> From Merriam-Webster:
> primer n 1: a device for priming 2: material used in priming a surface
> prime vb 1: fill, load 2: to prepare for firing 3: to apply the first color, coating or preparation to <~ a wall>

FWIW, I found it very confusing. I would have expected "diff.options" or
"diff.defaults". There is also some precedent in the form of
GIT_DIFF_OPTS, but I believe it _only_ handles --unified and -u, so it
is not necessarily a useful model.

-Peff
