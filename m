From: Matt Porter <mporter@kernel.crashing.org>
Subject: Re: [PATCH] Add exclude file support to cg-status
Date: Mon, 2 May 2005 21:21:07 -0700
Message-ID: <20050502212107.A26102@cox.net>
References: <20050502171042.A24299@cox.net> <7vd5s9nmio.fsf@assigned-by-dhcp.cox.net> <20050502193343.A25462@cox.net> <7v4qdlndw0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 06:17:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSoq9-0004mG-76
	for gcvg-git@gmane.org; Tue, 03 May 2005 06:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVECEXD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 00:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVECEXC
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 00:23:02 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:17337 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261375AbVECEW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 00:22:59 -0400
Received: from liberty.homelinux.org ([68.2.41.86]) by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050503042258.NSBJ7275.fed1rmmtao09.cox.net@liberty.homelinux.org>;
          Tue, 3 May 2005 00:22:58 -0400
Received: (from mmporter@localhost)
	by liberty.homelinux.org (8.9.3/8.9.3/Debian 8.9.3-21) id VAA26194;
	Mon, 2 May 2005 21:21:07 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <7v4qdlndw0.fsf@assigned-by-dhcp.cox.net>; from junkio@cox.net on Mon, May 02, 2005 at 09:15:43PM -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 02, 2005 at 09:15:43PM -0700, Junio C Hamano wrote:
> You may want to check the past thread, like this one:

<snip>

>     .git/
>       objects/    (traditional)
>       refs/       Directories of hex SHA1 + newline files
>         heads/    Commits which are heads of various sorts
>         tags/     Tags, by the tag name (or some local renaming of it)
>       info/       Other shared information
>         remotes
>       ...         Everything else isn't shared
>       HEAD        Symlink to refs/heads/<something>

Ok, I see I skimmed the archives way too fast after vacation. :)

I'll update the patch to match.

Thanks,
Matt
