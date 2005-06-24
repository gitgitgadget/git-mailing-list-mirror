From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Fri, 24 Jun 2005 15:46:21 +0200
Message-ID: <4d8e3fd3050624064620a4945e@mail.gmail.com>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org>
	 <20050624064101.GB14292@pasky.ji.cz>
	 <20050624130604.GK17715@g5.random> <20050624133952.GB7445@thunk.org>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Jun 24 15:44:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DloTg-0006ZM-42
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 15:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbVFXNtt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 09:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbVFXNtk
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 09:49:40 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:11127 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262496AbVFXNqY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2005 09:46:24 -0400
Received: by rproxy.gmail.com with SMTP id i8so453153rne
        for <git@vger.kernel.org>; Fri, 24 Jun 2005 06:46:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pU9SmJEse27AHlo1TpuHvTeyY9UQFjRHEnLXrjg4s4czdM5WIBW+mb8WxfLwctdIJMAMf/tiAbMp0FKBg3kD309pzyJFkrcy7Ye53ijsYwuez7V0bppUY/GD6wIen6aMskFvoeOfCR3C525uB4qCTmU0O8C+ODCfUMVnA+GJUVA=
Received: by 10.38.104.62 with SMTP id b62mr1357391rnc;
        Fri, 24 Jun 2005 06:46:21 -0700 (PDT)
Received: by 10.38.78.23 with HTTP; Fri, 24 Jun 2005 06:46:21 -0700 (PDT)
To: Theodore Ts'o <tytso@mit.edu>, Andrea Arcangeli <andrea@suse.de>,
	Petr Baudis <pasky@ucw.cz>, mercurial@selenic.com,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <20050624133952.GB7445@thunk.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

2005/6/24, Theodore Ts'o <tytso@mit.edu>:
> On Fri, Jun 24, 2005 at 03:06:04PM +0200, Andrea Arcangeli wrote:
> > On Fri, Jun 24, 2005 at 08:41:01AM +0200, Petr Baudis wrote:
> > > Cool. Except where the concepts are just different, Cogito mostly
> > > appears at least equally simple to use as Mercurial. Yes, some features
> > > are missing yet. I hope to fix that soon. :-)
> >
> > The user interface and network protocol isn't the big deal, the big deal
> > is the more efficient on-disk storage format IMHO.
> 
> E2fsprogs with the full revision history imported into git is 100
> megs, and that's with deltas.  E2fsprogs imported into Mercurial is 17
> megs (and actually, the imported repository was just a tad bit smaller
> than e2fsprogs' BK repository).
> 
> Which do you think is going to be faster to operate from a cold start
> using 4200 rpm laptop drives?  :-)
> 
>                                                - Ted

That's quite intersting, what the rational behind such a difference in
terms of disk occupation ?

-- 
Paolo
