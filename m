From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] A test for commit --amend allowing changing of a very
	empty commit message
Date: Thu, 21 Feb 2008 21:35:06 +0100
Message-ID: <20080221203506.GA20143@steel.home>
References: <20080221195438.GA6973@steel.home> <7vwsoyt5xt.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 21:36:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSI90-00013n-47
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 21:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760554AbYBUUfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 15:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760299AbYBUUfM
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 15:35:12 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:42930 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760295AbYBUUfK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 15:35:10 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClFhynk=
Received: from tigra.home (Fad6a.f.strato-dslnet.de [195.4.173.106])
	by post.webmailer.de (klopstock mo39) (RZmta 16.8)
	with ESMTP id q03f9ek1LJrhia ; Thu, 21 Feb 2008 21:35:07 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 61D92277BD;
	Thu, 21 Feb 2008 21:35:07 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id B9BDE56D24; Thu, 21 Feb 2008 21:35:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vwsoyt5xt.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74653>

Junio C Hamano, Thu, Feb 21, 2008 21:23:10 +0100:
> Alex Riesen <raa.lkml@gmail.com> writes:
> >
> > Well, it fails... In current master
> 
> Then please mark it with test_expect_failure.

That's because I expect it to be fixed (in the next mail)

> > +test_expect_success 'allow amend of an empty message' '
> > +
> > +	git reset --hard &&
> > +	sha=$(:|git commit-tree HEAD^{tree} -p HEAD) &&
> 
> You do not have to pipe; </dev/null would do ;-).

Sadly: no. There are very challenged systems. Like, for instance, ones
having no idea of what "/dev/null" is. Windows/Cygwin/ActiveState Perl
in a bloody stupid corporate combination.

I'm trying to minimize differences between my tree for my system at
work and the main tree. It is honestly the only purpose for this
construct.
