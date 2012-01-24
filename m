From: Jeff King <peff@peff.net>
Subject: Re: [BUG] Git bisect not finding the right commit
Date: Tue, 24 Jan 2012 15:21:54 -0500
Message-ID: <20120124202154.GB20145@sigill.intra.peff.net>
References: <87r4yw8j4i.fsf@franz.ak.mind.de>
 <7vlip4je87.fsf@alter.siamese.dyndns.org>
 <87ehuu958d.fsf@franz.ak.mind.de>
 <7vk44mfdow.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	"Andreas J. Koenig" <andreas.koenig.7os6VVqR@franz.ak.mind.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 24 21:22:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpmsU-0007t3-GB
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 21:22:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756707Ab2AXUV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 15:21:57 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43523
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756522Ab2AXUV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 15:21:57 -0500
Received: (qmail 12556 invoked by uid 107); 24 Jan 2012 20:28:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Jan 2012 15:28:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jan 2012 15:21:54 -0500
Content-Disposition: inline
In-Reply-To: <7vk44mfdow.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189067>

On Fri, Jan 20, 2012 at 10:09:51AM -0800, Junio C Hamano wrote:

> > Yes, thank you for finding that out. X is actually v5.15.4-109-g3ea0c58
> > and since there was a long timespan between the start of the development
> > of the code and the merge (May-Nov), the gitk presentation got a bit
> > complex to read.
> 
> (This is somewhat off-topic, so Andreas is on Cc: and the list is on To:)
> 
> I doubt --simplify-by-decoration alone would make it easier to view such a
> complex and long history, but I wonder if we can use the same logic to
> help users in a case like this. Instead of only keeping tagged versions in
> the result to show topology, perhaps we can allow the user to feed a list
> of "key points in history" as command line arguments and apply the same
> kind of simplification to help visualizing the topology?

This is something I think I've wanted in the past. But unfortunately, I
can't remember the exact details, so I'm not sure how workable it would
have been. In particular, how painful is it in practice to come up with
the list of "key points" to make the graph sensible?

So I'll add my vague "yeah, that sounds good" and try to pay attention
next time the situation comes up as to whether such a feature would
actually help in practice.

-Peff
