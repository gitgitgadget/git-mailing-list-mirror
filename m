From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] GIT commit statistics.
Date: Mon, 14 Nov 2005 17:01:43 +1300
Message-ID: <46a038f90511132001x6a9109fk17593b7ceaf3177e@mail.gmail.com>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
	 <7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
	 <7v4q6ilt3m.fsf@assigned-by-dhcp.cox.net>
	 <43758D21.3060107@michonline.com>
	 <7v7jbeia3v.fsf_-_@assigned-by-dhcp.cox.net>
	 <46a038f90511120419v70166c60t93d58b7544e03e3b@mail.gmail.com>
	 <7vy83s95k0.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90511131242p4692c74fn20c015998620b9f4@mail.gmail.com>
	 <7vlkzr6gzz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 05:03:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbVXP-0007MR-Nj
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 05:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbVKNEBo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 23:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbVKNEBo
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 23:01:44 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:49361 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750882AbVKNEBo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2005 23:01:44 -0500
Received: by zproxy.gmail.com with SMTP id 40so1024383nzk
        for <git@vger.kernel.org>; Sun, 13 Nov 2005 20:01:43 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XkePtunGiU6JzEO0E8B7K18e6mmxdZ35Z22i7GUutz0sOOTRMXeZjnR0ZTjMTYaInD/Mjry8wnHQIc9p5eB1psVjx/lBCi98vRscb3xXusv7qcsUplWtJBvhPxpsexzJVeam6GS4FjMPWLi3bHcLyUePqKXWc4OwolTMO7+ohDg=
Received: by 10.64.193.9 with SMTP id q9mr2279610qbf;
        Sun, 13 Nov 2005 20:01:43 -0800 (PST)
Received: by 10.64.242.4 with HTTP; Sun, 13 Nov 2005 20:01:43 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkzr6gzz.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11764>

On 11/14/05, Junio C Hamano <junkio@cox.net> wrote:
> In your message you indicated that you use "format-patch" piped
> to "am".  I think that is a better approach than "rebase" these
> days

Hmmm. But doesn't deal well with binary changes. We deal with a large
set of projects, and while we don't manage that many binary files, it
is just enough that I'll have to pass on only using format-patch.

> This was recently added by Linus to help git-merge do that:
>
>         git-read-tree --trivial -m -u $O $A $B

Cool! Abusing that, perhaps I could teach git-rebase to take a
'--trivial-only' flag, and then cg-update --rebase could try
git-rebase --trivial-only, and fall back on cg-merge...

cheers,


martin
