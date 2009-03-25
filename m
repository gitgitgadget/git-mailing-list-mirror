From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Documentation/Makefile: make most operations
	"quiet"
Date: Wed, 25 Mar 2009 00:28:42 -0400
Message-ID: <20090325042842.GB15498@coredump.intra.peff.net>
References: <20090324091836.GD1799@coredump.intra.peff.net> <1237954900-21161-1-git-send-email-chris_johnsen@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Chris Johnsen <chris_johnsen@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 05:30:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmKkx-0007RB-Jo
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 05:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396AbZCYE2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 00:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752105AbZCYE2w
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 00:28:52 -0400
Received: from peff.net ([208.65.91.99]:54250 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752067AbZCYE2w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 00:28:52 -0400
Received: (qmail 3953 invoked by uid 107); 25 Mar 2009 04:29:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 25 Mar 2009 00:29:03 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Mar 2009 00:28:42 -0400
Content-Disposition: inline
In-Reply-To: <1237954900-21161-1-git-send-email-chris_johnsen@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114561>

On Tue, Mar 24, 2009 at 11:21:39PM -0500, Chris Johnsen wrote:

>  technical/api-index.txt: technical/api-index-skel.txt \
> -	technical/api-index.sh $(patsubst %,%.txt,$(API_DOCS))
> +	$(QUIET_GEN)technical/api-index.sh $(patsubst %,%.txt,$(API_DOCS)) && \
>  	cd technical && sh ./api-index.sh

What's going on here? The line you remove is part of the dependencies,
but you replace it with a line of build instructions (and make barfs, of
course).

-Peff
