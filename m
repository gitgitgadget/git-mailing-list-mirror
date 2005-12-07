From: Junio C Hamano <junkio@cox.net>
Subject: Re: Failure in t6021 on Red Hat Enterprise Linux 4
Date: Wed, 07 Dec 2005 09:38:54 -0800
Message-ID: <7vfyp4u7rl.fsf@assigned-by-dhcp.cox.net>
References: <20051207164909.24221.qmail@web34304.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 18:43:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ek3Fw-0007RT-Ix
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 18:39:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbVLGRi5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 12:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbVLGRi5
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 12:38:57 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:7352 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751254AbVLGRi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2005 12:38:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051207173724.NDTD17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Dec 2005 12:37:24 -0500
To: Mark Allen <mrallen1@yahoo.com>
In-Reply-To: <20051207164909.24221.qmail@web34304.mail.mud.yahoo.com> (Mark
	Allen's message of "Wed, 7 Dec 2005 08:49:09 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13332>

Mark Allen <mrallen1@yahoo.com> writes:

> Running t/t6021-crisscross-merge.sh -v -i on Red Hat Enterprise Linux 4 Workstation with
> python 2.3.4 installed, I found a fatal error in the test.

Are you using git RPM, or building by hand?

If the latter, "grep -A2 python INSTALL" may be helpful.
