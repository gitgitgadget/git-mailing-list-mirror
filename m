From: Junio C Hamano <junkio@cox.net>
Subject: Re: FW: Git pulls failing on ia64 test tree?
Date: Wed, 14 Sep 2005 09:39:51 -0700
Message-ID: <7vbr2vob6w.fsf@assigned-by-dhcp.cox.net>
References: <B8E391BBE9FE384DAA4C5C003888BE6F046279C5@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 18:42:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFaIf-0004tr-WB
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 18:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbVINQjy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 12:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbVINQjy
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 12:39:54 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:35762 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1030268AbVINQjx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2005 12:39:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050914163953.UNLQ9510.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Sep 2005 12:39:53 -0400
To: "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F046279C5@scsmsx401.amr.corp.intel.com>
	(Tony Luck's message of "Wed, 14 Sep 2005 08:47:09 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8540>

"Luck, Tony" <tony.luck@intel.com> writes:

> After the first complaint, I looked around and found out about
> "git-update-server-info" (which I'd somehow missed).  So I ran
> (on master.kernel.org):
>
>   $ GIT_DIR=/pub/scm/linux/kernel/git/aegl/linux-2.6.git git-update-server-info
>
> and I now have info/refs, info/rev-cache, and objects/info/packs files.

That is a nice, but rsync bypasses all of that so I suspect
there is something else.  If you did not say:

> 12 hours later, I got another complaint.

I would have suspected that this was when one of the kernel.org
mirror machine was misbehaving and did not update for a day or
so, but I think it is already resolved now so I am puzzled..

> I've set up objects/info/alternates to point at linus' tree and deleted
> all the packs from my tree.  The web view at kernel.org/git looks ok,
> so I think those changes are ok.
>
> So what am I missing?

Let me take a look at your tree on master while I'll try to pull
from your public tree and see if I can reproduce.
