From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Renaming environment variables.
Date: Mon, 09 May 2005 17:22:30 -0700
Message-ID: <7vzmv4udyx.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0505091847050.30848-100000@iabervon.org>
	<7v7ji8vt5c.fsf@assigned-by-dhcp.cox.net>
	<20050510001351.GH15712@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Sean <seanlkml@sympatico.ca>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 10 02:16:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVIP7-0002Hg-D1
	for gcvg-git@gmane.org; Tue, 10 May 2005 02:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVEJAWf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 20:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVEJAWf
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 20:22:35 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:14249 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261436AbVEJAWd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2005 20:22:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050510002232.TOFX26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 9 May 2005 20:22:32 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050510001351.GH15712@pasky.ji.cz> (Petr Baudis's message of
 "Tue, 10 May 2005 02:13:51 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> I think it would be nice to have something like GIT_BASEDIR,
PB> which would default to .git, and the objects directory would
PB> then default to $GIT_BASEDIR/objects and the index file
PB> would default to $GIT_BASEDIR/index.

Yes and no.  While I agree that having more things customizable
may be nicer than not having them, I do not see what GIT_BASEDIR
buys us.  That is, I cannot come up with a good use scenario
that would be helped by having that environment variable.

Except that you do not have to specify GIT_OBJECTS and
GIT_INDEX_FILE separately, that is.  Is it what you are aiming
for?

