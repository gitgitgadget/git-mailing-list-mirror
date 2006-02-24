From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-seek: Eliminate spurious warning. Fix errant reference to git-bisect in docs.
Date: Thu, 23 Feb 2006 22:02:48 -0800
Message-ID: <7vslq9fg53.fsf@assigned-by-dhcp.cox.net>
References: <43F20532.5000609@iaglans.de>
	<Pine.LNX.4.64.0602140845080.3691@g5.osdl.org>
	<87k6bxvmj6.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0602141026570.3691@g5.osdl.org>
	<87fymlvgzv.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0602141224110.3691@g5.osdl.org>
	<87d5hpvc8p.wl%cworth@cworth.org>
	<7vu0b1pntl.fsf@assigned-by-dhcp.cox.net>
	<87zmkhrf4y.wl%cworth@cworth.org>
	<20060224001848.GB21094@fieldses.org>
	<87vev5r2m4.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 07:03:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCW3E-0001nR-Ek
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 07:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbWBXGCw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 01:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbWBXGCw
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 01:02:52 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:40067 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751846AbWBXGCv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 01:02:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060224060015.RHFH17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 24 Feb 2006 01:00:15 -0500
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87vev5r2m4.wl%cworth@cworth.org> (Carl Worth's message of "Thu,
	23 Feb 2006 17:01:55 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16684>

Carl Worth <cworth@cworth.org> writes:

>> I wonder if its a good idea to silently reset a branch named with a
>> short common word?
>
> It at least takes some care not to leave commits dangling when doing
> this, (the seek branch must at least be a subset of the current
> HEAD). I was pretty much following the lead of git-bisect here,
> (though "bisect" is definitely a touch longer and less common than
> "seek").

IIUC Cogito seems to use cg-seek-point or something long and
unusual like that...
