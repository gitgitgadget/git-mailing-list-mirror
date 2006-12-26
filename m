From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git reflog show
Date: Mon, 25 Dec 2006 22:14:23 -0800
Message-ID: <7vd567fakg.fsf@assigned-by-dhcp.cox.net>
References: <20061223101956.GD9396@spearce.org>
	<7v4prmsxjl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612231552140.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<20061224061151.GE7443@spearce.org>
	<Pine.LNX.4.63.0612241333280.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v1wmpq83g.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612251449140.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vwt4fj1cs.fsf@assigned-by-dhcp.cox.net>
	<20061226054815.GC28084@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 26 07:14:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gz5a6-0007GX-10
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 07:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWLZGOZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Dec 2006 01:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWLZGOZ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 01:14:25 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:36972 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932345AbWLZGOY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Dec 2006 01:14:24 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061226061423.DTCL97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Tue, 26 Dec 2006 01:14:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3JEc1W00j1kojtg0000000; Tue, 26 Dec 2006 01:14:37 -0500
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061226054815.GC28084@spearce.org> (Shawn Pearce's message of
	"Tue, 26 Dec 2006 00:48:15 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35413>

Shawn Pearce <spearce@spearce.org> writes:

> So what you are proposing is to make the reflog visible in 'git log'
> by a new option?  Or to just try to reuse all of its display code
> but keep the reflog under 'git reflog show' ?

I am not specifically proposing anything, but the part you
quoted is about the latter.

What Johannes brought up would involve hooking into the usual
log walking machinery to show the commits in "merge order" (more
precisely, "local appearance order").  I do not think it is
about "showing the reflog data", but about using reflog data to
give a different presentation order to the usual log output.
Your "reflog show" is more about showing what are recorded in
the reflog.

It is not like implementing the sorting of the logs in local
appearance order would make your "reflog show" redundant or
useless; both are independently useful, I think.
