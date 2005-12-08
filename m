From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] use "git init-db" in tests
Date: Thu, 08 Dec 2005 12:47:41 -0800
Message-ID: <7vu0dje2oi.fsf@assigned-by-dhcp.cox.net>
References: <20051208202555.GA3046@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 08 21:50:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkSgO-0004o9-NQ
	for gcvg-git@gmane.org; Thu, 08 Dec 2005 21:48:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbVLHUrr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 15:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbVLHUrr
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 15:47:47 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:46007 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751059AbVLHUrq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 15:47:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051208204745.BNMW25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 8 Dec 2005 15:47:45 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20051208202555.GA3046@steel.home> (Alex Riesen's message of
	"Thu, 8 Dec 2005 21:25:55 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13373>

Alex Riesen <raa.lkml@gmail.com> writes:

> Unless there was a special reason to use git-init-db from $PATH, could
> the patch below be accepted? It makes the test suite use git-init-db
> from the "the binaries we have just built".

A few lines above what you patched we do make sure the PATH
starts with the top of the build directory where you would find
git-init-db we have just built, so unless I am missing something...
