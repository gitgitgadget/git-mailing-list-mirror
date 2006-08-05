From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git-status: colorize status output
Date: Sat, 5 Aug 2006 13:28:51 +0200
Message-ID: <20060805112851.GA20807@moooo.ath.cx>
References: <20060805031418.GA11102@coredump.intra.peff.net> <20060805105953.GA5410@moooo.ath.cx> <7vejvve8ci.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 13:29:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9KKw-0004X9-RV
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 13:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbWHEL24 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 07:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbWHEL24
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 07:28:56 -0400
Received: from moooo.ath.cx ([85.116.203.178]:5763 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S932589AbWHEL2z (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Aug 2006 07:28:55 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vejvve8ci.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24910>

Junio C Hamano <junkio@cox.net> wrote:
> Matthias Lederhofer <matled@gmx.net> writes:
> >> Color support is controlled by status.color and status.color.*. There is no
> >> command line option, and the status.color variable is a simple boolean (no
> >> checking for tty output).
> > Is there any way to do isatty() from shell scripts?
> 
> Yes.
How? :) Is there any reason not checking isatty()?
