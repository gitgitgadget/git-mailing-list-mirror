From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Do not allow git-init-db to be called twice in the same directory
Date: Tue, 27 Dec 2005 08:47:52 -0800
Message-ID: <7vlky6bi6f.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0512270053030.14928@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vbqz3ibhn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0512271457200.17086@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 27 17:48:21 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ErHzc-00057V-3V
	for gcvg-git@gmane.org; Tue, 27 Dec 2005 17:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbVL0Qry (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Dec 2005 11:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbVL0Qry
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Dec 2005 11:47:54 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:34535 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932348AbVL0Qry (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2005 11:47:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051227164557.LDSP17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Dec 2005 11:45:57 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512271457200.17086@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 27 Dec 2005 15:01:40 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14078>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Is there a particular reason running the current init-db twice
>> is undesirable?
>
> In my case, yes. When I do that, it means that I did not correctly 
> change directories. I fscked up my private git repository twice that way.

Maybe a warning (e.g. "rerunning in an already set up
repository") is in order?
