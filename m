From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: git status and empty directories
Date: Thu, 18 May 2006 20:29:25 +0200
Message-ID: <E1FgnFV-0002FV-39@moooo.ath.cx>
References: <E1Fgmkh-0000ur-Hn@moooo.ath.cx> <Pine.LNX.4.64.0605181112040.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu May 18 20:30:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgnFd-0000i7-Kh
	for gcvg-git@gmane.org; Thu, 18 May 2006 20:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWERS32 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 14:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWERS32
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 14:29:28 -0400
Received: from moooo.ath.cx ([85.116.203.178]:6892 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751021AbWERS32 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 May 2006 14:29:28 -0400
To: Git Mailing List <git@vger.kernel.org>
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605181112040.10823@g5.osdl.org>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20296>

> Like this?
This is exactly the patch I'm using at the moment and I don't really
need an option to unhide empty directories. Maybe someone else
complains for some reason but git clean -d -n shows empty directories
too.

An option to show untracked files instead of untracked directories
like
> git-ls-files -z --others --exclude-per-directory=.gitignore
would be interesting to see what would be added instead of doing ls
manually.
