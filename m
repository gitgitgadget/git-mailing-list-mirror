From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix compilation of git.c
Date: Tue, 15 Nov 2005 19:01:23 -0800
Message-ID: <7v4q6de1oc.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511160243360.14176@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Nov 16 04:01:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcDY9-00054q-VJ
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 04:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbVKPDB0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 22:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbVKPDB0
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 22:01:26 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:61654 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932264AbVKPDBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 22:01:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051116030059.VLWF3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 15 Nov 2005 22:00:59 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511160243360.14176@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 16 Nov 2005 02:44:12 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11993>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Some systems do not define GLOB_ABORTED and GLOB_NOMATCH.

That's true, but the glob does not distinguish executables and
others anyway, do wouldn't it be more portable and easier to do
readdir, stat and list in the loop?
