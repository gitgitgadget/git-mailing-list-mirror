From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsimport: ignore CVSPS_NO_BRANCH and impossible branches
Date: Sat, 17 Jun 2006 14:00:10 -0700
Message-ID: <7vzmgb8plx.fsf@assigned-by-dhcp.cox.net>
References: <11500135293734-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat Jun 17 23:00:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Frhtx-0004Bl-27
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 23:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWFQVAN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 17:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWFQVAN
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 17:00:13 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:21923 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750899AbWFQVAM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jun 2006 17:00:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060617210011.MEDX11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 17 Jun 2006 17:00:11 -0400
To: Martin Langhoff <martin@catalyst.net.nz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22029>

Martin Langhoff <martin@catalyst.net.nz> writes:

> cvsps output often contains references to CVSPS_NO_BRANCH, commits that it
> could not trace to a branch. Ignore that branch.
>
> Additionally, cvsps will sometimes draw circular relationships between
> branches -- where two branches are recorded as opening from the other.
> In those cases, and where the ancestor branch hasn't been seen, ignore
> it.

This sounds more like an workaround than a real fix to me,
although I'd apply it for now.  I see Yann is collecting cvsps
patches but maybe there will be a real fix soonish?
