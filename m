From: Jeff King <peff@peff.net>
Subject: Re: gitk problems: can't unset "idinlist(...)"
Date: Sat, 21 Jul 2007 02:18:57 -0400
Message-ID: <20070721061857.GB29820@coredump.intra.peff.net>
References: <alpine.LFD.0.999.0707201554540.27249@woody.linux-foundation.org> <20070721050912.GB20622@coredump.intra.peff.net> <alpine.LFD.0.999.0707202226130.27249@woody.linux-foundation.org> <alpine.LFD.0.999.0707202304350.27249@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 21 08:19:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC8Ix-0004mO-JZ
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 08:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256AbXGUGTA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 02:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752908AbXGUGTA
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 02:19:00 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4000 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752678AbXGUGS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 02:18:59 -0400
Received: (qmail 14302 invoked from network); 21 Jul 2007 06:19:27 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 21 Jul 2007 06:19:27 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Jul 2007 02:18:57 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707202304350.27249@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53145>

On Fri, Jul 20, 2007 at 11:11:19PM -0700, Linus Torvalds wrote:

> Here's a patch. Not very well tested, but it makes gitk happy and passes 
> all the tests. And I really think Junio's code was very dubious (it did 
> that "p = p->next" *every* time, and then did "pp = &p->next", so "pp" 
> would end up jumping by multiple entries.

I just independently came to the same conclusion. Your patch looks
correct to me (though there are some unrelated formatting changes which
made it a little harder to read).

Acked-by: Jeff King <peff@peff.net>

-Peff
