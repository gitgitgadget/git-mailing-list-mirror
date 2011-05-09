From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] only warn about ambiguous refs if stderr is a tty
Date: Mon, 9 May 2011 18:09:52 -0400
Message-ID: <20110509220952.GD3719@sigill.intra.peff.net>
References: <BANLkTinLCirA4XP9AOb9piGo9ucMsmrmkQ@mail.gmail.com>
 <1304927478-3112-1-git-send-email-kusmabite@gmail.com>
 <20110509080315.GA6205@sigill.intra.peff.net>
 <BANLkTimR_S-px-MfRy0pKGrjxOgSC_=e=A@mail.gmail.com>
 <20110509103208.GA9060@sigill.intra.peff.net>
 <BANLkTimn7542tji-Uu5iH72HS9fcnaywvg@mail.gmail.com>
 <20110509124931.GA18197@sigill.intra.peff.net>
 <7vmxivq1fg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	steveire@gmail.com, felipe.contreras@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 00:10:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJYef-00088a-9E
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 00:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183Ab1EIWJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 18:09:56 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39572
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932232Ab1EIWJy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 18:09:54 -0400
Received: (qmail 12883 invoked by uid 107); 9 May 2011 22:11:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 May 2011 18:11:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2011 18:09:52 -0400
Content-Disposition: inline
In-Reply-To: <7vmxivq1fg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173274>

On Mon, May 09, 2011 at 09:33:07AM -0700, Junio C Hamano wrote:

> >> I think having the ambiguity warning in itself isn't the problem, it's
> >> gitk not swallowing it that is.
> >
> > Agreed.
> 
> I agree with both of the above.  It seems that the only thing we would
> need is to do (3) and nothing else in Erik's original list?
> [...]
> >>  3) Make gitk understand and forward warnings to the user

Yeah, I think so. Now we just need a volunteer who wants to write some
tcl.  :)

-Peff
