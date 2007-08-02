From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix documentation for core.gitproxy to reflect code
Date: Thu, 02 Aug 2007 13:12:31 -0700
Message-ID: <7vtzrhvgpc.fsf@assigned-by-dhcp.cox.net>
References: <ee77f5c20708020523m1a243bf2g9778994441cd21d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David Symonds" <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 22:13:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGh31-0004tC-2D
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 22:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761254AbXHBUMe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 16:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761250AbXHBUMe
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 16:12:34 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:52255 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761239AbXHBUMd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 16:12:33 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070802201232.TLDO11888.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Thu, 2 Aug 2007 16:12:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id X8CX1X00J1kojtg0000000; Thu, 02 Aug 2007 16:12:32 -0400
In-Reply-To: <ee77f5c20708020523m1a243bf2g9778994441cd21d5@mail.gmail.com>
	(David Symonds's message of "Thu, 2 Aug 2007 22:23:34 +1000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54591>

"David Symonds" <dsymonds@gmail.com> writes:

> This is with respect to my earlier email about core.gitproxy. I
> figured since 1.5.3 is looming it would be best to get the
> documentation correct, then nag about the feature later!
>
> Dave.

That's not a commit log message.

If the existing example does not work, then please say that you
fixed it (i.e. "The values in the example does not work.  The
accepted forms are such and such and such, so use them in the
example") in the log message.  "Your earlier email" does not
count.  People who are reading the "git log" output would not
have easy access to it.

If core.gitproxy is not documented (I suspect the parts you
touched are not about "how to use core.gitproxy" but "what's the
syntax of a configuration file" example), it needs its own
proper entry in config.txt.  If it has one, but if you feel it
needs more explanation or exmples, that section needs to be
updated.

Please retry.
