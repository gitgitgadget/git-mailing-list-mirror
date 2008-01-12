From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach remote machinery about remotes.default config
 variable
Date: Sat, 12 Jan 2008 21:22:53 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0801122119580.8333@wbgn129.biozentrum.uni-wuerzburg.de>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org>
 <478855B5.9070600@gmail.com> <alpine.LSU.1.00.0801121748290.8333@wbgn129.biozentrum.uni-wuerzburg.de> <4788F907.1050306@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 21:24:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDmtt-00037G-SK
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 21:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764086AbYALUW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 15:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764082AbYALUW6
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 15:22:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:57561 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763927AbYALUW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 15:22:56 -0500
Received: (qmail invoked by alias); 12 Jan 2008 20:22:54 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp043) with SMTP; 12 Jan 2008 21:22:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/OPV09lfTOWU/V8e2oodR4SvENLZ50Q9rfD8Xg+G
	DnLZE2xOoj58tL
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <4788F907.1050306@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70357>

Hi,

On Sat, 12 Jan 2008, Mark Levedahl wrote:

> Johannes Schindelin wrote:
> > 
> > No, that was not _at all_ my argument.
> > 
> > I said that hiding it under a different name _that you have to look 
> > up, too_ does _not_ make things easier.
> > 
> >   
> Granted, *IF* we had to look it up, but we don't. In fact, we use the 
> convention
>    servername.foo.bar
> has nickname
>    servername
> 
> So, we need to know the server name we are using, and that server name 
> is the nickname. So, no confusion and no extra lookup step. (Our server 
> names are unique without the domain suffixes, so this works well for 
> us).

How do you know _which_ default remote name your current repository uses? 
Exactly: you have to look it up.  So your whole *IF* argument is bogus.

And if you already have to look something up, and the user fiddled with 
her setup, you can no longer be sure that nickname servername points to 
servername.foo.bar, and you are in even more trouble.

That is why I maintain that your solution does not make things better.

Hth,
Dscho
