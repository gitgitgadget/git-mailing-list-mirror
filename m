From: Jeff King <peff@peff.net>
Subject: Re: Python extension commands in git - request for policy change
Date: Wed, 12 Dec 2012 07:29:09 -0500
Message-ID: <20121212122909.GA21624@sigill.intra.peff.net>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
 <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
 <50B1F684.5020805@alum.mit.edu>
 <CACsJy8BgOpWdxgCfwBwZ=abAEDr+sbj3hnmKY2EYCFeBPRUT7w@mail.gmail.com>
 <CACh33FrGPhaeNzZ2Tj5OxScecOPN13idw8TwU8Mf6o0KsAOB9A@mail.gmail.com>
 <CAMK1S_hy8U0rVY=-u-QCqXjhn-6jwz5ofj_q_mbokVn8CGCMtw@mail.gmail.com>
 <20121212033043.GA24937@thyrsus.com>
 <20121212063208.GA18322@sigill.intra.peff.net>
 <20121212122625.GB25981@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Patrick Donnelly <batrick@batbytes.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 13:29:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TilRK-0005Ee-Dz
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 13:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964Ab2LLM3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 07:29:13 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42878 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494Ab2LLM3N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 07:29:13 -0500
Received: (qmail 23943 invoked by uid 107); 12 Dec 2012 12:30:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Dec 2012 07:30:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Dec 2012 07:29:09 -0500
Content-Disposition: inline
In-Reply-To: <20121212122625.GB25981@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211350>

On Wed, Dec 12, 2012 at 07:26:25AM -0500, Eric S. Raymond wrote:

> Jeff King <peff@peff.net>:
> > I think there are really two separate use cases to consider:
> > 
> >   1. Providing snippets of script to Git to get Turing-complete behavior
> >      for existing Git features. For example, selecting commits during a
> >      traversal (e.g., a better "log --grep"), formatting output (e.g., a
> >      better "log --format" or "for-each-ref --format").
> > 
> >   2. Writing whole new git commands in a language that is quicker or
> >      easier to develop in than C.
> 
> That's good analysis.  I agree with your use-case split, I guess I'm just not
> very aware of the places in git where (1) is important.

Yeah, I don't think (1) is your use case at all. But when people talk
about "Jeff's lua experiment", they are talking about some patches I had
to do (1), which covered "log --format" (but ultimately would need more
cleanup to be acceptable upstream). Maybe that clears up the discussion
a little bit.

-Peff
