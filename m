From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Allow generating a non-default set of documentation
Date: Sun, 7 Oct 2012 19:29:42 -0400
Message-ID: <20121007232942.GA5685@sigill.intra.peff.net>
References: <7vzk3yow3f.fsf@alter.siamese.dyndns.org>
 <20121007214855.GB1743@sigill.intra.peff.net>
 <7vwqz1oqi4.fsf@alter.siamese.dyndns.org>
 <20121007230703.GC3490@sigill.intra.peff.net>
 <20121007231156.GD3490@sigill.intra.peff.net>
 <7vlifhooe1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:29:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TL0IJ-0003AS-Cw
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 01:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754614Ab2JGX3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 19:29:47 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44102 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754602Ab2JGX3o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 19:29:44 -0400
Received: (qmail 19794 invoked by uid 107); 7 Oct 2012 23:30:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 07 Oct 2012 19:30:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Oct 2012 19:29:42 -0400
Content-Disposition: inline
In-Reply-To: <7vlifhooe1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207216>

On Sun, Oct 07, 2012 at 04:25:58PM -0700, Junio C Hamano wrote:

> Yeah, modulo that the "defaults" is tracked and does not have to
> have the dash before "include" (it is an error if it is missing,
> no?).  It may want to be named with s/defaults/autodetect/, though.
> 
> > diff --git a/Makefile b/Makefile
> > index e3e3cd5..c00fd32 100644
> > --- a/Makefile
> > +++ b/Makefile
> > ...
> > -endif
> > -
> > +-include config.mak.defaults
> >  -include config.mak.autogen
> >  -include config.mak

Yeah, sorry, mindless copying on my part from the lines below. It
clearly should not have the "-".

I'm fine with something besides "defaults". I meant it to be "these are
the config defaults before you tweak them", but yeah, it is more like
"these are the config options we picked up from uname".

-Peff
