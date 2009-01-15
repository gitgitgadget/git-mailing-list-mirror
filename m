From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: rebase -p confusion in 1.6.1
Date: Thu, 15 Jan 2009 17:43:00 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901151739520.3586@pacific.mpi-cbg.de>
References: <slrngmu4j5.e1u.sitaramc@sitaramc.homelinux.net> <496F3C99.1040800@drmicha.warpmail.net> <20090115135518.GB10045@leksak.fem-net> <496F44AC.2060607@drmicha.warpmail.net> <20090115144050.GD10045@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org,
	Stephen Haberman <stephen@exigencecorp.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 17:43:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNVJf-0001Wn-B6
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 17:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645AbZAOQmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 11:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754643AbZAOQmK
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 11:42:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:47228 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754378AbZAOQmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 11:42:09 -0500
Received: (qmail invoked by alias); 15 Jan 2009 16:42:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp056) with SMTP; 15 Jan 2009 17:42:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18VaIsGCgIVXGz+2d8To+OVy2YSwuIVKYXkRHJJ0P
	cX1QAc7rE91uiM
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090115144050.GD10045@leksak.fem-net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105851>

Hi,

On Thu, 15 Jan 2009, Stephan Beyer wrote:

> Michael J Gruber wrote:
> > If it's about to be integrated we can do without the
> > present script...
> 
> I think it will take some time and some discussions on the list until it 
> will be integrated.  I remember, for example, Dscho, who has, since it 
> had first come up, always been opposed to the mark-reset / 
> mark-reset-merge scheme (in rebase -i -p, at least). Other users said 
> "Wow, this is much more flexible." ... and this is perhaps only one 
> thing that can lead to some bigger discussion.

Wow, much more flexible.  Except that you should not need this kind of 
flexibility.  If you need to do something complicated, it would be better 
to use "rebase -i -p" for the parts that do _not_ need to pick _other_ 
parents than are recorded in the commits.

And then you do an "edit" (or "pause" or whatever), and cherry-pick/merge 
_explicitely_ what you want.

Further, keep in mind that not only is that flexibility of dubitable value 
to the most users, it is also confusing, _and_ it adds code that is so 
rarely exercized that bugs can lurk in there for years... as you can 
experience right now.

So no, nothing has changed, I find that mark idea still horrible, 
horrible, horrible.

Ciao,
Dscho
