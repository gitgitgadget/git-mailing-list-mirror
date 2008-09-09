From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/6] t9400, t9401: use "git cvsserver" without dash
Date: Tue, 9 Sep 2008 17:56:35 -0400
Message-ID: <20080909215635.GA4226@coredump.intra.peff.net>
References: <20080910062529.6117@nanako3.lavabit.com> <7vljy13sq0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 23:57:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdBDU-0006qA-JV
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 23:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291AbYIIV4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 17:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753243AbYIIV4h
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 17:56:37 -0400
Received: from peff.net ([208.65.91.99]:3321 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752212AbYIIV4h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 17:56:37 -0400
Received: (qmail 21340 invoked by uid 111); 9 Sep 2008 21:56:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 09 Sep 2008 17:56:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Sep 2008 17:56:35 -0400
Content-Disposition: inline
In-Reply-To: <7vljy13sq0.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95447>

On Tue, Sep 09, 2008 at 02:38:31PM -0700, Junio C Hamano wrote:

> My eyes are getting dry after looking at these s/git-/git / patches, so
> please do not get offended if I leave these in my Inbox unread for a few
> days.

I did the same "look for conversion that should _not_ have occurred"
check for these patches, and all look sane with two exceptions:

 - the cvsserver stuff that you mentioned

 - patch 4/6 changes the commit log message in a few cases for some "git
   svn" tests; presumably nothing is caring about the commit id's
   generated here, but I don't actually have svn installed to run the
   tests to be sure

> So why don't we do this (not just for test but for documentation as well)?
> 
>  * We do not use "git foo" form when refering to the "server side
>    programs".  Make it official;
> 
>  * We move "server side programs" in git(7) documentation into its
>    separate subsection; and
> 
>  * We always install "server side programs" in $(bindir).
> 
> I think git-cvsserver is the last one we missed from the set of server
> side programs (git-cvsserver, git-daemon, git-receive-pack,
> git-upload-archive, git-upload-pack).

That makes perfect sense to me.

-Peff
