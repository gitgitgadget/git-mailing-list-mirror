From: Junio C Hamano <junkio@cox.net>
Subject: Re: Parallel pull for ssh-pull
Date: Tue, 02 Aug 2005 13:38:33 -0700
Message-ID: <7vmzo09ira.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.62.0508021544430.23721@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 02 22:39:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E03XA-0003TZ-60
	for gcvg-git@gmane.org; Tue, 02 Aug 2005 22:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVHBUij (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Aug 2005 16:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbVHBUij
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Aug 2005 16:38:39 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:9453 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261763AbVHBUih (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2005 16:38:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050802203835.JOYC3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 2 Aug 2005 16:38:35 -0400
To: barkalow@iabervon.org
In-Reply-To: <Pine.LNX.4.62.0508021544430.23721@iabervon.org>
	(barkalow@iabervon.org's message of "Tue, 2 Aug 2005 16:02:59 -0400
	(EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

barkalow@iabervon.org writes:

> This work is based on some now in -pu; what should I base my patches on? I 
> would ideally like to add a function to one of the patches in -pu and fix 
> a subtle bug in the other, in addition to further patches to actually use 
> the feature in ssh-pull.

The proposed patch queue is just a throw-away branch that I use
for the purpose of (1) not to lose patches from people, (2) to
ack patches from others, and (3) let people know which ones are
under consideration.

Either a patch on top of the pu branch, or a brand new patch on
top of the master branch would work fine for me.  If you feel
some stuff that are in pu need to be fixed or cleaned up, you
may want choose the latter --- that way, software archaeologists
do not need to know that you made a mess in earlier rounds ;-).
If you choose to do so, I would appreciate a warning to tell me
which existing patches to drop from pu, although that would
probably be pretty clear from the context.

Thanks.
