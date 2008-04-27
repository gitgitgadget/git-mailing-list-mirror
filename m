From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-email: add a new sendemail.cc configuration
	variable
Date: Sun, 27 Apr 2008 19:51:21 -0400
Message-ID: <20080427235120.GA13948@sigill.intra.peff.net>
References: <1209244746-12649-1-git-send-email-vmiklos@frugalware.org> <alpine.DEB.1.00.0804262330370.7944@eeepc-johanness> <20080426232737.GR4012@genesis.frugalware.org> <alpine.DEB.1.00.0804271252200.16320@eeepc-johanness> <20080427121458.GU4012@genesis.frugalware.org> <7vprsbf3hz.fsf@gitster.siamese.dyndns.org> <20080427224255.GD31919@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 01:52:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqGf5-0007EX-M5
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 01:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758592AbYD0XvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 19:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108AbYD0XvQ
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 19:51:16 -0400
Received: from peff.net ([208.65.91.99]:1790 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752038AbYD0XvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 19:51:16 -0400
Received: (qmail 1009 invoked by uid 111); 27 Apr 2008 23:51:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 27 Apr 2008 19:51:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 27 Apr 2008 19:51:21 -0400
Content-Disposition: inline
In-Reply-To: <20080427224255.GD31919@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80493>

On Mon, Apr 28, 2008 at 12:42:55AM +0200, Miklos Vajna wrote:

> Also, what is the preferred way of the testing method in this case?
> Should I just rely on a --dry-run output?

Look in t9001; there is a fake sendmail wrapper that outputs the sent
messages to files. You can then inspect the files to see that the
correct headers were added.

-Peff
