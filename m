From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-cvsserver wart?
Date: Fri, 26 May 2006 15:23:22 +1200
Message-ID: <46a038f90605252023v5ff3fd65l9a991b3bbfa0a024@mail.gmail.com>
References: <dcedf5e20605250942g6a7417dfh5f2f26df29842def@mail.gmail.com>
	 <46a038f90605251419kd45fbj419565eabdd63182@mail.gmail.com>
	 <dcedf5e20605252011v6738dc9dg3d4801144d3e9898@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 26 05:23:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjSv8-0007dF-QN
	for gcvg-git@gmane.org; Fri, 26 May 2006 05:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbWEZDXX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 23:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbWEZDXX
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 23:23:23 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:14122 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030258AbWEZDXX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 23:23:23 -0400
Received: by wr-out-0506.google.com with SMTP id i7so297115wra
        for <git@vger.kernel.org>; Thu, 25 May 2006 20:23:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tqJ05Po40VcM08uYB/I/lFn/H6Kxwt16fhr63foUvOFz9IcSbhWh08nuduu9n7VLj2uxOR943sHJ0Vu1hXFUFkELS2Elzq7kFm0CKkmq9irMAaEKQkGEsaJ69fRyaRJ7+MNNnfOGJtJyXESCXNN5q4VKAdeOqXnA+9m+FLx5GFc=
Received: by 10.54.101.13 with SMTP id y13mr69084wrb;
        Thu, 25 May 2006 20:23:22 -0700 (PDT)
Received: by 10.54.127.12 with HTTP; Thu, 25 May 2006 20:23:22 -0700 (PDT)
To: "Cameron McBride" <cameron.mcbride@gmail.com>
In-Reply-To: <dcedf5e20605252011v6738dc9dg3d4801144d3e9898@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20785>

On 5/26/06, Cameron McBride <cameron.mcbride@gmail.com> wrote:
> sorry, my bad. This error was discovered using the git stable, v1.3.3.
>  Grabbing the latest at git://git.kernel.org/pub/scm/git/git.git
> showed the same problem.

Ok. You might want to retain that latest, it has some further fixes ;-)

> > If that doesn't fix it, can you post the logs? I think you have to
> > declare CVS_LOG=/tmp/cvslog or somesuch.
>
> I'm assuming you mean the log from git-cvsserver (set via git/config
> with logfile=...)

I was actually thinking of setting the environment at the client end:
CVS_CLIENT_LOG,
http://cvsbook.red-bean.com/cvsbook.html#$CVS_CLIENT_LOG but it looks
like you've got it mostly sorted.

> Besides the log cutoff in the broken attempt, it appears the culprit
> is a lack of arguments being passed down as that is the only
> difference in the logs.

Yes, I was guessing as much. I am still curious about what parameters
(and in what order) cvs 1.11.7 sends...

> To quiet it down and get it to run - a crude hack seemed to work

It looks reasonable as a means to shut it up, but perhaps if we can
figure out what the client is telling us... ;-)


martin
