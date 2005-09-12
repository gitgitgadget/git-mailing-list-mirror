From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 4/4] cg-{diff,mkpatch}: rename/copy optional detection
Date: Mon, 12 Sep 2005 02:45:02 +0200
Message-ID: <20050912004502.GH15630@pasky.or.cz>
References: <20050902103125.24918.905.stgit@zion.home.lan> <20050902103135.24918.7990.stgit@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 02:46:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEcRd-0006Lv-8u
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 02:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbVILApG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 20:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbVILApG
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 20:45:06 -0400
Received: from w241.dkm.cz ([62.24.88.241]:7823 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751109AbVILApF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 20:45:05 -0400
Received: (qmail 28908 invoked by uid 2001); 12 Sep 2005 02:45:02 +0200
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Content-Disposition: inline
In-Reply-To: <20050902103135.24918.7990.stgit@zion.home.lan>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8352>

Dear diary, on Fri, Sep 02, 2005 at 12:31:38PM CEST, I got a letter
where Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it> told me that...
> Add -B, -M and -C options to detect content rewrites, renames and changes
> to cg-diff and cg-mkpatch, to be passed right down to git-diff-*.
> I've not added a way to pass down any option, since not everything may make
> sense, and a shell script colorizing --name-only-z output would not play so
> nice (and I mean "unreliable behaviour" - not tested obviously).

What about just by default doing full-blown detection, with an optional
flag to do no detection (to produce patch-compatible diffs)? I don't
think Cogito users usually need a more fine-tuned settings.

Obviously in that case we also have to fix cg-patch to process renames
and stuff - but we should do that anyway. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
