From: "Shyamal Sadanshio" <shyamal.sadanshio@gmail.com>
Subject: Re: GIT Error issue
Date: Thu, 20 Apr 2006 20:32:46 +0530
Message-ID: <3857255c0604200802h43582fa5w5bd6093a90ab4b31@mail.gmail.com>
References: <3857255c0604190416j62abeae8va164896c5100f6ee@mail.gmail.com>
	 <20060419112135.GA24807@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 17:03:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWagY-0007Gw-86
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 17:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWDTPCu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 11:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbWDTPCu
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 11:02:50 -0400
Received: from pproxy.gmail.com ([64.233.166.178]:59152 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750969AbWDTPCt convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 11:02:49 -0400
Received: by pproxy.gmail.com with SMTP id i49so223369pye
        for <git@vger.kernel.org>; Thu, 20 Apr 2006 08:02:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K2zuwXd0rw389k3j6jPGdLbOckRLNDMg4Vr6XDcMxskEKNm3byoNisLj1gHKfiVbo4QfxN5ZyqU9atY3V9SMeCVi5aZZUsFbYse0++bFcAdgdMsPxEXrj59vDQ+fkV59zfZSIXIdlZvmBxCMTPqy7g/QV6Pcb7r0CLIzm43xz5k=
Received: by 10.35.91.10 with SMTP id t10mr988363pyl;
        Thu, 20 Apr 2006 08:02:46 -0700 (PDT)
Received: by 10.35.60.20 with HTTP; Thu, 20 Apr 2006 08:02:46 -0700 (PDT)
To: "Erik Mouw" <erik@harddisk-recovery.com>
In-Reply-To: <20060419112135.GA24807@harddisk-recovery.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18974>

Hi,

Yes, I had installed a wrong GIT.
Thanks it worked now!
However, with a http protocol instead of git and rsync because of
firewall issue, I guess!

Thanks and Regards,
Shyamal

On 4/19/06, Erik Mouw <erik@harddisk-recovery.com> wrote:
> On Wed, Apr 19, 2006 at 04:46:57PM +0530, Shyamal Sadanshio wrote:
> > I am newbie to GIT and facing some problem with the GIT usage. I am
> > trying to clone a repository at www.linux-mips.org with the
> > following command, I get error message as below:
> >
> > **************************************************************************
> > [root@sshyamal git-tutorial]# git clone
> > git://ftp.linux-mips.org/pub/scm/linux-malta.git linux-malta.git
> > git: warning: invalid extra options ignored
> >
> > GNU Interactive Tools 4.3.20 (i686-pc-linux-gnu), 12:39:46 Apr 18 2006
> > GIT is free software; you can redistribute it and/or modify it under the
> > terms of the GNU General Public License as published by the Free
> > Software
> > Foundation; either version 2, or (at your option) any later version.
> > Copyright (C) 1993-1999 Free Software Foundation, Inc.
> > Written by Tudor Hulubei and Andrei Pitis, Bucharest, Romania
> >
> > git: fatal error: `chdir' failed: permission denied.
>
> You're using the wrong GIT. Remove the GNU Interactive Tools and use
> git from kernel.org.
>
> >
> ***************************************************************************
> >
> > I am exercising this command in root mode.
>
> There is absolutely zero reason to run git as root.
>
>
> Erik
>
> --
> +-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
> | Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
>
