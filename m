From: fork0@t-online.de (Alex Riesen)
Subject: Re: Cygwin install howto
Date: Thu, 7 Sep 2006 11:07:44 +0200
Message-ID: <20060907090744.GA7840@steel.home>
References: <46a038f90609062219g340a738fq3813f1c0e07916a0@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 07 11:08:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLFrZ-0007wt-7Z
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 11:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWIGJHx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 05:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWIGJHx
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 05:07:53 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:32652 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751294AbWIGJHw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 05:07:52 -0400
Received: from fwd34.aul.t-online.de 
	by mailout02.sul.t-online.com with smtp 
	id 1GLFrR-0005Zs-05; Thu, 07 Sep 2006 11:07:49 +0200
Received: from tigra.home (Z4HMg0Z1weWJdNDzGsZ9KpM70CTyKalA7kAA+JQJq3Oe2+-g1Bgr6V@[84.160.126.71]) by fwd34.sul.t-online.de
	with esmtp id 1GLFrO-0MeKlk0; Thu, 7 Sep 2006 11:07:46 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 8C291277AF;
	Thu,  7 Sep 2006 11:07:45 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1GLFrM-00043k-Vf; Thu, 07 Sep 2006 11:07:44 +0200
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90609062219g340a738fq3813f1c0e07916a0@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-ID: Z4HMg0Z1weWJdNDzGsZ9KpM70CTyKalA7kAA+JQJq3Oe2+-g1Bgr6V
X-TOI-MSGID: 98bf442c-dc28-4f09-9230-271d0439443e
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26623>

Martin Langhoff, Thu, Sep 07, 2006 07:19:26 +0200:
> - What cygwin packages are needed?

Perl, python, rcs (for merge), diff-utils, tcl/tk  for gitk (no, X
support is not needed. Tcl/Tk is not fully cygwin, if at all).

> - Makefile tweaks?

I disabled installation of repository templates. You can't use them in
Windows anyway (except under specific, rarely reached conditions).

> - How do I install for personal use?
> - How do I install in /usr/local?

Installation works as usual, just remember using cygwin path in
prefix. Cygpath (cygpath -w or cygpath -u) can be useful.

> - Anything else I should know?

Disable x-attribute in every repository. It never works.
Case insensitivity of all Windows filesystems breaks things often.
Restrict characters in filenames - no special symbols (like ?, : or *).
It is painfully slow on large repos (many files).
It is very slow on large files.
Try to avoid interrupting (Ctrl-C) - it breaks cygwin.
Ask me again if your friend has to use ActiveState Perl - it is a long
story to make perl scripts in git work with that piece of sh.t.

In general - use the OS very careful, it is not designed to be useful.
