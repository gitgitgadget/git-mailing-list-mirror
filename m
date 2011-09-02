From: Jeff King <peff@peff.net>
Subject: Re: Rebase & Trailing Whitespace
Date: Fri, 2 Sep 2011 04:28:51 -0400
Message-ID: <20110902082851.GA17703@sigill.intra.peff.net>
References: <CAE1pOi0rY4kRR4rvEdFhzzTgfhUczHMX=H5_9+o5aHnv4vTadw@mail.gmail.com>
 <20110901023127.GB31838@sigill.intra.peff.net>
 <29267EE41F9343E68AAAE2C33AA40E1A@PhilipOakley>
 <20110901212618.GB16308@sigill.intra.peff.net>
 <4E6086AA.40806@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 02 10:29:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzP7X-0001d3-7c
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 10:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540Ab1IBI25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 04:28:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37531
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932514Ab1IBI2z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 04:28:55 -0400
Received: (qmail 29345 invoked by uid 107); 2 Sep 2011 08:29:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Sep 2011 04:29:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Sep 2011 04:28:51 -0400
Content-Disposition: inline
In-Reply-To: <4E6086AA.40806@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180603>

On Fri, Sep 02, 2011 at 09:32:58AM +0200, Michael J Gruber wrote:

> > Thanks. By itself, I think many readers would ask "why would I want the
> > empty tree, so I threw in a few examples of use on the wiki, too.
> 
> Ugh. I mean: Thanks for the wiki entries, they're nice, but have you
> checked git.git for whitespace errors? Time for another war on
> whitespace? Many false positives, of course, but also true positives.

Yeah, there are a lot. Because of the potential disruption to patches in
progress, though, we tend not to do big bulk updates of style changes.
But it may be worth using the

  rm foo.c
  git diff -R | git apply --whitespace=fix

trick if you are going to be working on foo.c. And if there are a lot,
you can "add -p" whatever fixes are appropriate for the area you're
working in.

-Peff
