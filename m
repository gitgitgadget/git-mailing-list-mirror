From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Nov 2012, #02; Fri, 9)
Date: Fri, 9 Nov 2012 19:38:50 -0500
Message-ID: <20121110003850.GB12567@sigill.intra.peff.net>
References: <20121109192336.GA9401@sigill.intra.peff.net>
 <CAN0XMO+sgSgkqK7D6=5NL--rMYBwsGohgQ7v+ja4Twub20N1sQ@mail.gmail.com>
 <CAN0XMOL1SS2iiJkZyt3HACoCRXE1nGrd52B2rscWyS1e7X0GWQ@mail.gmail.com>
 <20121109201057.GA11368@sigill.intra.peff.net>
 <7vr4o2plmw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 01:39:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWz6N-0005m5-Ng
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 01:39:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755838Ab2KJAiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 19:38:54 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40566 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753102Ab2KJAix (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 19:38:53 -0500
Received: (qmail 13267 invoked by uid 107); 10 Nov 2012 00:39:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Nov 2012 19:39:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Nov 2012 19:38:50 -0500
Content-Disposition: inline
In-Reply-To: <7vr4o2plmw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209254>

On Fri, Nov 09, 2012 at 12:27:35PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I have not been pushing the individual topic branches to make life
> > easier for people who usually just track Junio's kernel.org repository,
> > and would not welcome suddenly getting a hundred extra remote branches.
> > I can make them public if it makes life easier for people, but it may
> > not be worth it at this point, with Junio returning soon.
> 
> What we should have arranged was to have https://github.com/git/git
> (which is not even owned by me, but I asked somebody at GitHub to
> assign me a write privilege) writable by the interim maintainer, so
> that normal people would keep pulling from there, while the interim
> maintainer can choose to publish broken-out branches to his
> repository.

Yes, I have write access to that repository, too, but I intentionally
held off from updating it out of a sense of nervousness. I figured if I
screwed up anything too badly, people who were clued-in enough to switch
to pulling from my repository would be clued-in enough to rebase across
any too-horrible mistake I made. ;)

I think if we do this again, I will make the same split you do (git/git
for integration branches, peff/git as a mirror of my private repo).

> And it is not too late to do so; from the look of your "What's
> cooking", you are doing pretty well ;-).

Any fool can merge topics to master. The real test will be how many
regressions people report in the next two weeks. :)

By the way, I did not touch 'maint' at all while you were gone. I don't
know what your usual method is for keeping track of maint-worthy topics
after they have gone to master. The usual "what's cooking" workflow
keeps track of things going to master, but no more; I'd guess you
probably just merge to maint when you delete them from last cycle's
"graduated to master" list.

I just let them stew in master for a bit longer, and we can easily find
and merge them with "git branch --no-merged maint | grep maint".

-Peff
