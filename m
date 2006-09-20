From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Support for custom per-project owner string
Date: Wed, 20 Sep 2006 08:02:21 -0700
Message-ID: <7veju6lgxu.fsf@assigned-by-dhcp.cox.net>
References: <20060919225522.GB13132@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 17:03:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ3ak-0007Yt-Da
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 17:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbWITPCX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 11:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbWITPCX
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 11:02:23 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:61828 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751418AbWITPCX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 11:02:23 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060920150221.VWOW6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Sep 2006 11:02:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Qf281V00M1kojtg0000000
	Wed, 20 Sep 2006 11:02:08 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060919225522.GB13132@pasky.or.cz> (Petr Baudis's message of
	"Wed, 20 Sep 2006 00:55:22 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27347>

Petr Baudis <pasky@suse.cz> writes:

> Also, ideally this would be in the configfile but calling repoconfig for
> each repository in the index would slow things down way too much.

Hmph.  I wonder why.  We do read description already from a file
so maybe we would want a faster way to access the config file to
grab gitweb.* variables in a single call?

In any case, I like where this patch is going and agree that
file owner should be overridable with something like this.
