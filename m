From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/7] gitweb: Trying to improve history view speed
Date: Sat, 09 Sep 2006 02:54:46 -0700
Message-ID: <7vr6ylwejd.fsf@assigned-by-dhcp.cox.net>
References: <200609061504.40725.jnareb@gmail.com> <edtuot$p76$2@sea.gmane.org>
	<7vvenxwglc.fsf@assigned-by-dhcp.cox.net> <edu180$vvs$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 09 11:54:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLzXo-0003hi-3G
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 11:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWIIJyX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 05:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWIIJyX
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 05:54:23 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:17819 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750890AbWIIJyX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Sep 2006 05:54:23 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060909095422.UZAG6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Sat, 9 Sep 2006 05:54:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id L9uC1V00J1kojtg0000000
	Sat, 09 Sep 2006 05:54:14 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <edu180$vvs$1@sea.gmane.org> (Jakub Narebski's message of "Sat,
	09 Sep 2006 11:24:53 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26742>

Jakub Narebski <jnareb@gmail.com> writes:

> By the way, what do you all do with the "failed experiments", to have them
> saved somewhere, but to not make trouble for normal operations?

I usually keep them under .git/refs/tags/hold/.  Yesterday (as I
said in another thread) I dropped the 64-bit packfile index
topic I had in jc/pack-toc topic from "pu" by:

	git tag hold/jc/pack-toc jc/pack-toc
	git branch -D jc/pack-toc

to shelve it and kill it.

In theory, I should occasionally come back to them and see if
they are worth keeping, but in practice they just keep piling up
X-<.  I should find time to clean them up.
