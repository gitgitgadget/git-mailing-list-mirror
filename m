From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] "test" in Solaris' /bin/sh does not support -e
Date: Mon, 26 Jun 2006 10:03:23 -0700
Message-ID: <7vd5cvj1d0.fsf@assigned-by-dhcp.cox.net>
References: <20060625014703.29304.12715.stgit@machine.or.cz>
	<7vk676orjy.fsf@assigned-by-dhcp.cox.net>
	<20060626082428.G52c9608e@leonov.stosberg.net>
	<20060626082754.G6ec0a61e@leonov.stosberg.net>
	<7vwtb4i89d.fsf@assigned-by-dhcp.cox.net>
	<20060626094211.G3b49c5c3@leonov.stosberg.net>
	<20060626100402.G5761a3ea@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 26 19:04:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuuVQ-0005lc-H4
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 19:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWFZRD2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 13:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWFZRD2
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 13:03:28 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:694 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751144AbWFZRDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jun 2006 13:03:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060626170324.UOES16011.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Jun 2006 13:03:24 -0400
To: Dennis Stosberg <dennis@stosberg.net>
In-Reply-To: <20060626100402.G5761a3ea@leonov.stosberg.net> (Dennis Stosberg's
	message of "Mon, 26 Jun 2006 12:04:03 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22677>

Dennis Stosberg <dennis@stosberg.net> writes:

> Argh!  Why don't they put their "standards compliant" shell to
> /bin/sh?  The current one doesn't even support the $( )-style command
> substitution, so making the scripts run with that shell would be
> _really_ ugly.

Which means this in pb/gitpm topic needs further changes,
perhaps.

$ git grep -n '\$\$(' pb/gitpm:Makefile
pb/gitpm:Makefile:537:	INSTLIBDIR=$$(make -s -C perl instlibdir) && \
