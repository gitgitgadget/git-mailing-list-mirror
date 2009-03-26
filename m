From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/8] Documentation: rename docbook-xsl-172 attribute to
	git-asciidoc-no-roff
Date: Thu, 26 Mar 2009 05:43:22 -0400
Message-ID: <20090326094322.GB14292@coredump.intra.peff.net>
References: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com> <1237881866-5497-4-git-send-email-chris_johnsen@pobox.com> <20090324090440.GC1799@coredump.intra.peff.net> <B70DE0F1-8CDA-46FC-9EF8-41B0FAC39631@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Chris Johnsen <chris_johnsen@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 10:45:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmm94-0007UL-L4
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 10:45:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754206AbZCZJnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 05:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753636AbZCZJng
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 05:43:36 -0400
Received: from peff.net ([208.65.91.99]:49355 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753431AbZCZJne (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 05:43:34 -0400
Received: (qmail 13106 invoked by uid 107); 26 Mar 2009 09:43:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 26 Mar 2009 05:43:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Mar 2009 05:43:22 -0400
Content-Disposition: inline
In-Reply-To: <B70DE0F1-8CDA-46FC-9EF8-41B0FAC39631@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114758>

On Tue, Mar 24, 2009 at 02:48:52PM -0500, Chris Johnsen wrote:

> I am not opposed to providing more version-specific controls, but I am not 
> sure which versions are important enough to justify their own variables. 
> Are you indicating that 1.73 is important enough because it was a "return 
> to sanity" after 1.72?

No, mainly because it is what is shipped in the last version of Debian,
which means it is a major enough version that there will be a lot of
people using it.

But let's just start with adding the tweakable knobs (which your series
is already doing), and see in what ways they need to be tweaked for
popular platforms before going overboard.

-Peff
