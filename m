From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC 2/2] Automatically transform .git/{branches,remotes} into .git/config
Date: Sun, 27 Nov 2005 22:22:49 -0800
Message-ID: <7vfyph1ebq.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511211455120.13775@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051127125945.GD22159@pasky.or.cz>
	<Pine.LNX.4.63.0511280248020.12343@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 07:40:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgcPt-0006nB-Ez
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 07:23:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbVK1GWx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 01:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbVK1GWx
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 01:22:53 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:24566 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932075AbVK1GWw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 01:22:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051128062208.FEG20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 28 Nov 2005 01:22:08 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511280248020.12343@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 28 Nov 2005 02:52:08 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12851>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I only realized that we -- in the good tradition of UNIX -- have many 
> different formats for different configurations: Some configurations are in 
> .gitignore, some are in .git/branches/, some in .git/remotes/, some in 
> .git/config, and even some in environment variables!

Can you live with something like this?

 - we will add new ones to config, now we have it;

 - we will not deprecate existing ones outside of config for some time;

 - we will not duplicate/move existing ones into config at least
   for now to keep our work less complicated;

 - we would revisit deprecating things outside config file
   sometime later after 1.0 stabilizes, and that's when we will
   talk about moving these things into config.
