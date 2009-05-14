From: Jeff King <peff@peff.net>
Subject: Re: git push origin error (1.6.3 new default functionality)
Date: Thu, 14 May 2009 02:31:57 -0400
Message-ID: <20090514063157.GA10411@coredump.intra.peff.net>
References: <81bfc67a0905111826y779555cer6679da11db787ab1@mail.gmail.com> <4A09594F.4040603@drmicha.warpmail.net> <81bfc67a0905122226p113e4aa5y2a3523ac63de77fc@mail.gmail.com> <20090513083203.GA25058@sigill.intra.peff.net> <4A0A8871.6080107@viscovery.net> <20090513090317.GA3421@sigill.intra.peff.net> <4A0A98CC.2090701@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 14 08:34:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4UUa-0007KO-BO
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 08:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754790AbZENGcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 02:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754334AbZENGcA
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 02:32:00 -0400
Received: from peff.net ([208.65.91.99]:32892 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752266AbZENGb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 02:31:59 -0400
Received: (qmail 20238 invoked by uid 107); 14 May 2009 06:31:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 14 May 2009 02:31:59 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 14 May 2009 02:31:57 -0400
Content-Disposition: inline
In-Reply-To: <4A0A98CC.2090701@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119148>

On Wed, May 13, 2009 at 11:54:20AM +0200, Michael J Gruber wrote:

> > Regardless, my point was: the warning was introduced for a purpose
> > (either to point out potentially confusing behavior, or to warn the user
> > about an upcoming change in default behavior). Showing up now and saying
> > "I don't like this warning" without addressing any of the points in the
> > original discussion or making any sort of proposal to try to accomplish
> > the same goals is just counterproductive.
> 
> I don't want to stir this up to much again - as I said, set config and
> be done.

Junio already posted a thoughtful (if perhaps somewhat frustrated) reply
elsewhere, and I agree with most of what he said. I did want to make one
additional point, though, because I think what I said may have appeared
mean. And I was really trying to be nice.

My initial reaction was to say "shut up and set the config variable".
But I really don't like doing that, because I don't want somebody
thinking that all decisions are closed, and it's not possible to come to
the table with new points that may make people change their minds.

When the subject was discussed before, there were people who preferred
various behaviors. They each made arguments, and in the aftermath, Junio
made a decision (presumably based on arguments by list members, opinions
of other developers, and whatever he thought was best) about what to
apply.

If somebody wants to bring up a new argument, new data, or point out
some or changed circumstance that may affect the decision, then I am all
for them doing so. And that is what I was trying to coax out of Caleb.
But without that, I don't see any reason why others should waste their
time reconsidering the decision. Let's assume that the original decision
making process was at least roughly deterministic and would just arrive
at the same answer.

And I think simply posting a "I would have been on the side to prefer X"
opinion isn't really new data. It pushes the tally for that preference
up by one, but the margin of error on such tallies is already huge (I
think we have seen in the past that there is a silent majority who are
_not_ on the git list, and we need to try to address their interests as
well). So while something like a well-managed survey of what git users
would prefer is new data, I consider a single (or even several) "me too"
messages on the list to just be noise in the data.

> My main issue is the fact that we have a config variable (push.default)
> which causes a different behaviour depending on whether it is unset or
> set to its default (!) value. That is a completely new UI approach. We

Well, it depends on how you think of the default. The default could be
"matched-and-warn", and you are fixing it by setting it to "matched". :)

-Peff
