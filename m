From: Santi <sbejar@gmail.com>
Subject: Re: [PATCH] Per branch properties for pull and fetch
Date: Thu, 27 Jul 2006 12:06:34 +0200
Message-ID: <8aa486160607270306s3f49a01cq91ef61e2c9f005e@mail.gmail.com>
References: <87lkqfcvm2.fsf@gmail.com> <20060727085516.GC27593@admingilde.org>
	 <8aa486160607270240h412b0dcek1d57eeb2b254fb2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 12:06:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G62lN-0000iv-Km
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 12:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWG0KGi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 27 Jul 2006 06:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWG0KGi
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 06:06:38 -0400
Received: from wx-out-0102.google.com ([66.249.82.197]:47173 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932106AbWG0KGh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 06:06:37 -0400
Received: by wx-out-0102.google.com with SMTP id i27so1260463wxd
        for <git@vger.kernel.org>; Thu, 27 Jul 2006 03:06:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uR/uNb/Jln4QuxY/sFpOc/c8ttggBYbFJv1uBW7lgve8NqlRPRsiX99aD7xGRKF+TQiikeZWl4+mYPsKeS+tuV6jG9lLObK5GUWrkaI1jzV8YtJdSNvbRzU1XRsiuk4sKYpxXs59YDbI5sbojMZWRNBl5D99VJwzZ7UzPzcb3V4=
Received: by 10.70.38.12 with SMTP id l12mr383126wxl;
        Thu, 27 Jul 2006 03:06:37 -0700 (PDT)
Received: by 10.70.19.6 with HTTP; Thu, 27 Jul 2006 03:06:34 -0700 (PDT)
To: "Martin Waitz" <tali@admingilde.org>
In-Reply-To: <8aa486160607270240h412b0dcek1d57eeb2b254fb2e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24276>

2006/7/27, Santi <sbejar@gmail.com>:
> 2006/7/27, Martin Waitz <tali@admingilde.org>:
> > hoi :)
> >
> > On Thu, Jul 27, 2006 at 10:14:45AM +0200, Santi B=E9jar wrote:
> > > It allows to specify on a per branch basis the following:
> > > .- default repository to fetch
> > > .- default branches to merge on a per repository basis
> > > .- default pull.{octopus,twohead}
> > >
> > > So if you have this in the config:
> > > [branch "my"]
> > >       remote=3Dyours
> > >       merge=3Dmaster
> > >       merge=3Dour from theirs
> > >       merge=3Dmine from .
> >
> > could we default the to-be-merged branch to "remotes/$remote/$branc=
h" if
> > that exists?. That could make life a lot easier when using
> > clone --use-separate-remote.
>
> I would prefer to change git-clone and git-branch to write the full
> config. And I'll do this if this or someting like this is accepted.
>

On the other hand, my patch changes the behaviour only when explicitly
configured, and your proposed default would change the behaviour even
without changes to the config.

Santi
