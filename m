From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/3] valgrind: ignore ldso and more libz errors
Date: Sun, 25 Jan 2009 19:14:52 -0500
Message-ID: <20090126001451.GA20256@coredump.intra.peff.net>
References: <20090121001219.GA18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210209580.19014@racer> <20090121190201.GA21686@coredump.intra.peff.net> <alpine.DEB.1.00.0901212137130.3586@pacific.mpi-cbg.de> <20090121215318.GA9107@sigill.intra.peff.net> <alpine.DEB.1.00.0901212332030.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901260014470.14855@racer> <alpine.DEB.1.00.0901260019000.14855@racer> <20090125233243.GD19099@coredump.intra.peff.net> <alpine.DEB.1.00.0901260101030.14855@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 26 01:16:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRF9M-0002Rd-O7
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 01:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbZAZAOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 19:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbZAZAOz
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 19:14:55 -0500
Received: from peff.net ([208.65.91.99]:39344 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbZAZAOy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 19:14:54 -0500
Received: (qmail 29659 invoked by uid 107); 26 Jan 2009 00:15:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 25 Jan 2009 19:15:01 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Jan 2009 19:14:52 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901260101030.14855@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107145>

On Mon, Jan 26, 2009 at 01:02:24AM +0100, Johannes Schindelin wrote:

> > Your 0/3 cover letter lists this me as the author of this patch, but 
> > there is no "From:" line at the top of this email. I don't particularly 
> > care one way or the other for this patch, but I wanted to point it out 
> > as a potential issue with your patch-sending workflow.
> 
> Yep, sorry.  I would not touch send-email with lead-protected gloves, so 
> what I do is to edit all patches I send.  And in this case, I missed the 
> fact that there was another "From:".  I am sorry.

Heh. I certainly can't blame you for that; I don't use send-email
myself.

It might be convenient for format-patch to have a mode where it uses the
committer as the rfc822 "From:" and then adds a "From:" for the author
in the body if it is not the same as the committer.

It certainly shouldn't be the default, since that would confuse things
like rebase. But it makes sense if you are just going to throw away the
From header anyway when you import into your MUA.

-Peff
