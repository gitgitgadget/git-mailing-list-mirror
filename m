From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH 0/2] Introduce ~/.gitconfig
Date: Thu, 08 Jun 2006 09:02:29 -0500
Message-ID: <1149775348.23938.236.camel@cashmere.sps.mot.com>
References: <Pine.LNX.4.63.0606081329200.11910@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jun 08 16:07:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoL9h-0004kq-5y
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 16:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbWFHOGe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 10:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWFHOGe
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 10:06:34 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:55291 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S964846AbWFHOGd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 10:06:33 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id k58ERDKc024083;
	Thu, 8 Jun 2006 07:27:13 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k58E6R1e021315;
	Thu, 8 Jun 2006 09:06:28 -0500 (CDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606081329200.11910@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21491>

On Thu, 2006-06-08 at 06:30, Johannes Schindelin wrote:

> 
> - The name. I personally prefer .gitconfig, since we talk about the repo
>   config all the time. But I have no strong feelings there.

I like .gitconfig over .gitrc.

> - The --no-local flag could be implemented more cleanly, but also less

Could we have multiple levels, and have names that call out
where it applies?  Perhaps something like:

--repo   into $GIT_DIR/.gitconfig  <- current default, right?
--home   into ~/.gitconfig
--site   into /etc/gitconfig
--share  into /usr/share/git/config

My issue is that --no-local is vague and doesn't call out
where it actually does go.  There could be more than one
different non-local place.


> - With this, repo-config does no longer merit its name. What do people think
>   about making it a builtin named "git config"? (Of course, nothing hinders
>   us to keep the synonymous "repo-config" indefinitely...)

I have often forgotten the "repo-" part, and go looking
for the "git config ..." man page and command.  I think
it should be "git config".

Perhaps, "git repo-config"  would be "git config --repo ...."
And "git config ..." would need an explict --home, --repo,
--site type location flag from above?


But, hey, that's all pre-coffee.

jdl
