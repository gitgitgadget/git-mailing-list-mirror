From: Tony Luck <tony.luck@gmail.com>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Thu, 7 Jul 2005 16:52:25 -0700
Message-ID: <12c511ca05070716526954edd@mail.gmail.com>
References: <20050703234629.GF13848@pasky.ji.cz> <42CBC822.30701@didntduck.org>
	 <20050707144501.GG19781@pasky.ji.cz>
	 <7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org>
	 <20050707221443.GB7151@pasky.ji.cz>
	 <Pine.LNX.4.58.0507071549330.25104@g5.osdl.org>
Reply-To: Tony Luck <tony.luck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 01:52:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqgAi-0006vO-DC
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 01:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbVGGXwa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 19:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbVGGXwa
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 19:52:30 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:11124 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262399AbVGGXw0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Jul 2005 19:52:26 -0400
Received: by zproxy.gmail.com with SMTP id f1so145723nzc
        for <git@vger.kernel.org>; Thu, 07 Jul 2005 16:52:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A4J85BmwuGs1q9K8YA+LmTrool1D1F3tXO5HwYDFxBURPsXUt/sJZIo6e6YjK9TdNtJUg6+KMFtCGC4Rh4dcYV4pJ1RbeIOeh0rA0pNrdS94xSGjvZJ3VUK+gFbKSE/Pdo/FfZtGyvhf5m0XjUyZklFcdlvdkPX/faUxn0NEi58=
Received: by 10.36.177.5 with SMTP id z5mr585645nze;
        Thu, 07 Jul 2005 16:52:25 -0700 (PDT)
Received: by 10.36.59.4 with HTTP; Thu, 7 Jul 2005 16:52:25 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507071549330.25104@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> > So, what _is_ then the way to pull now, actually? If we use rsync, won't
> > we end up with having the objects we previous had twice now?
> 
> Rsync works fine. You can either unpack the pack you get, or, if you
> prefer, just run
> 
>         git-prune-packed

cg-update from a local repo that contains packs is broken though :-(

Also "git-fsck-cache" in a repo that is fully packed complains:

   fatal: No default references

-Tony
