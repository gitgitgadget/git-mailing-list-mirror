From: Tony Luck <tony.luck@gmail.com>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Thu, 7 Jul 2005 17:09:45 -0700
Message-ID: <12c511ca050707170964a2cc92@mail.gmail.com>
References: <20050703234629.GF13848@pasky.ji.cz> <42CBC822.30701@didntduck.org>
	 <20050707144501.GG19781@pasky.ji.cz>
	 <7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org>
	 <20050707221443.GB7151@pasky.ji.cz>
	 <Pine.LNX.4.58.0507071549330.25104@g5.osdl.org>
	 <12c511ca05070716526954edd@mail.gmail.com>
	 <Pine.LNX.4.58.0507071658460.25104@g5.osdl.org>
Reply-To: Tony Luck <tony.luck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 02:10:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqgRJ-0008Iz-1H
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 02:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbVGHAJu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 20:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbVGHAJu
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 20:09:50 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:25420 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262383AbVGHAJr convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Jul 2005 20:09:47 -0400
Received: by zproxy.gmail.com with SMTP id l1so147515nzf
        for <git@vger.kernel.org>; Thu, 07 Jul 2005 17:09:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=totZHUCggXv+g6Y9aH+vEuanaHXioHxDjgU+PySbPSJAgR6r+lkGUzhO6QF7XIlRNgn5Ir+pzAAebQ5Uyj83970ZGjBlQ8KvNh3V0FkZB56wPIn6O6+AJkqtPPbfa6CJPi6jjHqZ/1txX5S3YXcqK4rySv0D1pVEkprcH37nzYk=
Received: by 10.36.141.10 with SMTP id o10mr595948nzd;
        Thu, 07 Jul 2005 17:09:45 -0700 (PDT)
Received: by 10.36.59.4 with HTTP; Thu, 7 Jul 2005 17:09:45 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507071658460.25104@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> > cg-update from a local repo that contains packs is broken though :-(
> 
> Is this with cg-0.12? The most recent release should be happy with packs.

Yes ... I pulled, built and installed the latest cogito this afternoon
before trying
to touch anything involving packs.  cg-version says:

cogito-0.12 (b21855b8734ca76ea08c0c17e4a204191b6e3add)

This is what happens ("linus" is a local branch just pulled from kernel.org,
so it just contains one pack file and its index).

$ cg-update linus
`/home/aegl/GIT/linus/.git/refs/heads/master' -> `.git/refs/heads/linus'
does not exist /home/aegl/GIT/linus/.git/objects/04/3d051615aa5da09a7e44f1edbb69
798458e067
Cannot obtain needed object 043d051615aa5da09a7e44f1edbb69798458e067
while processing commit 0000000000000000000000000000000000000000.
cg-pull: objects pull failed

If I try it again, it thinks things are up to date (since it
mistakenly updated the
.git/refs/heads/linus), but then fails to apply (since it doesn't have
the objects
it needs).

-Tony
