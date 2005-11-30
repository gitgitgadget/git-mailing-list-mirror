From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-name-rev off-by-one bug
Date: Tue, 29 Nov 2005 16:53:17 -0800
Message-ID: <7v4q5v5536.fsf@assigned-by-dhcp.cox.net>
References: <20051130001503.28498.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org, pasky@suse.cz
X-From: git-owner@vger.kernel.org Wed Nov 30 01:56:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhGG7-0003AG-UX
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 01:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbVK3Azk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 19:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbVK3Azk
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 19:55:40 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:3043 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750742AbVK3Azj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 19:55:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051130005241.FODV20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 29 Nov 2005 19:52:41 -0500
To: linux@horizon.com
In-Reply-To: <20051130001503.28498.qmail@science.horizon.com>
	(linux@horizon.com's message of "29 Nov 2005 19:15:03 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12976>

linux@horizon.com writes:

> I'm wondering if this isn't a philosophical issue.

I do not think so.  I have to admit I did not exactly agree with
the current behaviour when it was changed from the previous one,
but at the same time I did not have anything concrete against
it, and I did not care too much about the details back then.  I
suspect it was primarily be done to make things easier for the
end user without changing already existing tools (i.e.,
git-diff-files did not have to start taking --stage=2 flag to
tell it to compare stage2 and working tree).

This is the message from Linus that announced the current
behaviour:

	http://marc.theaimsgroup.com/?l=git&m=111826424425624
