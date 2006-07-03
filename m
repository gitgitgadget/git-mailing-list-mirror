From: Junio C Hamano <junkio@cox.net>
Subject: Re: Making perl scripts include the correct Git.pm
Date: Sun, 02 Jul 2006 18:38:35 -0700
Message-ID: <7vwtavxyas.fsf@assigned-by-dhcp.cox.net>
References: <20060702214012.GI29115@pasky.or.cz>
	<7v64if1rop.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 03:38:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxDOZ-00018Y-Fh
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 03:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWGCBih (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 21:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWGCBih
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 21:38:37 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:9198 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750812AbWGCBig (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 21:38:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060703013835.QVSF554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 2 Jul 2006 21:38:35 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <7v64if1rop.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 02 Jul 2006 17:02:30 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23148>

Junio C Hamano <junkio@cox.net> writes:

> Petr Baudis <pasky@suse.cz> writes:
>
>> so this is my attempt to summarize it:
>
> Ah, our message crossed -- thanks for summarizing it.  I do not
> particularly like any of the solution so far, but maybe the
> patch I just sent out to "do the normal thing unless we are
> running tests" might be the right thing to do.

I see you caught Merlyn so I decided the patch I sent earlier as
a tentative fix and merged the series in "next".  We should be
able to fix Perly problems in-tree while we have his attention
;-).

Rene's merge-bases fix is also in "next".  Hopefully this would
make merge-recursive work by Alex and Johannes go smoother?

On the other front, I applied the --remove-empty --parents fix
by Linus to "master".  Since this broke gitk and qgit it might
warrant a 1.4.1.1 hotfix.
