From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Add a 'source' decorator for commits
Date: Tue, 28 Oct 2008 15:53:04 -0400
Message-ID: <20081028195304.GC752@sigill.intra.peff.net>
References: <alpine.LFD.2.00.0810271256470.3386@nehalem.linux-foundation.org> <alpine.LFD.2.00.0810271305500.3386@nehalem.linux-foundation.org> <alpine.LFD.2.00.0810271306230.3386@nehalem.linux-foundation.org> <20081028054539.GA23195@sigill.intra.peff.net> <20081028131116.GA8272@artemis.googlewifi.com> <20081028194642.GB752@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Oct 28 20:54:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kuue5-00012C-Ka
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 20:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbYJ1TxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 15:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbYJ1TxJ
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 15:53:09 -0400
Received: from peff.net ([208.65.91.99]:2386 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193AbYJ1TxI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 15:53:08 -0400
Received: (qmail 23274 invoked by uid 111); 28 Oct 2008 19:53:07 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.19)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 28 Oct 2008 15:53:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Oct 2008 15:53:04 -0400
Content-Disposition: inline
In-Reply-To: <20081028194642.GB752@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99318>

On Tue, Oct 28, 2008 at 03:46:43PM -0400, Jeff King wrote:

> 
> Hmm. Why a date-based hack to see what's on the topic branch? Why not
> just give an option to walk the graph twice, giving name-rev style
> annotations, and just let it be slow. People will mostly look at it by
> specifying just their topic branches anyway. IOW:
> 
>   git log ^origin/master my/topic1 my/topic2 my/topic3

And obviously you could split the "these are the commits to annotate"
specification from "these are the commits to show". But I actually think
in practice most users would want those to be the same.

-Peff
