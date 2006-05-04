From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: git-unpack-objects
Date: Thu, 4 May 2006 12:02:37 +0200
Message-ID: <20060504100237.GA10548@fiberbit.xs4all.nl>
References: <625fc13d0605011552j4189338bx14083657acffc18e@mail.gmail.com> <7vu089qr4t.fsf@assigned-by-dhcp.cox.net> <625fc13d0605031035l721ab08dmee6f870abb49f4e4@mail.gmail.com> <Pine.LNX.4.64.0605031041150.4086@g5.osdl.org> <625fc13d0605031044y2ff03ed2h261db5455b234254@mail.gmail.com> <Pine.LNX.4.64.0605031054300.4086@g5.osdl.org> <625fc13d0605031731v7b65a738r6fc0169958235928@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 04 12:02:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbafW-0000jy-Je
	for gcvg-git@gmane.org; Thu, 04 May 2006 12:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbWEDKCo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 06:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWEDKCo
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 06:02:44 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:28901 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S1751477AbWEDKCn
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 4 May 2006 06:02:43 -0400
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.62)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1FbafN-0002ko-Sk; Thu, 04 May 2006 12:02:37 +0200
To: Josh Boyer <jwboyer@gmail.com>
Content-Disposition: inline
In-Reply-To: <625fc13d0605031731v7b65a738r6fc0169958235928@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19563>

On Wednesday May 3rd 2006 Josh Boyer wrote:

> >It does. That's what the "-a" (for "all") does.
> 
> Odd.  On one of my repos, I was seeing the correct behavior.  On
> another, there were multiple packs left after doing the 'git repack -a
> -d'.  Were there ever some packing bugs in older versions of git that
> would have maybe produced some packs that wouldn't get deleted or
> something?

Have you checked with "git fsck-objects" that maybe the "remaining"
packs contained non-reachable objects like dangling commits from resets
or from following volatile branches like +pu?
-- 
Marco Roeland
