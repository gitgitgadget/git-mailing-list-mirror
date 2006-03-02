From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 2 Mar 2006 17:20:33 +0100
Message-ID: <81b0412b0603020820j4b71057ay8e7c1e168d5cc4@mail.gmail.com>
References: <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com>
	 <43FD84EB.3040704@op5.se>
	 <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com>
	 <43FDB8CC.5000503@op5.se>
	 <81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com>
	 <20060226195552.GA30735@trixie.casa.cgf.cx>
	 <Pine.LNX.4.64.0602261217080.22647@g5.osdl.org>
	 <20060226204027.GC30735@trixie.casa.cgf.cx>
	 <81b0412b0603020618q3b205cdeuabc7e204044cca5b@mail.gmail.com>
	 <20060302152219.GG2781@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 17:21:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEqXf-0007Jb-FG
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 17:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbWCBQUg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 11:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbWCBQUg
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 11:20:36 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:49779 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751986AbWCBQUf convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 11:20:35 -0500
Received: by nproxy.gmail.com with SMTP id h2so305481nfe
        for <git@vger.kernel.org>; Thu, 02 Mar 2006 08:20:34 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iuDEMrKw7nr5vmqpKw45PJ3dkdF3IuhRBB7aMQ3SiiY2y8FIcIw6bCofGre4Vo3SkbGRwzdL/TDjh81hts5wNbMK88KIbqTY+lCizLIk2cjP9E641UxDzPWQPl73KC63259VHARa7nnQ3pRTX+5F0XsLZJG86yceFISg3fa9pBs=
Received: by 10.48.207.2 with SMTP id e2mr722288nfg;
        Thu, 02 Mar 2006 08:20:33 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Thu, 2 Mar 2006 08:20:33 -0800 (PST)
To: "Christopher Faylor" <me@cgf.cx>
In-Reply-To: <20060302152219.GG2781@trixie.casa.cgf.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17089>

On 3/2/06, Christopher Faylor <me@cgf.cx> wrote:
> >> The cygwin/windows version of spawn is basically like an extended version
> >> of exec*():
> >>
> >> pid = spawnlp (P_NOWAIT, "/bin/ls", "ls", "-l", NULL);
> >>
> >
> >By the way, is argv worked around?
> >AFAIK, windows has only one argument, returned by GetCommandLine?
>
> Cygwin passes an argv list between cygwin processes and a quoted command
> line to pure windows processes.

What for? They can't use it anyway.

$ notepad '"abc"'
