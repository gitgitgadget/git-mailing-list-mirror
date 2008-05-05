From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] I don't known anyone who understands what it means
	when they do a merge and see "file.txt: needs update". "file.txt:
	has changes" is much clearer.
Date: Mon, 5 May 2008 13:05:12 -0400
Message-ID: <20080505170512.GD17863@sigill.intra.peff.net>
References: <1209798522-13618-1-git-send-email-timcharper@gmail.com> <alpine.DEB.1.00.0805031509170.30431@racer> <7v3aozwcj6.fsf@gitster.siamese.dyndns.org> <3DE78C03-DA35-4CB5-8D3D-0529A89065EC@gmail.com> <7v63tvszgo.fsf@gitster.siamese.dyndns.org> <32541b130805031721n29cf470cx391fe0e8b4943706@mail.gmail.com> <7vtzhesvxu.fsf@gitster.siamese.dyndns.org> <32541b130805050935l7257a5e3t9b44d61abe28db37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Tim Harper <timcharper@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 05 19:06:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt48j-0001Ev-4d
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 19:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757311AbYEERFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 13:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757328AbYEERFM
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 13:05:12 -0400
Received: from peff.net ([208.65.91.99]:1191 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755628AbYEERFL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 13:05:11 -0400
Received: (qmail 13859 invoked by uid 111); 5 May 2008 17:05:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 05 May 2008 13:05:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 May 2008 13:05:12 -0400
Content-Disposition: inline
In-Reply-To: <32541b130805050935l7257a5e3t9b44d61abe28db37@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81301>

On Mon, May 05, 2008 at 12:35:06PM -0400, Avery Pennarun wrote:

> Hmm, perhaps the problem then is that we're using plumbing output and
> presenting it to the user as part of the porcelain.  Is there an
> elegant way to fix that?

2>&1 | sed 's/needs update/has local changes/' ?

Oh wait, you said elegant...

-Peff
