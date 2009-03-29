From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] Documentation/Makefile: make most operations
	"quiet"
Date: Sun, 29 Mar 2009 07:52:52 -0400
Message-ID: <20090329115252.GB31649@coredump.intra.peff.net>
References: <1238136579-23166-1-git-send-email-chris_johnsen@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Chris Johnsen <chris_johnsen@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 29 13:54:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LntbB-0002Yo-4L
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 13:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753675AbZC2LxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 07:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753307AbZC2LxC
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 07:53:02 -0400
Received: from peff.net ([208.65.91.99]:35660 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620AbZC2LxA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 07:53:00 -0400
Received: (qmail 30768 invoked by uid 107); 29 Mar 2009 11:53:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 29 Mar 2009 07:53:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 29 Mar 2009 07:52:52 -0400
Content-Disposition: inline
In-Reply-To: <1238136579-23166-1-git-send-email-chris_johnsen@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115020>

On Fri, Mar 27, 2009 at 01:49:38AM -0500, Chris Johnsen wrote:

> "v1" of this series can be found here: <http://thread.gmane.org/gmane.comp.version-control.git/114417/focus=114557>.
> 
> Changes since "v1": Fixed broken technical/api-index.txt target
>   (thanks, Peff). Extended error propagation across calls to
>   DOCBOOK2X_TEXI for gitman.texi. Added QUIET_XSLTPROC for
>   "one-off" user-manual.html.

This version looks fine to me (though I admit I didn't look at the texi,
since I don't have that toolchain installed).

Thanks for detailing in both series what changed from v1; that makes it
much simpler to review.

-Peff
