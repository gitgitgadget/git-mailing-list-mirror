From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2] gitweb: Use list for of open for running git commands, thorougly.
Date: Mon, 31 Jul 2006 03:53:28 -0700
Message-ID: <7virle6o5z.fsf@assigned-by-dhcp.cox.net>
References: <200607292239.11034.jnareb@gmail.com>
	<200607292251.21072.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 31 12:53:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7VOu-0000cL-Ua
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 12:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWGaKxa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 06:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWGaKxa
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 06:53:30 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:28869 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750793AbWGaKx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 06:53:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060731105328.UNUB12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 31 Jul 2006 06:53:28 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200607292251.21072.jnareb@gmail.com> (Jakub Narebski's message
	of "Sat, 29 Jul 2006 22:51:17 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24510>

This, together with PATCH 6, seems to break "history" link.
Visit a repository (summary page), click on "tree" on the second
line, and click on "history" (on any blob or tree).

I might have made a merge mistake while squashing PATCH 2 and
PATCH 6 into a single commit.

BTW, please be careful on trailing whitespaces.

I've wasted quite a lot of time yesterday just fixing up
trailing whitespaces from your patches (although the first in
your series was "whitespace cleanup" X-<).

I usually apply patches with whitespace=strip, unless there is a
compelling reason not to (e.g. when the patch is to add a
testcase of diff output which would inevitably have trailing
whitespaces when a context contains an empty line), which means
if you have a series of patches whose later patch updates lines
with trailing whitespaces an earlier patch introduced the patch
would not apply.
