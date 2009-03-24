From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/8] Documentation: move quieting params into
	manpage-base.xsl
Date: Tue, 24 Mar 2009 05:18:36 -0400
Message-ID: <20090324091836.GD1799@coredump.intra.peff.net>
References: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com> <1237881866-5497-5-git-send-email-chris_johnsen@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Chris Johnsen <chris_johnsen@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 10:20:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm2oB-0003Du-NH
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 10:20:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757467AbZCXJSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 05:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755904AbZCXJSq
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 05:18:46 -0400
Received: from peff.net ([208.65.91.99]:50208 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756826AbZCXJSp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 05:18:45 -0400
Received: (qmail 28464 invoked by uid 107); 24 Mar 2009 09:18:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 24 Mar 2009 05:18:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Mar 2009 05:18:36 -0400
Content-Disposition: inline
In-Reply-To: <1237881866-5497-5-git-send-email-chris_johnsen@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114440>

On Tue, Mar 24, 2009 at 03:04:22AM -0500, Chris Johnsen wrote:

> I am not sure why these were only in the -1.72 variant. They
> should probably be in -base (done by this patch) or in neither
> variant. If there is a good reason for having it only in -1.72,
> this patch can be dropped entirely, the rest do not depend on it.

Digging through the archive, it is hard to say. The original patch
mentions DOCBOOK_XSL_172 as if callouts.xsl were already doing this, but
I don't see any evidence that it ever did.

Definitely an improvement, IMHO. I wonder if we also want to consider
making the "make" output a little nicer to Documentation/Makefile,
similar to how the main Makefiles just prints "CC".

-Peff
