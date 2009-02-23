From: Jeff King <peff@peff.net>
Subject: Re: autocrlf=input and safecrlf (was Re: CVS import [SOLVED])
Date: Mon, 23 Feb 2009 01:56:15 -0500
Message-ID: <20090223065615.GA24807@coredump.intra.peff.net>
References: <19651.77.61.241.211.1234775877.squirrel@hupie.xs4all.nl> <7291.77.61.241.211.1234790434.squirrel@hupie.xs4all.nl> <60044.192.168.0.51.1234816333.squirrel@hupie.xs4all.nl> <alpine.DEB.1.00.0902162157080.6289@intel-tinevez-2-302> <20090220152849.GA3826@coredump.intra.peff.net> <32886.77.61.241.211.1235147143.squirrel@hupie.xs4all.nl> <20090220172918.GB4636@coredump.intra.peff.net> <499F3B9B.3020709@pelagic.nl> <20090223000840.GA20392@coredump.intra.peff.net> <2944.77.61.241.211.1235371848.squirrel@hupie.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Mon Feb 23 07:57:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbUl7-0003G0-MF
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 07:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbZBWG4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 01:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752037AbZBWG4R
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 01:56:17 -0500
Received: from peff.net ([208.65.91.99]:48854 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525AbZBWG4R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 01:56:17 -0500
Received: (qmail 21071 invoked by uid 107); 23 Feb 2009 06:56:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 23 Feb 2009 01:56:40 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Feb 2009 01:56:15 -0500
Content-Disposition: inline
In-Reply-To: <2944.77.61.241.211.1235371848.squirrel@hupie.xs4all.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111108>

[Can you please wrap your lines? They seem to be about 200 characters,
 and then rewrap the quoted text, but without putting a '>' marker.
 I had a very hard time figuring out what was quoted and what was not.]

On Mon, Feb 23, 2009 at 07:50:48AM +0100, Ferry Huberts (Pelagic) wrote:

> > I am a bit concerned about a proposal to set safecrlf=false in all
> > cvsimported repositories.  You are turning off the protection
> > against corrupting binary files.  _Even if_ the person has put
> > safecrlf=true into their ~/.gitconfig and thinks they are safe.
> 
> Ok.  I follow and agree. Full circle :-) We're back to Johannes'
> proposal: make sure that autocrlf is set to false. Agree? If so, then
> I'll try to whip up a patch.

But won't that now import CRLF's into your new git repo? Especially on
Windows, where (IIRC) cvs gives you files with CRLF by default?

-Peff
