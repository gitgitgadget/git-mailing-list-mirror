From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: Help with a tcl/tk gui thing..
Date: Wed, 1 Oct 2008 23:03:50 +0200
Message-ID: <237967ef0810011403i2b18255and988df29a71798bf@mail.gmail.com>
References: <alpine.LFD.2.00.0810011240390.3575@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 23:06:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl8sZ-0005Kw-RW
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 23:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbYJAVDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 17:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752619AbYJAVDx
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 17:03:53 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:2097 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbYJAVDw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 17:03:52 -0400
Received: by ey-out-2122.google.com with SMTP id 6so270494eyi.37
        for <git@vger.kernel.org>; Wed, 01 Oct 2008 14:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=iBe3bivuCPWmPqRKPJhRsnRSUaN28huuDiEBF/z+X5w=;
        b=jb7iE+9aKRRY7eW2JNXtU/whdTfqpiFOfG+hc9h6PyZoZnnKTd1hPfGUOt6sS7/h1e
         umzI4z3DqH4y7AucCLVNZjPSLRSDKcYEQe0tP8B1ihe/LqECi95+rAnXlKK+6uHsXtoU
         ZfCjlzLTwbrRV/pFb1ANWHAfJu7WTxBbE8ktw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=PmXdXLxdo7qB+Ahidlvf1lbnQfqiOcgry70hCl6W0Or2UbDqUp4nFOp2r+afcb6KGf
         T3AmMlkarPwE3ry3rOiVgl5dOAoE5KZ5nMdgZiJrk2FxkT9MHPOLhW4U+ep0qurUchgM
         Ero3I8nHHVn97oTi1Q6gK0N9prJk6G2Kvn5sY=
Received: by 10.210.124.15 with SMTP id w15mr10252478ebc.143.1222895030065;
        Wed, 01 Oct 2008 14:03:50 -0700 (PDT)
Received: by 10.210.19.20 with HTTP; Wed, 1 Oct 2008 14:03:50 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0810011240390.3575@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97268>

How's this?

git clone git://mika.l3ib.org/tracker.git

I wrote it in pygtk since I know zero to no tcl/tk, hope that's okay.
It has a label with the time remaining (simply read from the daemon file),
and shows the text in red if less than 10% is remaining. You'll need to
change the ./ in cb_function to /var/log/tracker since I forgot to change
that and I'm lazy :).

2008/10/1 Linus Torvalds <torvalds@linux-foundation.org>:
>
> Ok, this is ridiculous, and has nothing to do with git apart from being
> hosted in it, but I thought I'd send out an email about it since the git
> community is the only one I know that does any GUI work at all...
>
> I've got three girls, all wasting their time on their computer, and we set
> up this rule that they get to have a maximum of an hour of internet time
> each day. Of course, being the geek I am, I wrote a stupid time tracker
> for that purpose, and then totally forgot about it.
>
> Until the harddisk in their computer broke down, and I had to re-install,
> and realized that I didn't have a copy of my stupid tracker sources
> anywhere. So I had to re-write it, and to make sure that I didn't lose it
> _again_, I put it in a git repo this time, and now have it on my desktop
> machine.
>
> I _also_ have it on kernel.org, because I tend to change machines often
> enough that files get lost because I decide that switching machines is
> also a great way of doing "generational GC" on my home directory.
>
> [ iow, I copy my old home directory as "old-home" when I switch machines,
>  and anything I didn't end up copying by the time I switch machines
>  again, just gets deleted. Very neat, and a great way to lose things that
>  you only care about every other year or so. ]
>
> Whatever.
>
> To make a long story short, I have a very small program that does all the
> tracking, and I have no problems with that. It doesn't have much of a
> admin interface, but I can do "echo 3600 > /var/log/tracker/celeste" to
> reset the time etc. _I_ have no need for pretty GUI's.
>
> But I also have a UI that the kids can run to _see_ how much time they
> have left, so that getting thrown off the machine doesn't come as a total
> surprise. And yesterday Patricia asked why it has to be that ugly. And I
> had to admit that her dad is just not very good at UI's - and my
> re-implementation may in fact have been EVEN UGLIER than my original
> version. If that is even possible.
>
> But hey, I'm not above impressing my kids with pretty bling if I can get
> somebody else who actually knows what they are doing to enhance my wish
> scripts to something reasonable.
>
> Anybody?
>
> The repository is at
>
>        git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/tracker.git
>
> if somebody knows how to make the text turn red when the end is near
> and/or make it have some nice graphical bar that fills up as time is about
> to expire.
>
> And if nobody does, no worries. At least I tried. My kids can continue to
> watch ugly/small/monochrome fonts with just a count-down clock.
>
>                        Linus
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Mikael Magnusson
