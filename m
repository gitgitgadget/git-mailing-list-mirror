From: Jeff King <peff@peff.net>
Subject: Re: Speedlimit at "git clone"
Date: Sun, 6 Dec 2009 09:43:22 -0500
Message-ID: <20091206144322.GB26440@coredump.intra.peff.net>
References: <4B17AA6B.7030000@access.denied>
 <4B1AB717.9030601@access.denied>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 06 15:43:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHIKg-00018x-Np
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 15:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756877AbZLFOnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 09:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756876AbZLFOnS
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 09:43:18 -0500
Received: from peff.net ([208.65.91.99]:41670 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756311AbZLFOnR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 09:43:17 -0500
Received: (qmail 30305 invoked by uid 107); 6 Dec 2009 14:47:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 06 Dec 2009 09:47:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Dec 2009 09:43:22 -0500
Content-Disposition: inline
In-Reply-To: <4B1AB717.9030601@access.denied>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134663>

On Sat, Dec 05, 2009 at 08:40:07PM +0100, Stefan Kuhne wrote:

> Stefan Kuhne schrieb:
> Hello,
> > 
> > how can i limit the download speed at "git clone"?
> > 
> no one any idea?

Git has no internal support for doing this. You would have to choke the
TCP connection elsewhere. Look for QoS options in your operating
system's network setup. I think I have also seen LD_PRELOAD libraries
that will limit I/O, but I can't recall the name of any right now.

-Peff
