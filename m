From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git/cogito usage scenarios for CVS refugee
Date: Thu, 9 Jun 2005 08:26:03 +1200
Message-ID: <46a038f9050608132625803d@mail.gmail.com>
References: <46a038f9050608025152af4163@mail.gmail.com>
	 <20050608183414.GD982@pasky.ji.cz>
Reply-To: Martin Langhoff <martin.langhoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 22:23:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg73z-0000fb-3H
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 22:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVFHU0G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 16:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVFHU0G
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 16:26:06 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:27681 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261594AbVFHU0D convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 16:26:03 -0400
Received: by rproxy.gmail.com with SMTP id z35so224079rne
        for <git@vger.kernel.org>; Wed, 08 Jun 2005 13:26:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YcLRzMp7xKd1PGRNQLHBixon4RbOOJjDgs8TiFuCBn+nNXvlf2Yn96/Bk4w/K/BuEEft12ROPpgtVjK+ecYzULohGkzV0TydGbiOD20PEbrZ5oBtBl8uHsD/Q+OsnXm+eljSYLX/OmPj1gpoy82/oFyGWiJBK5n4jAZVcrwVI74=
Received: by 10.38.11.34 with SMTP id 34mr3859533rnk;
        Wed, 08 Jun 2005 13:26:03 -0700 (PDT)
Received: by 10.38.101.46 with HTTP; Wed, 8 Jun 2005 13:26:03 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050608183414.GD982@pasky.ji.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 6/9/05, Petr Baudis <pasky@ucw.cz> wrote:
> The answer for all those questions is that git has no support for
> cherrypicking (that sucks, but is hard to fix right now). git does ok
> as long as one branch is superset of the other, but it does not help you
> otherwise.

Agreed -- there's no support for cherry picking. Is there some
git-specific strategy perhaps?

For example, when using cvs, which doesn't support cherry picking
either, people running "stable" branches use a "merged" tag that they
move around to indicate how far the bugfixes on the stable branch have
been merged into head. It doesn't allow cherry picking, but it works
and it is a valuable (if hackish) practice.

> > And generally, is there any long-lived branch support? If I am to run
> > a "local branch" of the Linux kernel, does git help me at all?
> 
> I don't understand what do you mean. How does a long-lived branch differ
> from a short-lived one and what support would you expect/like?

Something along the lines of what I've mention above. I mean, not
literally moving a tag around, but to have some basic suport to
identify what the merge status is. As soon as we are one commit out of
sync, git stops being useful.

It doesn't need to happen inside git actually -- perhaps there is just
enough support to add an identifier in each commit msg, so we could
have ancillary scripts that perform some simple patch tracking for
simple scenarios.

When an automatic merge succeeds, does git bring in the commitmsg and
a unique identifier of the commit?

cheers,


martin
