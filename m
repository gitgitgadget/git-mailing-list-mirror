From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: use "spurious .sp" XSLT if
	DOCBOOK_SUPPRESS_SP is set
Date: Wed, 1 Apr 2009 06:34:42 -0400
Message-ID: <20090401103442.GD26181@coredump.intra.peff.net>
References: <7vljql4586.fsf@gitster.siamese.dyndns.org> <1238575834-17838-1-git-send-email-chris_johnsen@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: Chris Johnsen <chris_johnsen@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 12:40:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Loxrs-0003tk-Jq
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 12:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752456AbZDAKez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 06:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752058AbZDAKez
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 06:34:55 -0400
Received: from peff.net ([208.65.91.99]:50204 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751962AbZDAKey (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 06:34:54 -0400
Received: (qmail 16481 invoked by uid 107); 1 Apr 2009 10:35:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 01 Apr 2009 06:35:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Apr 2009 06:34:42 -0400
Content-Disposition: inline
In-Reply-To: <1238575834-17838-1-git-send-email-chris_johnsen@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115369>

On Wed, Apr 01, 2009 at 03:50:34AM -0500, Chris Johnsen wrote:

> The key revisions in the docbook SVN repo seem to be 5144 (before
> docbook-xsl 1.69.1) and 6359 (before docbook-xsl 1.71.1).
> 
> Testing done with asciidoc 8.3.1 and docbook-xsl 1.74.0.

In the course of your SVN research, did you find the fixes between
1.73.1 and 1.74.3 that fixed the spacing issue? If so, I wonder if it's
worth backporting that fix to DOCBOOK_FIX_LIST_SPACING.

-Peff
