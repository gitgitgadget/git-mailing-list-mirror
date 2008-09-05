From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Git User's Survey 2008 partial summary
Date: Sat, 6 Sep 2008 00:17:31 +0200
Message-ID: <20080905221731.GI15520@efreet.light.src>
References: <200809031607.19722.jnareb@gmail.com> <20080903144552.GA27682@spearce.org> <20080903172050.61d510d6@pc09.procura.nl> <94a0d4530809030925t33d4260bof169372d65717af4@mail.gmail.com> <402731c90809031943n181ad6fbw366f90e80aaca2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 00:18:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kbjdj-0007A7-BI
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 00:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbYIEWRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 18:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbYIEWRp
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 18:17:45 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:40451 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751751AbYIEWRo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 18:17:44 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 455615737A;
	Sat,  6 Sep 2008 00:17:43 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id RlP+SUydetmX; Sat,  6 Sep 2008 00:17:39 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 17BA557366;
	Sat,  6 Sep 2008 00:17:38 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1KbjcR-00078J-Kx; Sat, 06 Sep 2008 00:17:31 +0200
Content-Disposition: inline
In-Reply-To: <402731c90809031943n181ad6fbw366f90e80aaca2a@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95045>

On Wed, Sep 03, 2008 at 19:43:20 -0700, David Aguilar wrote:
> On Wed, Sep 3, 2008 at 9:25 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > On Wed, Sep 3, 2008 at 6:20 PM, H.Merijn Brand <h.m.brand@xs4all.nl> wrote:
> >> On Wed, 3 Sep 2008 07:45:52 -0700, "Shawn O. Pearce"
> >> <spearce@spearce.org> wrote:
> >>
> >>> Jakub Narebski <jnareb@gmail.com> wrote:
> >>> > This is partial summary of Git User's Survey 2008 [...]
> >>> >
> >>> > 03. With which programming languages are you proficient?
> >>> >
> >>> > Around 939 people answered this question.  C is most popular with 59%;
> >>> > Ruby and surprisingly a bit shell script programming have around second
> >>> > place, with about 52-53%.  More people are proficient with Python than
> >>> > in Perl by about 1/3-1/4.  Very few people (25 responses, around 3%)
> >>> > feel proficient in Tcl/Tk, which means shallow pool of possible git-gui
> >>> > and gitk contributors.
> >>
> >> Rewrite them in perl or python and get more patches?
> >> The fact that it is not perl withheld me from finding solutions to
> >> problems I still have with the git-gui gitk combination
> >
> > Ruby!
> >
> > --
> > Felipe Contreras
> 
> There's already a python git-gui:
>     http://cola.tuxfamily.org/
> 
> PyQt is a very mature library, which is one of the primary reasons I
> chose Python.

Sorry, but I disagree. Tried PyQt, been hugely disapointed. Boils down to any
thing that can make Python (or, for that matter, any) interpreter segfault
being totally broken.

But as far as Qt goes, I would really just stick with C++. Python or Ruby
have some advantage, but I am not sure it's that big to offset the fact, that
a lot of code already exists in QGit.

> Does Ruby have any good and mature UI libraries?  I know it's all the
> rage for web stuff, but I haven't heard too much about people using it
> for GUIs.

Qt? I believe Ruby Qt bindings are in better shape (properly handle Qt
deleting objects under Ruby's hands).

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
