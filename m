From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add receive.denyNonFastforwards config variable
Date: Wed, 20 Sep 2006 16:19:02 -0700
Message-ID: <7vzmcudt3t.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0609210027430.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vfyemf9ah.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0609210107140.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 01:19:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQBLQ-0003nr-EW
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 01:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWITXTF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 19:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbWITXTF
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 19:19:05 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:37339 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750855AbWITXTD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 19:19:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060920231902.FCI13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Sep 2006 19:19:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QnJo1V00Y1kojtg0000000
	Wed, 20 Sep 2006 19:18:49 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0609210107140.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 21 Sep 2006 01:07:54 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27429>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> If receive.denyNonFastforwards is set to true, git-receive-pack will deny
> non fast-forwards, i.e. forced updates. Most notably, a push to a repository
> which has that flag set will fail.
>
> As a first user, 'git-init-db --shared' sets this flag, since in a shared
> setup, you are most unlikely to want forced pushes to succeed.
>
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Looks good.  Care to do a handful more tasks before we forget?

 Documentation/git-init-db.txt
 Documentation/config.txt
 Documentation/git-receive-pack.txt
 t/t5400-send-pack.sh or a new test t/t5401-push-into-shared-repo.sh
