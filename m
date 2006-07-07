From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Makefile: export NO_SVN_TESTS
Date: Fri, 07 Jul 2006 05:41:52 -0700
Message-ID: <7vk66py4bz.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607071326030.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 07 14:42:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fypef-0003dP-Nw
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 14:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWGGMlz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 08:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWGGMlz
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 08:41:55 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:658 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932155AbWGGMly (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jul 2006 08:41:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060707124153.HSBB12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Jul 2006 08:41:53 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23439>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Without this patch, it really is not sufficient to define NO_SVN_TESTS
> in config.mak or the Makefile.

Good catch.  I never use config.mak but always use the make
wrapper approach, so I did not notice it.

Thanks.
