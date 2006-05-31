From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: git --version
Date: Wed, 31 May 2006 21:49:13 +0200
Message-ID: <4d8e3fd30605311249l6ba4ff74l72778ffe60462263@mail.gmail.com>
References: <4d8e3fd30605301516l782ad81dk5b11074e88db90a4@mail.gmail.com>
	 <7vu077ywmw.fsf@assigned-by-dhcp.cox.net>
	 <4d8e3fd30605311158n9d669dgd6c392ee8d194b78@mail.gmail.com>
	 <7vac8yypxc.fsf@assigned-by-dhcp.cox.net>
	 <4d8e3fd30605311213m6f2f2660u90701ad6bd5daabc@mail.gmail.com>
	 <4d8e3fd30605311220t17d319efyd5234dd4eb74fc96@mail.gmail.com>
	 <Pine.LNX.4.64.0605311224360.24646@g5.osdl.org>
	 <4d8e3fd30605311230h53981e57x8a417b176bedba86@mail.gmail.com>
	 <Pine.LNX.4.64.0605311233030.24646@g5.osdl.org>
	 <4d8e3fd30605311243q5a93a7a9l827c55827817602f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 31 21:50:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlWgw-0005LK-6Q
	for gcvg-git@gmane.org; Wed, 31 May 2006 21:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbWEaTtO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 15:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbWEaTtO
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 15:49:14 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:60741 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751775AbWEaTtN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 15:49:13 -0400
Received: by wr-out-0506.google.com with SMTP id i5so101339wra
        for <git@vger.kernel.org>; Wed, 31 May 2006 12:49:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=udyS44YXk2DzwUoSu9dz//5n1TozIesAxBDYrh66MzPh20JP1RFY3U1XgW5O8U8QsEKwr9klKgNeRGAv17PmYJlJXabJU4tR/xz5gsyqYKSvY2H2aOq/sLWw1+s7JY3HTxpFyP9Bv4/vd6yZsedZSQu33feqxuvOFJwvnWIHcXo=
Received: by 10.65.237.10 with SMTP id o10mr732405qbr;
        Wed, 31 May 2006 12:49:13 -0700 (PDT)
Received: by 10.64.250.4 with HTTP; Wed, 31 May 2006 12:49:13 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <4d8e3fd30605311243q5a93a7a9l827c55827817602f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21087>

On 5/31/06, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> On 5/31/06, Linus Torvalds <torvalds@osdl.org> wrote:
> > On Wed, 31 May 2006, Paolo Ciarrocchi wrote:
> > > >
> > > >         git describe
> > >
> > > paolo@Italia:~/git$ git describe
> > > v1.3.3-g2186d56
> >
> > Ok.
> >
> > > >         ./git --version
> > >
> > > paolo@Italia:~/git$ ./git --version
> > > git version 1.3.3.g2186
> > >
> > > Doh..
> >
> > Ok, that's also good.
> >
> > > >         which git
> > >
> > > paolo@Italia:~/git$ which git
> > > /home/paolo/bin/git
> >
> > I think I know what's up.
> >
> > Your "sudo" made "$HOME" be /root. So by doing "sudo make install", you
> > installed the git in _roots_ ~/bin, ie /root/bin/.
> >
>
> Doh... not sure to follow you, just did:
> sudo make install
> paolo@Italia:~/git$ ls /root/
> paolo@Italia:~/git$ git --version
> git version 1.3.GIT

And even more intersting:
make clean && make && sudo make install
git --version
git version 1.3.GIT

make install
[...]
mv git-cherry-pick+ git-cherry-pick
mv: sovrascrivo `git-cherry-pick' ignorando il modo 0755?
that in english is something like:
mv: overwrite `git-cherry-pick' ignoring mod 0755?

Wow...of course, make clean && make install fix everything

Ciao,

-- 
Paolo
http://paolociarrocchi.googlepages.com
