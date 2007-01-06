From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-reset --hard: use quotes when we tell the user what HEAD was reset to
Date: Sat, 06 Jan 2007 11:26:29 -0800
Message-ID: <7v8xgg553u.fsf@assigned-by-dhcp.cox.net>
References: <20070106102322.7468.57615.stgit@c165>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 20:26:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3HBa-000090-IJ
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 20:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbXAFT0b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 14:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbXAFT0b
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 14:26:31 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:47176 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932104AbXAFT0a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 14:26:30 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070106192629.YRA19398.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Sat, 6 Jan 2007 14:26:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7vSk1W00q1kojtg0000000; Sat, 06 Jan 2007 14:26:45 -0500
To: Fredrik Kuivinen <freku045@student.liu.se>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36096>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> Idea and motivating example from Andy Whitcroft:
>
>     apw@pinky$ git checkout -b bar master
>     apw@pinky$ git reset --hard ac9c1108d8915f0937795e354ad72c4ae6890a3f
>     HEAD is now at ac9c110... git-fetch: remove .keep file at the end.
>
>     Huh, fetch?  Remove what .keep file?  Did I do a fetch?  What?
>
>     I think we need to delimit the name better, probabally we need to quote
>     it.  Perhaps something like:
>
>     HEAD is now at ac9c110: "git-fetch: remove .keep file at the end".

I've also considered something along that line, but:

 (1) I think this 'confusion' is only because you are futzing
     with a project that deals with git-fetch and friends and
     not a general problem.

 (2) With "HEAD is now at xxxxx..."  prefix, even two characters
     are precious to fit the title of the commit on a single
     line.

With these in mind, do you still want to do this?
