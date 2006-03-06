From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH] annotate: Support annotation of files on other revisions.
Date: Mon, 6 Mar 2006 08:49:11 +0100
Message-ID: <20060306074911.GA4501@c165.ib.student.liu.se>
References: <20060305111334.GB23448@c165.ib.student.liu.se> <440B751F.5000801@michonline.com> <46a038f90603051629ke34a0a6u89dad995bbd777b0@mail.gmail.com> <20060306024353.GA23001@mythryan2.michonline.com> <46a038f90603052018n76d316eclf84b6921c9595f16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Mar 06 08:49:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGATN-00056V-RS
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 08:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbWCFHtY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 02:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbWCFHtX
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 02:49:23 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:31723 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S1752144AbWCFHtW
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Mar 2006 02:49:22 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 8B3B240FF; Mon,  6 Mar 2006 09:04:34 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1FGASt-0002pY-00; Mon, 06 Mar 2006 08:49:11 +0100
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90603052018n76d316eclf84b6921c9595f16@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17284>

On Mon, Mar 06, 2006 at 05:18:35PM +1300, Martin Langhoff wrote:
> On 3/6/06, Ryan Anderson <ryan@michonline.com> wrote:
> > annotate was *trying* to handle that cleanly, but failed due to a silly
> 
> Great stuff, thanks! I'll let it hit master and then I'll drop the
> messy part of req_annotate() in cvsserver.
> 
> > For annotate, the syntax I was using was:
> >         git annotate Makefile headname
> >
> > I'm not married to it, so please, send a patch to change it if you want
> > (Please fix up the test case I'm sending in this patch, as well.)
> 
> That's _perfect_. I was just making the syntax up.
> 

That syntax should work with git-blame too. If it doesn't, it's a bug.

- Fredrik
