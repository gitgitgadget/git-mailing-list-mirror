From: Petr Baudis <pasky@suse.cz>
Subject: Re: Expected Behavior?
Date: Thu, 10 Nov 2005 00:42:12 +0100
Message-ID: <20051109234212.GJ30496@pasky.or.cz>
References: <E1EZKOB-0002j5-VY@jdl.com> <7vwtjjllw4.fsf@assigned-by-dhcp.cox.net> <20051108210332.GB23265@c165.ib.student.liu.se> <20051109112452.GD30496@pasky.or.cz> <46a038f90511091504l7218df18k251bec75491891e9@mail.gmail.com> <7virv18kc3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 00:43:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZza5-0006JK-QG
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 00:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbVKIXmP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 18:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbVKIXmP
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 18:42:15 -0500
Received: from w241.dkm.cz ([62.24.88.241]:55254 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751608AbVKIXmO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 18:42:14 -0500
Received: (qmail 12811 invoked by uid 2001); 10 Nov 2005 00:42:12 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7virv18kc3.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11443>

Dear diary, on Thu, Nov 10, 2005 at 12:36:44AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Fredrik's using his own mergeFile is defensible from both
> performance and implementation point of view.  After the rename
> processing stage, he already extracted enough information from
> trees involved, and there is no reason for him to be preparing
> three stages in the index file with that information (which is
> cumbersome because there is no interface to populate the higher
> stage directly using git-update-index --- you have to first
> create temporary tree objects and ask git-read-tree -m to do so)
> and asking git-merge-index to call git-merge-one-file.  If you
> read git-merge-one-file, it is not a rocket science.

I'm not arguing against mergeFile but rather git-merge-one-file (and by
implication cg-Xmergefile), actually. My point is - couldn't be
mergeFile generalized a bit or padded with suitable interface to be
usable as git-merge-one-file's drop-in replacement?

> While we _may_ want to keep the logic that decides what to do in
> various cases across these three implementations, at least for me, it
> does not particularly feel disturbing, especially when there are good
> reasons.

I'm not sure I follow you here - what exactly does not feel disturbing
and what good reasons are there for whatever they are? :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
