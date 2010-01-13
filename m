From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] commit: show interesting ident information in
 summary
Date: Wed, 13 Jan 2010 13:45:10 -0500
Message-ID: <20100113184510.GA22849@coredump.intra.peff.net>
References: <20100113173408.GA16652@coredump.intra.peff.net>
 <20100113173951.GC16786@coredump.intra.peff.net>
 <1DDB570B-350A-40A0-B6E4-ADBDF4BE6BD2@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Adam Megacz <adam@megacz.com>,
	git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 19:45:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV8Dd-0008B0-Fa
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 19:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521Ab0AMSpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 13:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085Ab0AMSpV
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 13:45:21 -0500
Received: from peff.net ([208.65.91.99]:33994 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814Ab0AMSpU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 13:45:20 -0500
Received: (qmail 25762 invoked by uid 107); 13 Jan 2010 18:50:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 13 Jan 2010 13:50:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jan 2010 13:45:10 -0500
Content-Disposition: inline
In-Reply-To: <1DDB570B-350A-40A0-B6E4-ADBDF4BE6BD2@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136855>

On Wed, Jan 13, 2010 at 07:39:47PM +0100, Wincent Colaiuta wrote:

> > Your name and email address were configured automatically based
> > on your username and hostname. Please check that they are accurate.
> > You can suppress this message by setting them explicitly:
> >
> >     git config --global user.name Your Name
> >     git config --global user.email you@example.com
> >
> > If the identity used for this commit is wrong, you can fix it with:
> >
> >     git commit --amend --author='Your Name <you@example.com>'
> >
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> I'll never see this message myself, but I think you could (and
> perhaps should) replace almost all of that with:
> 
>   Your name and email address were configured automatically.
>   See "git config help" for information on setting them explicitly
>   or "git commit help" if you wish to amend this commit.

I don't have a huge problem with your wording, except that it needs
s/(\w+) help/help \1/.

Mainly I was trying to hand-hold because not having this information set
up means it may be your first commit, and you are probably a bit
clueless (the exceptions are people who have been using git, but are
seeing this new behavior in their new version, and people who have git
configured on another machine but are using _this_ machine for the first
time).

As far as reducing verbosity goes, I don't think there is much point.
Both of ours are huge and annoying enough to nag you into setting up
your config, so the user is only likely to see it a few times.

> But like I said, seeing as I won't see the message its verbosity won't
> directly affect me.

I am also in this boat. :)

-Peff
