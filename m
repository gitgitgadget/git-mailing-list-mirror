From: "Mike Coleman" <tutufan@gmail.com>
Subject: Re: suggested feature: completely expunge a file (or just a delta) a la rebase
Date: Thu, 3 May 2007 11:24:46 -0500
Message-ID: <3c6c07c20705030924i2204d972s14b0377ffe1fde76@mail.gmail.com>
References: <3c6c07c20704252248q3cd82d4cgcffb9852fa261a70@mail.gmail.com>
	 <7virbju17h.fsf@assigned-by-dhcp.cox.net>
	 <3c6c07c20704260750o68b1d296kc30c17e54a593023@mail.gmail.com>
	 <Pine.LNX.4.64.0704261716140.12006@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 03 18:24:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hje6x-0003qu-5e
	for gcvg-git@gmane.org; Thu, 03 May 2007 18:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S376201AbXECQYt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 12:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S376200AbXECQYt
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 12:24:49 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:50880 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S376201AbXECQYs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 12:24:48 -0400
Received: by an-out-0708.google.com with SMTP id b33so549828ana
        for <git@vger.kernel.org>; Thu, 03 May 2007 09:24:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=raOHcPdYxiGK3JzYoA7oRyOc06xbcFSvRjBIHakvGlxSRmiaZTIKqgJtEvIQTK/Bq22MPMo0+9yZiOE4wjcE9MKgehSVvkzJAGLb7sMCZg7jdj8Rftaf3D+Z06j8f6W0f2oAEz7QhkXRlworaMsbqIlkJZhph8tBcT9hK2xC84M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CWFoyQorxw9esE9iKD2W+GYf6Ic18EiN3MqSrtvGaMSPC/9CInZg/RkQFN0mGIEdM45/h/t1Of5wiQGaX9SSGOS/i+7sdMMk7ojxsnXQOADzuqkqWnJiwN3efBBcT5hA8hj2JLrtJDN5R+gmSmlbOnC+VeuwT/SCFhxiAlhYzBQ=
Received: by 10.100.119.14 with SMTP id r14mr1774588anc.1178209486957;
        Thu, 03 May 2007 09:24:46 -0700 (PDT)
Received: by 10.100.131.10 with HTTP; Thu, 3 May 2007 09:24:46 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0704261716140.12006@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46091>

I have no idea why bike sheds should be painted red (though this does
sound very vaguely familiar).  I did get a chance to try out
cg-admin-rewritehist last night, and it worked like a charm.  Even got
rid of my graft point (my project has previously lived in RCS, CVS,
and Subversion).

Anyway, it'd definitely be useful, I think, especially as a means to
unroll newby mistakes such as mine.

Mike


On 4/26/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 26 Apr 2007, Mike Coleman wrote:
>
> > On 4/26/07, Junio C Hamano <junkio@cox.net> wrote:
> > > There have been talks about polishing cg-rewritehist into a
> > > shape suitable for inclusion in core git.git, now Cogito is not
> > > actively developed anymore.
> >
> > Ah, that looks like it'd fit the bill.  I may see if it'll still work
> > for my simple case.  Thanks for the pointer.
> >
> > > I think the first thing to fix is its name "rewritehist", which
> > > may technically be correct, feels a bit too ugly ;-)
> >
> > Naming is very important.
>
> Maybe git-rewrite-commits?
>
> > I seem to recall hearing (from PE) that one of the early Unix guys was
> > later asked if there was anything they'd change in hindsight.  Their
> > response: they'd spell "creat" with an 'e'.
>
> In related news: there is really no question that bike sheds should be
> painted red. Really.
>
> Ciao,
> Dscho
>
>
