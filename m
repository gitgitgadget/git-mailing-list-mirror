From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] git-grep --relative: show pathnames relative to the current directory
Date: Fri, 11 Aug 2006 17:23:05 +0200
Message-ID: <20060811152305.GB9211@mars.ravnborg.org>
References: <7vpsf7u2x7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 11 17:23:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBYrI-0003kk-Ho
	for gcvg-git@gmane.org; Fri, 11 Aug 2006 17:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWHKPX3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Aug 2006 11:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWHKPX2
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Aug 2006 11:23:28 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:32925 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751186AbWHKPX2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Aug 2006 11:23:28 -0400
Received: from mars.ravnborg.org (0x535d98d8.hrnxx9.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtp.tele.dk (Postfix) with ESMTP id 4F6B218294;
	Fri, 11 Aug 2006 17:23:27 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 3564143C01F; Fri, 11 Aug 2006 17:23:05 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsf7u2x7.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25229>

On Fri, Aug 11, 2006 at 12:50:12AM -0700, Junio C Hamano wrote:
> By default, the command shows pathnames relative to the project
> root, even when run from a subdirectory.  With --relative flag,
> however, the command outputs pathnames relative to the current
> directory.
> 
> This makes it very pleasant to run in Emacs compilation (or
> "grep-find") buffer.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
> 
>  * Now the question is, shouldn't this be the default, with
>    the current output available as an option --full-name, just
>    like ls-files?
> 
>    Changing the default always risks breaking people's habit and
>    scripts, but I tend to think the current output is a
>    misfeature which we'd better fix sooner rather than later.
> 
>    Opinions? 

I always felt confused when path was relative to root of .git directory
and not relative to current directory.
But I never looked into changing this or reporting it - so it has not
been a big issue.

	Sam
