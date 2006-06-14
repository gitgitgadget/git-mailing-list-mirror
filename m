From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] auto-detect changed $prefix in Makefile and properly rebuild to avoid broken install
Date: Wed, 14 Jun 2006 14:32:31 -0700
Message-ID: <7vhd2nctjk.fsf@assigned-by-dhcp.cox.net>
References: <0J0V00LDT7B9BU00@mxout2.netvision.net.il>
	<7vver3cxlw.fsf@assigned-by-dhcp.cox.net>
	<f36b08ee0606141330l28330d79hab1aec5c741188c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 14 23:32:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fqcya-0000Hg-Tr
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 23:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWFNVce (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 17:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbWFNVcd
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 17:32:33 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:21214 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932330AbWFNVcd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jun 2006 17:32:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060614213232.SHTV19284.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Jun 2006 17:32:32 -0400
To: "Yakov Lerner" <iler.ml@gmail.com>
In-Reply-To: <f36b08ee0606141330l28330d79hab1aec5c741188c7@mail.gmail.com>
	(Yakov Lerner's message of "Wed, 14 Jun 2006 23:30:56 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21866>

"Yakov Lerner" <iler.ml@gmail.com> writes:

> I think single GIT-BUILD-FLAGS
> is enough, which will cover prefixes, too. Is this OK ?

Yes, it was what I was getting at.  I think a single
GIT-BUILD-FLAGS (or whatever name the list can fight over while
I am away) is preferred.

> BTW, I think it's useful to add Makefile itself as prerequisite for all *.o,
> so change in Makefile will cause recompilations. Shall I include this
> into this patch, too ?

I've thought about it but in practice this would make things
more inconvenient for developers without much gain, so I'd leave
it out.
