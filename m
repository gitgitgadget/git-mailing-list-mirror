From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: tracking branch for a rebase
Date: Mon, 7 Sep 2009 11:29:50 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909071126040.8306@pacific.mpi-cbg.de>
References: <20090904135414.GA3728@honk.padd.com> <4AA124DD.1030208@drmicha.warpmail.net> <20090904181846.GC19093@coredump.intra.peff.net> <20090904185949.GA21583@atjola.homenet> <20090905061250.GA29863@coredump.intra.peff.net> <20090905140127.GA29037@atjola.homenet>
 <20090905142841.GB15631@coredump.intra.peff.net> <7vfxaz9wfi.fsf@alter.siamese.dyndns.org> <20090907084324.GB17997@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 07 11:29:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkaWX-0006NK-3H
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 11:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbZIGJ2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 05:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbZIGJ2W
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 05:28:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:43346 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751965AbZIGJ2W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 05:28:22 -0400
Received: (qmail invoked by alias); 07 Sep 2009 09:28:23 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 07 Sep 2009 11:28:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/I5EJcwizInAl3TrdXPVRRhyG4k6/C+Y8ngPyepI
	0Ss+M7x6SqDrtS
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090907084324.GB17997@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127915>

Hi,

On Mon, 7 Sep 2009, Jeff King wrote:

> On Sun, Sep 06, 2009 at 10:05:21PM -0700, Junio C Hamano wrote:
> 
> > 	ref@{number}	-- nth reflog entry
> >         ref@{time}	-- ref back then
> > 	@{-number}	-- nth branch switching
> > 
> > So perhaps ref@{upstream}, or any string that is not a number and cannot
> > be time, can trigger the magic operation on the ref with ref@{magic}
> > syntax?
> 
> I think using @{} is a reasonable extension format.

Sorry to enter this thread that late, but I did not realize that it 
touches my %<branch> work.

Your proposal leads to something like "master@{upstream}@{2.days.ago}", 
which looks ugly.  And it is much more to type.

I still think that it is not too-much asked for to require the 
"refs/heads/" prefix if somebody starts her branch names with "%".

Or did I miss something (as I do not have time to read long mails these 
days, I tend to read only the short, to-the-point ones; I allowed myself 
to only skim over the rest of your mail)?

Ciao,
Dscho
