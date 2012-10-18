From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add new git-remote-hd helper
Date: Thu, 18 Oct 2012 10:47:07 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1210181031320.3049@bonsai2>
References: <1350478721-3685-1-git-send-email-felipe.contreras@gmail.com> <alpine.DEB.1.00.1210171759230.3049@bonsai2> <CAMP44s1WY+Q7jyy4PQvwff7JSxHsnkhrPWozOLnNuNOrn7FGBA@mail.gmail.com> <alpine.DEB.1.00.1210171936170.3049@bonsai2>
 <CAMP44s2=hhMz35SpYXMBLcQPfVaPxY4pBWZDF7zbqVwz=tbedA@mail.gmail.com> <CAGdFq_i4c=ei4ni5bv9nNEbCfNG4sbRkqyip2voW17GhkRAKPQ@mail.gmail.com> <CAMP44s2-BCuA5v7jE8S3d-Gg+DxKf6Yte9MvTDBDr4jEkLKZ9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 10:47:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOllV-0004V6-Gu
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 10:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754527Ab2JRIr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 04:47:29 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:37324 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751168Ab2JRIr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 04:47:26 -0400
Received: (qmail invoked by alias); 18 Oct 2012 08:47:22 -0000
Received: from unknown (EHLO bonsai2) [2.215.133.187]
  by mail.gmx.net (mp024) with SMTP; 18 Oct 2012 10:47:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+V6l1aQXyVKjO83dw8I4m1HAxWHOLA/SQqKQejmu
	qb9hzUh+aU6VCQ
X-X-Sender: gene099@bonsai2
In-Reply-To: <CAMP44s2-BCuA5v7jE8S3d-Gg+DxKf6Yte9MvTDBDr4jEkLKZ9g@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207978>

Hi Felipe,

On Wed, 17 Oct 2012, Felipe Contreras wrote:

> On Wed, Oct 17, 2012 at 8:18 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> > On Wed, Oct 17, 2012 at 11:12 AM, Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
> >> But fine, lets remove the tests out of the equation (150 lines), the
> >> number of lines of code still exceeds 3000.
> >
> > I don't think it's fair to just look at LOC, git-remote-hg when it was
> > just parsing was fairly simple. Most of the current code is our copy
> > of the python fast-import library which is only used to support
> > pushing to mercurial.
> 
> Well, as a rule of thumb more code means more places for bugs to hide.

Everybody on this list knows that. But it is equally true that more
functionality requires more code.

Besides, we are talking about concrete code, so there is no need at all
for handwaving arguments. GitHub makes it easy to point at exact line
numbers in exact file names in exact revisions, as you know, and we should
use that to discuss code.

> It is also quite frankly rather difficult to navigate; very
> spaghetti-like. I have the feeling [...]

Yours truly always welcomes constructive criticism. Other types of
criticism, not so much.

As to the functionality you seek: git-remote-hg found in
git://github.com/msysgit/git works. It has the following advantages over
every other solution, including the one proposed in this thread:

- it works

- no really, it works

- it supports pushes, too

- it matured over a long time

- there are tests

- whenever we fixed bugs, we also added tests for the bug fixes

- it is rock solid

- it is in constant use

Without push support, remote-hg is useless to me. Without regression tests
proving that it is rock solid, I will not use remote-hg. And I will not
indulge in efforts to duplicate work.

If there are concerns about code style or unnecessary code (insofar it is
really unnecessary, testgit for example is not, unless you want to avoid
robust regression tests), I will discuss issues and collaborate. If the
idea was not to collaborate, but to show off how much shorter code can be
when it lacks functionality and proof of robustness I require for my
everyday use of the program, dismissing existing code and concepts, less
so.

Hth,
Johannes
