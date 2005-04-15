From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Re: Re: Re: Remove need to untrack before tracking new branch
Date: Sat, 16 Apr 2005 01:49:05 +0200
Message-ID: <81b0412b050415164958cadbe8@mail.gmail.com>
References: <20050412132307.GH22614@pasky.ji.cz>
	 <20050413221936.GI25711@pasky.ji.cz>
	 <1113461754.23299.68.camel@nosferatu.lan>
	 <1113467335.23299.77.camel@nosferatu.lan>
	 <1113467905.23299.81.camel@nosferatu.lan>
	 <20050414091106.GX25711@pasky.ji.cz>
	 <1113471609.23299.95.camel@nosferatu.lan>
	 <1113472557.23299.99.camel@nosferatu.lan>
	 <81b0412b0504141535793cc235@mail.gmail.com>
	 <1113543914.23299.151.camel@nosferatu.lan>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 01:46:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMaVl-0000uq-Ic
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 01:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbVDOXtn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 19:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbVDOXtn
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 19:49:43 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:37591 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262385AbVDOXtg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 19:49:36 -0400
Received: by wproxy.gmail.com with SMTP id 69so850916wri
        for <git@vger.kernel.org>; Fri, 15 Apr 2005 16:49:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tp+b/qsz4BUT5C3cPf/OcV4VVBd2fFhKU3PLY/WsyMaQzuLIAbtgSvoyv+3eOnYJjlsUnq9B2SaYKddIqpl7zs4Tivg+YZNQxGMrq6/z6rQOvv695gXXiYotb00T16+4z2TLsyd0YHeSczhJyULOR1qY8rfDCdpbkNE48qIDeVc=
Received: by 10.54.43.72 with SMTP id q72mr347337wrq;
        Fri, 15 Apr 2005 16:49:35 -0700 (PDT)
Received: by 10.54.79.20 with HTTP; Fri, 15 Apr 2005 16:49:05 -0700 (PDT)
To: azarah@nosferatu.za.org
In-Reply-To: <1113543914.23299.151.camel@nosferatu.lan>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 4/15/05, Martin Schlemmer <azarah@nosferatu.za.org> wrote:
> > > +               if (update_mode && changed & MODE_CHANGED)
> > > +                       chmod(ce->name, ce->st_mode);
> >
> > it's "if ((update_mode && changed) & MODE_CHANGED)"
> > Did you really mean that?
> 
> No, '&' have a higher priority (weight?) than '&&'.  Although, yes, it
> might be better style to add brackets.

I wasn't concerned about style

> But just to make you happy, let me prove it:

It's not to make me happy, it's just to prove you're right.
You did it, I stand corrected.
