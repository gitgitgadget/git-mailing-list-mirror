From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Do not allow git-init-db to be called twice in the same directory
Date: Mon, 26 Dec 2005 17:18:12 -0800
Message-ID: <7vbqz3ibhn.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0512270053030.14928@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Dec 27 02:18:22 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Er3To-0008VK-8J
	for gcvg-git@gmane.org; Tue, 27 Dec 2005 02:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVL0BSO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Dec 2005 20:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbVL0BSO
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Dec 2005 20:18:14 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:1153 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932178AbVL0BSO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Dec 2005 20:18:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051227011626.WYXF26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Dec 2005 20:16:26 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512270053030.14928@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 27 Dec 2005 00:54:05 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14067>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> t5300 is also adapted, since it relies heavily on init-db not complaining 
> when $GIT_DIR already exists.

I think it tries not to overwrite things that are already there
and is meant to be safe to run in an already populated
repository; e.g. you should be able to use it to pick up newly
added templates.

Is there a particular reason running the current init-db twice
is undesirable?
