From: Junio C Hamano <junkio@cox.net>
Subject: Re: cg-update (cogito-0.13) bug: changed heads
Date: Tue, 06 Sep 2005 19:17:29 -0700
Message-ID: <7vhdcxbozq.fsf@assigned-by-dhcp.cox.net>
References: <431E03A5.6060709@zytor.com> <20050906231756.GC26934@pasky.ji.cz>
	<431E24FF.2000700@zytor.com> <431E4409.50307@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 07 04:18:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECpVN-0006vN-T1
	for gcvg-git@gmane.org; Wed, 07 Sep 2005 04:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbVIGCRc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 22:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbVIGCRb
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 22:17:31 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:41454 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750703AbVIGCRb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2005 22:17:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050907021731.OASD3414.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Sep 2005 22:17:31 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <431E4409.50307@zytor.com> (H. Peter Anvin's message of "Tue, 06
	Sep 2005 18:36:09 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8161>

"H. Peter Anvin" <hpa@zytor.com> writes:

> H. Peter Anvin wrote:
>>>
> OK, now later in the day I could not reproduce this on another box. 
> Either the situation was different enough, or I did something else wrong.

One thing that comes to mind, which may or may not be relevant
to your situation, is which branch you were on when you ran
cg-update.  I cannot speak for Pasky and I do not use Cogito,
but the 'git fetch' and 'git pull' commands that come with core
GIT used to have a funny interaction of fetch attempting to
update the branch head ref if your working tree happened to be
on that branch, which was fixed some time ago.
