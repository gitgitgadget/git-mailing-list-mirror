From: Jeff King <peff@peff.net>
Subject: Re: approxidate parsing for bad time units
Date: Fri, 7 Sep 2012 09:54:52 -0400
Message-ID: <20120907135452.GA1290@sigill.intra.peff.net>
References: <CAFE6XRFgQa10vTWXfxRG53W6K4U=VGqpK5sQwH7xp9GfKd=2Uw@mail.gmail.com>
 <7vehme3n49.fsf@alter.siamese.dyndns.org>
 <CAFE6XREG5-gwjzvyP9r_hfyY3bWSV2=Bjv9ZbXkejXQRoqYERA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeffrey Middleton <jefromi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 15:55:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9z1Z-00065t-32
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 15:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759834Ab2IGNy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 09:54:57 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33307 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754295Ab2IGNy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 09:54:56 -0400
Received: (qmail 3275 invoked by uid 107); 7 Sep 2012 13:55:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 07 Sep 2012 09:55:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Sep 2012 09:54:52 -0400
Content-Disposition: inline
In-Reply-To: <CAFE6XREG5-gwjzvyP9r_hfyY3bWSV2=Bjv9ZbXkejXQRoqYERA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204970>

On Thu, Sep 06, 2012 at 02:01:30PM -0700, Jeffrey Middleton wrote:

> I'm generally very happy with the fuzzy parsing. It's a great feature
> that is designed to and in general does save users a lot of time and
> thought. In this case I don't think it does. The problems are:
> (1) It's not ignoring things it can't understand, it's silently
> interpreting them in a useless way.

Right, but we would then need to come up with a list of things it _does_
understand. So right now I can say "6 June" or "6th of June" or even "6
de June", and it works because we just ignore the cruft in the middle.

So I think you'd need to either whitelist what everybody is typing, or
blacklist some common typos (or convince people to be stricter in what
they type).

> So I do think it's worth improving. (Yes, I know, send patches; I'll
> think about it.)

You read my mind. :)

-Peff
