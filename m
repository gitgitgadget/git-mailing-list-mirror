From: Jeff King <peff@peff.net>
Subject: Re: Start deprecating "git-command" in favor of "git command"
Date: Sun, 1 Jul 2007 04:22:02 -0400
Message-ID: <20070701082202.GB6093@coredump.intra.peff.net>
References: <alpine.LFD.0.98.0706301135300.1172@woody.linux-foundation.org> <7vy7i1b6bt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 01 10:22:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4uhI-0001Kd-Ng
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 10:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018AbXGAIWH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 04:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754206AbXGAIWH
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 04:22:07 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2302 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753704AbXGAIWF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 04:22:05 -0400
Received: (qmail 31999 invoked from network); 1 Jul 2007 08:22:25 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 1 Jul 2007 08:22:25 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 01 Jul 2007 04:22:02 -0400
Content-Disposition: inline
In-Reply-To: <7vy7i1b6bt.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51283>

On Sat, Jun 30, 2007 at 12:17:10PM -0700, Junio C Hamano wrote:

> So I am somewhat negative on this, unless there is a way for
> scripts to say "Even though I say 'git foo', I do mean 'git foo'
> not whatever the user has aliased".

I had submitted GIT_NOALIAS=1 patches a while back, but IIRC, the
consensus was that it was a bit too ugly and fragile in concept.

-Peff
