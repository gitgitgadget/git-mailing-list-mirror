From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow pickaxe and diff-filter options to be used by git log.
Date: Thu, 18 May 2006 23:05:34 -0700
Message-ID: <7v3bf6k0r5.fsf@assigned-by-dhcp.cox.net>
References: <BAYC1-PASMTP04945C92FB14DA65AB1AC7AEA70@CEZ.ICE>
	<7vac9elm2p.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP096010F052E9BF78B5FD4AAEA70@CEZ.ICE>
	<7vbqtuk1uw.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP092CB0667E05EA20FBA30EAEA70@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 08:05:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fgy7M-0007Qn-Vu
	for gcvg-git@gmane.org; Fri, 19 May 2006 08:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWESGFg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 02:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWESGFg
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 02:05:36 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:15796 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932234AbWESGFf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 02:05:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060519060535.HEFQ24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 19 May 2006 02:05:35 -0400
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP092CB0667E05EA20FBA30EAEA70@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Fri, 19 May 2006 01:49:38 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20326>

Sean <seanlkml@sympatico.ca> writes:

> Well, I was looking at the use of diff-filter and -S as a way
> to prune uninteresting commits from the log rather than as an 
> desire to see the patch information.

Fair enough.

> It's pretty natural to add -p or --stat along with the above 
> options if that is what the user wants.  If you make those implied
> by using --diff-filter or -S is there a way for the user to say,
> no patch and no stat?

Well, I was sneaking in a hidden feature with that tweak.

Regardless of the diff-filter/-S issues, with that alternative
patch, you could do:

	$ git log -r

It lets you do a wonderful thing with surprisingly small number
of keystrokes ;-).
