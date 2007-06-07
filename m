From: Keith Duthie <keith@no.net.nz>
Subject: Re: pull/merge --no-commit
Date: Fri, 8 Jun 2007 08:51:17 +1200 (NZST)
Message-ID: <alpine.DEB.0.99.0706080841030.6319@sleipnir.no.net.nz>
References: <46678909.10608@alcatel-lucent.com> <7vfy54qqu8.fsf@assigned-by-dhcp.cox.net>
 <46684EFD.1080804@alcatel-lucent.com> <alpine.DEB.0.99.0706080658070.6319@sleipnir.no.net.nz>
 <46686B63.6080808@alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kevin Green <Kevin.T.Green@morganstanley.com>
To: kurt_p_lloyd <kplloyd@alcatel-lucent.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 22:52:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwOxe-0001EH-6C
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 22:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760779AbXFGUvj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 16:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762114AbXFGUvj
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 16:51:39 -0400
Received: from webmail.woosh.co.nz ([202.74.207.2]:3030 "EHLO
	mail2.woosh.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760779AbXFGUvi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 16:51:38 -0400
Received: from sleipnir.no.net.nz (203-211-120-198.ue.woosh.co.nz [203.211.120.198]) by woosh.co.nz
 (Rockliffe SMTPRA 6.1.22) with ESMTP id <B0080290496@mail2.woosh.co.nz>;
 Fri, 8 Jun 2007 08:51:36 +1200
In-Reply-To: <46686B63.6080808@alcatel-lucent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49388>

On Thu, 7 Jun 2007, kurt_p_lloyd wrote:

> Just an idea.  Of course, if something like this already exists ....
> (I'd rather not shut down sshd, nor have to create a separate "public"
>  repository (for certain types of "projects" anyway).)

Actually, a separate public repository is probably exactly what you want
here. If you clone the repository with the local and shared flags you'll
only need to have one copy of the objects on disk (if I understand things
correctly), and you can just push your development branch to the public
repository whenever you're happy with the state of your code.

And if you're going to give other people access to your development
repository then you're probably best off having a branch (or branches)
that are there specifically for other people to pull from, and make sure
you don't merge anything into those branches without it being ready for
release. And then tell people it's their own fault if they grab one of
your work-in-progress branches instead ;-)

-- 
The universe hates you, but don't worry - it's nothing personal.
