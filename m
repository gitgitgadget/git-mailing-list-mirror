From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] fetch-pack: mention server version with verbose
 output
Date: Mon, 13 Aug 2012 17:07:57 -0400
Message-ID: <20120813210757.GA32599@sigill.intra.peff.net>
References: <20120810075342.GA30072@sigill.intra.peff.net>
 <20120810075816.GC8399@sigill.intra.peff.net>
 <7v7gt6jz3s.fsf@alter.siamese.dyndns.org>
 <20120810211509.GB888@sigill.intra.peff.net>
 <7v393uif9g.fsf@alter.siamese.dyndns.org>
 <7vboieehrf.fsf@alter.siamese.dyndns.org>
 <7v7gt2ehl4.fsf_-_@alter.siamese.dyndns.org>
 <20120813205423.GA31630@sigill.intra.peff.net>
 <7va9xycxh1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 23:08:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T11rq-00067i-Nw
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 23:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493Ab2HMVIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 17:08:00 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36539 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752363Ab2HMVIA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 17:08:00 -0400
Received: (qmail 30594 invoked by uid 107); 13 Aug 2012 21:08:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 13 Aug 2012 17:08:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Aug 2012 17:07:57 -0400
Content-Disposition: inline
In-Reply-To: <7va9xycxh1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203366>

On Mon, Aug 13, 2012 at 02:07:22PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Of course, a server can also say "agent=git/none-of-your-business"; this
> > is just a syntactic question.
> 
> You do not even have to advertise it in the first place, no?

If you want the client to respond with theirs, you do.

-Peff
