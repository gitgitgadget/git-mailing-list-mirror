From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUCNE] GIT 1.1.0
Date: Mon, 09 Jan 2006 14:59:43 -0800
Message-ID: <7vwth9f1nk.fsf@assigned-by-dhcp.cox.net>
References: <7v4q4eurgu.fsf@assigned-by-dhcp.cox.net>
	<43C2CAED.8030304@cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 00:00:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ew5zQ-0003C9-3t
	for gcvg-git@gmane.org; Mon, 09 Jan 2006 23:59:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbWAIW7p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 17:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbWAIW7p
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 17:59:45 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:3253 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751602AbWAIW7p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2006 17:59:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060109225843.NSXG20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 9 Jan 2006 17:58:43 -0500
To: lamikr@cc.jyu.fi
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14382>

lamikr <lamikr@cc.jyu.fi> writes:

>> - "git --version" from an interim snapshot gives a more
>>   descriptive version name than "1.0-GIT" (Linus).
>>  
>>
> I installed 1.1.0 today and it shows me
>
> $ git --version
> git version 1.0.GIT

Ah, sorry, and thanks for catching this.  RPM building procedure
is somewhat tricky, and I failed to catch this bug.  Fixed in my
tree --- this calls for an early 1.1.1 release I guess.

On the other hand, if you are building from the source, what
Andreas said applies, and in addition you need to fetch v1.1.0
tag before building; otherwise the versioning mechanism would not
notice you are building v1.1.0.
