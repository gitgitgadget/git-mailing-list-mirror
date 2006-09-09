From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 2/4] git-archive: wire up TAR format.
Date: Sat, 9 Sep 2006 16:38:13 +0200
Message-ID: <cda58cb80609090738p239c7359pfd0be092d93ed657@mail.gmail.com>
References: <450019C3.4030001@innova-card.com>
	 <11576347252834-git-send-email-vagabon.xyz@gmail.com>
	 <4501D0CF.70306@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 09 16:38:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GM3yS-0002Jc-FL
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 16:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWIIOiR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 9 Sep 2006 10:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWIIOiR
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 10:38:17 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:62051 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932221AbWIIOiP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Sep 2006 10:38:15 -0400
Received: by wx-out-0506.google.com with SMTP id s14so974369wxc
        for <git@vger.kernel.org>; Sat, 09 Sep 2006 07:38:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C6f9VV6CHS0GQKPpfJZB++yLS8cTgGX67LLWX1E9Zvlfrr5aseuKfbahJlgl67IA59wOFF5CbhqbaJ92yG4FI1kIgWEEcayOKaDIkO8vt9Wlj+V2tzML8q098iso/foOb8Q7RnzP+Eb2LaK44vKqp1WEiXwH7QD5/+d3WY4wU08=
Received: by 10.70.96.3 with SMTP id t3mr2317376wxb;
        Sat, 09 Sep 2006 07:38:14 -0700 (PDT)
Received: by 10.70.72.5 with HTTP; Sat, 9 Sep 2006 07:38:13 -0700 (PDT)
To: "Rene Scharfe" <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <4501D0CF.70306@lsrfire.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26749>

2006/9/8, Rene Scharfe <rene.scharfe@lsrfire.ath.cx>:
> Franck Bui-Huu schrieb:
> > From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> >
> > Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> > Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
>
> I did not sign off this exact patch.  I wrote and submitted the
> builtin-tar-tree.c part, with memory leak and all, then sent a note
> on where the leak needs to be plugged.  You put it together and
> converted it to struct archiver_args.  I'd very much have liked to
> see a comment stating this.  Or simply just say "based on code by
> Rene" or something.  The same is true for patch 3/4.
>

OK I'll change that....

> > ---
> >  extern void parse_pathspec_arg(const char **pathspec,
> >                              struct archiver_args *args);
> > +/*
> > + *
> > + */
>
> Especially I would not have signed off this invisible comment. ;)
>
> Ren=E9
>

and put something usefull here.

Thanks
--=20
               Franck
