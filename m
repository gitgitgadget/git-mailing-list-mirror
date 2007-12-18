From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-stash: RFC: Adopt the default behavior to other commands
Date: Tue, 18 Dec 2007 15:15:37 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712181513060.23902@racer.site>
References: <20071217110322.GH14889@albany.tokkee.org>
 <506C6191-655D-46AE-A5C2-1335A9044F44@lrde.epita.fr>
 <7vk5nd53lp.fsf@gitster.siamese.dyndns.org> <57F403E7-AF5B-40F1-AE9D-8EA036675A67@lrde.epita.fr>
 <7vfxy04ze7.fsf@gitster.siamese.dyndns.org> <20071218105941.GA17251@albany.tokkee.org>
 <Pine.LNX.4.64.0712181231420.23902@racer.site> <4767D7A2.30703@op5.se>
 <Pine.LNX.4.64.0712181445420.23902@racer.site> <4767E07A.2020100@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sebastian Harl <sh@tokkee.org>, Junio C Hamano <gitster@pobox.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Dec 18 16:16:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4eBN-0005kV-Iy
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 16:16:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753862AbXLRPPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 10:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756559AbXLRPPy
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 10:15:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:39976 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753667AbXLRPPx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 10:15:53 -0500
Received: (qmail invoked by alias); 18 Dec 2007 15:15:51 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp044) with SMTP; 18 Dec 2007 16:15:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Qmq0+chsQVnb+WzXG0lNseHHpuaLEhkDRtG+9nh
	wAZxNCnWyUAG8p
X-X-Sender: gene099@racer.site
In-Reply-To: <4767E07A.2020100@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68760>

Hi,

On Tue, 18 Dec 2007, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
>
> > In the alternative, you could just scrap all those default actions, 
> > showing synopses instead.  For all commands, including "git commit", 
> > "git log", "git fetch", etc.
> 
> Like we do for the git wrapper, you mean? Yes, that would be one 
> solution, although not a very good one for all commands.

Exactly.  Not a good one.

> It's probably not a bad idea for commands where the primary use is 
> something else than producing visual output though, such as tag or 
> branch, but those handle creation/deletion of stuff, so the default 
> action for them is to list stuff of the kind they operate on. I fail to 
> see why stash should be any different.

I also fail to see why stash should be any different.  And that's why I 
expect it to have a default operation, which is -- you guessed it -- 
"stash the changes!"

If I am not sure what I am about to do, there is -- wonder of wonders -- 
the "-h" option!  And indeed:

	$ git stash -h
	Usage: /home/gitte/bin/git-stash [  | save | list | show | apply | 
		clear | create ]

So what exactly was your point again?

Ciao,
Dscho
