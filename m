From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] git push: Push nothing if no refspecs are given or
	configured
Date: Mon, 9 Mar 2009 17:10:33 -0400
Message-ID: <20090309211033.GA5989@coredump.intra.peff.net>
References: <20090305221529.GA25871@pvv.org> <alpine.DEB.1.00.0903061126550.10279@pacific.mpi-cbg.de> <200903092139.35788.markus.heidelberg@web.de> <alpine.DEB.1.00.0903092148040.6358@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Markus Heidelberg <markus.heidelberg@web.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 09 22:12:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgmlo-0006Yn-T6
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 22:12:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759AbZCIVKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 17:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753244AbZCIVKx
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 17:10:53 -0400
Received: from peff.net ([208.65.91.99]:54121 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752784AbZCIVKw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 17:10:52 -0400
Received: (qmail 4014 invoked by uid 107); 9 Mar 2009 21:10:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 09 Mar 2009 17:10:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Mar 2009 17:10:33 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0903092148040.6358@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112744>

On Mon, Mar 09, 2009 at 09:48:31PM +0100, Johannes Schindelin wrote:

> > > The two spaces after the full stop were not actually a typo.
> > 
> > What's its purpose? Just recently I added "set nojoinspaces" to my
> > .vimrc to not insert two spaces when joining sentences.
> 
> It was explained to me as "English grammar".  Two spaces after a full 
> stop.

It's not grammar, but rather a typographical convention dating to
monospaced print fonts. It's mostly outdated these days for computer
input, as markup languages will put in the "right" amount of space
automatically (e.g., one and two spaces after a period are equivalent in
both TeX and HTML) and proportional fonts and justification mean your
spacing isn't standard, anyway. So as a rule, it seems to be dying out.
You can google "two spaces after period" to see the ensuing flamewars.

In this particular instance, we consider the pre-markup version
something readable (since that is the point of asciidoc), and people
will tend to view it in a monospaced fonts. So it at least makes a
difference here (and you can then have a flamewar about how it looks).

-Peff
