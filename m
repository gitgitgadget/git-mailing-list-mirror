From: Junio C Hamano <junkio@cox.net>
Subject: Re: maybe breakage with latest git-pull and http protocol
Date: Sat, 15 Oct 2005 09:37:39 -0700
Message-ID: <7vwtkeohws.fsf@assigned-by-dhcp.cox.net>
References: <867jciz18w.fsf@blue.stonehenge.com>
	<864q7kqsa4.fsf@blue.stonehenge.com>
	<7vhdbkt8ad.fsf@assigned-by-dhcp.cox.net>
	<86achcoyvz.fsf@blue.stonehenge.com>
	<Pine.LNX.4.63.0510141543030.23242@iabervon.org>
	<863bn3lypn.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 15 18:38:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQp2m-0001CP-4V
	for gcvg-git@gmane.org; Sat, 15 Oct 2005 18:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbVJOQhl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Oct 2005 12:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbVJOQhl
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Oct 2005 12:37:41 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:43943 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751183AbVJOQhl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2005 12:37:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051015163730.KBWA19461.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 15 Oct 2005 12:37:30 -0400
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <863bn3lypn.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "15 Oct 2005 06:03:00 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10135>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Daniel" == Daniel Barkalow <barkalow@iabervon.org> writes:
>
> Daniel> Can you give a general description of what happens? I've
> Daniel> noticed that I sometimes get spurious error messages that
> Daniel> don't actually affect the download, which I haven't tracked
> Daniel> down yet.
>
> OK, it happened this morning.  While syncing to update from
> yesterday's version, I got:
>
>     localhost:~/MIRROR/git-GIT % git-pull
>     Fetching refs/heads/master from http://www.kernel.org/pub/scm/git/git.git using http
>     Getting alternates list
>     got 4546738b58a0134eef154231b07d60fc174d56e3
>     walk 4546738b58a0134eef154231b07d60fc174d56e3
>     got d402d5566fdf226697a386dfb9858e5d954e9b91
>     got 873d8e5652c06c3891278f33546c437efc209c2d
>     walk d402d5566fdf226697a386dfb9858e5d954e9b91
>     error: 
>     Getting pack list
>     got 0207ab18a3876249a928e7539d8f594a4f6921f1
>     got 9f7534accdf34b980a2de670cb1009dd84ee56c4
>     error: Unable to find 5ad4a2766d34569f3a1278544ab64978fab14cc8 under http://www.kernel.org/pub/scm/git/git.git/
>
>     Cannot obtain needed blob 5ad4a2766d34569f3a1278544ab64978fab14cc8
>     while processing commit d402d5566fdf226697a386dfb9858e5d954e9b91.
>
> Definitely broken.  But I can "rsync" just fine.
>
> -- 
> Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
> <merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
> Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
> See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
