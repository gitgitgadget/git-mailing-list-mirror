From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: [PATCH] Invoke git-repo-config directly.
Date: Thu, 16 Mar 2006 12:53:20 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrne1inu0.fr9.mdw@metalzone.distorted.org.uk>
References: <20060314211022.GA12498@localhost.localdomain> <Pine.LNX.4.64.0603141351470.3618@g5.osdl.org> <20060314224027.GB14733@localhost.localdomain> <Pine.LNX.4.64.0603141506130.3618@g5.osdl.org> <7vek13ieap.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0603151450070.3618@g5.osdl.org> <7vlkvbffhz.fsf@assigned-by-dhcp.cox.net> <20060316075324.GA19650@pfit.vm.bytemark.co.uk> <7v64mebxsu.fsf@assigned-by-dhcp.cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 16 13:54:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJrz4-0005Fb-9t
	for gcvg-git@gmane.org; Thu, 16 Mar 2006 13:53:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbWCPMxZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Mar 2006 07:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbWCPMxZ
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Mar 2006 07:53:25 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:56288 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1750858AbWCPMxY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Mar 2006 07:53:24 -0500
Received: (qmail 5180 invoked by uid 110); 16 Mar 2006 12:53:20 -0000
To: git@vger.kernel.org
Received: (qmail 5167 invoked by uid 9); 16 Mar 2006 12:53:20 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1142513600 5165 172.29.199.2 (16 Mar 2006 12:53:20 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Thu, 16 Mar 2006 12:53:20 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17633>

Junio C Hamano <junkio@cox.net> wrote:

> *1* BTW, I just noticed that git-sh-setup needs to be on user's
> PATH, so we probably have to inline and duplicate the git_exec()
> shell function definition at the beginning of each script after
> all, when we make the initial ". git-sh-setup" inclusion to
> honor GIT_EXEC_PATH without munging the user's PATH.

. ${GIT_EXEC_PATH-'@@@GIT_EXEC_PATH@@@'}/git-sh-setup

isn't too grim, and shows how the git_exec shell function can be made
somewhat terser.

By the way, am I the only person who /likes/ having all the git-*
programs on his path?  It makes shell completion work fairly well
without having to install strange completion scripts which get out of
date for one thing.

-- [mdw]
