From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] builtin-push: resurrect parsing of Push: lines
Date: Sun, 30 Apr 2006 15:02:22 -0700
Message-ID: <7viroqyb69.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0604301405150.2026@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 01 00:02:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaJzz-0008GV-AD
	for gcvg-git@gmane.org; Mon, 01 May 2006 00:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWD3WCZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 18:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWD3WCZ
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 18:02:25 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:27808 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750878AbWD3WCY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 18:02:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060430220224.TSVI27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 30 Apr 2006 18:02:24 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0604301405150.2026@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 30 Apr 2006 14:05:55 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19360>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The C'ification of push left these behind.

> +#define MAX_REFSPECS 10
> +static int current_refspec = 0;
> +static char *refspecs_[MAX_REFSPECS];

While this fix makes perfect sense, I think MAX_URI set to 16 is
reasonable hard limit, but I am not happy about giving hard
limit to MAX_REFSPECS -- that's a regression from the shell
script one.
