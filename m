From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Expected Behavior?
Date: Thu, 10 Nov 2005 15:47:38 +1300
Message-ID: <46a038f90511091847t70567e50o2303f1dc7ada2464@mail.gmail.com>
References: <E1EZKOB-0002j5-VY@jdl.com>
	 <7vwtjjllw4.fsf@assigned-by-dhcp.cox.net>
	 <20051108210332.GB23265@c165.ib.student.liu.se>
	 <20051109112452.GD30496@pasky.or.cz>
	 <46a038f90511091504l7218df18k251bec75491891e9@mail.gmail.com>
	 <20051109231248.GL16061@pasky.or.cz>
	 <46a038f90511091543h520f6a84k3e3b14c2e502989f@mail.gmail.com>
	 <20051109234925.GL30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Junio C Hamano <junkio@cox.net>,
	Jon Loeliger <jdl@freescale.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 03:49:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ea2TX-0007nn-AL
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 03:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbVKJCrj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 21:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbVKJCrj
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 21:47:39 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:50729 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751038AbVKJCri convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 21:47:38 -0500
Received: by zproxy.gmail.com with SMTP id j2so311209nzf
        for <git@vger.kernel.org>; Wed, 09 Nov 2005 18:47:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ncoug6p4A07jFC+/NYhThy6nnQfHiy+XmuZiQwvMBtTcVa34XNB+6EuRoo+qDLyx8Du3edgUWS1v18eyST4Jb5ZGrvo//fQ9215c2wzc67elyDBjQYbejavc/tzcvX/oxrw03j+dfFx0N+OPTTJiYHa9ldtxVu/kk7uLsr0kZ0s=
Received: by 10.64.201.20 with SMTP id y20mr242099qbf;
        Wed, 09 Nov 2005 18:47:38 -0800 (PST)
Received: by 10.64.242.4 with HTTP; Wed, 9 Nov 2005 18:47:38 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051109234925.GL30496@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11461>

On 11/10/05, Petr Baudis <pasky@suse.cz> wrote:
> But that's something different that I'm talking about. :-)

Ack! Sorry about that!

> Yes. My longer plan is to use the strategy resolvers as well, but my
> TODO list is big... And I don't perceive this as a critical thing (the
> standard strategy seems to work well enough), although I would like to
> see this before 1.0.

Fair enough. If you can outline how the interaction between cg-merge
and cg-commit are expected to work, I'll try and find some time for
that.

> > Right now I am seeing some slightly abnormal things (*) in how some
> > our our merges are going, so I' ll have to roll up my sleeves at some
> > point and try and figure out what's going on. And as I look into
> > cg-merge and cg-Xmergefile, not many eyes have been through it...
>
> At least this is the one area of Cogito that has at least a bit
> reasonable automated testing suite. ;-)

The good news is that git-merge is doing almost the same. Posted separately...


martin
