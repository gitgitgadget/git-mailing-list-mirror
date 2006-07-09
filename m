From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Patch] Using 'perl' in *.sh
Date: Sun, 09 Jul 2006 03:14:39 -0700
Message-ID: <7vd5cfnkz4.fsf@assigned-by-dhcp.cox.net>
References: <200607081732.04273.michal.rokos@nextsoft.cz>
	<7v3bdcq7dy.fsf@assigned-by-dhcp.cox.net>
	<20060709094630.GB5919@steel.home> <20060709095114.GQ22573@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Michal Rokos <michal.rokos@nextsoft.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 12:15:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzWJX-000687-Mk
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 12:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbWGIKOu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 06:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWGIKOu
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 06:14:50 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:29315 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S965007AbWGIKOu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jul 2006 06:14:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060709101449.HONR985.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 9 Jul 2006 06:14:49 -0400
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
In-Reply-To: <20060709095114.GQ22573@lug-owl.de> (Jan-Benedict Glaw's message
	of "Sun, 9 Jul 2006 11:51:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23541>

Jan-Benedict Glaw <jbglaw@lug-owl.de> writes:

> My personal oppinion is to call perl scripts as `perl foo.pl' and thus
> let the user decide (by means of setting $PATH) which perl incarnation
> she wants to use.

Sounds sane, and I was wrong.

We should be able to do that for perl (we cannot in general do
that for GNU tools since some people seem to like renaming them
from foo to gfoo).

Michal, is there a reason you do not want to have the version of
perl you teach git tools via #! lines with PERL_PATH on your $PATH?
