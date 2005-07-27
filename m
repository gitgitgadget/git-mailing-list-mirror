From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git 1.0 Synopis (Draft v2)
Date: Wed, 27 Jul 2005 15:13:18 -0700
Message-ID: <7vek9jq4n5.fsf@assigned-by-dhcp.cox.net>
References: <20050727100123.GH19290@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 00:18:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxuE3-00040y-Pb
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 00:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVG0WR1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jul 2005 18:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVG0WOz
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jul 2005 18:14:55 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:46543 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261191AbVG0WNt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2005 18:13:49 -0400
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j6RMDm3f009246
	for <git@vger.kernel.org>; Wed, 27 Jul 2005 15:13:48 -0700
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050727221311.UEC8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 27 Jul 2005 18:13:11 -0400
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20050727100123.GH19290@mythryan2.michonline.com> (Ryan Anderson's message of "Wed, 27 Jul 2005 06:01:23 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on zeus1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ryan Anderson <ryan@michonline.com> writes:

> Source Code Management with Git

Thanks for doing this.  Generally looks excellent.

>   o Two, interchangeable, on-disk formats are used:
>     o An efficient, packed format that saves spaced and network
>       bandwidth.

??? "spaced" ???

> 	Or via Git itself:
> 	git clone http://www.kernel.org/pub/scm/git/git.git/
> 	git clone rsync://rsync.kernel.org/pub/scm/git/git.git/
> 	(rsync is generally faster for an initial pull)

These need a target directory name to create, like this:

    git clone rsync://rsync.kernel.org/pub/scm/git/git.git/ $new_dir
    git clone http://www.kernel.org/pub/scm/git/git.git/ $new_dir

> Git results from the inspiration and frustration of Linus Torvalds, and
> the enthusiastic help of over 300 participants on the development
> mailing list.[1]  It is maintained by Junio C Hamano <junkio@cox.net>.

Please drop the e-mail address here; you mention nobody else's.

Well, dropping "the current maintainer" information altogether
might be even better; the above to a casual reader sounds like
Linus was frustrated and I wrote it for him, which is definitely
not what we would like to say.  I suspect it still has more code
by Linus than anybody else (I stopped counting some time ago).
