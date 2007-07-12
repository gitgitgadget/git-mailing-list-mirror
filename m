From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Move the --decorate option from builtin-log.c to revision.c.
Date: Thu, 12 Jul 2007 11:45:38 -0700
Message-ID: <7v4pk9v4tp.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707110220340.4047@racer.site>
	<Pine.LNX.4.64.0707110229120.4047@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 12 20:45:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I93fb-0004X9-Nt
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 20:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756221AbXGLSpk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 14:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756558AbXGLSpk
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 14:45:40 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:61155 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbXGLSpj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 14:45:39 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070712184539.URPQ1428.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Thu, 12 Jul 2007 14:45:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Nile1X00i1kojtg0000000; Thu, 12 Jul 2007 14:45:39 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52317>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> ---decorate::
> -	Print out the ref names of any commits that are shown.
> -
> ...
> +
> +--decorate::
> +	When a commit is shown, and it matches a ref, print that ref name
> +	in brackets after the commit name.

The character-pair ( and ) are usually called parentheses, not
brackets.

Other than that, these two code movements and refactorings feel
a sane thing to do.
