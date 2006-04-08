From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to create independent branches
Date: Sat, 08 Apr 2006 13:49:04 -0700
Message-ID: <7vsloneqtb.fsf@assigned-by-dhcp.cox.net>
References: <20060407184701.GA6686@xp.machine.de>
	<7vr749i48s.fsf@assigned-by-dhcp.cox.net>
	<20060408180244.GA4807@xp.machine.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 08 22:49:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSKMy-0002Mj-FV
	for gcvg-git@gmane.org; Sat, 08 Apr 2006 22:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWDHUtH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Apr 2006 16:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWDHUtH
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Apr 2006 16:49:07 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:30636 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751426AbWDHUtG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Apr 2006 16:49:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060408204906.GMMD20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 8 Apr 2006 16:49:06 -0400
To: Peter Baumann <peter.baumann@gmail.com>
In-Reply-To: <20060408180244.GA4807@xp.machine.de> (Peter Baumann's message of
	"Sat, 8 Apr 2006 20:02:44 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18528>

Peter Baumann <peter.baumann@gmail.com> writes:

> Another question. I'd like to create a totaly independent branch (like
> the "todo" branch in git). Is there a more user friendly way than doing
>
> git-checkout -b todo
> rm .git/refs/heads/todo
> rm .git/index
> rm <all_files_in_your_workdir>
>
> ... hack hack hack ...
> git-commit -a
>
> I looked all over the docs, but can't find anything obvious.

My "todo" branch is not even part of my main git repository.  I
just have two independent repositories (git and todo) locally,
and push into the same public repository.

        
