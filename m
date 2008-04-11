From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] When a remote is added but not fetched, tell the user.
Date: Fri, 11 Apr 2008 22:08:16 +0300
Message-ID: <20080411190816.GA17277@mithlond>
References: <20080409101428.GA2637@elte.hu> <1207869946-17013-1-git-send-email-g2p.code@gmail.com> <alpine.DEB.1.00.0804111621080.31025@eeepc-johanness> <20080411203501.7095b866@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Gabriel <g2p.code@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 21:09:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkOcS-0004Hl-Lv
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 21:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760636AbYDKTIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 15:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760603AbYDKTIU
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 15:08:20 -0400
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:37289 "EHLO
	pne-smtpout4-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760235AbYDKTIT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Apr 2008 15:08:19 -0400
Received: from mithlond (80.220.180.181) by pne-smtpout4-sn1.fre.skanova.net (7.3.129)
        id 47A7970A003D1826; Fri, 11 Apr 2008 21:08:16 +0200
Received: from dtw by mithlond with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JkObg-0005Mo-5t; Fri, 11 Apr 2008 22:08:16 +0300
Content-Disposition: inline
In-Reply-To: <20080411203501.7095b866@localhost>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79287>

Gabriel wrote (2008-04-11 20:35 +0200):

> I think the transcript that started the thread makes it clear that
> having "git remote add" not fetching is not the right default. The
> user wants to use a remote repository, and has learned these are
> called "remotes". So he does not have too much trouble
> finding/remembering the command "git remote add <name> <url>". Now
> with the user's goal in mind, it makes no sense to add a remote and
> then not fetch it, because the user definitely wants to do something
> with the remote. By not fetching it, we are surprising the user 

Hmm, I'm quite newbie but I have never expected "git remote add" to
fetch anything. I wouldn't want it to do it automatically. From the
beginning I saw "git remote" as a _configuration_ tool. No doubt it's
common to fetch after configuring a remote but in my mind they are two
logically different steps (configure, fetch/pull) which I think should
be kept separate. Once I have configured something I may want to check
that I did the right thing, then configure some more remotes and maybe
fetch tomorrow. Maybe I don't want to fetch at all but only pull from
that remote. So let's not build ready workflows for users, only
convenient, logical tools.

That said, I don't mind short messages like "use 'git fetch' to obtain
branches" but I don't think that is necessary.
