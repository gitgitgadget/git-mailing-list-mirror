From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Move color option parsing out of diff.c and into color.[ch]
Date: Fri, 8 Sep 2006 05:12:06 -0400
Message-ID: <20060908091206.GA5758@coredump.intra.peff.net>
References: <20060908073452.GA25343@coredump.intra.peff.net> <20060908080318.GA3771@coredump.intra.peff.net> <7vk64eivzj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 11:12:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLcPJ-0006ew-Ai
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 11:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWIHJMK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 05:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWIHJMK
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 05:12:10 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:56712 "HELO
	peff.net") by vger.kernel.org with SMTP id S1750741AbWIHJMJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Sep 2006 05:12:09 -0400
Received: (qmail 6338 invoked from network); 8 Sep 2006 05:11:32 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 8 Sep 2006 05:11:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri,  8 Sep 2006 05:12:06 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk64eivzj.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26693>

On Fri, Sep 08, 2006 at 01:49:20AM -0700, Junio C Hamano wrote:

> > +	if (trail)
> > +		r += printf("%s", trail);
> > +	if (*color)
> > +		r += printf("%s", COLOR_RESET);
> > +	return r;
> > +}
> Hmm,... don't you mean RESET first and then trail (which is often "\n")?

ARGH. Yes, sorry about that. I wrote it correctly once, and then
refactored it to be wrong. :)

> Please spell NULL not 0 (please do not argue that writing a NULL

Sorry, I should clearly go read the linux CodingStyle doc before
subjecting you to any more of my patches.

I'm assuming you can mark both of those up yourself rather than having
me resend?

-Peff
