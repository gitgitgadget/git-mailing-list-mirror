From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Dec 2008, #02; Sun, 14)
Date: Sun, 14 Dec 2008 06:15:48 -0500
Message-ID: <20081214111548.GB6499@coredump.intra.peff.net>
References: <7v7i632mg9.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0812141142300.2014@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 14 12:17:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBoyg-0003sq-DD
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 12:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754472AbYLNLPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 06:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754444AbYLNLPx
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 06:15:53 -0500
Received: from peff.net ([208.65.91.99]:2721 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753241AbYLNLPw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 06:15:52 -0500
Received: (qmail 29089 invoked by uid 111); 14 Dec 2008 11:15:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 14 Dec 2008 06:15:50 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Dec 2008 06:15:48 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0812141142300.2014@eeepc-johanness>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103068>

On Sun, Dec 14, 2008 at 11:44:23AM +0100, Johannes Schindelin wrote:

> > * mv/um-pdf (Wed Dec 10 23:44:50 2008 +0100) 1 commit
> >  - Add support for a pdf version of the user manual
> > 
> > I do not have a new enough combination of dblatex and asciidoc myself 
> > but this would help interested people.
> 
> I haven't had a look at the patches, but isn't "pdflatex" supposed to be 
> the common way to get .pdf files from LaTeX sources?

But we don't have latex sources; we have docbook sources. Hence dblatex
(which does the conversion to PDF internally, so it is a bit of a
misnomer).

-Peff
