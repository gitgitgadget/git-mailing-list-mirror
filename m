From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: tracking branch for a rebase
Date: Thu, 10 Sep 2009 09:47:52 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909100941330.8306@pacific.mpi-cbg.de>
References: <20090904135414.GA3728@honk.padd.com> <4AA124DD.1030208@drmicha.warpmail.net> <20090904181846.GC19093@coredump.intra.peff.net> <20090904185949.GA21583@atjola.homenet> <20090905061250.GA29863@coredump.intra.peff.net> <20090905140127.GA29037@atjola.homenet>
 <20090905142841.GB15631@coredump.intra.peff.net> <7vfxaz9wfi.fsf@alter.siamese.dyndns.org> <20090907084324.GB17997@coredump.intra.peff.net> <alpine.DEB.1.00.0909071126040.8306@pacific.mpi-cbg.de> <20090909104550.GA20108@coredump.intra.peff.net>
 <7vzl93cncn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 09:46:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MleMR-0004wp-TT
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 09:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754101AbZIJHqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 03:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753382AbZIJHqT
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 03:46:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:52490 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752813AbZIJHqS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 03:46:18 -0400
Received: (qmail invoked by alias); 10 Sep 2009 07:46:19 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp026) with SMTP; 10 Sep 2009 09:46:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/DnWoxZtHDKYUAluKEiG5LFBgXb3zjjv8mYgURWK
	Xbr6WAON+nlm4L
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vzl93cncn.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128099>

Hi,

On Wed, 9 Sep 2009, Junio C Hamano wrote:

> I find a prefix % not descriptive enough (besides being ugly); if it were
> "^branch", as some people said, it would probably have matched its meaning
> "up", but that notation is already taken for "uninteresting".

How about ^^branch? *ducks*

Seriously again, I think that ^{tracking} (with shorthand ^t, maybe) is 
not too shabby an option.  The point is: if we make this unattractive 
enough by requiring a lot of typing, we will never get to the point where 
it is popular enough to make a shorthand: it just will not be used at all.

> When I say there is only one kind of magic notation for refs, I am
> primarily talking about the end-user perception.  @{time}, @{number} and
> @{-number} all do their magic using the reflog, but that is about _how_
> they do what they do.  End-user perception begins with _what_ they do, and
> at that level, the magic consistently works on refs and different genie is
> summoned depending on what is inside {}.
> 
> The @{upstream} thing won't be using reflog to do its job, but that is
> about _how_ it is implemented, and the end users don't care.

Ah, I get what you're saying.  @{2.days.ago} says something about this 
branch locally, but @{upstream} says something about this branch remotely 
(well, our local cache).  From that view point, it makes sense.

But my point stands: @{upstream} is too awkward to type.  Let's have _at 
least_ a shortcut '@{up}'.

Ciao,
Dscho
