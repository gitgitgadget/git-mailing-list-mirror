From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin-rm: Add a --force flag
Date: Fri, 8 Aug 2008 20:05:36 -0400
Message-ID: <20080809000536.GB6065@sigill.intra.peff.net>
References: <1218235022-33695-1-git-send-email-pdebie@ai.rug.nl> <7v8wv7az0z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 02:06:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRbyk-0000mJ-Fp
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 02:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650AbYHIAFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 20:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754604AbYHIAFk
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 20:05:40 -0400
Received: from peff.net ([208.65.91.99]:4795 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754516AbYHIAFj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 20:05:39 -0400
Received: (qmail 24145 invoked by uid 111); 9 Aug 2008 00:05:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 08 Aug 2008 20:05:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Aug 2008 20:05:36 -0400
Content-Disposition: inline
In-Reply-To: <7v8wv7az0z.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91729>

On Fri, Aug 08, 2008 at 04:05:16PM -0700, Junio C Hamano wrote:

> I think this makes sense even this late in -rc cycle.  Thanks.

Maybe squash this in?

-Peff

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 4d0c495..0aaf161 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -36,6 +36,7 @@ OPTIONS
 	but this requires the `-r` option to be explicitly given.
 
 -f::
+--force::
 	Override the up-to-date check.
 
 -n::
