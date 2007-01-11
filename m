From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] OSX ends with "install: git-init.1: No such file or directory"
Date: Thu, 11 Jan 2007 15:53:50 -0800
Message-ID: <7vd55l15o1.fsf@assigned-by-dhcp.cox.net>
References: <8664bedsbc.fsf@blue.stonehenge.com>
	<7vmz4q5abe.fsf@assigned-by-dhcp.cox.net> <45A60A0B.5000001@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Jan 12 00:54:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H59kd-0004YK-1d
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 00:54:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030377AbXAKXyK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 18:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbXAKXyK
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 18:54:10 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:36977 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030381AbXAKXyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 18:54:09 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070111235406.NLNP7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Thu, 11 Jan 2007 18:54:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9ztE1W00n1kojtg0000000; Thu, 11 Jan 2007 18:53:15 -0500
To: Andreas Ericsson <ae@op5.se>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36636>

Andreas Ericsson <ae@op5.se> writes:

> Perhaps, but "git init-db" does a lot more than just initialise the
> object database (such as setting default config-variables, installing
> template hooks...). "git init" is actually a more sensible name now
> adays.

Thanks.  That's the "excuse" I was hoping to come from somewhere ;-).

In general, I do not like any change, and I do not see much
point in renaming init-db to init.  Granted, other people may be
used to see "scm init", but that is not a strong enough reason
for _me_ to sell the name change to old-timers.

So let's do this instead.

 (1) Documentation/git-init.txt will have the full
     documentation, and we mention init and init-db are
     synonyms;

 (2) We refer people to gitlink:git-init[1] from
     Documentation/git-init-db.txt
