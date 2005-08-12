From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Re: git-http-pull broken in latest git
Date: Thu, 11 Aug 2005 19:01:46 -0700
Message-ID: <7vzmrnc3qt.fsf@assigned-by-dhcp.cox.net>
References: <42F8D472.3080404@de.bosch.com>
	<20050811223349.GI25280@pasky.ji.cz>
	<7v4q9wf4ad.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508111929010.12816@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 04:02:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3Os0-0001go-Oi
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 04:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbVHLCB4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 22:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbVHLCB4
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 22:01:56 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:34557 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S964772AbVHLCBy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2005 22:01:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050812020147.USTV1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 11 Aug 2005 22:01:47 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0508111929010.12816@iabervon.org> (Daniel
	Barkalow's message of "Thu, 11 Aug 2005 19:38:09 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Daniel Barkalow <barkalow@iabervon.org> writes:

> It should work anyway,...

That is true.  Please forget about the "recommendation" to slurp
packs and not falling back on commit walker.

Thanks for the patch.
