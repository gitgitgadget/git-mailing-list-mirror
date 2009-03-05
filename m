From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 2/2] make remote hangup warnings more friendly
Date: Thu, 5 Mar 2009 05:45:06 -0500
Message-ID: <20090305104506.GB17196@coredump.intra.peff.net>
References: <20090303184106.GH14365@spearce.org> <20090304084245.GB31798@coredump.intra.peff.net> <20090304190452.GJ14365@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 05 11:47:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfB6G-0003Fb-2x
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 11:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbZCEKpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 05:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbZCEKpR
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 05:45:17 -0500
Received: from peff.net ([208.65.91.99]:33199 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902AbZCEKpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 05:45:16 -0500
Received: (qmail 29947 invoked by uid 107); 5 Mar 2009 10:45:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 05 Mar 2009 05:45:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Mar 2009 05:45:06 -0500
Content-Disposition: inline
In-Reply-To: <20090304190452.GJ14365@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112293>

On Wed, Mar 04, 2009 at 11:04:52AM -0800, Shawn O. Pearce wrote:

> Hmm.  It would be nice to clean up these messages, but I
> think the better way to do it is...
>  
> >      I think this would be improved somewhat with stderr processing to:
> > 
> >        remote: sh: bogus: command not found
> 
> ... because then we can have positive proof that the remote said
> something to the user, and we tagged it as being from the remote
> side, just like we do with progress data in sideband, and then the
> user can work from that information.  Any local side errors are
> very likely caused by the remote errors, so we shouldn't bother
> displaying them.

OK. I was hoping to avoid that because it's more work, but I think it is
a better path in the long run. I'll add it to do my todo list. Unless
you want to redeem yourself by working on it first. ;)

-Peff
