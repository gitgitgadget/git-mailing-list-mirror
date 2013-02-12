From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv4 3/6] Git.pm: refactor command_close_bidi_pipe to use
 _cmd_close
Date: Tue, 12 Feb 2013 15:48:07 -0500
Message-ID: <20130212204807.GB25330@sigill.intra.peff.net>
References: <cover.1360677646.git.mina86@mina86.com>
 <fc760829f74f31d23f94b61a9e087eda2a66956e.1360677646.git.mina86@mina86.com>
 <7va9r9gy5y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michal Nazarewicz <mpn@google.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 21:48:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5MmP-00045l-0X
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 21:48:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759077Ab3BLUsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 15:48:10 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45471 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759069Ab3BLUsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 15:48:09 -0500
Received: (qmail 5484 invoked by uid 107); 12 Feb 2013 20:49:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Feb 2013 15:49:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Feb 2013 15:48:07 -0500
Content-Disposition: inline
In-Reply-To: <7va9r9gy5y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216194>

On Tue, Feb 12, 2013 at 10:55:05AM -0800, Junio C Hamano wrote:

> Michal Nazarewicz <mpn@google.com> writes:
> 
> > From: Michal Nazarewicz <mina86@mina86.com>
> >
> > The body of the loop in command_close_bidi_pipe function is identical to
> > what _cmd_close function does so instead of duplicating, refactor change
> > _cmd_close so that it accepts list of file handlers to be closed, which
> 
> s/file handlers/file handles/, I think.

And s/refactor change/refactor/.

Other than that, I think the series looks OK. I have one style micro-nit
on patch 4 which I'll reply in-line. But it is either "fix while
applying" or "ignore", I don't think it will be worth a re-roll.

-Peff
