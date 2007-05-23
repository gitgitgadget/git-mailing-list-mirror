From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-applymbox: Remove command
Date: Wed, 23 May 2007 14:57:24 -0700
Message-ID: <7vejl719vf.fsf@assigned-by-dhcp.cox.net>
References: <20070520001012.5051.38142.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed May 23 23:57:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hqypn-0006Kw-Vz
	for gcvg-git@gmane.org; Wed, 23 May 2007 23:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756306AbXEWV51 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 17:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758995AbXEWV51
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 17:57:27 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:61548 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758957AbXEWV50 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 17:57:26 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070523215726.RJBT12190.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Wed, 23 May 2007 17:57:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 2lxQ1X00A1kojtg0000000; Wed, 23 May 2007 17:57:24 -0400
In-Reply-To: <20070520001012.5051.38142.stgit@rover> (Petr Baudis's message of
	"Sun, 20 May 2007 02:10:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48182>

Petr Baudis <pasky@suse.cz> writes:

> I believe noone uses git-applymbox, and noone definitely should, since it
> is supposed to be completely superseded and everything by its younger
> cousin git-am. The only known person in the universe to use it was Linus
> and he declared some time ago that he will try to use git-am instead in his
> famous dotest script.
>
> The trouble is that git-applymbox existence creates confusing UI. I'm a bit
> like a recycled newbie to the git porcelain and *I* was confused by
> git-applymbox primitiveness until I've realized a while later that I'm of
> course using the wrong command.
>
> Signed-off-by: Petr Baudis <pasky@suse.cz>
>
> ---
>
> (Admittelly this patch is a bit brave and maybe we should make applymbox
> print some scary messages first for some time. I'm testing the water here
> to see if anyone complains. I still think that noone really uses it,
> though.)

Brave.

I suspect nobody really uses it, too.
