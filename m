From: Wayne Scott <wsc9tt@gmail.com>
Subject: Re: Can't use gitk.
Date: Mon, 14 Nov 2005 09:04:15 -0500
Message-ID: <59a6e5830511140604o12af40fdp1b05cc84962d5903@mail.gmail.com>
References: <cda58cb80511140253s92f28e2g@mail.gmail.com>
	 <437870AF.8060607@op5.se>
	 <cda58cb80511140322v686e4ee0g@mail.gmail.com>
	 <43787831.3030404@op5.se>
	 <cda58cb80511140355q1add0ba5n@mail.gmail.com>
	 <43787E6E.8030702@op5.se>
	 <cda58cb80511140600k2c0188c4i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 15:05:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbewV-00060e-Qv
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 15:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbVKNOER (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 09:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbVKNOER
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 09:04:17 -0500
Received: from xproxy.gmail.com ([66.249.82.200]:21607 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751129AbVKNOEQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 09:04:16 -0500
Received: by xproxy.gmail.com with SMTP id s14so1400634wxc
        for <git@vger.kernel.org>; Mon, 14 Nov 2005 06:04:16 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NjzlbQVXjdhn+ky6XdMsDtEVjHMH2ZE7QxsUGndqfEa3ig18xwDj7mgOmwVM9WeXxold9hUQ3AHvxjHL52GRHn60ZnehqU21fyamp5C9/C+mxoX8h8DDYTQOB1x1LJW614+Nv4C/BBy3DQuhtj6IcVzqmBRVMoMPmPhkUPwEeyA=
Received: by 10.70.42.19 with SMTP id p19mr1482447wxp;
        Mon, 14 Nov 2005 06:04:15 -0800 (PST)
Received: by 10.70.7.3 with HTTP; Mon, 14 Nov 2005 06:04:15 -0800 (PST)
To: Franck <vagabon.xyz@gmail.com>
In-Reply-To: <cda58cb80511140600k2c0188c4i@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11799>

Probably you need to fix your .profile or .bashrc.   Set your PATH
unconditionally and not just for interactive shells. In general
anytime you make some setup in your shell conditional on being
interactive it is just asking for problems.

Test like this:
   ssh localhost 'echo $PATH'

-Wayne

On 11/14/05, Franck <vagabon.xyz@gmail.com> wrote:
> Andreas
>
> 2005/11/14, Andreas Ericsson <ae@op5.se>:
> > Yes, but wish or some such might strip $HOME/bin away from it.
> >
> > Try doing
> >
> > make clean; make prefix=/usr
> > sudo make prefix=/usr install
> >
> > and see if it works.
>
> it works.
>
> >
> > If it does, some program somewhere is manipulating your $PATH.
>
> It seems that once wish is executed, $PATH does not include anymore my
> $HOME/bin directory. Do you have any idea why ?
>
> Thanks
> --
>                Franck
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
