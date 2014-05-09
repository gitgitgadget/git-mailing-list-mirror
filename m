From: Jeff King <peff@peff.net>
Subject: Re: Output from "git blame A..B -- path" for the bottom commit is
 misleading
Date: Fri, 9 May 2014 11:29:35 -0400
Message-ID: <20140509152935.GD18197@sigill.intra.peff.net>
References: <xmqq8uqc2dt5.fsf@gitster.dls.corp.google.com>
 <20140508212647.GA6992@sigill.intra.peff.net>
 <874n10ot2m.fsf@fencepost.gnu.org>
 <20140509001145.GA8734@sigill.intra.peff.net>
 <87zjiro856.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri May 09 17:31:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wimm9-00038E-Tf
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 17:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757066AbaEIP3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 11:29:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:48308 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757044AbaEIP3h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 11:29:37 -0400
Received: (qmail 26721 invoked by uid 102); 9 May 2014 15:29:36 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 May 2014 10:29:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 May 2014 11:29:35 -0400
Content-Disposition: inline
In-Reply-To: <87zjiro856.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248574>

On Fri, May 09, 2014 at 07:04:05AM +0200, David Kastrup wrote:

> Arguably if the user explicitly limited the range, he knows what he's
> looking at. Admittedly, I don't know offhand which options _will_
> produce boundary commit indications: there may be some without explicit
> range limitation, and we might also be talking about limiting through
> shallow repos (git blame on a shallow repo is probably a bad idea in the
> first place, but anyway).

Yes, I was thinking mostly of "X..Y" types of ranges, which are probably
the most common. I hadn't considered shallow repositories, and you can
also hit the root commit as a boundary if you do not specify --root.

I guess the question still in my mind is: what use does the identity of
the boundary commit have? That is, whether you know ahead of time where
the boundary is or not, is there ever a case where knowing its author
and/or commit sha1 is a useful piece of information, as opposed to
knowing that we hit a boundary at all?

I could not think of one, but I may simply lack imagination.

-Peff
