From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Java GIT/Eclipse GIT version 0.1.1
Date: Fri, 28 Jul 2006 23:32:14 -0400
Message-ID: <20060729033214.GA28128@spearce.org>
References: <20060728063620.GD30783@spearce.org> <slrnecjcsn.8td.Peter.B.Baumann@xp.machine.xx> <20060728030859.n8ks44ck8884ss44@webmail.spamcop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 29 05:32:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6fZ7-0005aW-Jr
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 05:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWG2DcX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 23:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWG2DcX
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 23:32:23 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47063 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751365AbWG2DcX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jul 2006 23:32:23 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G6fYb-0001nK-Al; Fri, 28 Jul 2006 23:32:05 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7541A20E433; Fri, 28 Jul 2006 23:32:15 -0400 (EDT)
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <20060728030859.n8ks44ck8884ss44@webmail.spamcop.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24409>

Pavel Roskin <proski@gnu.org> wrote:
> Quoting Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>:
> 
> > On 2006-07-28, Shawn Pearce <spearce@spearce.org> wrote:
> > > My Java GIT library and Eclipse GIT team provider is now at a point
> > > where it may be partially useful to someone else who is also trying
> > > to write something which interacts with GIT.  Or who might also
> > > be interested in seeing a pure-Java Eclipse team provider for GIT.
> > >
> > > So I've posted my repository (currently ~200 KB) on my website:
> > >
> > >   http://www.spearce.org/projects/scm/egit.git
> > >
> >
> > Doesn't work for me.
> 
> Neither does it for me:
> 
> $ git clone http://www.spearce.org/projects/scm/egit.git
> error: File ac32c7cc2f7cf87a1ed80d0cdfca2af2a0385bb2
> (http://www.spearce.org/projects/scm/egit.git/objects/ac/32c7cc2f7cf87a1ed80d0cdfca2af2a0385bb2)
> corrupt
> Getting pack list for http://www.spearce.org/projects/scm/egit.git/
> error: XML error: not well-formed (invalid token)

Hmm.  My website is known to return 200 OK status codes on missing
files with HTML pages rather than proper 404 Not Found.  I guess
I need to get that fixed.

I just compiled and installed `next` (1.4.2.rc1.g802da) and it can
clone this repository just fine over HTTP, despite my broken server.
So I'm not really sure what is going on.

I should look into fixing my server, but its low on my priority list.

-- 
Shawn.
