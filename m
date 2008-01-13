From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach remote machinery about remotes.default config
 variable
Date: Sun, 13 Jan 2008 22:22:29 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0801132220200.8333@wbgn129.biozentrum.uni-wuerzburg.de>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org>
 <478855B5.9070600@gmail.com> <7vbq7ry405.fsf@gitster.siamese.dyndns.org> <47885B2C.8020809@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com>
 <alpine.LSU.1.00.0801122123430.8333@wbgn129.biozentrum.uni-wuerzburg.de> <47893F53.2070908@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 13 22:23:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEAIG-0004gA-W1
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 22:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025AbYAMVWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 16:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754023AbYAMVWd
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 16:22:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:57648 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754007AbYAMVWc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 16:22:32 -0500
Received: (qmail invoked by alias); 13 Jan 2008 21:22:30 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp045) with SMTP; 13 Jan 2008 22:22:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX197+hRlbZR7+t3mmK9R1A2HZxpy8g6/EGojR91VMa
	3jXdOl3zf6Ii+R
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <47893F53.2070908@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70414>

Hi,

On Sat, 12 Jan 2008, Mark Levedahl wrote:

> Johannes Schindelin wrote:
> > Why is your patch then not about git-submodule?
> > 
> > And I still fail to see -- even for submodules -- how you begin to 
> > tackle that lookup problem.
> 
> Because git-submodule is a wrapper around git-fetch and git-clone and 
> git-remote, and those lacked the mechanism to honor the fact that when I 
> said
> 
>       git clone -o  frotz frontz.foo.bar/foo.git
> 
> I *defined* the upstream's nickname as "frotz", not "origin", and origin 
> is *not* defined so don't try to use it. As sub-modules are git 
> projects, fixing this in a sub-module necessarily fixes it in any git 
> project.

Unfortunately, you _still_ fail to even ackonwledge that you still need a 
lookup, and that I have a point when saying "your patch does not help, 
since you still have a lookup".

But I start to believe that you do not even want to present an argument 
against this reasoning, so I will stop here.

Ciao,
Dscho
