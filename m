From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: git --version
Date: Wed, 31 May 2006 21:30:51 +0200
Message-ID: <4d8e3fd30605311230h53981e57x8a417b176bedba86@mail.gmail.com>
References: <4d8e3fd30605301516l782ad81dk5b11074e88db90a4@mail.gmail.com>
	 <7vu077ywmw.fsf@assigned-by-dhcp.cox.net>
	 <4d8e3fd30605311158n9d669dgd6c392ee8d194b78@mail.gmail.com>
	 <7vac8yypxc.fsf@assigned-by-dhcp.cox.net>
	 <4d8e3fd30605311213m6f2f2660u90701ad6bd5daabc@mail.gmail.com>
	 <4d8e3fd30605311220t17d319efyd5234dd4eb74fc96@mail.gmail.com>
	 <Pine.LNX.4.64.0605311224360.24646@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 31 21:31:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlWP9-0001u5-Pn
	for gcvg-git@gmane.org; Wed, 31 May 2006 21:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbWEaTax (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 15:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965122AbWEaTaw
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 15:30:52 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:31794 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965121AbWEaTaw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 15:30:52 -0400
Received: by wr-out-0506.google.com with SMTP id i5so97641wra
        for <git@vger.kernel.org>; Wed, 31 May 2006 12:30:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kG+ph8/IL/6ay1MbtgTIQEocbn5B+UD6KPAjinUhXIkTiVGx/JJzaHUxOfwdUGgbKLwRGnHZQOt3fGe/6h5/3UcaLsRlX+pId38ha12qk7Brjm+AxKDKmUxw9Ru1OP7GrX8gBCC2Q6IRWMWqsjYUeDnZRNym5tUURnYPexGxxDw=
Received: by 10.65.215.12 with SMTP id s12mr703932qbq;
        Wed, 31 May 2006 12:30:51 -0700 (PDT)
Received: by 10.64.250.4 with HTTP; Wed, 31 May 2006 12:30:51 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605311224360.24646@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21082>

On 5/31/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Wed, 31 May 2006, Paolo Ciarrocchi wrote:
> >
> > Tried with:
> > make clean
> > make && sudo make install
> > [...]
> > paolo@Italia:~/git$ git --version
> > git version 1.3.GIT
> > paolo@Italia:~/git$ ./GIT-VERSION-GEN
> > GIT_VERSION = 1.3.3.g2186
>
> What does
>
>         git describe

paolo@Italia:~/git$ git describe
v1.3.3-g2186d56

>         ./git --version

paolo@Italia:~/git$ ./git --version
git version 1.3.3.g2186

Doh..

>         which git

paolo@Italia:~/git$ which git
/home/paolo/bin/git

Ciao,
-- 
Paolo
http://paolociarrocchi.googlepages.com
