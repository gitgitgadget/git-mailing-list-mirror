From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] GIT commit statistics.
Date: Mon, 14 Nov 2005 09:42:31 +1300
Message-ID: <46a038f90511131242p4692c74fn20c015998620b9f4@mail.gmail.com>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
	 <20051107225807.GA10937@c165.ib.student.liu.se>
	 <7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
	 <7v4q6ilt3m.fsf@assigned-by-dhcp.cox.net>
	 <43758D21.3060107@michonline.com>
	 <7v7jbeia3v.fsf_-_@assigned-by-dhcp.cox.net>
	 <46a038f90511120419v70166c60t93d58b7544e03e3b@mail.gmail.com>
	 <7vy83s95k0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 13 21:44:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbOgc-0006dH-2v
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 21:42:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVKMUmd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 15:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVKMUmd
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 15:42:33 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:53888 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750732AbVKMUmc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2005 15:42:32 -0500
Received: by zproxy.gmail.com with SMTP id 40so970304nzk
        for <git@vger.kernel.org>; Sun, 13 Nov 2005 12:42:32 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DZByXk75zuG9H8HMgxHjZbUAlIqKfJuVksZ1EiBJ1bVOArMz1PoQn8XlXrxwM715KoDbWAwHC3fOt41OdJn+1Zf9QqSZ0SrMrBZL2dglQe5pcnQbXj7IQhfxXUbtlJ/OOHBcsMLT9Z6qtMmRkYtFzEW7V6y37qVn4z8mIBILB2k=
Received: by 10.64.131.4 with SMTP id e4mr1959300qbd;
        Sun, 13 Nov 2005 12:42:31 -0800 (PST)
Received: by 10.64.242.4 with HTTP; Sun, 13 Nov 2005 12:42:31 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy83s95k0.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11750>

On 11/13/05, Junio C Hamano <junkio@cox.net> wrote:
> Ah, the commit master~3 was what he had the last time I pulled
> from him, and since then he made a commit while I did three.  I
> could do "git pull . origin" at this point, but that would
> result in a useless mini-merge.  My tree is not public so I can
> freely rebase to clean things up.
>
>         $ git rebase origin
>         $ git show-branch

What happens if there are conflicts during git-rebase? I'm thinking of
adding an '-r' option to cg-update that will rebase instead of
merging, if the rebase is clean.

Is there a cheap way to ask from a shell script whether the merge is
truly trivial? I thought git-diff-tree would help me here, but it
doesn't...


martin
