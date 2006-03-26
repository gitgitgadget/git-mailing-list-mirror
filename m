From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] send-email: address expansion for common mailers
Date: Sat, 25 Mar 2006 17:30:25 -0800
Message-ID: <7vlkuyt2ku.fsf@assigned-by-dhcp.cox.net>
References: <20060325235017.GN26071@mythryan2.michonline.com>
	<11433354063582-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 03:30:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNK5U-0004qK-68
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 03:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWCZBa2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 20:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWCZBa2
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 20:30:28 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:11741 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751254AbWCZBa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 20:30:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060326013027.RHBG6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Mar 2006 20:30:27 -0500
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <11433354063582-git-send-email-normalperson@yhbt.net> (Eric
	Wong's message of "Sat, 25 Mar 2006 17:10:06 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18016>

Eric Wong <normalperson@yhbt.net> writes:

> Two git repo-config keys are required for this
> (as suggested by Ryan Anderson):
>
> 	sendemail.aliasesfile = <filename of aliases file>
> 	sendemail.aliasfiletype = (mutt|gnus|pine|mailrc)
>
> I was initially working on auto-detection, but mailrc and mutt formats
> tend to throw each other off (they're alike, but handle multiple
> addresses per-alias differently).

I think specifying the type explicitly is probably not too much
hassle for the end user, so that is fine.  Now, do we want to
support more than one aliases file?
