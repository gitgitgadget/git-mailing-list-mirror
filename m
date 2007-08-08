From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Mod. gitk to support REBASE (with stash support).
Date: Wed, 08 Aug 2007 12:53:20 -0700
Message-ID: <7vvebp3irz.fsf@assigned-by-dhcp.cox.net>
References: <1186598028457-git-send-email-alexandre.bourget@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, paulus@samba.org
To: Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 21:53:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIraz-0007W5-C3
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 21:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760367AbXHHTxW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 15:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760294AbXHHTxW
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 15:53:22 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:54468 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758034AbXHHTxV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 15:53:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070808195320.HAPU7349.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 8 Aug 2007 15:53:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZXtL1X00C1kojtg0000000; Wed, 08 Aug 2007 15:53:21 -0400
In-Reply-To: <1186598028457-git-send-email-alexandre.bourget@savoirfairelinux.com>
	(Alexandre Bourget's message of "Wed, 8 Aug 2007 14:33:48 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55350>

Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>
writes:

> ---
> Adds a context menu for commits, so that a 'rebase' can be done.
>
> Optionally, it will ask if you want to 'stash' current work before doing so.
>
> TODO: better error handling.

Please do not discard a commit log message by placing them after
the three-dashes.  A good commit message would be of this form:

 - A single line to summarize what it does (goes to Subject);

 - A blank line (paragraph break);

 - A paragraph or more that elaborate on the above summary, if
   needed, and defend why the change is a good idea; especially
   if you considered other alternatives, a comparison to justify
   your choice.

This is largely up to Paulus, but I think anything that
updates the repository should go to git-gui, not gitk.  The
latter is primarily a viewer.
