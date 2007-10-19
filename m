From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 04:11:28 -0400
Message-ID: <20071019081127.GA30168@coredump.intra.peff.net>
References: <20071019062219.GA28499@coredump.intra.peff.net> <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com> <20071019073938.GN14735@spearce.org> <20071019075725.GA29436@coredump.intra.peff.net> <20071019080755.GO14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Symonds <dsymonds@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 10:11:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IimxQ-000668-Ba
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 10:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933094AbXJSILf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 04:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbXJSILe
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 04:11:34 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3313 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751111AbXJSILd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 04:11:33 -0400
Received: (qmail 10394 invoked by uid 111); 19 Oct 2007 08:11:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 19 Oct 2007 04:11:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Oct 2007 04:11:28 -0400
Content-Disposition: inline
In-Reply-To: <20071019080755.GO14735@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61670>

On Fri, Oct 19, 2007 at 04:07:55AM -0400, Shawn O. Pearce wrote:

> Then you get linewrap on smaller terminals, and bigger ones don't
> line up the right side.  *shrug*

Bigger ones will line up, just not on the far right side of the
terminal. I guess we ought to support smaller terminals, though).

> > > +			show_update("* branch", note, "->", "FETCH_HEAD", NULL);
> > Hrm, btw, I can't seem to get this one to show (I was curious how ugly
> > the FETCH_HEAD would look).
> Yea, I can't easily see how to get this to generate.

I thought "git-fetch bare_url" would do it, since then we have no
remote fetchspec to look up, but it doesn't.

> > Also, I was unable to generate a test case that showed this one. Did
> > you?
> git fetch -v jc

Ah, thanks.

-Peff
