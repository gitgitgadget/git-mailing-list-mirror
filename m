From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jan 2009, #07; Wed, 28)
Date: Thu, 12 Feb 2009 07:32:08 -0500
Message-ID: <20090212123207.GA5397@sigill.intra.peff.net>
References: <bd6139dc0901290327u572cc30ci9dc719c912fbf875@mail.gmail.com> <20090129113735.GA6505@coredump.intra.peff.net> <351A6988-32EB-473F-B6E5-8FBB38D91F88@ai.rug.nl> <bd6139dc0901290345u4962f747gbe93c945ab35c9cb@mail.gmail.com> <20090129115026.GB10792@coredump.intra.peff.net> <bd6139dc0901290420x1216a399w656e4d1622178a06@mail.gmail.com> <20090130045131.GB18655@coredump.intra.peff.net> <alpine.DEB.1.00.0901301415260.3586@pacific.mpi-cbg.de> <7vr62j0wpc.fsf@gitster.siamese.dyndns.org> <7v3aekqhpo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 13:34:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXal9-0006TG-SJ
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 13:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756607AbZBLMcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 07:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756561AbZBLMcM
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 07:32:12 -0500
Received: from peff.net ([208.65.91.99]:58240 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561AbZBLMcL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 07:32:11 -0500
Received: (qmail 8190 invoked by uid 107); 12 Feb 2009 12:32:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 12 Feb 2009 07:32:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Feb 2009 07:32:08 -0500
Content-Disposition: inline
In-Reply-To: <7v3aekqhpo.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109609>

On Wed, Feb 11, 2009 at 10:42:27PM -0800, Junio C Hamano wrote:

> We seem to have acquired a bad habit of discussing and agreeing on a
> potential improvement and then not following through, forgetting it
> altogether.
> 
> Exciting new features we can count on original submitters to stick to them
> and push them forward whether we go into a release freeze, but the more
> boring kind of patches that we already know what we want to see by the
> next release are actually the more important to the overall project;
> sadly, they tend to get lost somewhere in the crack.  I wonder if we can
> do anything about it.

I used to be more diligent about making a note of such things in my todo
list and then actually trying to reduce the size of that todo list
occasionally. But my git time has shrunk a bit lately due to my day job,
and I have been spending more time reviewing patches and discussing
ideas on the list, so it has been a while since I have actually sat down
to check something off of my todo.

I think in this case it was a matter of "it didn't make it onto
anybody's todo list". So I think it is nice that you put together the
patch; but I also think a gentle nudge of "so is anybody going to do
this?" would have worked, since it gives another chance for people to
claim ownership.

> And no, a bug tracker is not the answer, even though it could be a (small)
> part of the solution.

Maybe it would be sufficient to simply keep a public record of
intent-to-work on certain topics. Usually it is obvious from the mail
exchange what is going to happen next, but sometimes (as I think in this
case) it is left somewhat ambiguous.

> -- >8 --
> Subject: Install the default "master" branch configuration after cloning a void

The patch looks good to me.

-Peff
