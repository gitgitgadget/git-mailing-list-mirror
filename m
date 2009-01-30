From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jan 2009, #07; Wed, 28)
Date: Fri, 30 Jan 2009 11:26:03 -0500
Message-ID: <20090130162603.GB7065@sigill.intra.peff.net>
References: <7vwscej26i.fsf@gitster.siamese.dyndns.org> <20090129035138.GC11836@coredump.intra.peff.net> <bd6139dc0901290327u572cc30ci9dc719c912fbf875@mail.gmail.com> <20090129113735.GA6505@coredump.intra.peff.net> <351A6988-32EB-473F-B6E5-8FBB38D91F88@ai.rug.nl> <bd6139dc0901290345u4962f747gbe93c945ab35c9cb@mail.gmail.com> <20090129115026.GB10792@coredump.intra.peff.net> <bd6139dc0901290420x1216a399w656e4d1622178a06@mail.gmail.com> <20090130045131.GB18655@coredump.intra.peff.net> <alpine.DEB.1.00.0901301415260.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 30 17:27:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSwDP-0003RR-Vc
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 17:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230AbZA3Q0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 11:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752215AbZA3Q0J
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 11:26:09 -0500
Received: from peff.net ([208.65.91.99]:41990 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752171AbZA3Q0I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 11:26:08 -0500
Received: (qmail 2872 invoked by uid 107); 30 Jan 2009 16:26:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 30 Jan 2009 11:26:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Jan 2009 11:26:03 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901301415260.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107843>

On Fri, Jan 30, 2009 at 02:18:32PM +0100, Johannes Schindelin wrote:

> > You could make a guess that they will use "master", and if you are
> > wrong, it behaves as now. But if you are right, "git pull" pulls down
> > master automatically.
> > 
> > But that is getting a little confusing. So let's push this "git push
> > --track" idea to completion and see how people like it.
> 
> How about installing
> 
> 	[branch "master"]
> 		remote = origin
> 		merge = refs/heads/master
> 
> by default?  It is a safe bet that this will be the case for 99% of all 
> users that want to clone an empty repository (especially if they are 
> putting their public repositories on something like repo.or.cz, where you 
> cannot change the default branch from "master" to something else).
> 
> And if somebody wants to track another branch, tough, she has to call 
> this:
> 
> 	$ git checkout -t origin/blablabla

I was tempted to suggest that, but I haven't thought through whether
there are any lurking corner cases (which empty clone seems to be
fraught with). So I think it is a reasonable thing to try and play with.

-Peff
