From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] GIT commit statistics.
Date: Sun, 13 Nov 2005 01:19:45 +1300
Message-ID: <46a038f90511120419v70166c60t93d58b7544e03e3b@mail.gmail.com>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
	 <20051107225807.GA10937@c165.ib.student.liu.se>
	 <7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
	 <7v4q6ilt3m.fsf@assigned-by-dhcp.cox.net>
	 <43758D21.3060107@michonline.com>
	 <7v7jbeia3v.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Ryan Anderson <ryan@michonline.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 13:20:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EauMJ-0007dE-UP
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 13:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbVKLMTs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 07:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbVKLMTr
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 07:19:47 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:45422 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932370AbVKLMTr convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 07:19:47 -0500
Received: by zproxy.gmail.com with SMTP id i1so721020nzh
        for <git@vger.kernel.org>; Sat, 12 Nov 2005 04:19:46 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mbs4aioEn9udAyW/soDD6SyvUQQ4hviqB+mZgt7i9g4cJ2BHwEZYL9vnbhGfXNlgRc7vkKm57yYzjt7MmUPjH43zX6/klP92+ZtGkscSVU0N1A5mVPeMRjNf58mwR0tNX7maLIqxUd8FqOqiMmXfAVGWBQmAlnVgc4NKEpraD1M=
Received: by 10.65.233.8 with SMTP id k8mr3542390qbr;
        Sat, 12 Nov 2005 04:19:46 -0800 (PST)
Received: by 10.64.242.4 with HTTP; Sat, 12 Nov 2005 04:19:45 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7jbeia3v.fsf_-_@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11675>

On 11/12/05, Junio C Hamano <junkio@cox.net> wrote:
> Ryan Anderson <ryan@michonline.com> writes:
>
> > Junio C Hamano wrote:
> >
> >> Just for fun, I randomly picked two heads/master commits from
> >> linux-2.6 repository ... and fed the commits
> >> between the two to a little script that looks at commits and
> >> tries to stat what they did (the script ignores renames so they
> >> appear as deletes and adds).

Related to this, I've been wondering whether it'd be possible to teach
git to rebase local patches, even if that means rewriting local
history. When you are dealing with team shared repo, the sequences of
pull/push end up being quite messy, full of little meaningless merges.
Similarly, when dealing with an upstream, my tree gets slowly out of
sync and slightly messy. Eventually I get a new checkout, and rebase
any pending patches with git-format-patch and git-am.

The same process would be much easier if I could just cg-update from
the repo and get it to try and actually rebase my local commits --
rewriting history as if I had committed them after the update. Of
course, it'd be cheating... but we cheat all the time anyway, we only
sweat harder at it ;-)

cheers,


martin
