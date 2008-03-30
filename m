From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with
	non-ascii characters
Date: Sun, 30 Mar 2008 00:31:52 -0400
Message-ID: <20080330043151.GA18603@sigill.intra.peff.net>
References: <20080328212700.GA9529@coredump.intra.peff.net> <200803290944.55273.robin.rosenberg.lists@dewire.com> <20080329085304.GC19200@coredump.intra.peff.net> <200803291038.48847.robin.rosenberg.lists@dewire.com> <20080329095238.GB21814@coredump.intra.peff.net> <47EEF71E.7060805@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sun Mar 30 06:32:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfpDi-0007rI-26
	for gcvg-git-2@gmane.org; Sun, 30 Mar 2008 06:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbYC3Eb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 00:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbYC3Eb4
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 00:31:56 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2544 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750719AbYC3Eb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 00:31:56 -0400
Received: (qmail 791 invoked by uid 111); 30 Mar 2008 04:31:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 30 Mar 2008 00:31:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Mar 2008 00:31:52 -0400
Content-Disposition: inline
In-Reply-To: <47EEF71E.7060805@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78498>

On Sun, Mar 30, 2008 at 03:12:46PM +1300, Sam Vilain wrote:

> > Any idea what version of perl started shipping I18N::Langinfo? I
> > couldn't see anything useful from grepping the Changes files.
> Module::CoreList knows.  See the man page for that.

Thanks, I didn't know about that (I foolishly assumed that such
information would be, well, along with the core of perl).

The answer is: I18N::Langinfo started shipping with 5.007003. I think we
have pretty much given up on perl < 5.6 (at least from my experience
with 5.005 on Solaris), so it is probably safe to use.

-Peff
