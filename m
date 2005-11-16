From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add option USE_INPLACE to Makefile
Date: Tue, 15 Nov 2005 19:11:18 -0800
Message-ID: <7vmzk5cmnd.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511160333460.15130@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 04:12:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcDhk-0007xy-6W
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 04:11:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965184AbVKPDLV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 22:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965196AbVKPDLU
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 22:11:20 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:54955 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S965184AbVKPDLU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 22:11:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051116031055.YARK15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 15 Nov 2005 22:10:55 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511160333460.15130@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 16 Nov 2005 03:35:48 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11996>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> and you no longer need to worry about setting variables like
> GIT_EXEC_PATH and GIT_PYTHON_PATH.

I think you can already do this in the config.mak mechanism
added by, ... (goes and asks git-whatchanged about it),...
*you*, no?

You know you are not installing things anyway if you do that, so
I do not see much point hiding the install target and friends
either.
