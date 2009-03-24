From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/8] Documentation: use parametrized manpage-base.xsl
	with manpage-{1.72,normal}.xsl
Date: Tue, 24 Mar 2009 04:57:51 -0400
Message-ID: <20090324085751.GB1799@coredump.intra.peff.net>
References: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com> <1237881866-5497-3-git-send-email-chris_johnsen@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Chris Johnsen <chris_johnsen@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 09:59:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm2Tw-0005Qc-OJ
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 09:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758109AbZCXI6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 04:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758101AbZCXI6D
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 04:58:03 -0400
Received: from peff.net ([208.65.91.99]:42044 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758120AbZCXI6A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 04:58:00 -0400
Received: (qmail 28201 invoked by uid 107); 24 Mar 2009 08:58:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 24 Mar 2009 04:58:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Mar 2009 04:57:51 -0400
Content-Disposition: inline
In-Reply-To: <1237881866-5497-3-git-send-email-chris_johnsen@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114429>

On Tue, Mar 24, 2009 at 03:04:20AM -0500, Chris Johnsen wrote:

> +<!-- manpage-1.72.xsl:
> +     special settings for manpages rendered from asciidoc+docbook
> +     must be used with manpage-base.xsl
> +     handles peculiarities in docbook-xsl 1.72.0 -->

Hmm. I'm not sure I understood all of the issues you ran into that you
mentioned in the commit message (but trust me, having tried to do
anything with docbook, I can sympathize with the frustration you
probably felt), so maybe I am missing something. But is it not possible
to <xsl:include> manpage-base here, rather than a comment saying "Make
sure you have already included it"?

-Peff
