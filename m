From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach git-apply about '-R'
Date: Fri, 28 Jul 2006 08:36:18 -0700
Message-ID: <7v3bcln3m5.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607261940090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<200607262039.25155.Josef.Weidendorfer@gmx.de>
	<20060728013038.GH13776@pasky.or.cz>
	<Pine.LNX.4.63.0607281213250.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 28 17:37:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6UOZ-0005y2-Oz
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 17:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161121AbWG1PgV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 11:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161124AbWG1PgV
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 11:36:21 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:27310 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1161121AbWG1PgU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jul 2006 11:36:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060728153619.DYRH12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 28 Jul 2006 11:36:19 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607281213250.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 28 Jul 2006 12:14:46 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24391>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

A quick comment without looking much at the code.  Do you sanely
bail out when asked to reverse-apply a binary patch?

Also what was the reason to change an existing test vector in
4102?  That does not look like related to -R flag.
