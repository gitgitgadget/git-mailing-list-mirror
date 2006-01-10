From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Remember and use GIT_EXEC_PATH on exec()'s
Date: Tue, 10 Jan 2006 13:09:47 -0800
Message-ID: <7vhd8b6b8k.fsf@assigned-by-dhcp.cox.net>
References: <1136849678.11717.514.camel@brick.watson.ibm.com>
	<1136849810.11717.518.camel@brick.watson.ibm.com>
	<7vwth8bxqd.fsf@assigned-by-dhcp.cox.net>
	<1136900174.11717.537.camel@brick.watson.ibm.com>
	<43C3CC4A.4030805@op5.se>
	<1136910406.11717.579.camel@brick.watson.ibm.com>
	<7vzmm36f1x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0601102054200.27363@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Ostrowski <mostrows@watson.ibm.com>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 22:10:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwQka-0002cZ-JX
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 22:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932683AbWAJVJu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 16:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbWAJVJu
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 16:09:50 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:5339 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932683AbWAJVJt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 16:09:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060110210835.BAAT20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 10 Jan 2006 16:08:35 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0601102054200.27363@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 10 Jan 2006 20:55:01 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14456>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Why? If what is prepended to PATH only contains git programs?

Recall the "diff" example Michal gave us.


 
