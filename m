From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] New script: git-changelog.perl - revised
Date: Sat, 3 Nov 2007 15:58:48 +0100
Message-ID: <20071103145848.GA3175@steel.home>
References: <67837cd60711021303q488e0873lea363b93fc90d591@mail.gmail.com> <472C3309.70109@op5.se> <67837cd60711030646p6d7dc8e3t8a5f5f336e8bbad6@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Ronald Landheer-Cieslak <ronald@landheer-cieslak.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 15:59:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoKSo-00014y-Kd
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 15:59:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754304AbXKCO6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 10:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754210AbXKCO6w
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 10:58:52 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:61715 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754199AbXKCO6v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 10:58:51 -0400
Received: from tigra.home (Fc897.f.strato-dslnet.de [195.4.200.151])
	by post.webmailer.de (klopstock mo64) (RZmta 14.0)
	with ESMTP id t039e3jA3D4rpC ; Sat, 3 Nov 2007 15:58:49 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 2D73E277AE;
	Sat,  3 Nov 2007 15:58:49 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id F3F4F56D22; Sat,  3 Nov 2007 15:58:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <67837cd60711030646p6d7dc8e3t8a5f5f336e8bbad6@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+a6ls=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63278>

Ronald Landheer-Cieslak, Sat, Nov 03, 2007 14:46:27 +0100:
> On Nov 3, 2007 4:36 AM, Andreas Ericsson <ae@op5.se> wrote:
> > Ronald Landheer-Cieslak wrote:
> > >
> > > This is also available through git at
> > > git://vlinder.landheer-cieslak.com/git/git.git#topic/git-log-changelog
> > >
> >
> > This mode of specifying a repository + branch was just thoroughly shot
> > down in a list discussion, and git certainly doesn't grok it. I'd be a
> > happier fella if you didn't use it.
> >
> Is there a canonical way to specify both the location and the branch
> in one shot, then? ...

Something like this:

    Please fetch from

    git://vlinder.landheer-cieslak.com/git/git.git topic/git-log-changelog

If one uses git-fetch the result will be in FETCH_HEAD, a pull will
merge it nicely with the commit message like:

    "Merge branch 'topic/git-log-changelog' of git://vlinder.landheer-cieslak.com/git/git"

which fits, I believe.
