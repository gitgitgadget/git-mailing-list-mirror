From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] remote: allow adding remote w same name as alias
Date: Sun, 21 Dec 2014 21:40:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412212139430.21312@s15462909.onlinehome-server.info>
References: <20141216021900.50095.24877@random.io> <alpine.DEB.1.00.1412160944180.13845@s15462909.onlinehome-server.info> <CAChhagAFTxmFVvCUiKp3a369awPJtZEuVsfFMcdiqeB9ZwYnKg@mail.gmail.com> <alpine.DEB.1.00.1412191034560.13845@s15462909.onlinehome-server.info>
 <CAChhagA7eZ_7=g-xhAusZ1NX085KLjPDRbgJwx00F4pgOURXnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Anastas Dancha <anapsix@random.io>
X-From: git-owner@vger.kernel.org Sun Dec 21 21:41:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2nJn-0004oG-PG
	for gcvg-git-2@plane.gmane.org; Sun, 21 Dec 2014 21:41:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbaLUUkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2014 15:40:35 -0500
Received: from mout.gmx.net ([212.227.15.18]:63679 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239AbaLUUke (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2014 15:40:34 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0M6Ana-1Xie730zak-00y83k;
 Sun, 21 Dec 2014 21:40:31 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CAChhagA7eZ_7=g-xhAusZ1NX085KLjPDRbgJwx00F4pgOURXnQ@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:GfKRlksrg/w6HtSBCn+xRbLWYcHfMvcj8DIGgZXs5/Nyn1s5K08
 z8k/ihkR38AAhQ8rzHw/u1LDlvB+FXyRhwiEq/1UdrZrx1Ahz9CqLNoXKUe2YQ3KIJ5r1qb
 +FhEhSEc4kdd8S/VYaOyH0m8sfCc8eLXLo0PC1NvwnG2CWskENwuCdasukAYYUXPmjYN6Qy
 8hpRac8n3J+40Jp6O3/BQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261629>

Hi Anastas,

On Fri, 19 Dec 2014, Anastas Dancha wrote:

> On Fri, Dec 19, 2014 at 4:37 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > [...]
> > There is one bit left to clarify: let me guess, you have a $HOME/.gitconfig
> > like this:
> >
> >         [url "anastas@company.com"]
> >                 insteadOf = backup
> >                 pushInsteadOf = backup
> >
> > and then you want to add the "backup" remote in a Git working directory
> > like this:
> >
> >         git remote add backup me@my-laptop.local
> >
> > but my suggested fix will still disallow this because the URL does not
> > match the url.anastas@company.com.insteadOf?
> 
> Precisely that. In fact, it will not work even if you do any of these:
> 
>     git remote add backup anastas@company.com

This will succeed after applying my suggested change. I even tested this
;-)

Ciao,
Johannes
