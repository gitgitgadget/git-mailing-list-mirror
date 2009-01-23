From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Allow cloning an empty repository
Date: Fri, 23 Jan 2009 17:37:41 -0500
Message-ID: <20090123223740.GA11527@coredump.intra.peff.net>
References: <1232669252-21881-1-git-send-email-srabbelier@gmail.com> <7vwscm4xx0.fsf@gitster.siamese.dyndns.org> <bd6139dc0901221746h258f548etf857ab37399133da@mail.gmail.com> <alpine.DEB.1.00.0901230333060.3586@pacific.mpi-cbg.de> <bd6139dc0901221847u6b8aeadcl580a091751de3d26@mail.gmail.com> <alpine.DEB.1.00.0901230419080.3586@pacific.mpi-cbg.de> <20090123223205.GA11491@coredump.intra.peff.net> <bd6139dc0901231434n6d6af5a6ma8bb12a634d5b3ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 23:39:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQUg7-0007j6-73
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 23:39:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755985AbZAWWho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 17:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755552AbZAWWhn
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 17:37:43 -0500
Received: from peff.net ([208.65.91.99]:41800 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754312AbZAWWhm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 17:37:42 -0500
Received: (qmail 12097 invoked by uid 107); 23 Jan 2009 22:37:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 23 Jan 2009 17:37:49 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jan 2009 17:37:41 -0500
Content-Disposition: inline
In-Reply-To: <bd6139dc0901231434n6d6af5a6ma8bb12a634d5b3ba@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106926>

On Fri, Jan 23, 2009 at 11:34:04PM +0100, Sverre Rabbelier wrote:

> On Fri, Jan 23, 2009 at 23:32, Jeff King <peff@peff.net> wrote:
> > Really? I have scripts that call clone (usually followed by building the
> > result). Are you proposing that all scripts should "git init && git
> > remote add && git fetch"?
> >
> > So I am strongly in favor of telling the difference between failure and
> > emptiness.
> 
> A switch then, '--allow-empty'?

No, I don't mind success on cloning an empty repository. But I thought
the issue at hand was that for some instances, we would report that we
successfully created an empty repository, when in fact what happened was
that we failed to clone a non-empty repository. And that that was
fixable, but it was a problem with our code interfaces (which should be
fixable) and not some fundamental limitation.

Or am I misunderstanding the situation?

-Peff
