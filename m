From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-commit: allow From: line to be entered in commit message
Date: Thu, 12 Jan 2006 20:03:36 -0800
Message-ID: <7v4q48hizr.fsf@assigned-by-dhcp.cox.net>
References: <BAYC1-PASMTP117A18814EAAFACFE0F31DAE270@CEZ.ICE>
	<7vzmm1mcfz.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP102ED7B30D2B48BEE601F5AE260@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 05:04:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExGAM-00026A-VN
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 05:03:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161325AbWAMEDj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 23:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWAMEDi
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 23:03:38 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:27265 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S964799AbWAMEDh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 23:03:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060113040122.QCWW17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 Jan 2006 23:01:22 -0500
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP102ED7B30D2B48BEE601F5AE260@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Thu, 12 Jan 2006 21:32:07 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14609>

sean <seanlkml@sympatico.ca> writes:

> ...   Apparently he is more or less
> hand munging mutliple cvs branches into a nice git package for 
> Linus to pull.  He said that many of the patches don't apply as-is
> and need some manual tweaking before committing.

Then what is needed is an exporter from those cvs branches into
git.  Well, don't we have one already?  If it does not work for
dirty changes, wouldn't it be better to fix it so it is
restartable, just like when rebase stops it lets you fix up and
go on, without having you to write "From: " or GIT_AUTHOR_*
yourself and just does the right thing?
