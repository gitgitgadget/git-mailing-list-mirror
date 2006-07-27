From: Santi <sbejar@gmail.com>
Subject: Re: [PATCH] Per branch properties for pull and fetch
Date: Thu, 27 Jul 2006 11:40:37 +0200
Message-ID: <8aa486160607270240h412b0dcek1d57eeb2b254fb2e@mail.gmail.com>
References: <87lkqfcvm2.fsf@gmail.com> <20060727085516.GC27593@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 11:40:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G62ME-0003m9-96
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 11:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbWG0Jkj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 27 Jul 2006 05:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbWG0Jkj
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 05:40:39 -0400
Received: from wx-out-0102.google.com ([66.249.82.203]:57667 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932554AbWG0Jki convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 05:40:38 -0400
Received: by wx-out-0102.google.com with SMTP id i27so1257172wxd
        for <git@vger.kernel.org>; Thu, 27 Jul 2006 02:40:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UawWjbGxXHkhY5fbz3ogEpK/KCWyM7BumtXodO4iD9Prl0Etsmzvbsr+kbcSAhRfXW/RocrOMMMgBrDsH7uDG0DhNzruwSyFWugVOgmg8WJLplrkSFT/x/cJPZwwbAv02QVbcGZqF+jDHAYeu2nSv7/xXH4dsGGzJnqRfzpFGwM=
Received: by 10.70.38.12 with SMTP id l12mr360114wxl;
        Thu, 27 Jul 2006 02:40:37 -0700 (PDT)
Received: by 10.70.19.6 with HTTP; Thu, 27 Jul 2006 02:40:37 -0700 (PDT)
To: "Martin Waitz" <tali@admingilde.org>
In-Reply-To: <20060727085516.GC27593@admingilde.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24274>

2006/7/27, Martin Waitz <tali@admingilde.org>:
> hoi :)
>
> On Thu, Jul 27, 2006 at 10:14:45AM +0200, Santi B=E9jar wrote:
> > It allows to specify on a per branch basis the following:
> > .- default repository to fetch
> > .- default branches to merge on a per repository basis
> > .- default pull.{octopus,twohead}
> >
> > So if you have this in the config:
> > [branch "my"]
> >       remote=3Dyours
> >       merge=3Dmaster
> >       merge=3Dour from theirs
> >       merge=3Dmine from .
>
> could we default the to-be-merged branch to "remotes/$remote/$branch"=
 if
> that exists?. That could make life a lot easier when using
> clone --use-separate-remote.

I would prefer to change git-clone and git-branch to write the full
config. And I'll do this if this or someting like this is accepted.

  Santi
