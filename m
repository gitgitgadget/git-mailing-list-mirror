From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH][RFC] Add git-archive-tree
Date: Mon, 04 Sep 2006 15:20:44 -0700
Message-ID: <7vwt8jl1dv.fsf@assigned-by-dhcp.cox.net>
References: <44F977C0.4060901@lsrfire.ath.cx>
	<44F982BD.1050509@lsrfire.ath.cx>
	<cda58cb80609021313p5156a14du4895e53387dd24dc@mail.gmail.com>
	<44FC6EDE.4010300@lsrfire.ath.cx>
	<7vy7szmm1u.fsf@assigned-by-dhcp.cox.net>
	<44FCA272.7040907@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 05 00:20:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKMnp-0000S9-LS
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 00:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWIDWUW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 18:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWIDWUW
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 18:20:22 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:8096 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S964977AbWIDWUV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 18:20:21 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060904222020.FKHZ6711.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Mon, 4 Sep 2006 18:20:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JNLD1V00W1kojtg0000000
	Mon, 04 Sep 2006 18:20:14 -0400
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <44FCA272.7040907@lsrfire.ath.cx> (Rene Scharfe's message of
	"Tue, 05 Sep 2006 00:02:26 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26439>

Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Junio C Hamano schrieb:
>...
> Well, this is just _one_ of the positions I've taken on this topic, I
> have to admit.  Franck then convinced me that merging downloader and
> archiver into one command is nice for users (less commands to remember,
> keeps existing --remote option) even if it doesn't make sense
> technically, because their implementations have nothing in common.

Ah, I was not following the thread closely and I agree with you
and Franck now in that smaller number of commands the better.
(IOW, download-archive in my 3-item list is not needed in the
end user UI and can be implemented as "git-archive-tree
--remote=<repo>).

Thanks for clarification.
