From: fork0@t-online.de (Alex Riesen)
Subject: Re: [PATCH] Git.pm: Kill Git.xs for now
Date: Sun, 24 Sep 2006 13:48:34 +0200
Message-ID: <20060924114834.GA5800@steel.home>
References: <20060923181849.28753.56984.stgit@machine.or.cz> <7vwt7ta6sh.fsf@assigned-by-dhcp.cox.net> <20060924105016.GA5732@steel.home> <20060924110816.GK20017@pasky.or.cz>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 13:49:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRSUK-0000x6-RN
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 13:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbWIXLtA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 07:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWIXLtA
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 07:49:00 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:10451 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1750979AbWIXLs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Sep 2006 07:48:58 -0400
Received: from fwd33.aul.t-online.de 
	by mailout08.sul.t-online.com with smtp 
	id 1GRSTX-0004fx-00; Sun, 24 Sep 2006 13:48:47 +0200
Received: from tigra.home (Tb4190ZYYe6t5+t-9Mzbh7icsexUeoCgEB6hzDrpLvKeSF6uODmFk4@[84.160.110.72]) by fwd33.sul.t-online.de
	with esmtp id 1GRSTV-0Zt9l20; Sun, 24 Sep 2006 13:48:45 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 3DA52277AF;
	Sun, 24 Sep 2006 13:48:35 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1GRSTK-0001Vp-Ts; Sun, 24 Sep 2006 13:48:34 +0200
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20060924110816.GK20017@pasky.or.cz>
User-Agent: Mutt/1.5.11
X-ID: Tb4190ZYYe6t5+t-9Mzbh7icsexUeoCgEB6hzDrpLvKeSF6uODmFk4
X-TOI-MSGID: f386ac28-cde9-4c8a-8fb0-6c70c2cdc1fa
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27661>

Petr Baudis, Sun, Sep 24, 2006 13:08:16 +0200:
> > > > This patch removes Git.xs from the repository for the time being. This
> > > > should hopefully enable Git.pm to finally make its way to master.
> > > 
> > > It's a bit sad, but I think this is a sane thing to do.
> > > 
> > > I suspect Alex still has problem with Makefile.PL due to issues
> > > around ActiveState (slash vs bs and CRLF line ending if I recall
> > > correctly)?
> > 
> > Absolutely.
> 
> I'm sorry but I don't even have a Windows installation on my machine and
> I don't intend to personally work on Windows support. If you need to
> keep ActiveState working seamlessly, please post patches. I hate to say
> it, but that's just how it should work - if someone cares about Git
> working on a non-mainstream (for Git audience) platform, he needs to
> maintain it, not ask the "core" developers do it. ...

Ain't asking you nor anyone. Ain't actually care, activetstate's perl
being just another stupid windows program done badly. Can't promise,
but will try to post my workarounds to that particular combination
on list (never demanded to include them).
The original mail was more of a word of warning for anyone unhappy to
work with the sh%t.

Aside from that, any chance of making Git.xs optional (enabled by
default, but disableable)? Disabling Git.xs will disable related
scripts, sure, but also gives you an installation with one external
(libperl) dependency less (probably with ability to install git and
Git.xs separately).
