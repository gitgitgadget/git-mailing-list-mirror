From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git svn: allow uppercase UUIDs from SVN
Date: Sun, 12 Jul 2009 14:56:58 -0700
Message-ID: <20090712215658.GA24389@dcvr.yhbt.net>
References: <ohrc5510bko329be5ugj3n6bgvhcevd2kg@4ax.com> <20090710033133.GA23082@dcvr.yhbt.net> <5m5e55538tlnq40rup7rci61i2mg16q0dv@4ax.com> <20090710203322.GA18051@dcvr.yhbt.net> <20090712185821.GA26749@dcvr.yhbt.net> <7vtz1hli15.fsf@alter.siamese.dyndns.org> <7v7hydlgal.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Esben Skovenborg <esskov@oncable.dk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 12 23:57:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQ72f-0007cw-Ik
	for gcvg-git-2@gmane.org; Sun, 12 Jul 2009 23:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336AbZGLV5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2009 17:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752237AbZGLV47
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 17:56:59 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38583 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751929AbZGLV46 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2009 17:56:58 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6241A1F5D0;
	Sun, 12 Jul 2009 21:56:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v7hydlgal.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123164>

Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Eric Wong <normalperson@yhbt.net> writes:
> >
> >>   Junio: pushed out to git://git.bogomips.org/git-svn along with
> >>          some patches I think I forgot to tell you about:
> >
> > Thanks, will pull.
> 
> Actually I think I got something different from what I thought I was
> expecting.  Your message said:
> 
>     Eric Wong (1):
>           git svn: allow uppercase UUIDs from SVN
> 
>     Mattias Nissler (2):
>           git-svn: Always duplicate paths returned from get_log
>           git-svn: Fix branch detection when repository root is inaccessible
> 
> but after merge:
> 
>     Junio C Hamano (1):
>           Merge git://git.bogomips.org/git-svn
> 
>     Mattias Nissler (2):
>           git-svn: Always duplicate paths returned from get_log
>           git-svn: Fix branch detection when repository root is inaccessible
> 
>     Yann Dirson (4):
>           git-svn.txt: stop using dash-form of commands.
>           git-svn.txt: make formatting more consistent.
>           git-svn.txt: fix fetch flags incorrectly documented as init flags.
>           git-svn.txt: fix description of fetch flags accepted by clone.
> 
> For example, you have this:
> 
>     commit eb0d671e3b73f05106dca83b9cecd74d4acdb291
>     Author: Yann Dirson <ydirson@altern.org>
>     Date:   Mon Jul 6 00:03:15 2009 +0200
> 
> which is an old iteration of 
> 
>     commit 6c32a7a99495da3f49e2a142791bc10af3f6f059
>     Author: Yann Dirson <ydirson@altern.org>
>     Date:   Tue Jul 7 22:22:20 2009 +0200
> 
> that is already in 'master'.
> 
> Perhaps you forgot to push it out?  These are what I see:

Exactly, just pushed.  Sorry about that.

-- 
Eric Wong
