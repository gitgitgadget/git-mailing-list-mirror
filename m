From: Jeff King <peff@peff.net>
Subject: Re: gitk problems: can't unset "idinlist(...)"
Date: Sat, 21 Jul 2007 02:06:00 -0400
Message-ID: <20070721060600.GA29820@coredump.intra.peff.net>
References: <alpine.LFD.0.999.0707201554540.27249@woody.linux-foundation.org> <20070721050912.GB20622@coredump.intra.peff.net> <alpine.LFD.0.999.0707202226130.27249@woody.linux-foundation.org> <20070721055918.GA22399@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 21 08:06:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC86S-0002bR-5R
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 08:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758140AbXGUGGE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 02:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755259AbXGUGGD
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 02:06:03 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2452 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757798AbXGUGGC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 02:06:02 -0400
Received: (qmail 13939 invoked from network); 21 Jul 2007 06:06:30 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 21 Jul 2007 06:06:30 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Jul 2007 02:06:00 -0400
Content-Disposition: inline
In-Reply-To: <20070721055918.GA22399@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53143>

On Sat, Jul 21, 2007 at 01:59:18AM -0400, Jeff King wrote:

> v1.5.2 works, so I am bisecting.

Hmm. The bad commit is 1ed84157. The commit message is a very suspicious
"Revert 88494423 (removal of duplicate parents in the output codepath)."

-Peff
