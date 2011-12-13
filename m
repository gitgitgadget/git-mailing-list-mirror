From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Makefile: optionally exclude code that needs Unix
 sockets
Date: Mon, 12 Dec 2011 19:58:12 -0500
Message-ID: <20111213005812.GA3947@sigill.intra.peff.net>
References: <7vzkexwb7m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 01:58:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaGhJ-0008Qa-5i
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 01:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027Ab1LMA6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 19:58:15 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48439
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753890Ab1LMA6P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 19:58:15 -0500
Received: (qmail 8545 invoked by uid 107); 13 Dec 2011 01:04:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Dec 2011 20:04:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2011 19:58:12 -0500
Content-Disposition: inline
In-Reply-To: <7vzkexwb7m.fsf@alter.siamese.dyndns.org>
 <7v1us91i5b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186995>

On Mon, Dec 12, 2011 at 03:31:44PM -0800, Junio C Hamano wrote:

> > In theory we should also disable the documentation for credential-cache.
> > But that means surgery not only to Documentation/Makefile, but figuring
> > out how to pass the flags down to the actual asciidoc process (since
> > gitcredentials(7) mentions it in the text). Certainly possible, but I
> > don't know if it's worth the effort or not.
> 
> I do not think it matters that much. We've been shipping documentation for
> stuff like remote archiver and daemon without conditional compilation, no?

True. Let's not worry about it, then.

> I'll queue a single patch that is a squash between 2/2 and Peff's test
> updates between "credentials: add "cache" helper" and "strbuf: add
> strbuf_add*_urlencode" in the series.

That's perfect. Thanks.

-Peff
