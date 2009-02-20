From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Migrating from StarTeam to GIT
Date: Fri, 20 Feb 2009 10:11:51 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902201005190.10279@pacific.mpi-cbg.de>
References: <89b129c60902190919p2cdbe349o4a2a659617dae341@mail.gmail.com> <20090220030856.GD22419@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sean Kelley <sean.v.kelley@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 20 10:13:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaRRb-0000Cx-C6
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 10:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561AbZBTJKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 04:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbZBTJKu
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 04:10:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:49345 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751824AbZBTJKs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 04:10:48 -0500
Received: (qmail invoked by alias); 20 Feb 2009 09:10:46 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp043) with SMTP; 20 Feb 2009 10:10:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18sNTE77QgsgVzGF/gOZPkSGBx0CxK2KOgXvkaOvu
	emqz6E0Jf9n66z
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090220030856.GD22419@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110825>

Hi,

On Thu, 19 Feb 2009, Jeff King wrote:

> On Thu, Feb 19, 2009 at 11:19:28AM -0600, Sean Kelley wrote:
> 
> > Are there ways to migrate views in StarTeam to a DVCS like GIT? Anyone
> > have experience with this?
> 
> Wow, I've never even heard of StarTeam. AFAIK, there is no converter
> already (as in, I have never heard of one, and searching the list
> archive turns up nothing).
> 
> Getting history data into git is usually easy. If you can generate a
> series of snapshots, at worst you can script around commiting each one.
> Or you can write to the "git fast-import" input language, which is,
> well...fast.

And you can learn by example: "git -p fast-export HEAD" ;-)

> The tricky part will be getting your data out of StarTeam, which is
> apparently not very easy:
> 
>   http://svn.haxx.se/users/archive-2005-07/0720.shtml

According to http://en.wikipedia.org/wiki/StarTeam, there is a 
cross-platform Java client; I'd try to hack that, using a combination of 
"unzip -p $JAR META-INF/MANIFEST.MF", javap, and good luck ;-)

/me has an idea and goes off Googling

Yes.  There is no need to hack it: 
http://techpubs.borland.com/starteam/2008r2/en/SDK_Documentation/api/index.html

>From a quick glance, it appears that com.starbase.starteam.Project should 
be the entry point.

Ciao,
Dscho
