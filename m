From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/8] Documentation: XSLT/asciidoc.conf cleanup; tty
	literals
Date: Sun, 29 Mar 2009 07:50:52 -0400
Message-ID: <20090329115052.GA31649@coredump.intra.peff.net>
References: <1238136245-22853-1-git-send-email-chris_johnsen@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Chris Johnsen <chris_johnsen@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 29 13:52:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LntZ6-0002C7-Nl
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 13:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413AbZC2LvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 07:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752234AbZC2LvD
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 07:51:03 -0400
Received: from peff.net ([208.65.91.99]:35655 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620AbZC2LvB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 07:51:01 -0400
Received: (qmail 30730 invoked by uid 107); 29 Mar 2009 11:51:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 29 Mar 2009 07:51:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 29 Mar 2009 07:50:52 -0400
Content-Disposition: inline
In-Reply-To: <1238136245-22853-1-git-send-email-chris_johnsen@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115018>

On Fri, Mar 27, 2009 at 01:43:57AM -0500, Chris Johnsen wrote:

> "v1" of this series can be found here: <http://thread.gmane.org/gmane.comp.version-control.git/114417>.
> 
> Change since "v1":
> 
>   1/8: No content change from "v1". This time -C -M was used to
>        show copy/rename of callouts.xsl (thanks to Peff for
>        pointing to diff.renames config option).
> 
>   2/8: Use <xsl:import> instead of xmlto command line to reuse
>        manpage-base.xsl. In commit message, move discussion of
>        --stringparm to 8/8.
> 
>   8/8: No content change from "v1" (though context is changed due
>        to content change in 2/8). In commit message, add some of
>        --stringparm discussion from "v1" 2/8.

Thanks. This version (and its output) look sane to me (I am now building
with ASCIIDOC_NO_ROFF).

-Peff
