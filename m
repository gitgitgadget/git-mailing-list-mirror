From: fork0@t-online.de (Alex Riesen)
Subject: Re: Git-daemon messing up permissions for gitweb
Date: Sun, 11 Jun 2006 00:30:53 +0200
Message-ID: <20060610223053.GC5825@steel.home>
References: <5A14AF34CFF8AD44A44891F7C9FF410507957896@usahm236.amer.corp.eds.com> <20060610213051.GB5825@steel.home> <Pine.LNX.4.64.0606101439530.5498@g5.osdl.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Post, Mark K" <mark.post@eds.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 11 00:31:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpBz5-00026c-Ce
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 00:31:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161042AbWFJWbI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 18:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161043AbWFJWbI
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 18:31:08 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:58278 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1161042AbWFJWbG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jun 2006 18:31:06 -0400
Received: from fwd31.aul.t-online.de 
	by mailout01.sul.t-online.com with smtp 
	id 1FpByt-0000FN-00; Sun, 11 Jun 2006 00:30:59 +0200
Received: from tigra.home (Zqcc0ZZO8elCTKdabA6Z-Q6oiCKpE7wAW86JSIJlmnILQs0ZYsOaop@[84.160.94.32]) by fwd31.sul.t-online.de
	with esmtp id 1FpByo-1RGqPI0; Sun, 11 Jun 2006 00:30:54 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C9939277B5;
	Sun, 11 Jun 2006 00:30:53 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FpByn-0003kp-8g; Sun, 11 Jun 2006 00:30:53 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606101439530.5498@g5.osdl.org>
User-Agent: Mutt/1.5.6i
X-ID: Zqcc0ZZO8elCTKdabA6Z-Q6oiCKpE7wAW86JSIJlmnILQs0ZYsOaop
X-TOI-MSGID: 98dd553d-2675-4d89-942a-f5eea03693f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21624>

Linus Torvalds, Sat, Jun 10, 2006 23:41:52 +0200:
> >
> >      ~/.ssh/rc
> > 
> > AFAIK, it was always there.
> 
> Note that since umask is a per-process flag, and only inherited from 
> parents to children, not the other way around, if the rc file is run as a 
> separate shell script (and I assume it is) instead of "sourced" from the 
> the shell that actually executes the programs you run, then this won't 
> help at all.

Right, it doesn't. I should have tried ~/.ssh/rc with umask, really.
Because of this it can't be used for environment too (that's why they
have ~/.ssh/environment).
