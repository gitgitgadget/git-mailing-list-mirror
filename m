From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/8] Make the "traditionally-supported" URLs a special 
 case
Date: Fri, 4 Sep 2009 23:08:16 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909042305390.8306@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0909032213180.28290@iabervon.org>  <fabb9a1e0909032229k5e6e2ed5mc11e8ff9c16dfcc0@mail.gmail.com>  <alpine.LNX.2.00.0909041114440.28290@iabervon.org> <7vy6ouk4io.fsf@alter.siamese.dyndns.org>  <alpine.DEB.1.00.0909041930450.8306@pacific.mpi-cbg.de>
 <alpine.LNX.2.00.0909041429540.28290@iabervon.org> <fabb9a1e0909041235x74a3b9b4gf65e650ca0d00831@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1893452795-1252098497=:8306"
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 23:07:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjfzr-0000Bi-7s
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 23:07:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934103AbZIDVGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 17:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934025AbZIDVGx
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 17:06:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:40428 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933995AbZIDVGw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 17:06:52 -0400
Received: (qmail invoked by alias); 04 Sep 2009 21:06:54 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 04 Sep 2009 23:06:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/3SH5UpXL3OA/J8XL8dXqYsyIDeMHc1anAMUqkHM
	jHImtx05kFeWxG
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <fabb9a1e0909041235x74a3b9b4gf65e650ca0d00831@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127769>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1893452795-1252098497=:8306
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 4 Sep 2009, Sverre Rabbelier wrote:

> On Fri, Sep 4, 2009 at 21:05, Daniel Barkalow<barkalow@iabervon.org> 
> wrote:
> > Some foreign vcses, including the only one I ever personally use, do 
> > not have URLs, and require a bunch of options and paths to specify a 
> > repository. I don't want to have to use:
> >
> >        url = p4://rsh:ssh+-q+-a+-x+-l+p4ssh+-q+-x+perforce+%2Fbin%2Ftrue//projects/foo/bar-1.0/...,//projects/foo/bar-1.1/...
> 
> Btw, doesn't p4 have these config files that you can download that 
> contain the configuration? In that case 
> 'p4://example.org/p4/main-development.configfile' would be very 
> convenient.

If that's how p4 users initialize their working directories, then that is 
the way to go.

And I cannot start to believe that the complicated way you described is 
the common way to initialize p4 working directories, as that would tempt 
the intelligence/enthusiasm of the average programmer.

> > For cases where the foreign vcs has something to put in the "url" 
> > spot, you don't need to set "vcs". In fact, you are only allowed to 
> > set one or the other of "vcs" and "url" with my current version. What 
> > you're interested in is explicitly left for later, when we have a 
> > prototype helper for such a foreign vcs and can try it out with 
> > potential users.
> 
> I need to hurry up and get working on that hg implementation then :).

Indeed you do.  If only to prove that _this_ and the likes are something 
to optimize for, not some obscure vcs config variable that only introduces 
a little-exercized code path that's _prone_ to break and does not help 
anybody.

Ciao,
Dscho

--8323328-1893452795-1252098497=:8306--
