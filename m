From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Tue, 19 Oct 2010 15:15:15 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010191508370.2764@xanadu.home>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
 <AANLkTimkovH9OysLSxA+=di89Xi+dTCYL5hRPmNaADDH@mail.gmail.com>
 <20101019175103.GA28847@kytes> <20101019182845.GE25139@burratino>
 <AANLkTi=DXH1WwGJ-h6s3dFfWZZ3tpu_jQgV1Y9O7c6Xf@mail.gmail.com>
 <0B20EFC4-E613-4D4A-B4F8-8B1750AA8AFD@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_rFNsOK6dmR1YdwVxJiI4Rw)"
Cc: git@vger.kernel.org
To: Thore Husfeldt <thore.husfeldt@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 21:15:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8Hf8-0005rM-Kw
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 21:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893Ab0JSTPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 15:15:49 -0400
Received: from relais.videotron.ca ([24.201.245.36]:36469 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab0JSTPs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 15:15:48 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LAJ0019SXH72ZE0@vl-mh-mrz21.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 19 Oct 2010 15:15:08 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <0B20EFC4-E613-4D4A-B4F8-8B1750AA8AFD@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159357>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_rFNsOK6dmR1YdwVxJiI4Rw)
Content-type: TEXT/PLAIN; charset=windows-1252
Content-transfer-encoding: 8BIT

On Tue, 19 Oct 2010, Thore Husfeldt wrote:

> Also, in the user-manual.txt:
> 
> > Examining branches from a remote repository
> > -------------------------------------------
> > 
> > The "master" branch that was created at the time you cloned is a copy
> > of the HEAD in the repository that you cloned from.  That repository
> > may also have had other branches, though, and your local repository
> > keeps branches that track each of those remote branches, which you
> > can view using the "-r" option to linkgit:git-branch[1]:
> > 
> > ------------------------------------------------
> > $ git branch -r
> >   origin/HEAD
> >   origin/html
> >   origin/maint
> >   origin/man
> >   origin/master
> >   origin/next
> >   origin/pu
> >   origin/todo
> > ------------------------------------------------
> > 
> > You cannot check out these remote-tracking branches, but you can
> > examine them on a branch of your own, just as you would a tag:
> 
> That’s just wrong, isn’t it? You absolutely can check out a remote-tracking branch.--

Yes, the above is wrong.  But to check out a remote-tracking branch, or 
a tag, or a random commit through its SHA1, we do rely on the concept of 
a "detached head".  That term and concept has caused newbies grief in 
the past as well, despite the fact that seasoned Git users are perfectly 
fine with it.

A detached head is HEAD not being linked to any branch.  This is done 
because tags and remote-tracking branches are not meant to be altered by 
local changes.  Hence committing stuff on top of a detached head will 
advance HEAD, but no actual branch is keeping a record of it.


Nicolas

--Boundary_(ID_rFNsOK6dmR1YdwVxJiI4Rw)--
