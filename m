From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Add git-submodule command
Date: Fri, 25 May 2007 16:52:27 +0200
Message-ID: <8c5c35580705250752k2021f02dv804d87da5c0d5da7@mail.gmail.com>
References: <11800866643203-git-send-email-hjemli@gmail.com>
	 <Pine.LNX.4.64.0705251157450.4648@racer.site>
	 <8c5c35580705250646h12f4f30bt301f4c4bdc2ad530@mail.gmail.com>
	 <Pine.LNX.4.64.0705251451530.4648@racer.site>
	 <8c5c35580705250716j27695a01kd1db222be6c7eac7@mail.gmail.com>
	 <Pine.LNX.4.64.0705251539260.4648@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 25 16:52:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrb9e-0002Vd-KV
	for gcvg-git@gmane.org; Fri, 25 May 2007 16:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491AbXEYOw3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 10:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757718AbXEYOw3
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 10:52:29 -0400
Received: from nz-out-0506.google.com ([64.233.162.230]:28963 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333AbXEYOw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 10:52:28 -0400
Received: by nz-out-0506.google.com with SMTP id n1so352844nzf
        for <git@vger.kernel.org>; Fri, 25 May 2007 07:52:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V7Z/Jn1D1j2z0IQw3MTa0Un4/tB2GtmVML2gnE8aViMgmTdP0opu238OAPUDQefR2Bg1uYIX9zJzdC3YD3rxkeB4mRC2Bvy+d2IowXsFt/Ha4SyO3di3Y9iYE/2xqGIaSV+xGWnhodVrOIwgaev3Z4j8SHpk2R7Pw2eeimoKCfw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BwxYRzO7iNoudzp4/WSS3EsYt2QZGmW5hsbX4sKJCnTeaRt0rhBS30ZPpXsEs3BFMS9v39LeEEmBgrz/ayjr03zZJ6E/cxtX4lRO6uAQ9FLq8LiiCuh+Bq1DwsJb+o9i/iIbBmSHSvw89N/iqK51RTIwL3Z1q+v7lu1BOS+hauI=
Received: by 10.114.79.1 with SMTP id c1mr1521654wab.1180104747402;
        Fri, 25 May 2007 07:52:27 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Fri, 25 May 2007 07:52:27 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0705251539260.4648@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48387>

On 5/25/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 25 May 2007, Lars Hjemli wrote:
>
> > On 5/25/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > On Fri, 25 May 2007, Lars Hjemli wrote:
> > > > On 5/25/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > >
> > > > > All in all, I like it: it is short, to the point, and it should do
> > > > > the job (maybe with a few enhancements like "--update" without
> > > > > arguments means _all_ submodules).
> > > >
> > > > Well, it does (or should) update all initialized submodules, but
> > > > maybe that's not what you meant?
> > >
> > > Oops. I meant "init".
> >
> > Hmm, it does (or should) clone all submodules if you run 'git submodule
> > --init' (no paths specified). Did it fail for you?
>
> I don't have any superproject to try with ;-)

You could always try cgit ;-)

>
> Actually, I missed the "$@" in modules_init. You might want to change the
> documentation, though, since it suggests (at least to yours truly) that
> you _need_ to pass a path with "--init".

Ok, will do.

--
larsh
