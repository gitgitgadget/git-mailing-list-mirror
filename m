From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: What's in git.git, and announcing GIT 1.4.2-rc4
Date: Thu, 10 Aug 2006 16:30:46 +0200
Message-ID: <81b0412b0608100730r292c1863nfa60ec159d3aad1d@mail.gmail.com>
References: <7vy7txxts5.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0608100634j4f82d486nd8ba6dd3ac85b0e7@mail.gmail.com>
	 <Pine.LNX.4.63.0608101558290.10541@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 16:32:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBBYh-00088x-RZ
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 16:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161253AbWHJOas (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 10:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161258AbWHJOas
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 10:30:48 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:57780 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161253AbWHJOar (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 10:30:47 -0400
Received: by wx-out-0506.google.com with SMTP id s14so432376wxc
        for <git@vger.kernel.org>; Thu, 10 Aug 2006 07:30:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kC6Jh49KU+BJOEL7NmPeMNrxjqA8RyOTjqEEYdlLsoUd5SZ+U/EsobWUwN2QFtXJq3SDNEV5tfWddSPmvApu0QjyNsP0DUsheiLzb22qY76Ak9jJdepSxjJdLRKEnob7ffKNBvXw7XXdZrELTAz0PcBtxIqtzW4wuKwzTEPyvfw=
Received: by 10.78.107.8 with SMTP id f8mr1331249huc;
        Thu, 10 Aug 2006 07:30:46 -0700 (PDT)
Received: by 10.78.160.12 with HTTP; Thu, 10 Aug 2006 07:30:45 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608101558290.10541@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25185>

On 8/10/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > I noticed that it spends a lot of time finding renames (diffcore_std,
> > in particular).
>
> My next plans -- after making sure that merge-recursive is accurate
> (enough) -- was to use oprofile to find the expensive spots.

BTW, it maybe subjective, but diff-tree seem to have slowed down too.

> > Why doesn't it take that much time for "diff-tree -M -r base head1" +
> > "diff-tree -M -r base head2", I wonder...? (~30 sek, for that windows box).
>
> Could it be that it has many common ancestors? You have to do the rename
> handling twice for each merge...

No. I'd notice that.

> > Sorry, I can't provide the tree. I suppose Mozilla tree can be compared
> > to that thing, when it becomes available. Linux kernel is no good for
> > reproducing this problem: it's too clean and compact.
>
> The beauty of Open Source: since everyone can see your mess, you tend to
> be tidier...

Yep. One of the reasons to have source closed: so your customers do
not see how dirty the mess they paid for is.
