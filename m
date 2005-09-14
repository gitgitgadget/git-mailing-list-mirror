From: Junio C Hamano <junkio@cox.net>
Subject: Re: Another merge test case from the kernel tree.
Date: Wed, 14 Sep 2005 10:51:45 -0700
Message-ID: <7v7jdjleq6.fsf@assigned-by-dhcp.cox.net>
References: <20050907164734.GA20198@c165.ib.student.liu.se>
	<20050907165012.GA20392@c165.ib.student.liu.se>
	<7vzmqk2u1w.fsf_-_@assigned-by-dhcp.cox.net>
	<7vpsrcqjj6.fsf_-_@assigned-by-dhcp.cox.net>
	<20050914174251.GA21639@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Tony Luck <tony.luck@intel.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 19:53:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFbQE-0007R2-Ro
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 19:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbVINRvs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 13:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbVINRvs
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 13:51:48 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:36543 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932471AbVINRvr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2005 13:51:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050914175147.YAYE8185.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Sep 2005 13:51:47 -0400
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20050914174251.GA21639@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Wed, 14 Sep 2005 19:42:51 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8547>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> It works for me. The 'recursive' strategy cleanly merges this and
> produces a result identical to the actual commit.
>
> The tree object 1d20af805193ab9982a48cb4c828c0f6af034c6c is the tree
> of the commit a1cddb88920b915eaba10712ecfd0fc698b00a22 which is one of
> the common ancestors. Are you sure that you got the entire repository? 
> It took some time for me to figure out that 'git clone
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/aegl/linux-2.6.git
> aegl.git' will _not_ give you a usable repository. You have to change
> aegl.git/.git/objects/objects/info/alternates before it becomes
> usable.

Ah, that figures..  I was looking at Tony's repository right
now.

Thanks.
