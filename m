From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use $DESTDIR instead of $dest
Date: Fri, 05 Aug 2005 16:17:17 -0700
Message-ID: <7v4qa4geiq.fsf@assigned-by-dhcp.cox.net>
References: <20050804225529.GJ24479@pasky.ji.cz>
	<20050804235638.GL24479@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 01:17:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1BRV-00013H-4d
	for gcvg-git@gmane.org; Sat, 06 Aug 2005 01:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVHEXRY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Aug 2005 19:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbVHEXRX
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Aug 2005 19:17:23 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:11186 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262016AbVHEXRV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2005 19:17:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050805231718.ZCRM19627.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 5 Aug 2005 19:17:18 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050804235638.GL24479@pasky.ji.cz> (Petr Baudis's message of
	"Fri, 5 Aug 2005 01:56:38 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> $DESTDIR is more usual during the build than $dest and is what is usually
> used in the makefiles, so let's use it too.

While I do not have much preference either way, I do not want to
make this kind of change without making corresponding changes to
the spec.in and debian/rules file in the same commit, or another
commit that immediately follow it.  And I wanted to do a 0.99.4
tomorrow, so I hope you would not mind if I placed this on
hold...
