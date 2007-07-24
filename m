From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Tue, 24 Jul 2007 02:47:13 -0700
Message-ID: <7vd4yigmla.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site>
	<Pine.LNX.4.64.0707222205050.23426@reaper.quantumfyre.co.uk>
	<Pine.LNX.4.64.0707222223460.14781@racer.site>
	<Pine.LNX.4.64.0707222234020.5382@reaper.quantumfyre.co.uk>
	<Pine.LNX.4.64.0707222255010.14781@racer.site>
	<Pine.LNX.4.64.0707222302170.19212@reaper.quantumfyre.co.uk>
	<Pine.LNX.4.64.0707230000020.14781@racer.site>
	<20070723035644.GC32566@spearce.org>
	<7v1wezohi4.fsf@assigned-by-dhcp.cox.net>
	<46A5B5F5.6000202@trolltech.com>
	<Pine.LNX.4.64.0707241002410.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 11:47:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDGzF-0007wP-MM
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 11:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934215AbXGXJrR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 05:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934360AbXGXJrQ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 05:47:16 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:56154 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933427AbXGXJrO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 05:47:14 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070724094713.TPVY1393.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Tue, 24 Jul 2007 05:47:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TMnD1X00A1kojtg0000000; Tue, 24 Jul 2007 05:47:14 -0400
In-Reply-To: <Pine.LNX.4.64.0707241002410.14781@racer.site> (Johannes
	Schindelin's message of "Tue, 24 Jul 2007 10:02:58 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53549>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> While you guys are discussing this, please please keep in mind that there are
>> Windows users (/me raises his hand) out there that really really want this
>> too. So, please try to keep it light on the symlinks.
>
> Easy: use cygwin.
>
> Okay, a bit more seriously again: in the recent weeks, it seems that more 
> and more Windows users are asking for features.  Since I guess you are a 
> developer (why else would you want to use git), IMHO it is your itch to 
> scratch.

I do not know this is an appropriate itch to scratch for a
Windows developer to begin with.  The new-workdir setting *is*
about symlinked .git/ metainfo space.  If somebody wants to work
on a filesystem without symlink, he should not be using
new-workdir but something else.  E.g. GIT_DIR + GIT_WORK_TREE,
or perhaps GIT_DIR + core.worktree comes to mind.
