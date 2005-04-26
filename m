From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Add archive-tree, a cpio archive creator
Date: Tue, 26 Apr 2005 16:42:04 +0200
Message-ID: <426E533C.70502@lsrfire.ath.cx>
References: <20050424014346.GA23083@lsrfire.ath.cx> <20050425153011.34c93b38.paul@permanentmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: pasky@ucw.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 16:38:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQRC0-0007Et-72
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 16:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVDZOmc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 10:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVDZOmb
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 10:42:31 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:10382 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261566AbVDZOmO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 10:42:14 -0400
Received: from [10.0.1.3] (p508E5FF1.dip.t-dialin.net [80.142.95.241])
	by neapel230.server4you.de (Postfix) with ESMTP id 845A615B;
	Tue, 26 Apr 2005 16:42:08 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: de-DE, de, en-us, en
To: Paul Dickson <paul@permanentmail.com>
In-Reply-To: <20050425153011.34c93b38.paul@permanentmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Paul Dickson schrieb:
> Use the "newc" format.  The "odc" will generate a lot of errors on a
>  large filesystem (which I discovered this past weekend).

How is that?  I can only imagine problems with the size of individual
files inside an archive because the size field in the header is limited
to 33 bits.

In any case, I switched to the tar format.  It's more complicated but it
turned out that creating these things is still easy.  Parsing them might
be more of a challenge, but we already have tar for that. :-)

See my other mail for more on the tar creator.  I also rebased it to
core GIT because it's no helper script.

Rene
