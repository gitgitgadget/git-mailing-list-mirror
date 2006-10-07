From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Support hiding of chosen repositories from project list
Date: Sat, 07 Oct 2006 02:33:30 -0700
Message-ID: <7vu02gtqqd.fsf@assigned-by-dhcp.cox.net>
References: <20061006182822.9194.78330.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 07 11:33:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GW8Ys-0002dT-Hq
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 11:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWJGJdc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 05:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWJGJdb
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 05:33:31 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:36334 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750717AbWJGJdb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 05:33:31 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061007093330.ZFDA6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Sat, 7 Oct 2006 05:33:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XMZZ1V0061kojtg0000000
	Sat, 07 Oct 2006 05:33:33 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28461>

Petr Baudis <pasky@suse.cz> writes:

> @@ -125,6 +125,7 @@ GITWEB_HOME_LINK_STR = projects
>  GITWEB_SITENAME =
>  GITWEB_PROJECTROOT = /srv/git

What code base are you working on?

>  GITWEB_EXPORT_OK =
> +GITWEB_HIDE_REPO = .hide
>  GITWEB_STRICT_EXPORT =
>  GITWEB_BASE_URL =
>  GITWEB_LIST =

I see how this feature would be useful, but I am not happy to
add random new files under $GIT_DIR/.
