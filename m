From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUCNE] GIT 1.1.0
Date: Mon, 09 Jan 2006 16:28:03 -0800
Message-ID: <7v7j99exkc.fsf@assigned-by-dhcp.cox.net>
References: <7v4q4eurgu.fsf@assigned-by-dhcp.cox.net>
	<43C2CAED.8030304@cc.jyu.fi> <7vwth9f1nk.fsf@assigned-by-dhcp.cox.net>
	<43C2F7E2.4090909@cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 01:28:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ew7Mx-0003y5-SD
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 01:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbWAJA2G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 19:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbWAJA2G
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 19:28:06 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:35288 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751795AbWAJA2F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2006 19:28:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060110002711.DMJP15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 9 Jan 2006 19:27:11 -0500
To: lamikr@cc.jyu.fi
In-Reply-To: <43C2F7E2.4090909@cc.jyu.fi> (lamikr@cc.jyu.fi's message of "Tue,
	10 Jan 2006 01:55:14 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14393>

lamikr <lamikr@cc.jyu.fi> writes:

> Did you mean that things should work after 1.1.1 is released?
> I tried to fresh build and install of 1.1.0 on top of the previous
> 1.1.0 build but "git --version" is still displaying me "git version 1.0.GIT"

You need to build from a git repository for these automated
version numbers to work, and this will *not* change post 1.1.1.

But with the patch I sent out earlier, you should be able to:

	$ VN=1.1.1 make

in a non-git repository (e.g. an untarred directory from a
tarball).  What the patch fixes is to fix it for RPM binary
packages.

I expect that people building from the source do so from a git
repository not from a tarball, except when bootstrapping, so
hopefully this should not be too much of a problem.
