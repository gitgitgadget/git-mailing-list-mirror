From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitk highlight feature
Date: Tue, 02 May 2006 16:48:49 -0700
Message-ID: <7vejzcj8da.fsf@assigned-by-dhcp.cox.net>
References: <17495.61142.677439.171773@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 01:48:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fb4bw-00058v-Hs
	for gcvg-git@gmane.org; Wed, 03 May 2006 01:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWEBXsy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 19:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbWEBXsx
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 19:48:53 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:34014 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964903AbWEBXsx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 May 2006 19:48:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060502234851.NQMV27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 2 May 2006 19:48:51 -0400
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17495.61142.677439.171773@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Wed, 3 May 2006 09:44:22 +1000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19444>

Paul Mackerras <paulus@samba.org> writes:

> I just pushed out some changes to gitk which allow you to use one view
> to highlight another (see the "Highlight" submenu under the "View"
> menu), and which allow you to specify arbitrary git-rev-list arguments
> for a view.  The arguments string uses shell quoting conventions.

Eh, the string entered by me is quoted by the program, or do I
have to quote it myself?  I suspect it should not be so bad to
code, even if you have to do it with tcl ;-).

> I had been thinking of having fields in the view editor dialog where
> you could put in refs that you did and didn't want included, date
> specifiers, etc., all in separate fields with suitable labels.  Now
> I'm thinking that it's probably just as convenient to put
> "ORIG_HEAD.." into the git-rev-list arguments field as it is to put
> "ORIG_HEAD" in the "Don't include commits reachable from this" field.
> There may be an argument for having fields for "Exclude commits before
> this date" and "Exclude commits after this date", because those things
> often have spaces in them (e.g. "2 weeks ago") which would have to be
> quoted in the git-rev-list arguments field.
>
> Thoughts?

Calendar widgets.  BTW, "rev-list --since=2.days.ago" would work
rather well ;-).
