From: Jeff King <peff@peff.net>
Subject: Re: Detached checkout will clobber branch head when using symlink
	HEAD
Date: Thu, 16 Oct 2008 16:22:02 -0400
Message-ID: <20081016202202.GA9487@coredump.intra.peff.net>
References: <1224095087.5366.19.camel@localhost> <20081016191751.GB14707@coredump.intra.peff.net> <1224187863.2796.15.camel@localhost> <alpine.LFD.2.00.0810161619330.26244@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matt Draisey <matt@draisey.ca>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Oct 16 22:23:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqZNQ-0006v3-HX
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 22:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753837AbYJPUWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 16:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753852AbYJPUWG
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 16:22:06 -0400
Received: from peff.net ([208.65.91.99]:3778 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753748AbYJPUWG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 16:22:06 -0400
Received: (qmail 9547 invoked by uid 111); 16 Oct 2008 20:22:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 16 Oct 2008 16:22:03 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Oct 2008 16:22:02 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810161619330.26244@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98411>

On Thu, Oct 16, 2008 at 04:20:32PM -0400, Nicolas Pitre wrote:

> > so almost all my git repositories are still using a symlink HEAD.
> > I have some old scripts That I use occasionally and still depend on it.
> > Using detached checkout is the only problem I've had.
> 
> A symlink HEAD and detached checkouts are simply incompatible.

Agreed, but I think the complaint is not that it doesn't work, but that
it silently clobbers the current branch when you try it.

-Peff
