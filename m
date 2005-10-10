From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach git-status about spaces in file names also on MacOSX
Date: Mon, 10 Oct 2005 13:35:31 -0700
Message-ID: <7vd5md3yb0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0510102212230.8106@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Oct 10 22:37:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP4NH-0000rQ-Q3
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 22:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbVJJUfe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 16:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbVJJUfe
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 16:35:34 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:10961 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751213AbVJJUfd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 16:35:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051010203516.QXUG29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Oct 2005 16:35:16 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510102212230.8106@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 10 Oct 2005 22:13:37 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9925>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Not that I really understand what Kai's original patch really does, but on
> my iBook, sed does not understand '\t' and consequently cuts of every file
> name at the first "t" (or backslash...).

Thanks; not Kai's fault but mine.
