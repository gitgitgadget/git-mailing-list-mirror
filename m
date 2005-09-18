From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fix archive-destroying "git repack -a -d" bug
Date: Sun, 18 Sep 2005 10:26:30 -0700
Message-ID: <7v4q8i5ltl.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0509171839590.26803@g5.osdl.org>
	<20050918031837.GB23405@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sun Sep 18 19:27:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH2vz-0002hG-AB
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 19:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbVIRR0d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 13:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbVIRR0d
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 13:26:33 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:6306 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932129AbVIRR0c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2005 13:26:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050918172632.GGND29184.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 18 Sep 2005 13:26:32 -0400
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20050918031837.GB23405@redhat.com> (Dave Jones's message of
	"Sat, 17 Sep 2005 23:18:37 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8791>

Dave Jones <davej@redhat.com> writes:

> Hmm, I'm sure I've done this several times in my x86info git repo
> (http://www.codemonkey.org.uk/projects/x86info/x86info.git)
>
> It seems to look ok to git-fsck-cache though. Would that pick up
> any breakage if present ?

Yes.  This is a real bug and I owe Linus big for spotting it
before 0.99.7.
