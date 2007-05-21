From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Teach 'git-apply --whitespace=strip' to remove empty lines at the end of file
Date: Mon, 21 May 2007 10:59:46 +0200
Message-ID: <200705211059.46678.Josef.Weidendorfer@gmx.de>
References: <e5bfff550705200251j3dd9b377je7ae5bafac988060@mail.gmail.com> <20070520191718.GI4085@planck.djpig.de> <e5bfff550705201344r274ac9f4g9ca5e1fefe7c12cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Frank Lichtenheld" <frank@lichtenheld.de>,
	"Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 21 10:59:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq3kB-0006L1-VT
	for gcvg-git@gmane.org; Mon, 21 May 2007 10:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759603AbXEUI7v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 04:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759398AbXEUI7v
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 04:59:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:47876 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757564AbXEUI7u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 04:59:50 -0400
Received: (qmail invoked by alias); 21 May 2007 08:59:48 -0000
Received: from p5496B42B.dip0.t-ipconnect.de (EHLO noname) [84.150.180.43]
  by mail.gmx.net (mp036) with SMTP; 21 May 2007 10:59:48 +0200
X-Authenticated: #352111
X-Provags-ID: V01U2FsdGVkX18l5IB9M6AlxEYq7GH55LMsW+Cogk91rYoy2dr0Vm
	4ylK57WQf31mDX
User-Agent: KMail/1.9.6
In-Reply-To: <e5bfff550705201344r274ac9f4g9ca5e1fefe7c12cd@mail.gmail.com>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47996>

On Sunday 20 May 2007, Marco Costalba wrote:
> On 5/20/07, Frank Lichtenheld <frank@lichtenheld.de> wrote:
> > > >
> > > >But we have kept our sources -Wdeclaration-after-statement
> > > >clean so far
> > >
> > > ??????
> > >
> > > Wie bitte?
> >
> > man gcc:
> >
> > -Wdeclaration-after-statement (C only)
> >    Warn when a declaration is found after a statement in a block.
> >
> 
> Just for my personal knowledge, what's the meaning of this apparently
> non-sense kind of warning?

man gcc:

 -Wdeclaration-after-statement (C only)
    Warn when a declaration is found after a statement in a block.  This con-
    struct, known from C++, was introduced with ISO C99 and is by default allowed
    in GCC.  It is not supported by ISO C90 and was not supported by GCC versions
    before GCC 3.0.

There are some C compilers out there which break out with an error when
using declaration after a statement; however, we want git code to compile
even using these compilers.

Josef

> 
> Thanks
> Marco
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
