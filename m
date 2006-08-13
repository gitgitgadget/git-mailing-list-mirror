From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-commit: no silent exit on duplicate Signed-off-by lines
Date: Sun, 13 Aug 2006 01:16:06 -0700
Message-ID: <7vejvlm4op.fsf@assigned-by-dhcp.cox.net>
References: <20060813080328.14584.qmail@web31805.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 13 10:16:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCB8p-0006PX-At
	for gcvg-git@gmane.org; Sun, 13 Aug 2006 10:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWHMIQI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 04:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWHMIQI
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 04:16:08 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:51389 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750750AbWHMIQH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Aug 2006 04:16:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060813081607.BJRF12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 13 Aug 2006 04:16:07 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20060813080328.14584.qmail@web31805.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Sun, 13 Aug 2006 01:03:28 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25278>

Luben Tuikov <ltuikov@yahoo.com> writes:

> @@ -690,7 +690,7 @@ case "$verify" in
>  t)
>  	if test -x "$GIT_DIR"/hooks/commit-msg
>  	then
> -		"$GIT_DIR"/hooks/commit-msg "$GIT_DIR"/COMMIT_EDITMSG || exit
> +		"$GIT_DIR"/hooks/commit-msg "$GIT_DIR"/COMMIT_EDITMSG || die "Duplicate Signed-off-by lines -- nothing commited"
>  	fi
>  esac

Please emit the complaint from the sample hook/commit-msg
script, not from git-commit.
