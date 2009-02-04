From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] builtin-remote: make rm() use properly named
	variable to hold return value
Date: Wed, 4 Feb 2009 10:34:46 -0500
Message-ID: <20090204153446.GD6896@sigill.intra.peff.net>
References: <76718490902030638y36299191i1fcc2ab8646b9593@mail.gmail.com> <1233683473-87893-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 16:36:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUjnU-00023F-W5
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 16:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585AbZBDPev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 10:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752275AbZBDPev
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 10:34:51 -0500
Received: from peff.net ([208.65.91.99]:49230 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752257AbZBDPeu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 10:34:50 -0500
Received: (qmail 29736 invoked by uid 107); 4 Feb 2009 15:35:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 04 Feb 2009 10:35:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Feb 2009 10:34:46 -0500
Content-Disposition: inline
In-Reply-To: <1233683473-87893-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108380>

On Tue, Feb 03, 2009 at 12:51:12PM -0500, Jay Soffian wrote:

> "i" is a loop counter and should not be used to hold a return value; use
> "result" instead which is consistent with the rest of builtin-remote.c.
> 
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---
> I'm not sure this minor change needed to be broken out into its own commit,
> so squash with 2/2 if that's appropriate.

Looks obviously correct to me...

-Peff
