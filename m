From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 9/9] Implement git commit as a builtin command.
Date: Mon, 17 Sep 2007 19:56:45 -0400
Message-ID: <20070917235645.GG24342@sigill.intra.peff.net>
References: <11890382242333-git-send-email-krh@redhat.com> <11890382243290-git-send-email-krh@redhat.com> <11890382253220-git-send-email-krh@redhat.com> <11890382252522-git-send-email-krh@redhat.com> <1189038225525-git-send-email-krh@redhat.com> <11890382262161-git-send-email-krh@redhat.com> <11890382264046-git-send-email-krh@redhat.com> <11890382271931-git-send-email-krh@redhat.com> <Pine.LNX.4.64.0709061741370.28586@racer.site> <1190069881.10112.10.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 01:56:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXQSI-0008HN-1T
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 01:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756233AbXIQX4h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Sep 2007 19:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756221AbXIQX4g
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 19:56:36 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2923 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756161AbXIQX4g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 19:56:36 -0400
Received: (qmail 21901 invoked by uid 111); 17 Sep 2007 23:56:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 17 Sep 2007 19:56:34 -0400
Received: (qmail 25364 invoked by uid 1000); 17 Sep 2007 23:56:45 -0000
Content-Disposition: inline
In-Reply-To: <1190069881.10112.10.camel@hinata.boston.redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58502>

On Mon, Sep 17, 2007 at 06:58:01PM -0400, Kristian H=F8gsberg wrote:

> > > -	builtin-runstatus.o \
> >=20
> > Better keep it; some people's scripts could depend on it.
>=20
> Seriously?  Why don't we remove it and see if somebody yells?  It's m=
ore
> of an implementation detail than most other git commands; if you need
> status output in your script why wouldn't you just run git status?

As the author of builtin-runstatus, I had always intended that it was a
temporary part of the transition to a C git-commit, and would go away
then. But I see in the interim somebody documented it.  It should
perhaps have been called git-status--helper, and the documentation
should have read "DO NOT USE THIS."

So certainly my intent was for it to go away, but whether it has become
something else is perhaps up to others to judge.

-Peff
