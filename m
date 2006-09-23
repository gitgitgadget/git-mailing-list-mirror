From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix buggy ref recording
Date: Fri, 22 Sep 2006 17:44:31 -0700
Message-ID: <7vzmcrxvgw.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0609141005440.4388@g5.osdl.org>
	<20060919205554.GA8259@pasky.or.cz>
	<20060922230845.GB8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 02:44:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQvdF-0005Iz-EI
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 02:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbWIWAod (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 20:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWIWAod
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 20:44:33 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:64648 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S964979AbWIWAoc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Sep 2006 20:44:32 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060923004432.QTYJ13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Fri, 22 Sep 2006 20:44:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id RckZ1V00m1kojtg0000000
	Fri, 22 Sep 2006 20:44:34 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27550>

Petr Baudis <pasky@suse.cz> writes:

> And since just reporting it did not magically result in a fix... ;-)

Yes, please always send in a patch to be applied to get the
attribution right.

I've never seen you send out a corrupt patch over e-mail.
What's different this time?

> diff --git a/refs.c b/refs.c
> index 40f16af..5fdf9c4 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -472,7 +472,7 @@ static struct ref_lock *lock_ref_sha1_ba
>
>  	lock->ref_name = xstrdup(ref);
>  	lock->log_file = xstrdup(git_path("logs/%s", ref));

The empty line at the beginning of the hunk is totally empty,
not even with a SP to show it is a context line.

Will hand-apply, no need to resend.
