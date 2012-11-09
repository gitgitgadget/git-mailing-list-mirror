From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Nov 2012, #02; Fri, 9)
Date: Fri, 9 Nov 2012 15:10:57 -0500
Message-ID: <20121109201057.GA11368@sigill.intra.peff.net>
References: <20121109192336.GA9401@sigill.intra.peff.net>
 <CAN0XMO+sgSgkqK7D6=5NL--rMYBwsGohgQ7v+ja4Twub20N1sQ@mail.gmail.com>
 <CAN0XMOL1SS2iiJkZyt3HACoCRXE1nGrd52B2rscWyS1e7X0GWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 21:11:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWuv3-0001Yb-Ud
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 21:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755560Ab2KIUK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 15:10:59 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40380 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753603Ab2KIUK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 15:10:59 -0500
Received: (qmail 10898 invoked by uid 107); 9 Nov 2012 20:11:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Nov 2012 15:11:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Nov 2012 15:10:57 -0500
Content-Disposition: inline
In-Reply-To: <CAN0XMOL1SS2iiJkZyt3HACoCRXE1nGrd52B2rscWyS1e7X0GWQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209246>

On Fri, Nov 09, 2012 at 09:06:47PM +0100, Ralf Thielow wrote:

> > It seems that the repo doesn't contain the integration branches?!?
> >
> > $ git remote add peff git://github.com/peff/git.git
> > $ git fetch -v peff
> > From git://github.com/peff/git
> >  * [new branch]      maint      -> peff/maint
> >  * [new branch]      master     -> peff/master
> >  * [new branch]      next       -> peff/next
> >  * [new branch]      pu         -> peff/pu
> >  * [new branch]      todo       -> peff/todo
> > $
> 
> But "integration branches" means "master", "next" and "pu" than I haven't
> said anything. ;) Sorry for the noise.

Right. :)

I have not been pushing the individual topic branches to make life
easier for people who usually just track Junio's kernel.org repository,
and would not welcome suddenly getting a hundred extra remote branches.
I can make them public if it makes life easier for people, but it may
not be worth it at this point, with Junio returning soon.

-Peff
