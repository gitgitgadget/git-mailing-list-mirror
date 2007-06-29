From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 28 Jun 2007 17:02:19 -0700
Message-ID: <7vmyyjmxv8.fsf@assigned-by-dhcp.pobox.com>
References: <7vd50xz7lq.fsf@assigned-by-dhcp.cox.net>
	<7vodkb1adr.fsf@assigned-by-dhcp.cox.net>
	<7virac547s.fsf@assigned-by-dhcp.cox.net>
	<7v6466oygl.fsf@assigned-by-dhcp.cox.net>
	<7vfy54tt3l.fsf@assigned-by-dhcp.cox.net>
	<7vtztbbnsq.fsf@assigned-by-dhcp.pobox.com>
	<7v4pl1zsd7.fsf@assigned-by-dhcp.pobox.com>
	<7v645cz7vm.fsf@assigned-by-dhcp.pobox.com>
	<20070626133548.GB11504@moooo.ath.cx>
	<7vtzsurvo1.fsf@assigned-by-dhcp.pobox.com>
	<20070628202321.GA13263@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jun 29 02:02:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I43wP-0001My-69
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 02:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763647AbXF2ACW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 20:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764735AbXF2ACW
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 20:02:22 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:62700 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759911AbXF2ACU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 20:02:20 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070629000220.QKLI3993.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Jun 2007 20:02:20 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id HC2K1X00i1kojtg0000000; Thu, 28 Jun 2007 20:02:20 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51139>

Matthias Lederhofer <matled@gmx.net> writes:

> When doing more stuff in receive-pack old hooks might stop working
> break.
>
> For example receive-pack could set up GIT_WORK_TREE with a sane
> default value if a working tree can be found, i.e.
>     $ export GIT_WORK_TREE=$(dirname $(pwd))
> if the working tree is in the parent directory
>     $ export GIT_WORK_TREE=$(git config core.worktree)
> if core.worktree is set and otherwise GIT_WORK_TREE is not exported.
> This way hooks can just use GIT_WORK_TREE for the working tree if
> they don't need anything special.

Your analysis looks good.  Probably we can start without doing
anything to see if anybody screams.
