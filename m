From: "Stefan Pfetzing" <stefan.pfetzing@gmail.com>
Subject: Re: Git 1.3.2 on Solaris
Date: Wed, 17 May 2006 17:08:48 +0200
Message-ID: <f3d7535d0605170808l21d9f6d0gff1afaa10db17af9@mail.gmail.com>
References: <4973.1147836384@lotus.CS.Berkeley.EDU>
	 <Pine.LNX.4.64.0605162047380.10823@g5.osdl.org>
	 <f3d7535d0605170105j2a6942cfh5a5a8a0d6153046f@mail.gmail.com>
	 <Pine.LNX.4.64.0605170728520.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed May 17 17:13:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgNdv-00077j-DA
	for gcvg-git@gmane.org; Wed, 17 May 2006 17:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWEQPIv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 11:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWEQPIt
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 11:08:49 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:14892 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750958AbWEQPIs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 11:08:48 -0400
Received: by wr-out-0506.google.com with SMTP id i11so237718wra
        for <git@vger.kernel.org>; Wed, 17 May 2006 08:08:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cn5/3sbopBwu7PDRmWIpDxH1ha5k+L6Tpi14J4mxqZj4F+N1+Ots2kLjB+bOKvsKVJInOPNVkozNwz8PozzniRv4d7J0s+FxZSUQT5YSS8Frmp3/eFlJoj/hhjoysc5yN/arNAqTkMc+gira7Tpf1GdHcBkCz1NliDR4kGQJOfU=
Received: by 10.65.188.2 with SMTP id q2mr1219315qbp;
        Wed, 17 May 2006 08:08:48 -0700 (PDT)
Received: by 10.65.20.19 with HTTP; Wed, 17 May 2006 08:08:48 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605170728520.10823@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20206>

Hi Linus,

2006/5/17, Linus Torvalds <torvalds@osdl.org>:
>
> So let me just quote the thing you quoted but apparently didn't read:

[snip]

I did read that.

> There already _is_ such a directory. It's your "prefix=" directory plus
> "bin".
>
> So what you can do is make sure you compile with
>
>         make prefix=/my/git/installation/prefix
>
> and then install the GNU tools in /my/git/installation/prefix/bin, and
> you're all set.

Ok, if I would do so, my prefix would be /usr/pkg, and the bindir would be
/usr/pkg/bin. So I would need to have an xargs and so on symlink in
/usr/pkg/bin.
But this is simply not acceptable, because it breaks other NetBSD
pkgsrc scripts.

Besides that, installing git to a different location is not an option
for me, because
I want to have git packaged by pkgsrc.

I suggest Junio's solution will work (gitexecdir) but I have to try
that later today.

> At most you might have to make some of the tests use "git xyzzy" instead
> of "git-xyzzy", and run "make install" before "make test".
>
> It wouldn't be wonderful, but hey, I've given alternatives (like using the
> GNU tools by default, or helping make git more portable in the first
> place). So it's a hack.

Yes I know, as far as I can, I'm willing to help with this.

bye

dreamind

-- 
       http://www.dreamind.de/
Oroborus and Debian GNU/Linux Developer.
