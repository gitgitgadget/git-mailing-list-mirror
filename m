From: Jeff King <peff@peff.net>
Subject: Re: [RFC/WIP 0/2] Documentation clean-up: git commands
Date: Mon, 23 Mar 2009 23:34:11 -0400
Message-ID: <20090324033410.GB12829@coredump.intra.peff.net>
References: <1237818533-31577-1-git-send-email-git@drmicha.warpmail.net> <7vwsag5hva.fsf@gitster.siamese.dyndns.org> <37FD43AD-E43A-4565-8085-95E606E0B868@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Chris Johnsen <chris_johnsen@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 04:36:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlxR7-0003rl-8u
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 04:36:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992AbZCXDeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 23:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbZCXDeU
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 23:34:20 -0400
Received: from peff.net ([208.65.91.99]:37605 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751408AbZCXDeT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 23:34:19 -0400
Received: (qmail 26099 invoked by uid 107); 24 Mar 2009 03:34:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 23 Mar 2009 23:34:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Mar 2009 23:34:11 -0400
Content-Disposition: inline
In-Reply-To: <37FD43AD-E43A-4565-8085-95E606E0B868@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114399>

On Mon, Mar 23, 2009 at 06:13:11PM -0500, Chris Johnsen wrote:

> I have a series of patches prepared to "cleanup" and modify  
> {callout,manpage-1.72}.xsl and asciidoc.conf, but I am still running a 
> series of "make doc" runs across the changes to try to make sure they are 
> sane. Here is a preview:
>
> Documentation: move callouts.xsl to manpage-{base,normal}.xsl
> Documentation: use parametrized manpage-base.xsl with manpage- 
> {1.72,normal}.xsl
> Documentation: rename docbook-xsl-172 attribute to git-asciidoc-no-roff
> Documentation: move quieting params into manpage-base.xsl
> Documentation: move "spurious .sp" code into manpage-base.xsl
> Documentation: asciidoc.conf: always use <literallayout> for [blocktext]
> Documentation: asciidoc.conf: fix verse block with block titles
> Documentation: option to render literal text as italic for manpages

Oh, good, thanks for working on this. I was actually about to start
looking at it tonight.

For the final one, italicized or emphasized text will often end up
underlined in most terminals. Peeking at other manpages led me to the
conclusion that bolding literal text is the most common convention.

-Peff
