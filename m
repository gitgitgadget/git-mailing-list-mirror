From: Jeff King <peff@peff.net>
Subject: Re: git-send-email and aliases
Date: Tue, 27 Mar 2007 06:46:23 -0400
Message-ID: <20070327104623.GA26796@sigill.intra.peff.net>
References: <38b2ab8a0703260239j3f3f0be2teee70fc502f6f7c1@mail.gmail.com> <7vwt14wd38.fsf@assigned-by-dhcp.cox.net> <38b2ab8a0703270238n655bdee1kac227a6675261210@mail.gmail.com> <7vircnou7i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Francis Moreau <francis.moro@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 12:46:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW9CO-0001dG-Pv
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 12:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790AbXC0Kq1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 06:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753791AbXC0Kq1
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 06:46:27 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1574 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753790AbXC0Kq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 06:46:26 -0400
Received: (qmail 23405 invoked from network); 27 Mar 2007 10:46:56 -0000
Received: from sigill.intra.peff.net (10.0.0.7)
  by peff.net with (DHE-RSA-AES256-SHA encrypted) SMTP; 27 Mar 2007 10:46:56 -0000
Received: (qmail 27835 invoked by uid 1000); 27 Mar 2007 10:46:23 -0000
Content-Disposition: inline
In-Reply-To: <7vircnou7i.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43257>

On Tue, Mar 27, 2007 at 03:29:37AM -0700, Junio C Hamano wrote:

> > Isn't possible to mimic bash alias handling:. From man: "Aliases are
> > not expanded when the shell is not interactive,... "
> I do not think so, but I think alias expanding "git foo" while
> not expanding "git-foo" should not be too hard.  You need two
> extra preparation steps for such a change to be useful, though.

Might it not be easier to simply add a GIT_NOALIAS variable, and set it
at the top of all git programs?

-Peff
