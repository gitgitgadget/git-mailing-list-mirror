From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] A new merge algorithm, take 2
Date: Sun, 28 Aug 2005 02:42:21 -0700
Message-ID: <7vslwuo0si.fsf@assigned-by-dhcp.cox.net>
References: <20050827205135.GB16587@c165.ib.student.liu.se>
	<7vmzn2prck.fsf@assigned-by-dhcp.cox.net>
	<20050828080341.GA1928@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 11:44:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9JgH-000827-EB
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 11:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbVH1JmX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 05:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbVH1JmX
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 05:42:23 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:49140 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750881AbVH1JmW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2005 05:42:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050828094222.EVWP19627.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 28 Aug 2005 05:42:22 -0400
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20050828080341.GA1928@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Sun, 28 Aug 2005 10:03:41 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7866>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> I didn't know you could do things like that with git-ls-files :) But
> yeah, it's certainly less intrusive to do it that way. It will
> probably simplify things a great deal too. Wouldn't '--unmerged' be
> the appropriate flag to use for git-ls-files in this case?

Certainly.  I was trying to see if you are paying attention ;-).
