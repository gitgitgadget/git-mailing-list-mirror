From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git-publish
Date: Sun, 13 Aug 2006 19:23:56 -0700
Message-ID: <7virkwgimb.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0608131158500.9789@iabervon.org>
	<20060813191346.GA21487@mars.ravnborg.org>
	<Pine.LNX.4.64.0608131536590.9789@iabervon.org>
	<20060814015127.GA18667@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Sam Ravnborg <sam@ravnborg.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 14 04:24:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCS7h-0004fj-EB
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 04:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWHNCX6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 22:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbWHNCX6
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 22:23:58 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:31144 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751229AbWHNCX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Aug 2006 22:23:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060814022357.UTSE12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 13 Aug 2006 22:23:57 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060814015127.GA18667@spearce.org> (Shawn Pearce's message of
	"Sun, 13 Aug 2006 21:51:27 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25308>

Shawn Pearce <spearce@spearce.org> writes:

> Although other SCMs (e.g. SVN or CVS) would encourage you to commit
> and push to the remote immediately this is actually a pretty bad
> idea in GIT.

Well, non-distributed SCM is totally a different story.  For
them, committing is to propagating the change to the central
repository to be consumed by others.

You can use git in that way as well, but you do not have to, and
that is an improvement;-).
