From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 12:49:17 -0400
Message-ID: <20080623164917.GA25474@sigill.intra.peff.net>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <20080623082223.GA12130@artemis.madism.org> <alpine.DEB.1.00.0806231312130.6440@racer> <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jun 23 18:50:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KApFC-0005CB-12
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 18:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888AbYFWQtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 12:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751649AbYFWQtV
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 12:49:21 -0400
Received: from peff.net ([208.65.91.99]:2311 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278AbYFWQtU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 12:49:20 -0400
Received: (qmail 27351 invoked by uid 111); 23 Jun 2008 16:49:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 23 Jun 2008 12:49:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jun 2008 12:49:17 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85885>

On Mon, Jun 23, 2008 at 09:25:10AM -0700, Linus Torvalds wrote:

> Could you handle the "recursive" use of parse_options() in builtin-blame.c 
> by teaching it about recursion? Yes. But again, it's just _simpler_ to 
> just teach parse_options() to parse the things it knows about, and leave 
> the other things in place.

If I know that I have option "-a", what is the correct partial parsing
of:

  git foo -b -a

?

-Peff
