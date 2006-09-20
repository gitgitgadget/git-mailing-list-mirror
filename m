From: Junio C Hamano <junkio@cox.net>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 14:42:55 -0700
Message-ID: <7vodtafc4g.fsf@assigned-by-dhcp.cox.net>
References: <20060920080308.673a1e93@localhost.localdomain>
	<Pine.LNX.4.64.0609200816400.4388@g5.osdl.org>
	<20060920155431.GO8259@pasky.or.cz>
	<Pine.LNX.4.63.0609201801110.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060920160756.GP8259@pasky.or.cz>
	<Pine.LNX.4.64.0609200915550.4388@g5.osdl.org>
	<Pine.LNX.4.64.0609200920290.4388@g5.osdl.org>
	<20060920163437.GC23260@spearce.org>
	<Pine.LNX.4.63.0609202321390.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060920212747.GB24415@spearce.org>
	<Pine.LNX.4.63.0609202333320.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 20 23:43:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ9qO-0002l6-9K
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 23:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWITVm6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 17:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWITVm5
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 17:42:57 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:1993 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932152AbWITVm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 17:42:57 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060920214254.LWLO6711.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Sep 2006 17:42:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Qlii1V00W1kojtg0000000
	Wed, 20 Sep 2006 17:42:42 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0609202333320.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 20 Sep 2006 23:37:12 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27414>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I'd rather set another config variable with --shared, which tells git to 
> refuse receiving non-fast-forwards. This could be a sensible setting in 
> other setups than shared ones after all. Thoughts?

If this option is meant to forbid fixing up an screw-up by doing
"git-push --force", I do not quite like it.

It sounds as if arguing that "rm -fr" is dangerous so presence
of -f and -r at the same time should imply -i option.  I think
the right answer is not making -i implied, but train the user to
understand what -fr means before using it.
