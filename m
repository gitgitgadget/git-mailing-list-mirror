From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Builtin-commit: show on which branch a commit was added
Date: Mon, 29 Sep 2008 18:44:30 -0400
Message-ID: <20080929224430.GA11545@sigill.intra.peff.net>
References: <4C04A26E-5829-4A39-AD89-F5A68E606AA3@ai.rug.nl> <1220634785-55543-1-git-send-email-pdebie@ai.rug.nl> <7vzlmkpltb.fsf@gitster.siamese.dyndns.org> <20080921104238.GA9217@sigill.intra.peff.net> <A36A4B61-D223-4821-9969-FA76EAECD1EC@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Tue Sep 30 00:45:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkRUw-00028Z-2U
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 00:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbYI2Woe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 18:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596AbYI2Woe
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 18:44:34 -0400
Received: from peff.net ([208.65.91.99]:1591 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487AbYI2Woe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 18:44:34 -0400
Received: (qmail 27593 invoked by uid 111); 29 Sep 2008 22:44:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 29 Sep 2008 18:44:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Sep 2008 18:44:30 -0400
Content-Disposition: inline
In-Reply-To: <A36A4B61-D223-4821-9969-FA76EAECD1EC@ai.rug.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97056>

On Mon, Sep 29, 2008 at 10:09:17PM +0200, Pieter de Bie wrote:

> How about something like
>
> 	Created commit abcd1234 on widget -- "subwidget: one line summary"

I think that is probably just trading one visual problem for another.
That is, there are other people will have the same problem with "--"
that I had with ": ".

And of course it doesn't deal with the line length issues.

Anyway, I seem to be the only one complaining, so perhaps it should just
be left as-is.

-Peff
