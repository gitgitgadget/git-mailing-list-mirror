From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: git --version
Date: Wed, 31 May 2006 21:32:59 +0200
Message-ID: <4d8e3fd30605311232m3025aae7l9376f8a959d33921@mail.gmail.com>
References: <4d8e3fd30605301516l782ad81dk5b11074e88db90a4@mail.gmail.com>
	 <7vu077ywmw.fsf@assigned-by-dhcp.cox.net>
	 <4d8e3fd30605311158n9d669dgd6c392ee8d194b78@mail.gmail.com>
	 <7vac8yypxc.fsf@assigned-by-dhcp.cox.net>
	 <4d8e3fd30605311213m6f2f2660u90701ad6bd5daabc@mail.gmail.com>
	 <4d8e3fd30605311220t17d319efyd5234dd4eb74fc96@mail.gmail.com>
	 <Pine.LNX.4.64.0605311224360.24646@g5.osdl.org>
	 <4d8e3fd30605311230h53981e57x8a417b176bedba86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 31 21:33:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlWRU-0002IB-6g
	for gcvg-git@gmane.org; Wed, 31 May 2006 21:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbWEaTdK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 15:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbWEaTdJ
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 15:33:09 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:45620 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965125AbWEaTdA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 15:33:00 -0400
Received: by wr-out-0506.google.com with SMTP id 50so101944wri
        for <git@vger.kernel.org>; Wed, 31 May 2006 12:32:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FdmBarQMLKl+VN6qZbEUWX0G4S+eTe19fbZXaZLdF/22Cm/1H5MGBrL5zWdUPSmnLPAGnmETwm4NZwWU5ufYUEYg5fMtbaThCho9VJ39NndmJoGJmvkN/a1EtruhycFLy0/HrwfpafJwjp9CpiLbgWBNWy3av+O2US7Iv9HV7Lw=
Received: by 10.64.125.17 with SMTP id x17mr204087qbc;
        Wed, 31 May 2006 12:32:59 -0700 (PDT)
Received: by 10.64.250.4 with HTTP; Wed, 31 May 2006 12:32:59 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <4d8e3fd30605311230h53981e57x8a417b176bedba86@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21083>

On 5/31/06, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> On 5/31/06, Linus Torvalds <torvalds@osdl.org> wrote:
> >
> >
> > On Wed, 31 May 2006, Paolo Ciarrocchi wrote:
> > >
> > > Tried with:
> > > make clean
> > > make && sudo make install
> > > [...]
> > > paolo@Italia:~/git$ git --version
> > > git version 1.3.GIT
> > > paolo@Italia:~/git$ ./GIT-VERSION-GEN
> > > GIT_VERSION = 1.3.3.g2186
> >
> > What does
> >
> >         git describe
>
> paolo@Italia:~/git$ git describe
> v1.3.3-g2186d56
>
> >         ./git --version
>
> paolo@Italia:~/git$ ./git --version
> git version 1.3.3.g2186
>
> Doh..
>
> >         which git
>
> paolo@Italia:~/git$ which git
> /home/paolo/bin/git
>

Ok...
make && make install

Now I get:
paolo@Italia:~$ git --version
git version 1.3.3.g2186

That is correct.

But I'm still wondering why doing sudo make install caused that
problem, git was correcly installed in /home/paolo/git

Really puzzled.

Ciao,

-- 
Paolo
http://paolociarrocchi.googlepages.com
