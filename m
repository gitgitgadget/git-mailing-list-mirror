From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 01/10] refs: add "for_each_bisect_ref" function
Date: Fri, 27 Mar 2009 03:08:55 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903270305340.10279@pacific.mpi-cbg.de>
References: <20090326055509.1bc16b28.chriscool@tuxfamily.org> <49CBA42D.3000404@drmicha.warpmail.net> <alpine.DEB.1.00.0903261748280.12753@intel-tinevez-2-302> <200903270141.57426.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-802119745-1238119736=:10279"
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Mar 27 03:09:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln1VQ-0003hg-1T
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 03:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbZC0CGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 22:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758997AbZC0CGt
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 22:06:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:53826 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753551AbZC0CGs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 22:06:48 -0400
Received: (qmail invoked by alias); 27 Mar 2009 02:06:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp014) with SMTP; 27 Mar 2009 03:06:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/95pgzI5v9hrGqis0kiDJLHQXJjgvdMi74wBJrWO
	1BDEKGVz4viel6
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200903270141.57426.chriscool@tuxfamily.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114840>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-802119745-1238119736=:10279
Content-Type: TEXT/PLAIN; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 27 Mar 2009, Christian Couder wrote:

> Le jeudi 26 mars 2009, Johannes Schindelin a écrit :
>
> > On Thu, 26 Mar 2009, Michael J Gruber wrote:
> > > Christian Couder venit, vidit, dixit 26.03.2009 08:48:
> > > > Le jeudi 26 mars 2009, Sverre Rabbelier a écrit :
> > > >> A 10 patches series with no cover letter?
> > > >
> > > > I am not a big fan of cover letters. Usually I prefer adding 
> > > > comments in the patches.
> > >
> > > I'm sorry I have to say that, but your individual preferences don't 
> > > matter. Many of us would do things differently, each in their own 
> > > way, but people adjust to the list's preferences. It's a matter of 
> > > attitude. So, please...
> >
> > Actually, a better way to ask for a cover letter would have been to 
> > convince Christian.  So I'll try that.
> 
> Thanks.
> 
> As you know, I have been sending patches since nearly 3 years ago to 
> this list. And it's only since a few weeks ago that I am asked to send 
> cover letters...

Heh, I have the feeling that your patch series were much shorter, and did 
not have many revisions, until a few weeks ago ;-)

> > From the patch series' titles (especially when they are cropped due to 
> > the text window being too small to fit the indented thread), it is not 
> > all that obvious what you want to achieve with those 10 patches.
> >
> > From recent discussions, I seem to remember that you wanted to have 
> > some cute way to mark commits as non-testable during a bisect, and I 
> > further seem to remember that Junio said that very method should be 
> > usable outside of bisect, too.
> 
> Well, we want to move "git bisect skip" code from shell (in 
> "git-bisect.sh") to C. So this patch series does that by creating a new 
> "git bisect--helper" command in C that contains the new code and using 
> that new command in "git-bisect.sh".

Oh?  I _completely_ missed that.  And that's being one of the original 
Cc:ed persons...

> > Unfortunately, that does not reveal to me, quickly, what is the 
> > current state of affairs, and what you changed since the last time.
> 
> Yeah, I should have at least put something in the comment section of my 
> first patch in this series.

No.  I would still have missed it.

The cover letter is outside of any patch, because it describes the purpose 
of the _whole_ patch series, not just one patch.

So, it would have been nice to get a heads-up that this is not your 
bisect-skip-a-whole-bunch-of-commits series, but a new animal.

This way, I decided I do not have time for something I do not need, and 
deleted it without having a look.

Ciao,
Dscho

--8323328-802119745-1238119736=:10279--
