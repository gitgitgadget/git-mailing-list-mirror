From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] Introduce "reset type" flag to "git reset"
Date: Tue, 23 Aug 2005 22:26:37 +0200
Message-ID: <20050823202637.GA8061@mars.ravnborg.org>
References: <7vu0hhzcj1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Aug 23 22:30:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7fL5-0005UM-He
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 22:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbVHWUZe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 16:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbVHWUZe
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 16:25:34 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:30030 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S932373AbVHWUZd
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 16:25:33 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepc.post.tele.dk (Postfix) with ESMTP id C875D262894;
	Tue, 23 Aug 2005 22:25:29 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 417EB6AC01D; Tue, 23 Aug 2005 22:26:37 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu0hhzcj1.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7666>

> I am not sure what mixed reset (the current behaviour) is good
> for.  If nobody comes up with a good use case it may not be a
> bad idea to remove it.
Using the principle of minimum suprise the --mixed should be removed.
--soft - undo the commit leaving all changes.
--hard - undo the commit and removing all changes

I'm a cogito user so not used to got options.
But --soft, --hard looks rather confusing to me.

Something like --force or --prune may be a bit more intuitive, and let
default behaviour be the one you name --soft for now.

I think it would make sense to be able to specify the topmost SHA1 (or 
HEAD:5 or HEAD^^^^^) from where the reset should start.

	Sam
