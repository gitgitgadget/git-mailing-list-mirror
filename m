From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (part #2)
Date: Thu, 01 Jun 2006 23:40:43 -0700
Message-ID: <7v3beodpqs.fsf@assigned-by-dhcp.cox.net>
References: <7v64jli66m.fsf@assigned-by-dhcp.cox.net>
	<20060602023545.GA5039@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 08:41:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fm3L3-0004UA-Fs
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 08:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWFBGkq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 02:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWFBGkq
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 02:40:46 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:12526 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751207AbWFBGkp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jun 2006 02:40:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060602064044.NMDA19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 2 Jun 2006 02:40:44 -0400
To: Shawn Pearce <spearce@spearce.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21150>

Shawn Pearce <spearce@spearce.org> writes:

> I find it useful to track what I've sent to you just in case I
> screw up some ref somewhere.  I like knowing that if I perform a
> bad update-ref call (which I'm prone to do sometimes) that I can
> recover quickly as the log exists.

I find it interesting to be able to say:

	$ git log next@{yesterday}..next

I often find myself getting curious to see:

	$ git reflog next
        Wed May 31 14:23:58 2006 -0700
                62b693a... Merge branch 'master' into next
        Wed May 31 14:26:39 2006 -0700
                422dfaf... Merge branch 'lt/tree-2' into next
        Wed May 31 15:14:58 2006 -0700
                100c25f... Merge branch 'ff/svnimport' into next
        Wed May 31 15:23:54 2006 -0700
                a25963b... Merge branch 'jc/fmt-patch' into next
        ...

The latter is probably not so useful in practice -- I suspect
that I would want to see such a list only while I am interested
in how well reflog works.
