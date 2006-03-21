From: Junio C Hamano <junkio@cox.net>
Subject: Re: Bad merging with stgit or git
Date: Tue, 21 Mar 2006 12:57:49 -0800
Message-ID: <7vy7z3ecs2.fsf@assigned-by-dhcp.cox.net>
References: <1142969653.4749.109.camel@praia>
	<20060321200847.GS18185@pasky.or.cz>
	<Pine.LNX.4.64.0603211219230.3622@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Mar 21 21:58:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLnvi-0002Se-BH
	for gcvg-git@gmane.org; Tue, 21 Mar 2006 21:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113AbWCUU5y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Mar 2006 15:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965112AbWCUU5y
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Mar 2006 15:57:54 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:15548 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S965110AbWCUU5x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Mar 2006 15:57:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060321205335.BTSW20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 21 Mar 2006 15:53:35 -0500
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0603211219230.3622@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 21 Mar 2006 12:37:50 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17789>

Linus Torvalds <torvalds@osdl.org> writes:

> And I _hope_ that no git that recent will commit a merge in progress. 

Not even 1.1 series for that matter, no.

> However, it does look like the 
>
> 	case "$all,$also" in
> 	,t)
>
> case doesn't check for MERGE_HEAD. That could be the bug. Junio?

I do not think so.  

"Also" (aka -i) means "run update-index for these paths for me
first, and commit them alongside with what I (or merge) have
already updated in the index".
