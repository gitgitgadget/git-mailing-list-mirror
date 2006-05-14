From: "Bertrand Jacquin" <beber.mailing@gmail.com>
Subject: Re: Howto get the merge-base ?
Date: Sun, 14 May 2006 20:04:45 +0200
Message-ID: <4fb292fa0605141104j6c73c1eao5a8eeea9ad1b6282@mail.gmail.com>
References: <4fb292fa0605141021r20cefaa0he592b9c713ede333@mail.gmail.com>
	 <7v3bfc33hm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 14 20:04:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfKxV-0002nB-VK
	for gcvg-git@gmane.org; Sun, 14 May 2006 20:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbWENSEr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 14:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWENSEr
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 14:04:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:15147 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751527AbWENSEq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 May 2006 14:04:46 -0400
Received: by nf-out-0910.google.com with SMTP id n29so532344nfc
        for <git@vger.kernel.org>; Sun, 14 May 2006 11:04:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MA51LFp8I23OV0REHMlKL31dG6Bar+sDxmlJxJJJOB1mxxQOmQUq/ejcEFV9ijoClSbEU3JB7V5WxHoNqgII/QWP3gC6c30IjJhIj+S4OtkCJBoZ+UZgm+JFQwPAS1vSfh4zi5eedEN7oUjVgNHov4lkKxkQYBfczd9Ihs8jZiE=
Received: by 10.49.49.14 with SMTP id b14mr1614762nfk;
        Sun, 14 May 2006 11:04:45 -0700 (PDT)
Received: by 10.49.5.5 with HTTP; Sun, 14 May 2006 11:04:45 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v3bfc33hm.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19975>

On 5/14/06, Junio C Hamano <junkio@cox.net> wrote:
> "Bertrand Jacquin" <beber.mailing@gmail.com> writes:
>
> > I'm trying to know which commit it the parent of a merge.
> > For exemple if I do that :
> >
> >   o Merge
> >  / \
> > /   \
> > |   |
> > |   o Commit D
> > |   |
> > |   o Commit C
> > |   |
> > o   | Commit B
> > \  /
> >  \/
> >  o Commit A
> >  |
> >  o Init
> >
> > How could I know that ``Commit A'' is the merge-base of ``Merge'' ?
>
> > I try to get this git-merge-base but result is strange and quiet
> > mysterious as he return me always second args I passed to.
>
> It is mysterious to me because you did not say what you gave as
> arguments ;-).

I was using git-merge-base ``merge-ish'' ``comit-ish''. Docs about it
is atrocious so was trying many but not the one good. Blam me.

> If I am reading you correctly, you already have a "Merge"
> commit, made by you or somebody else, and are trying to figure
> out where the merge base was.  If that is the case:
>
>         git-merge-base Merge^1 Merge^2
>
> in other words
>
>         git-merge-base CommitB CommitD

That's ok :)

> is what you are looking for?

Yes ! Thanks :)

> But what do you need that information for?  To reproduce
> somebody else's merge?

No, that's just on the following of git-send-mail-commit.sh thread (or
something near). To make a readable merge mail with diffstat and
summury.

-- 
Beber
#e.fr@freenode
