From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk problems: can't unset "idinlist(...)"
Date: Sat, 21 Jul 2007 21:42:27 +1000
Message-ID: <18081.61731.641169.306397@cargo.ozlabs.ibm.com>
References: <alpine.LFD.0.999.0707201554540.27249@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 21 13:43:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICDMR-00048T-Ev
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 13:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933334AbXGULms (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 07:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933307AbXGULms
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 07:42:48 -0400
Received: from ozlabs.org ([203.10.76.45]:42107 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933235AbXGULmr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 07:42:47 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 793E7DDEB8; Sat, 21 Jul 2007 21:42:46 +1000 (EST)
In-Reply-To: <alpine.LFD.0.999.0707201554540.27249@woody.linux-foundation.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53157>

Linus Torvalds writes:

> Somebody who knows 
> tcl/tk, and gitk?

That sounds like me. :)  I see from the following messages that the
bug turned out to be elsewhere in git, but it looks like gitk should
be more robust and do something sensible rather than just throwing a
Tcl error.  I'll look at it.

Paul.
