From: Jeff King <peff@peff.net>
Subject: Re: Intensive rename detection
Date: Mon, 3 Nov 2008 23:31:33 -0500
Message-ID: <20081104043133.GB31276@coredump.intra.peff.net>
References: <216e54900811031717j70669868p3c7503357ceb5138@mail.gmail.com> <216e54900811031718o4cc81294sc0c32be1e71b9372@mail.gmail.com> <alpine.LFD.2.00.0811032021210.3419@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andrew Arnott <andrewarnott@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Nov 04 05:32:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxDaz-0003NH-Gb
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 05:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbYKDEbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 23:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbYKDEbg
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 23:31:36 -0500
Received: from peff.net ([208.65.91.99]:2500 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881AbYKDEbf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 23:31:35 -0500
Received: (qmail 5079 invoked by uid 111); 4 Nov 2008 04:31:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 03 Nov 2008 23:31:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Nov 2008 23:31:33 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0811032021210.3419@nehalem.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100033>

On Mon, Nov 03, 2008 at 08:22:34PM -0800, Linus Torvalds wrote:

> How many renames do you have? Modern versions of git will do any number of 
> exact renames, but the (rather expensive) inexact rename detection has a 
> default limit of something fairly small.

I was about to say "git should have complained about turning off the
requested rename detection", but I forgot that we silenced that warning
except for merges.

Maybe it makes sense for "status" or a single "diff" (but definitely not
"log", where it isn't even clear which diff caused it!). I dunno. I find
it clutter for anything except a merge, but if that is in fact what is
happening here, it might have produced one slightly less confused user.

-Peff
