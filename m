From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/2] Re: user-manual: general improvements
Date: Thu, 21 May 2009 00:15:29 -0400
Message-ID: <20090521041529.GD8091@sigill.intra.peff.net>
References: <1241650416-12224-1-git-send-email-felipe.contreras@gmail.com> <20090507072326.GA13123@vidovic> <7veiv0cvdt.fsf@alter.siamese.dyndns.org> <20090508042814.GA30031@vidovic> <94a0d4530905131430q2250a43ei692265c3f32b5715@mail.gmail.com> <20090514160609.GA12910@vidovic> <7vvdnvtf2n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 21 06:15:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6zgw-0007ki-Fr
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 06:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbZEUEPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 00:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbZEUEP3
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 00:15:29 -0400
Received: from peff.net ([208.65.91.99]:52925 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbZEUEP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 00:15:29 -0400
Received: (qmail 12205 invoked by uid 107); 21 May 2009 04:15:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 21 May 2009 00:15:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 May 2009 00:15:29 -0400
Content-Disposition: inline
In-Reply-To: <7vvdnvtf2n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119653>

On Wed, May 20, 2009 at 06:33:36PM -0700, Junio C Hamano wrote:

> >> http://people.freedesktop.org/~felipec/git/user-manual-general-improvements/
> >
> > Thank you very much Felipe to take the time to upload the patches there.
> > I already have a copy there and I'll look at it soon.
> 
> Has anybody looked at this?  It's a bit large-ish and touches all over the
> place, so I am finding it a bit hard to concentrate on it myself really
> nitpicking, but from the cursory look after formatting the result looked
> Ok.

I started to, but the first commit message is lacking something that I
think would make reviewing much simpler: what are the general classes of
changes that are being made?

I see some doublequotes becoming backticks, and some becoming single
quotes. And some becoming tex-quotes (``...''), and even some becoming
doublequotes _with_ single quotes. It would be easier to verify that
they are doing the right thing if the commit message briefly described
the rules it followed for changing each one. I think they are something
like:

  - tex-quotes if it was really a prose-style quotation

  - backticks (causing monospace) for branch names, commands, etc in
    prose

but that leaves me confused. Some things which I thought should be in
monospace backticks are in single-quotes (causing emphasis). Like
'master' or 'linux-2.6'. And some things are emphasized and in double
quotes in the prose, like '"o"' or '"branch A"'. What is the rule to
decide which text should have visible doublequotes but also be
emphasized, as opposed to just having double-quotes or just being
emphasized?

Maybe this was even discussed earlier in the thread (I didn't go back to
look), but it should definitely be part of the commit message.

-Peff
