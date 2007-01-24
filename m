From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Wed, 24 Jan 2007 15:23:35 -0800
Message-ID: <7vlkjsdn60.fsf@assigned-by-dhcp.cox.net>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net>
	<eovccc$usc$1@sea.gmane.org>
	<Pine.LNX.4.63.0701211207500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17846.20498.635623.173653@lisa.zopyra.com>
	<Pine.LNX.4.64.0701231157430.32200@woody.linux-foundation.org>
	<Pine.LNX.4.64.0701241108370.3606@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Mark Nudelman <markn@greenwoodsoftware.com>,
	Bill Lear <rael@zopyra.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 25 00:23:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9rSv-0004fu-6J
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 00:23:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932880AbXAXXXi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 18:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932883AbXAXXXi
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 18:23:38 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:38506 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932880AbXAXXXh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 18:23:37 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070124232336.XFYP29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Wed, 24 Jan 2007 18:23:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id FBPu1W00c1kojtg0000000; Wed, 24 Jan 2007 18:23:55 -0500
In-Reply-To: <Pine.LNX.4.64.0701241108370.3606@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 24 Jan 2007 11:21:10 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37691>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> NOTE! To see this problem, you must use the LESS environment that git 
> provides by default (LESS=FRSX) and not have your own environment set that 
> overrides the git ones (or if you do, it must have -F set).
>
> Is it ugly? Yes. Does it work? Yes. Do we want to apply it? You decide.

I would not call it ugly.

I once consiered to fork another process in between the pager
and the caller here and make it buffer "the first screenful"
before actually spawning the pager, or write out the short
output itself without spawning, to fix the "no output but the
cursor goes to the end" problem.  THAT's ugly.

But I do not think your patch is ugly, and it would help normal
people who work in a windowed environment (I did not see the
need for it myself since I usually never resize the terminal --
even working inside X my terminals are usually fixed size and
are always running "screen").
