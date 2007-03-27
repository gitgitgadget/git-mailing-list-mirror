From: Jeff King <peff@peff.net>
Subject: Re: git-send-email and aliases
Date: Tue, 27 Mar 2007 07:02:46 -0400
Message-ID: <20070327110246.GA30217@sigill.intra.peff.net>
References: <38b2ab8a0703260239j3f3f0be2teee70fc502f6f7c1@mail.gmail.com> <7vwt14wd38.fsf@assigned-by-dhcp.cox.net> <38b2ab8a0703270238n655bdee1kac227a6675261210@mail.gmail.com> <7vircnou7i.fsf@assigned-by-dhcp.cox.net> <20070327104623.GA26796@sigill.intra.peff.net> <7vlkhjne9k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Francis Moreau <francis.moro@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 13:03:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW9SB-0001Q6-QO
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 13:03:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbXC0LCu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 07:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753804AbXC0LCt
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 07:02:49 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3507 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991AbXC0LCt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 07:02:49 -0400
Received: (qmail 23699 invoked from network); 27 Mar 2007 11:03:19 -0000
Received: from sigill.intra.peff.net (10.0.0.7)
  by peff.net with (DHE-RSA-AES256-SHA encrypted) SMTP; 27 Mar 2007 11:03:19 -0000
Received: (qmail 30230 invoked by uid 1000); 27 Mar 2007 11:02:46 -0000
Content-Disposition: inline
In-Reply-To: <7vlkhjne9k.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43261>

On Tue, Mar 27, 2007 at 03:59:19AM -0700, Junio C Hamano wrote:

> It might be easier but I do not think that is useful.  When
> git-commit runs the $EDITOR for the commit log message, I think
> people would expect (if you are using vi) "!!git log" to honor
> their alias.

Then git-commit can unset GIT_NOALIAS when it expects to call into
"user" code such as the editor.

A potentially bigger problem with any such scheme is that non-git
scripts would have to set GIT_NOALIAS. Not a big deal for new scripts,
but it might break old scripts.

-Peff
