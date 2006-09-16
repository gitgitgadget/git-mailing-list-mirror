From: Junio C Hamano <junkio@cox.net>
Subject: Re: nightly tarballs of git
Date: Sat, 16 Sep 2006 11:09:24 -0700
Message-ID: <7v3baradkb.fsf@assigned-by-dhcp.cox.net>
References: <20060914172754.GF8013@us.ibm.com>
	<20060914175116.GB22279@redhat.com>
	<7v1wqe45vs.fsf@assigned-by-dhcp.cox.net>
	<20060914193616.GA32735@redhat.com>
	<7virjq2oyc.fsf@assigned-by-dhcp.cox.net>
	<20060916175853.GA24124@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 16 20:09:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOebk-0002kF-U4
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 20:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWIPSJ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 14:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWIPSJ0
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 14:09:26 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:57521 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750875AbWIPSJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Sep 2006 14:09:25 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060916180925.ZIWZ2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Sat, 16 Sep 2006 14:09:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id P69S1V00R1kojtg0000000
	Sat, 16 Sep 2006 14:09:26 -0400
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20060916175853.GA24124@redhat.com> (Dave Jones's message of
	"Sat, 16 Sep 2006 13:58:53 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27125>

Dave Jones <davej@redhat.com> writes:

> This went well, right up until you checked something in :-)
>
> Generating pack...
> Done counting 155 objects.
> Result has 126 objects.
> Deltifying 126 objects.
>    0% (1/126) done
> ...
> Unpacking 126 objects
> Total 126, written 126 (delta 93), reused 0 (delta 0)
> * refs/heads/origin: fast forward to branch 'master' of git://git.kernel.org/pub/scm/git/git
>   from 38529e28a4f465ad5d5f2fa249ca17da680bac5f to fc2b2be031f44aef0106cf7f872b750cd90b2253
> * refs/heads/pu: does not fast forward to branch 'pu' of git://git.kernel.org/pub/scm/git/git;
>   not updating.
> Something wicked happend.

You care only about 'master' in that repository anyway, so I
would suggest removing other lines from remotes/origin and have
only these two lines:

	URL:  git://git.kernel.org/pub/scm/git/git
        Pull: refs/heads/master:refs/heads/origin
