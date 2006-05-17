From: "Stefan Pfetzing" <stefan.pfetzing@gmail.com>
Subject: Re: Git 1.3.2 on Solaris
Date: Wed, 17 May 2006 11:06:34 +0200
Message-ID: <f3d7535d0605170206y76e24f25w305a688d32f4a0a1@mail.gmail.com>
References: <f3d7535d0605161652n3b2ec033r874336082755e728@mail.gmail.com>
	 <7vpsidhx79.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed May 17 11:06:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgHzN-0004Up-0u
	for gcvg-git@gmane.org; Wed, 17 May 2006 11:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWEQJGh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 05:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWEQJGh
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 05:06:37 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:6276 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750908AbWEQJGg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 05:06:36 -0400
Received: by wr-out-0506.google.com with SMTP id 36so162663wra
        for <git@vger.kernel.org>; Wed, 17 May 2006 02:06:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AMxnjflldYCxDsiu9VjRP8Hj65aGB3cPkR7kvWP9kIdldu7WcCkRXjdlw314Ft4bVzwW/5uGlqQ5pCtPCXI71Iziq/+K0Xvwo4Bt6ttV9JCLTwro19tA8dDi6E5vJDj34HwIyk/dLMyq0FYJs4N11OmB5Cph90FJe4XzHtAu6ME=
Received: by 10.65.138.2 with SMTP id q2mr816873qbn;
        Wed, 17 May 2006 02:06:35 -0700 (PDT)
Received: by 10.65.20.19 with HTTP; Wed, 17 May 2006 02:06:34 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
In-Reply-To: <7vpsidhx79.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20175>

Hi Junio,

2006/5/17, Junio C Hamano <junkio@cox.net>:
> "Stefan Pfetzing" <stefan.pfetzing@gmail.com> writes:
>
> > 1.  fix every single shellscript automatically during the build phase
> > 2.  setup a dir which contains symlinks to the "right" binaries and
> > put that dir into PATH.
>
> You forgot 3.
>
>   3.  rewrite scripts so that they would require only POSIX;
>       for ones that do need GNU extended coreutils to do in
>       shell, find other ways, perhaps rewriting the stuff in C.

Yes, thats right, but this can only be a long term goal, because I guess
this will take significantly longer. - even "tr" and "diff" behave different
on Solaris.

> I am not looking forward to do the g- prefix in the main
> Makefile.  The approach to have symlink forest under gitexecdir
> (<Pine.LNX.4.64.0605162047380.10823@g5.osdl.org> by Linus) is
> more palatable, and I am not opposed to host a script to do so
> under contrib/notgnu perhaps.

Hm, gitexecdir is also the path where git is installed, right? So if I'd
install git with pkgsrc it will be /usr/pkg/bin, right? - If so,
putting symlinks
there _will_ break pkgsrc.

bye

Stefan
-- 
       http://www.dreamind.de/
Oroborus and Debian GNU/Linux Developer.
