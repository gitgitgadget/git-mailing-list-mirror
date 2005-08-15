From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add -k kill keyword expansion option to git-cvsimport
Date: Mon, 15 Aug 2005 01:48:06 -0700
Message-ID: <7vr7cv1t89.fsf@assigned-by-dhcp.cox.net>
References: <46a038f9050814235140877be7@mail.gmail.com>
	<7vk6in65dp.fsf@assigned-by-dhcp.cox.net>
	<46a038f90508150037f128d6@mail.gmail.com>
	<7vacjj3968.fsf@assigned-by-dhcp.cox.net>
	<46a038f905081501301bd9a801@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 10:48:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4adl-0004KB-0l
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 10:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbVHOIsJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 04:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbVHOIsJ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 04:48:09 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:52209 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932272AbVHOIsI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 04:48:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050815084808.JVCF25443.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 Aug 2005 04:48:08 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f905081501301bd9a801@mail.gmail.com> (Martin Langhoff's
	message of "Mon, 15 Aug 2005 20:30:01 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Martin Langhoff <martin.langhoff@gmail.com> writes:

> Do you want just -kv or you'd like to handle all the modes?

No, I do not.

I was just wondering if we are limiting options for people who
want to convert their own CVS repositories by always using
either -kkv or -ko and nothing else.  Your simply saying "I do
not think so, -ko is what makes the most sense, and any other
option does not make any sense, but we used to do -kkv so let's
leave that as the default and have a -k option that does -ko" is
enough for me.

It is getting late for me so I'll merge it and push it out
tomorrow when I find time; it will be my day-job day.
