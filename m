From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/4] send-email: lazy-load Email::Valid and make it optional
Date: Sat, 25 Mar 2006 12:33:47 -0800
Message-ID: <7v8xqyuuvo.fsf@assigned-by-dhcp.cox.net>
References: <11432834101430-git-send-email-normalperson@yhbt.net>
	<11432834111972-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 25 21:34:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNFSK-0008Lj-Bs
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 21:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWCYUdt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 15:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWCYUdt
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 15:33:49 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:29136 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751399AbWCYUds (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 15:33:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060325203348.GDWN17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Mar 2006 15:33:48 -0500
To: Eric Wong <normalperson@yhbt.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17997>

Eric Wong <normalperson@yhbt.net> writes:

> +my $have_email_valid = eval { require Email::Valid or undef };

Merlyn already commented on this and I'd appreciate this part to
be redone.
