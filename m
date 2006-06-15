From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] auto-detect changed $prefix in Makefile and properly rebuild to avoid broken install
Date: Thu, 15 Jun 2006 11:26:02 +0200
Message-ID: <E1Fqo70-0003pZ-PU@moooo.ath.cx>
References: <0J0V00LDT7B9BU00@mxout2.netvision.net.il> <7vver3cxlw.fsf@assigned-by-dhcp.cox.net> <f36b08ee0606141330l28330d79hab1aec5c741188c7@mail.gmail.com> <7vhd2nctjk.fsf@assigned-by-dhcp.cox.net> <f36b08ee0606141438u7d7b59e1ra68bc23e2e926290@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 15 11:26:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fqo7A-0006Re-Kx
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 11:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWFOJ0J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 05:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWFOJ0I
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 05:26:08 -0400
Received: from moooo.ath.cx ([85.116.203.178]:52884 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S932456AbWFOJ0H (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jun 2006 05:26:07 -0400
To: Yakov Lerner <iler.ml@gmail.com>
Mail-Followup-To: Yakov Lerner <iler.ml@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <f36b08ee0606141438u7d7b59e1ra68bc23e2e926290@mail.gmail.com>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21887>

> Either GIT-CFLAGS or GIT-BUILD-FLAGS,
> whichever is shorter :-)

I would not take GIT-CFLAGS because there is an environment variable
used by make named CFLAGS and means something else.

What is the target test-prefix-change good for? Should it really be
included?
