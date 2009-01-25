From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 1/3] Introduce config variable "diff.primer"
Date: Sun, 25 Jan 2009 18:25:20 -0500
Message-ID: <20090125232520.GB19099@coredump.intra.peff.net>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu> <1232904657-31831-2-git-send-email-keith@cs.ucla.edu> <alpine.DEB.1.00.0901251916010.14855@racer> <alpine.GSO.2.00.0901251033160.12651@kiwi.cs.ucla.edu> <20090125221141.GA17490@coredump.intra.peff.net> <alpine.GSO.2.00.0901251446260.12651@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Mon Jan 26 00:26:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRENK-0000GP-U9
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 00:26:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbZAYXZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 18:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbZAYXZX
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 18:25:23 -0500
Received: from peff.net ([208.65.91.99]:49768 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750786AbZAYXZX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 18:25:23 -0500
Received: (qmail 29131 invoked by uid 107); 25 Jan 2009 23:25:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 25 Jan 2009 18:25:30 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Jan 2009 18:25:20 -0500
Content-Disposition: inline
In-Reply-To: <alpine.GSO.2.00.0901251446260.12651@kiwi.cs.ucla.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107127>

On Sun, Jan 25, 2009 at 02:58:34PM -0800, Keith Cascio wrote:

> OK, point taken.  I wasn't trying to be idiosyncratic at all.  Just
> trying to be explicit and avoid all confusion.  Since all diff options
> already have default values, primer looks to me like the layer one
> step above defaults, hence the painting analogy.  Mercurial calls it
> "defaults", but that doesn't mean we should necessarily follow in
> their footsteps (see
> http://article.gmane.org/gmane.comp.version-control.git/107103).
> 
> I think being as clear as possible about what primer is, that is it
> NOT defaults, helps to feel more comfortable with its consequences,
> i.e. in my opinion, that it will not break things.

I'm not sure I agree that they are not new defaults, but any such
argument is going to get into the exact definition of "default" which is
not really useful to the task at hand.

I think "options" is a better word (as in, pretend like you already
specified these "options" on the command line), but I am not going to
insist on that. I mainly just wanted to point out that I found "primer"
confusing. Enough so that, even though I knew you were interested in
this topic from your previous mails, I saw the word "primer" and said to
myself: "what in the world is this patch about?"

-Peff
