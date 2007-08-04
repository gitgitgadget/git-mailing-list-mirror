From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-gui: Added support for OS X right click
Date: Sat, 4 Aug 2007 13:58:26 -0400
Message-ID: <20070804175826.GC17113@sigill.intra.peff.net>
References: <C4431971-A1F1-463E-B238-D351FCBB57F8@pp.inet.fi> <20070804065516.GS20052@spearce.org> <20070804071131.GA6557@coredump.intra.peff.net> <alpine.LFD.0.999.0708040928350.5037@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	V?in? J?rvel? <v@pp.inet.fi>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 19:58:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHNta-0007NB-4B
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 19:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbXHDR6b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 4 Aug 2007 13:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764923AbXHDR6b
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 13:58:31 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3683 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764167AbXHDR6a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 13:58:30 -0400
Received: (qmail 1348 invoked from network); 4 Aug 2007 17:58:34 -0000
Received: from unknown (HELO sigill.intra.peff.net) (10.0.0.7)
  by peff.net with (DHE-RSA-AES256-SHA encrypted) SMTP; 4 Aug 2007 17:58:34 -0000
Received: (qmail 17384 invoked by uid 1000); 4 Aug 2007 17:58:26 -0000
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0708040928350.5037@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54892>

On Sat, Aug 04, 2007 at 09:37:17AM -0700, Linus Torvalds wrote:

> However (and this is a pretty common thing), the *headers* are=20
> unspecified, and a lot of email clients seem to think that if that=20
> happens, they default to US-ASCII and think that those iso-latin1=20
> characters are crud.

Well, that _is_ what the standard says, I believe. I agree with you tha=
t
practice is more important than a standard, and if there are high-bit
characters in the 'From' field, I think that using the body charset is =
a
reasonable guess (although keep in mind that the "body" could be hidden
below a multipart/mixed,  multipart/alternative, or some other arcane
structure).

But I really have no idea why fully mime-aware mailers refuse to use
rfc2047 encoding of the headers. In fact, my copy of the message you
sent (to which I am replying) has munged V=E4in=F6's name in the cc hea=
der,
because it failed to use rfc2047 encoding. I'm surprised that alpine
would fail to get that right.

-Peff
