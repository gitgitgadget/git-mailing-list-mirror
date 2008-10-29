From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] Implement git-staged, an alias for 'git diff --cached'.
Date: Wed, 29 Oct 2008 02:01:07 +0100
Message-ID: <20081029010107.GB12065@leksak.fem-net>
References: <1225237145-95435-1-git-send-email-dsymonds@gmail.com> <1225238368-98594-1-git-send-email-dsymonds@gmail.com> <20081029003931.GA7291@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 29 02:02:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuzS7-0005fZ-3O
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 02:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbYJ2BBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 21:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752463AbYJ2BBO
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 21:01:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:48475 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752020AbYJ2BBN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 21:01:13 -0400
Received: (qmail invoked by alias); 29 Oct 2008 01:01:11 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp037) with SMTP; 29 Oct 2008 02:01:11 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/83K1P4pz8PMIqywFhW9l/IstL1YfNWd91luAkAP
	MZtT5pwKG/vF1s
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KuzQp-0006Rm-Ie; Wed, 29 Oct 2008 02:01:07 +0100
Content-Disposition: inline
In-Reply-To: <20081029003931.GA7291@sigill.intra.peff.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99342>

Hi,

> > --- /dev/null
> > +++ b/git-staged.sh
> > @@ -0,0 +1,2 @@
> > +#!/bin/sh
> > +exec git diff --cached $*
> 
> This is broken for arguments with spaces. Use "$@" instead.
> 
> But I think this isn't a serious patch anyway, so we are probably
> wasting too much time on it. ;P

I'm still not understanding, what it's for.
Usability? Because doing
	git config --global alias.staged 'diff --cached'
is lame?

Regards,
  Stephan

PS: Btw, if ever meant serious, it's missing an insertion into
    command-list.txt and serious documentation.
    But I think you know that. :-)

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
