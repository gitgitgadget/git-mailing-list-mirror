From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Support of "make -s" in git-gui: do not output anything of the build itself
Date: Wed, 07 Mar 2007 10:07:46 -0800
Message-ID: <7v8xe9exl9.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0703061557j1cade6f6k4577da5e447a4e2a@mail.gmail.com>
	<20070307001410.GA26050@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 07 19:08:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP0Yu-0005ed-M5
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 19:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422976AbXCGSHu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 13:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422975AbXCGSHu
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 13:07:50 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:56097 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422976AbXCGSHs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 13:07:48 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070307180748.SFUO2394.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Mar 2007 13:07:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Xu7m1W00Z1kojtg0000000; Wed, 07 Mar 2007 13:07:47 -0500
In-Reply-To: <20070307001410.GA26050@spearce.org> (Shawn O. Pearce's message
	of "Tue, 6 Mar 2007 19:14:10 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41686>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> If it is alright with Alex, I'd like to hold off on merging git-gui
> into git.git right now.  We just got gitgui-0.6.3 merged, and I'd
> like to see at least one version of git ship with a stable tag from
> git-gui, rather than an arbitrary commit.  ;-)

Well, I do not think these Makefile clean-ups deserve to be
applied to 'maint'.  They are by definition not to have any
effect on the build products (otherwise that is called a bug),
so will not either fix nor improve the end user experience.

In 'maint', I try to have changes that fixes problems in the end
user experience that exist in the corresponding feature release,
and nothing else.  That is what 'maintenance' means.
