From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git and cogito uses different exclude files
Date: Fri, 16 Sep 2005 09:43:27 -0700
Message-ID: <7vfys5ote8.fsf@assigned-by-dhcp.cox.net>
References: <432A7902.20603@drzeus.cx> <tnxbr2t9zsk.fsf@arm.com>
	<20050916104430.GA25169@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 18:46:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGJK0-0008ON-Bx
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 18:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161189AbVIPQni (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 12:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161187AbVIPQnh
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 12:43:37 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:17121 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1161189AbVIPQnh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 12:43:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050916164329.NJMF3414.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Sep 2005 12:43:29 -0400
To: Petr Baudis <pasky@suse.cz>,
	Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20050916104430.GA25169@pasky.or.cz> (Petr Baudis's message of
	"Fri, 16 Sep 2005 12:44:30 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8692>

Petr Baudis <pasky@suse.cz> writes:

>> The latest StGIT snapshot uses .git/info/exclude. Probably next week I
>> will make a new StGIT release.
>
> So does Cogito now. ;-) It still looks at .git/exclude as well and gives
> warning if it exists.

Late last night I could not find in the list archive the "list
consensus" I used to justify what 'git-status' does in this log
message:

    Message-ID: <7vfysw89do.fsf@assigned-by-dhcp.cox.net>
    From: Junio C Hamano <junkio@cox.net>
    Subject: [PATCH] Teach git-status-script about git-ls-files --others
    Date: Fri, 26 Aug 2005 18:18:59 -0700

    When there is non-empty $GIT_DIR/info/exclude file, use it along
    with .gitignore per-directory exclude pattern files (which was
    a convention agreed on the list while ago and is compatible with
    Cogito) to generate a list of ignored files as well.

    Signed-off-by: Junio C Hamano <junkio@cox.net>

I do remember checking Cogito and StGIT and making sure the use
of .gitignore is consistent with you two, but I do not remember
if we had consensus on info/exclude now.  It could be that I was
just hallucinating back then and ended up forcing this change
onto you and your users by mistake in this round.

Anyway, thanks both.
