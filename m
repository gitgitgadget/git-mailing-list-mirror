From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Fri, 30 Nov 2007 10:12:23 -0500
Message-ID: <20071130151223.GB22095@coredump.intra.peff.net>
References: <20071129211409.GA16625@sigill.intra.peff.net> <Pine.LNX.4.64.0711292218240.27959@racer.site> <20071129231444.GA9616@coredump.intra.peff.net> <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org> <7veje8twt2.fsf@gitster.siamese.dyndns.org> <20071130003512.GB11683@coredump.intra.peff.net> <7vzlwwsgkp.fsf@gitster.siamese.dyndns.org> <20071130005852.GA12224@coredump.intra.peff.net> <alpine.LFD.0.9999.0711291821220.8458@woody.linux-foundation.org> <5E2A9E2B-8B9A-46B0-99D0-DB3798F10119@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Nov 30 16:12:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy7Xp-0002il-Dj
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 16:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760442AbXK3PM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 10:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759951AbXK3PM0
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 10:12:26 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1628 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758089AbXK3PMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 10:12:25 -0500
Received: (qmail 2861 invoked by uid 111); 30 Nov 2007 15:12:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 30 Nov 2007 10:12:24 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Nov 2007 10:12:23 -0500
Content-Disposition: inline
In-Reply-To: <5E2A9E2B-8B9A-46B0-99D0-DB3798F10119@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66644>

On Fri, Nov 30, 2007 at 06:51:35AM +0100, Steffen Prohaska wrote:

> What will happen to gitk?
>
> Shouldn't it be included in the nice collection?  gitk is
> an essential command.  Then, following your reasoning,
> "git <tab><tab>" should recommend it, no?
>
> Note, "git gui" already works.  gitk would really be the last
> git "command" that can't be accessed through "git <command>"

Except for qgit, tig, etc. The only difference being that gitk actually
ships with git.

But I am not opposed to having some "git foo" form for gitk.

-Peff
