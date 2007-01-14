From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Allow whole-tree operations to be started from a subdirectory
Date: Sun, 14 Jan 2007 11:36:26 -0800
Message-ID: <7vhcutflj9.fsf@assigned-by-dhcp.cox.net>
References: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net>
	<7vy7o8rnyw.fsf_-_@assigned-by-dhcp.cox.net>
	<7vac0orml9.fsf_-_@assigned-by-dhcp.cox.net>
	<200701140111.20671.Josef.Weidendorfer@gmx.de>
	<45A97EC5.10401@midwinter.com>
	<7virfaie1m.fsf@assigned-by-dhcp.cox.net>
	<45AA72E1.6060701@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:47:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VWX-0000sf-OI
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:21:33 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V80-0003eK-FO
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbXANTg3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 14:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751645AbXANTg3
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 14:36:29 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:40353 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbXANTg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 14:36:28 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070114193627.RKNK20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Sun, 14 Jan 2007 14:36:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id B7cj1W00w1kojtg0000000; Sun, 14 Jan 2007 14:36:44 -0500
To: Steven Grimm <koreth@midwinter.com>
In-Reply-To: <45AA72E1.6060701@midwinter.com> (Steven Grimm's message of "Sun,
	14 Jan 2007 10:13:53 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36850>

Steven Grimm <koreth@midwinter.com> writes:

> For example, on a simple Web project, the UI designers will always cd
> to the "html" directory. They get "src" and "lib" too, but if they had
> a choice they wouldn't. When they cherry-pick, it'll always be a
> cherry-pick of their own stuff (in the html directory) and likewise
> with a revert, so they have no reason to cd-up for any of those
> operations if the tool doesn't demand it. And perhaps less obvious: in
> a typical shared integration area setup, they will never have any
> conflicts anywhere but their subdirectory since the other directories
> will always be able to fast-forward merge. So cd-up isn't useful for
> them even in the case of merge conflicts.

Both good points.  Especially the latter one, I did not think of
myself.

Thanks.
