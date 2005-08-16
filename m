From: Kalle Valo <Kalle.Valo@iki.fi>
Subject: Re: [PATCH] Add git-branches-script
Date: Tue, 16 Aug 2005 20:53:49 +0300
Message-ID: <87hddplqdu.fsf@litku.valo.iki.fi>
References: <20050815204430.GA77829@rossby.metr.ou.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 19:51:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E55ZV-0006V5-Fb
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 19:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbVHPRty (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 13:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbVHPRty
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 13:49:54 -0400
Received: from fep31-0.kolumbus.fi ([193.229.0.35]:9888 "EHLO
	fep31-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1030261AbVHPRty (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 13:49:54 -0400
Received: from litku.valo.iki.fi ([81.197.35.21]) by fep31-app.kolumbus.fi
          with ESMTP
          id <20050816174944.DUSP4404.fep31-app.kolumbus.fi@litku.valo.iki.fi>;
          Tue, 16 Aug 2005 20:49:44 +0300
To: Amos Waterland <apw@rossby.metr.ou.edu>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Amos Waterland <apw@rossby.metr.ou.edu> writes:

> For people whose workflow involves switching back and forth between a
> lot of branches, it can be really helpful to be able to quickly tell
> which branch you are on and which ones are available.  This patch
> introduces a small script that when invoked as `git branches' prints a
> list of available branches with a star in front of the one you are on:
>
>  $ cd linux-2.6/
>  $ git checkout -b ppc64-cleanups
>  $ git checkout -b ppc64-new-devel
>  $ git checkout -b ppc64-all-merge
>  $ git branches
>    master
>  * ppc64-all-merge
>    ppc64-cleanups
>    ppc64-new-devel

I would prefer to using some git command compared to 'ls -l
.git/refs/heads/'. In my opinion there is a need for this command and
it should be included.

But my immediate concern was that there is already 'git branch'
command and 'git branches' is too similar. I think they should be
merged. I have a patch coming up.

-- 
Kalle Valo
