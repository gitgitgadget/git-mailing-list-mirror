From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce <branch>@{tracked} as shortcut to the tracked
 branch
Date: Thu, 10 Sep 2009 12:14:22 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909101211340.8306@pacific.mpi-cbg.de>
References: <20090904135414.GA3728@honk.padd.com> <4AA124DD.1030208@drmicha.warpmail.net> <20090904181846.GC19093@coredump.intra.peff.net> <20090904185949.GA21583@atjola.homenet> <20090905061250.GA29863@coredump.intra.peff.net> <20090905140127.GA29037@atjola.homenet>
 <20090905142841.GB15631@coredump.intra.peff.net> <7vfxaz9wfi.fsf@alter.siamese.dyndns.org> <20090907084324.GB17997@coredump.intra.peff.net> <alpine.DEB.1.00.0909071126040.8306@pacific.mpi-cbg.de> <20090909104550.GA20108@coredump.intra.peff.net>
 <7vzl93cncn.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0909100941330.8306@pacific.mpi-cbg.de> <alpine.DEB.1.00.0909101135590.8306@pacific.mpi-cbg.de> <4AA8CA88.9060802@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Sep 10 12:13:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlgeC-0006CU-6a
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 12:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755381AbZIJKMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 06:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755370AbZIJKMs
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 06:12:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:39481 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755358AbZIJKMr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 06:12:47 -0400
Received: (qmail invoked by alias); 10 Sep 2009 10:12:49 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp027) with SMTP; 10 Sep 2009 12:12:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18RJ/chNEARB2WW0ZUlc9HfZ+7b5IGVDPiQDAisdA
	7QNBLzZOESJPVP
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4AA8CA88.9060802@drmicha.warpmail.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128105>

Hi,

On Thu, 10 Sep 2009, Michael J Gruber wrote:

> Johannes Schindelin venit, vidit, dixit 10.09.2009 11:36:
> > 
> > Often, it is quite interesting to inspect the branch tracked by a given
> > branch.  This patch introduces a nice notation to get at the tracked
> > branch: '<branch>@{tracked}' can be used to access that tracked branch.
> > 
> > A special shortcut '@{tracked}' refers to the branch tracked by the
> > current branch.
> 
> Sorry, I didn't know the name of the long form was up for discussion.
> But it should certainly coincide with the key which for-each-ref uses,
> shouldn't it? I don't care whether tracked or upstream, but
> for-each-ref's "upstream" has set the precedent.

You're right.

sed -i -e 's/@{tracked}/@{upstream}/g' -e 's/@{t}/@{u}/g' $PATCH

Ciao,
Dscho
