From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT 0.99.7d, and end of week status.
Date: Mon, 26 Sep 2005 13:23:25 -0700
Message-ID: <7vwtl3h936.fsf@assigned-by-dhcp.cox.net>
References: <7vll1lr1bq.fsf@assigned-by-dhcp.cox.net>
	<200509252143.23905.alan@chandlerfamily.org.uk>
	<7v1x3cn1cj.fsf@assigned-by-dhcp.cox.net>
	<200509260709.12937.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 26 22:25:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJzVx-0000Bm-CS
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 22:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbVIZUX2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 16:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbVIZUX2
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 16:23:28 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:9163 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932510AbVIZUX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 16:23:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050926202327.HWMU29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Sep 2005 16:23:27 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9329>

Alan Chandler <alan@chandlerfamily.org.uk> writes:

> This is where I get puzzled.  Fetch on its own didn't move where "maint" 
> pointed to so doing this checkout would have left me at the v0.99.7c tag (I 
> didn't actually do it - as I was then puzzling over the documentation trying 
> to see what I did wrong)

Because "git fetch origin tag v0.99.7d" fetched only that tag --
git-fetch command is not told to fetch anything else.  Most
importantly, it did not tell it to update "maint" branch head
from the remote.  That was why I said that instrucition was
busted.
