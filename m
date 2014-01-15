From: Jeff King <peff@peff.net>
Subject: Re: BUG: check-ref-format and rev-parse can not handle branches with
 an @ in their name combined with @{u}
Date: Wed, 15 Jan 2014 02:47:58 -0500
Message-ID: <20140115074758.GA8978@sigill.intra.peff.net>
References: <52D5C296.7050906@lge.com>
 <xmqqvbxm2kmg.fsf@gitster.dls.corp.google.com>
 <20140115050003.GA27237@sigill.intra.peff.net>
 <7v1u091ybx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Keith Derrick <keith.derrick@lge.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 08:48:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3LCo-00012k-A2
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 08:48:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbaAOHsC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 02:48:02 -0500
Received: from cloud.peff.net ([50.56.180.127]:60887 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750749AbaAOHsA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 02:48:00 -0500
Received: (qmail 6873 invoked by uid 102); 15 Jan 2014 07:48:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jan 2014 01:48:00 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jan 2014 02:47:58 -0500
Content-Disposition: inline
In-Reply-To: <7v1u091ybx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240436>

On Tue, Jan 14, 2014 at 11:46:58PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Is that what "--branch" does? I have never used it, but the manpage
> > seems to suggest it is about _parsing_ (which, IMHO, means it probably
> > should have been an option to rev-parse, but that is another issue
> > altogether).
> 
> Ahh, of course you are right.  I never use it, and somehow thought
> it was just prepending refs/heads/ to its arguments, but it seems to
> want to do a lot more than that.

I am just about done with a patch series to address this, and a few
other related bugs I found. So don't look too hard; I should have
something out in a few minutes.

-Peff
