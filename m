From: Junio C Hamano <junkio@cox.net>
Subject: Re: Merge with local conflicts in new files
Date: Wed, 17 May 2006 01:20:22 -0700
Message-ID: <7v4pzpjc55.fsf@assigned-by-dhcp.cox.net>
References: <8aa486160605161500m1dd8428cj@mail.gmail.com>
	<7v1wut61aj.fsf@assigned-by-dhcp.cox.net>
	<8aa486160605161611p4c9ddbc0v@mail.gmail.com>
	<7vu07p35xn.fsf@assigned-by-dhcp.cox.net>
	<1147852052.31879.50.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 10:20:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgHGd-0005do-6Z
	for gcvg-git@gmane.org; Wed, 17 May 2006 10:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbWEQIUY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 04:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWEQIUY
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 04:20:24 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:16361 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932475AbWEQIUX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 04:20:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060517082023.ONAO27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 May 2006 04:20:23 -0400
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1147852052.31879.50.camel@dv> (Pavel Roskin's message of "Wed,
	17 May 2006 03:47:32 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20168>

Pavel Roskin <proski@gnu.org> writes:

> I'm afraid this approach, while understandable from the technical
> standpoint, could prevent git from ever becoming a version control
> system that "just works" without any porcelains.
>
> I know a person who refuses to use any version control.  If he
> encountered this situation, he would never try any version control
> again.
>
> After all, we are talking about files in the _working_ directory.  It's
> not merely a transient appendix to the repository.  git is not the only
> player here.  If a file doesn't "belong" to git, it belongs to its
> "supreme commander", i.e. the user, and should be approached with utmost
> care.

I am biased ;-) and appreciate corrections like this.  How does
the updated patch I just sent out look?
