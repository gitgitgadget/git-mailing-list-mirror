From: "Stefan Pfetzing" <stefan.pfetzing@gmail.com>
Subject: Re: Git 1.3.2 on Solaris
Date: Wed, 17 May 2006 10:05:39 +0200
Message-ID: <f3d7535d0605170105j2a6942cfh5a5a8a0d6153046f@mail.gmail.com>
References: <4973.1147836384@lotus.CS.Berkeley.EDU>
	 <Pine.LNX.4.64.0605162047380.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed May 17 10:05:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgH2R-0003TJ-N7
	for gcvg-git@gmane.org; Wed, 17 May 2006 10:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWEQIFl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 04:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWEQIFl
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 04:05:41 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:37960 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932467AbWEQIFk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 04:05:40 -0400
Received: by wr-out-0506.google.com with SMTP id i11so165950wra
        for <git@vger.kernel.org>; Wed, 17 May 2006 01:05:40 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dq+EeY8N0LHgrQk8M/MBDNCXw7nf7lGynqfsd2Rw7yeWKQM5PxXN/hC3eS/oFTFP85dwSE3jqRWfz05m8N4+4rC7PHKYkiNiXgY9Mdp1/XsH96A+8QiruRXx8isgRI+1yl55Zw6vrevF1nB/xPS+LUOXUzsYWK7vOxAGQRodl6Q=
Received: by 10.65.73.20 with SMTP id a20mr809063qbl;
        Wed, 17 May 2006 01:05:39 -0700 (PDT)
Received: by 10.65.20.19 with HTTP; Wed, 17 May 2006 01:05:39 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605162047380.10823@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20166>

Hi Linus,

2006/5/17, Linus Torvalds <torvalds@osdl.org>:
>
> On Tue, 16 May 2006, Jason Riedy wrote:
> >
> > But for recommending and using git on these systems _now_...
>
> Yes. For that, I would literally suggest having people install the GNU
> tools (and/or a recent enough perl) somewhere early in the path.
>
> If you use the git wrapper, for example, you can already depend on the
> fact that it will prepend the git installation directory to the path, so
> while the GNU tools might not _normally_ be on the path, if you put them
> in the same directory as your git install, you'll automatically get them
> as long as you use the "git cmd" format (rather than the "git-cmd"
> format).

Well I guess for my pkgsrc environment this won't work.
I already (quite some time ago) tried to have gnu coreutils, findutils and
diffutils installed without the g prefix.
This broke several things on NetBSD and on Solaris.

So I'd prefer a solution where one could set one flag for the Makefile of git,
and git would check for the g prefix, create somewhere a directory with
symlinks to the "real" gnu binaries and put it into $PATH upon startup of
every git c-program or shellscript.

I suggest having these gnu "tools" dependancies removed can only be a long
term goal.

bye

dreamind

P.S.: I had to re-sent this mail, somehow gmail did put html crap into it.
--
       http://www.dreamind.de/
Oroborus and Debian GNU/Linux Developer.
