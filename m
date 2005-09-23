From: Junio C Hamano <junkio@cox.net>
Subject: Re: /bin/sh portability question
Date: Fri, 23 Sep 2005 02:19:15 -0700
Message-ID: <7vfyrwdtv0.fsf@assigned-by-dhcp.cox.net>
References: <20050923075058.GA25473@bohr.gbar.dtu.dk>
	<7vzmq4faz6.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP05141C92C0F083A17B2EEFAE960@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 11:20:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIjiq-0003XA-Ii
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 11:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbVIWJTR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 05:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbVIWJTR
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 05:19:17 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:14023 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750825AbVIWJTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 05:19:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050923091916.BLOL13739.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Sep 2005 05:19:16 -0400
To: "Sean" <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP05141C92C0F083A17B2EEFAE960@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Fri, 23 Sep 2005 05:02:57 -0400
	(EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9170>

"Sean" <seanlkml@sympatico.ca> writes:

> If not, would you accept a patch that first converted the shell scripts to
> #!/bin/bash and then added a "make install" option that allowed them to be
> replaced?   Something like "make install S=/bin/ash" for instance?

    $ make SHELL_PATH=/bin/bash

Perhaps?
