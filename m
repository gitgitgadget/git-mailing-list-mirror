From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 2/3] Make tutorial-script work with current cogito
Date: Sun, 19 Mar 2006 23:37:03 +0100
Message-ID: <20060319223703.GI18185@pasky.or.cz>
References: <20060303011154.14619.71590.stgit@dv.roinet.com> <20060303011157.14619.99070.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 19 23:36:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FL6W4-00026U-T4
	for gcvg-git@gmane.org; Sun, 19 Mar 2006 23:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWCSWgu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Mar 2006 17:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWCSWgu
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Mar 2006 17:36:50 -0500
Received: from w241.dkm.cz ([62.24.88.241]:8677 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751146AbWCSWgu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Mar 2006 17:36:50 -0500
Received: (qmail 31227 invoked by uid 2001); 19 Mar 2006 23:37:03 +0100
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <20060303011157.14619.99070.stgit@dv.roinet.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17733>

Dear diary, on Fri, Mar 03, 2006 at 02:11:57AM CET, I got a letter
where Pavel Roskin <proski@gnu.org> said that...
> Labels on merge conflict lines have changed.  There is no "git rename",
> use cg-mv instead.  In one case stack.h is not created, so copy
> stack.h~master to stack.h before fixing it.
> 
> Also fix comments in script.sh to use the new labels.
> 
> Signed-off-by: Pavel Roskin <proski@gnu.org>

Whoops, overlooked this and already fixed it on my own. Thanks anyway.

> @@ -308,6 +308,7 @@ echo "Merge with 0.4" | cg-merge && shou
>  # Mishandled stack.h
>  ed Makefile < $TOP/0021-bob-alice-fixup1.ed
>  ed rpn.c    < $TOP/0022-bob-alice-fixup2.ed
> +cp stack.h~master stack.h
>  ed stack.h  < $TOP/0023-bob-alice-fixup3.ed
>  cg-add stack.h

Isn't it enough to just kill ~master and move ~origin there, though?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
