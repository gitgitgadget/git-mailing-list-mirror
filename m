From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch
 when appropriate to do so
Date: Wed, 14 Oct 2009 00:31:50 -0400
Message-ID: <20091014043150.GB28795@coredump.intra.peff.net>
References: <0016e68fd0123a175304754694b4@google.com>
 <200910130836.57011.trast@student.ethz.ch>
 <7vljjf226t.fsf@alter.siamese.dyndns.org>
 <200910131051.47117.trast@student.ethz.ch>
 <7vy6nfwssk.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0910132302380.4985@pacific.mpi-cbg.de>
 <20091013220640.GB12603@coredump.intra.peff.net>
 <alpine.DEB.1.00.0910140117280.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Euguess@gmail.com,
	Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 14 06:39:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxveO-00086a-Oa
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 06:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbZJNEc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 00:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbZJNEc0
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 00:32:26 -0400
Received: from peff.net ([208.65.91.99]:34476 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751104AbZJNEc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 00:32:26 -0400
Received: (qmail 24179 invoked by uid 107); 14 Oct 2009 04:35:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 14 Oct 2009 00:35:21 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Oct 2009 00:31:50 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0910140117280.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130241>

On Wed, Oct 14, 2009 at 01:22:26AM +0200, Johannes Schindelin wrote:

> At some point, trying to educate the user is not helpful but annoying.  If 
> Git already knows what I want, why does it not do it already?  _That_ is 
> the question I already hear in my ears.

I am not entirely convinced that the suggested behaviors will result in
that user response, or a different one (like "why does git keep giving
me bad advice?"). Which is why I suggested data collection.

> > So doing step (1) would be a way of collecting some of that data (will 
> > users say "stupid git, if you knew what I wanted, why didn't you just do 
> > it?" or "stupid git, your suggestion is just confusing me!").
> 
> I disagree.  It is not about collecting data.  We will not get any 
> feedback from the affected people.  You know that, I know that.

I don't agree. You are already talking about users complaining about
git's interface. Isn't that feedback? How do you hear those complaints
now?

I don't think they will come on the list and talk about it, but if we
release a version of git that has differing behavior and give it some
time to be used in the wild, we _will_ get feedback in the form of
blogs, complaints on other lists, word-of-mouth, etc.

Now maybe that is not a good idea in this instance, because that sort of
feedback may take several versions to appear, and we are talking about a
potential timetable of v1.7.0, which is probalby only two versions away.

-Peff
