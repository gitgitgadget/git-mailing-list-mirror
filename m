From: eschvoca <eschvoca@gmail.com>
Subject: Re: How do I clear the directory cache
Date: Sat, 22 Oct 2005 15:20:40 -0400
Message-ID: <2b05065b0510221220r5c498c28lcb00d8846f156686@mail.gmail.com>
References: <2b05065b0510170720n5333f03l1941e84c1288fc5d@mail.gmail.com>
	 <20051020085931.GW30889@pasky.or.cz>
	 <2b05065b0510202023i62ab7c03uea1381d76535dcc7@mail.gmail.com>
	 <20051021105235.GF30889@pasky.or.cz>
	 <2b05065b0510211340y9551767i53fe53c0dc14460a@mail.gmail.com>
	 <20051021214326.GJ30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 22 21:21:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETOvV-0005YY-EW
	for gcvg-git@gmane.org; Sat, 22 Oct 2005 21:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbVJVTUo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Oct 2005 15:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbVJVTUo
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Oct 2005 15:20:44 -0400
Received: from qproxy.gmail.com ([72.14.204.203]:42655 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750982AbVJVTUn convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2005 15:20:43 -0400
Received: by qproxy.gmail.com with SMTP id q12so21039qbq
        for <git@vger.kernel.org>; Sat, 22 Oct 2005 12:20:40 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uTskns3jqT5WENhTIl6FUR3e277dILUZBnlde5atGyR5crTc2z9OITu9FLfVyoUxrMzwGUZEJVOfm2oY2sj4M7vlwV5CjxmpfoXf3ovyOpO2sWco3Ij2d9/oFhD8Qd8v4So/z2kvrXZfc6wYQYcpzMzztAhEiCbencCtzlt48Vg=
Received: by 10.65.192.11 with SMTP id u11mr2448159qbp;
        Sat, 22 Oct 2005 12:20:40 -0700 (PDT)
Received: by 10.65.44.2 with HTTP; Sat, 22 Oct 2005 12:20:40 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051021214326.GJ30889@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10473>

On 10/21/05, Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Fri, Oct 21, 2005 at 10:40:07PM CEST, I got a letter
> where eschvoca <eschvoca@gmail.com> told me that...
> > On 10/21/05, Petr Baudis <pasky@suse.cz> wrote:
> > > Dear diary, on Fri, Oct 21, 2005 at 05:23:28AM CEST, I got a letter
> > > where eschvoca <eschvoca@gmail.com> told me that...
> > > > cg-status -<status_flag>  # list files with given status flag (without
> > > > status flag in column 1)
> > > >   git-ls-files [--others|--deleted|etc] --exclude-per-directory=/.gitignore
> > >
> > > All right, this might be useful. Implemented as cg-status -s '?' and such,
> > > thanks for the idea.
> >
> > This is great but it would be easier to work with if there was another
> > switch to turn off printing
> > out the status flag.  Otherwise you have to 'sed' or 'awk' out the
> > status flag which is a pain, especially when files have spaces in
> > them.
>
> Not such a huge pain, but if we already have -s... I added -n which does
> what you want.

Great.

> > Also, the "cg-add -r" exits when a file is bad.  It would have saved
> > me a few hours if it would keep not exit on a failure (and add the bad
> > files to .gitignore ... but that is probably asking for too much).
>
> I don't like the idea of adding the files automagically to .gitignore,
> but it won't abort the whole operation because of them anymore.
>

I think it would make a lot of sense to print out an error to stderr
if the file is
bad (maybe you already do).  From there it should be easy to capture stderr
and construct .gitignore.

Thanks for making cogito better for me and exceeding my expectations.
