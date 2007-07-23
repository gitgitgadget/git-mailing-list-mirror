From: Jason Riedy <ejr@cs.berkeley.edu>
Subject: Re: If NEEDS_LIBICONV is set for Solaris 8, it does not build git for me
Date: Mon, 23 Jul 2007 11:35:48 -0700
Organization: CS Div, EECS Dept, Univ. of California, Berkeley
Message-ID: <878x97eznf.fsf@sparse.dyndns.org>
References: <20070722104045.GF4760@cip.informatik.uni-erlangen.de>
	<7v8x98qc3k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Glanzmann <thomas@glanzmann.de>, GIT <git@vger.kernel.org>,
	Paul Jakma <paul@clubi.ie>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 20:48:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID2xC-0004Uc-3E
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 20:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758465AbXGWSsT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 14:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756736AbXGWSsT
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 14:48:19 -0400
Received: from a.mail.sonic.net ([64.142.16.245]:40773 "EHLO a.mail.sonic.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755301AbXGWSsS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 14:48:18 -0400
X-Greylist: delayed 740 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Jul 2007 14:48:18 EDT
Received: from nan.sparse.dyndns.org (69-12-153-204.dsl.dynamic.sonic.net [69.12.153.204])
	(authenticated bits=0)
	by a.mail.sonic.net (8.13.8.Beta0-Sonic/8.13.7) with ESMTP id l6NIZmvH014715;
	Mon, 23 Jul 2007 11:35:49 -0700
In-Reply-To: <7v8x98qc3k.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 22 Jul 2007 15:59:11 -0700")
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53459>

And Junio C. Hamano writes:
>
> In a distant past when I built git on an otherwise unused Sol8
> at work I recall I needed that.  I do not think that machine
> used Forte compiler, though.

I didn't even know you could patch 5.8 enough to use that
compiler version.  I can't imagine what strange combinations of
C89 and C99 features are available.

Luckily for me, I no longer have easy access to Solaris <9.

At some point, the crazy patch combinations need relegated to
each particular site's config.mak.  Solaris 8 has entered the
first "retirement phase", but new orders can include it for about
another month:
  http://www.sun.com/software/solaris/support/sol8.xml

Jason
