From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: git --version
Date: Wed, 31 May 2006 21:26:39 +0200
Message-ID: <4d8e3fd30605311226p4a0efab5qcebe102e03d458b6@mail.gmail.com>
References: <4d8e3fd30605301516l782ad81dk5b11074e88db90a4@mail.gmail.com>
	 <7vu077ywmw.fsf@assigned-by-dhcp.cox.net>
	 <4d8e3fd30605311158n9d669dgd6c392ee8d194b78@mail.gmail.com>
	 <7vac8yypxc.fsf@assigned-by-dhcp.cox.net>
	 <4d8e3fd30605311213m6f2f2660u90701ad6bd5daabc@mail.gmail.com>
	 <Pine.LNX.4.64.0605311222010.24646@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 31 21:26:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlWL8-0001Gh-DM
	for gcvg-git@gmane.org; Wed, 31 May 2006 21:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbWEaT0l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 15:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbWEaT0l
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 15:26:41 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:302 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965116AbWEaT0k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 15:26:40 -0400
Received: by wr-out-0506.google.com with SMTP id i12so92881wra
        for <git@vger.kernel.org>; Wed, 31 May 2006 12:26:40 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bIJkIMRzGlKGDQGpG9t8IG5toKN1gKqHkdkLesRpsOJLsqHEZdVgeYosAAcMm5Q/7KeahCpNknDDjRxlbDs5uh0YJIWgfOgeW+NcUXW+Udr3LlVYeVA7Fc0kkpvajN6Ef5iE7UhY3xPxttvENpI5QB7uhYT0UWcEF6NyFGabQtc=
Received: by 10.65.250.8 with SMTP id c8mr682272qbs;
        Wed, 31 May 2006 12:26:39 -0700 (PDT)
Received: by 10.64.250.4 with HTTP; Wed, 31 May 2006 12:26:39 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605311222010.24646@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21081>

On 5/31/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Wed, 31 May 2006, Paolo Ciarrocchi wrote:
> > [...]
> > install git gitk '/home/paolo/bin'
>
> Why are you doing a "sudo" when you install in your own ~/bin (the default
> for git).

Good question :-)
Just because I'm used to do that but you are absolutelly right saying
that is wrong.

> The whole point of installing in ~/bin is to not need any elevated
> priorities.
>
> I get the feeling that you might have installed something in /usr/bin/ or
> /usr/local/bin earlier, and that they are before ~/bin in your PATH.

I don't think so since:
paolo@Italia:~/git$ which git
/home/paolo/bin/git

But I'll do a make && make install in a minute.

Thanks!

Ciao,
-- 
Paolo
http://paolociarrocchi.googlepages.com
