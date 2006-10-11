From: Jeff King <peff@peff.net>
Subject: Re: Clueless bisect error message
Date: Wed, 11 Oct 2006 14:04:49 -0400
Message-ID: <20061011180449.GA2897@coredump.intra.peff.net>
References: <fcaeb9bf0610110008g642da719pb17f7f52169097e2@mail.gmail.com> <7vpsczuxj9.fsf@assigned-by-dhcp.cox.net> <fcaeb9bf0610110050h4c3a56fbge19607ff0bc094af@mail.gmail.com> <7v1wpfuv9d.fsf@assigned-by-dhcp.cox.net> <20061011091411.GA21527@coredump.intra.peff.net> <m3ejtfvwvi.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 20:05:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXiRt-0003y0-LO
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 20:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161171AbWJKSEx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 14:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161173AbWJKSEx
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 14:04:53 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:8376 "HELO
	peff.net") by vger.kernel.org with SMTP id S1161171AbWJKSEw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 14:04:52 -0400
Received: (qmail 23536 invoked from network); 11 Oct 2006 14:04:49 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 11 Oct 2006 14:04:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Oct 2006 14:04:49 -0400
To: Krzysztof Halasa <khc@pm.waw.pl>
Content-Disposition: inline
In-Reply-To: <m3ejtfvwvi.fsf@defiant.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28731>

On Wed, Oct 11, 2006 at 02:51:29PM +0200, Krzysztof Halasa wrote:

> > +			die "You can't bisect a seeked tree!"
> Just to make sure: dictionary.reference.com doesn't know the
> "seeked" word (I don't either though that may be normal).
> 
> Should it read "sought"? Not sure what does the message talk about.

Seeked is not a "real" word in the sense of being in any dictionary. The
past participle form of "seek" is indeed "sought" (though one might want
to use the passive perfect participle form "being sought" for this
case).

However, the use of the word "sought" implies to me the classical
definition of the word seek: "to look for something." The definition we
are using here is a more modern, computer-oriented definition: "to move
to a position within an ordered set" (since we are referring to Cogito's
cg-seek command). Just as you might verbify (another non-word!) a
command and say "I catted those files together", the tree has been
"seeked." One could argue it should be "cat'd" and "seek'd" to indicate
their non-word status, but that idiom is common enough among
programmers, especially Unix users, that I suspect it will make sense
either way.

At any rate, the word "seeked" was in the original error message, so I
didn't introduce it. Are other people bothered by it?

-Peff
