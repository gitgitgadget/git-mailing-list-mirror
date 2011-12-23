From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Specify a precision for the length of a subject string
Date: Fri, 23 Dec 2011 18:03:32 -0500
Message-ID: <20111223230332.GA1734@sigill.intra.peff.net>
References: <20111220220754.GC21353@llunet.cs.wisc.edu>
 <20111221043843.GA20714@sigill.intra.peff.net>
 <20111221145112.GA13097@llunet.cs.wisc.edu>
 <20111223100957.GA1247@sigill.intra.peff.net>
 <20111223103511.GA10029@sigill.intra.peff.net>
 <7v1urvc8fb.fsf@alter.siamese.dyndns.org>
 <20111223230228.GA1718@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: nathan.panike@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 24 00:03:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ReE9K-0003bn-Fj
	for gcvg-git-2@lo.gmane.org; Sat, 24 Dec 2011 00:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757956Ab1LWXDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Dec 2011 18:03:35 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51935
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757914Ab1LWXDe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2011 18:03:34 -0500
Received: (qmail 4812 invoked by uid 107); 23 Dec 2011 23:10:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Dec 2011 18:10:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Dec 2011 18:03:32 -0500
Content-Disposition: inline
In-Reply-To: <20111223230228.GA1718@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187646>

On Fri, Dec 23, 2011 at 06:02:28PM -0500, Jeff King wrote:

> On Fri, Dec 23, 2011 at 12:58:00PM -0800, Junio C Hamano wrote:
> 
> > > Here's how I would have done it. Not involving %w at all, but applying
> > > equally to all placeholders.
> > 
> > Hmm, just curious why you rejected the %w() approach, as enhancing %w
> > sounded to me like a better approach at the design level, but that was a
> > knee-jerk reaction without inspecting the codepaths involved myself hence
> > not knowing the potential amount of work required.
> 
> Not so much rejecting as I took a quick look at how I would have done
> what your original patch did, and it was simple enough that I took it
> all the way to working and decided to post it. I left it up to you to
> decide whether using %w would be more sensible. I just wanted to present
> another alternative for discussion.

Eh, I misread the "From" header. All of the "you" there is "Nathan".

-Peff
