From: Junio C Hamano <junkio@cox.net>
Subject: Re: 1dfcfbce2d643b7c7b56dc828f36ced9de2bf9f2
Date: Mon, 22 Aug 2005 00:44:40 -0700
Message-ID: <7vpss6bel3.fsf@assigned-by-dhcp.cox.net>
References: <7vy86vf7lg.fsf@assigned-by-dhcp.cox.net>
	<43096B50.60605@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 00:37:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7KsX-0002Hi-Eq
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 00:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbVHVWdT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Aug 2005 18:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbVHVWdS
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Aug 2005 18:33:18 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:31370 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751384AbVHVWdR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Aug 2005 18:33:17 -0400
Received: from fed1rmmtao12.cox.net (fed1rmmtao12.cox.net [68.230.241.27])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7M7mWaw013930
	for <git@vger.kernel.org>; Mon, 22 Aug 2005 00:48:34 -0700
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050822074441.MEGZ550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 22 Aug 2005 03:44:41 -0400
To: Dirk Behme <dirk.behme@de.bosch.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on zeus1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dirk Behme <dirk.behme@de.bosch.com> writes:

> Seems to me that this breaks http update
>
> cg-update http://www.kernel.org/pub/scm/git/git.git
>
> error: Tried 
> http://www.kernel.org/pub/scm/git/git.git/objects/6f/f87c4664981e4397625791c8ea3bbb5f2279a3
> Cannot obtain needed blob 6ff87c4664981e4397625791c8ea3bbb5f2279a3
> while processing commit 1dfcfbce2d643b7c7b56dc828f36ced9de2bf9f2.
> cg-pull: objects pull failed

I suspect that your copy of Cogito/git is old and incapable of
fetching from a packed repository.  Did your Cogito come with
its own copy of git (specifically, git-http-pull)?  Modern
Cogito "cg-pull" uses git-http-pull from core GIT as its
underlying pull driver for http transport, which should not have
the problem anymore.
