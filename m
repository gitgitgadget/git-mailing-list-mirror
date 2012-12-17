From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] log --format: teach %C(auto,black) to paint it black
 only on terminals
Date: Mon, 17 Dec 2012 17:55:16 -0500
Message-ID: <20121217225516.GA1408@sigill.intra.peff.net>
References: <20121213131329.GA5042@sigill.intra.peff.net>
 <CACsJy8AgtwtJfMXzArJLiHQtR+WNRJxRdRgUts30EN-QvgGT=g@mail.gmail.com>
 <20121215101659.GB21577@sigill.intra.peff.net>
 <7v7gojtbgr.fsf@alter.siamese.dyndns.org>
 <7vobhtm5pk.fsf_-_@alter.siamese.dyndns.org>
 <CACsJy8Dt4vEpO+EcAhWnko=XAajQ9OMgbDbVx78Eb=sZTjmKQA@mail.gmail.com>
 <20121217121354.GB21858@sigill.intra.peff.net>
 <7v4njkmq07.fsf@alter.siamese.dyndns.org>
 <20121217194926.GA5209@sigill.intra.peff.net>
 <7vmwxcla3n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"Srb, Michal" <michal.srb11@imperial.ac.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 23:55:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkjb3-00053i-6R
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 23:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379Ab2LQWzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 17:55:23 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57087 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752491Ab2LQWzT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 17:55:19 -0500
Received: (qmail 10774 invoked by uid 107); 17 Dec 2012 22:56:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Dec 2012 17:56:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2012 17:55:16 -0500
Content-Disposition: inline
In-Reply-To: <7vmwxcla3n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211713>

On Mon, Dec 17, 2012 at 12:03:40PM -0800, Junio C Hamano wrote:

> > So no, I do not think you can cover every conceivable case. But having
> > git-log respect --color and the usual color.* variables for this feature
> > seems like the only sane default. It makes the easy cases just work, and
> > the hard cases are not any worse off (and they may even be better off,
> > since the script can manipulate --color instead of rewriting their
> > format strings, but that is a minor difference).
> 
> OK, care to reroll the one with your patch in the other message
> squashed in, possibly with fixes to the test (the result should now
> honor --color={always,never}, I think)?

Here it is. It was easier to just skip using test_format, so it did not
need to be touched. I broke its cleanups out into a separate patch.

  [1/2]: t6006: clean up whitespace
  [2/2]: log --format: teach %C(auto,black) to respect color config

-Peff
