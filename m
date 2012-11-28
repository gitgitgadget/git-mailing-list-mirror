From: Jeff King <peff@peff.net>
Subject: Re: Topics currently in the Stalled category
Date: Tue, 27 Nov 2012 21:59:28 -0500
Message-ID: <20121128025928.GA27772@sigill.intra.peff.net>
References: <7vpq39up0m.fsf@alter.siamese.dyndns.org>
 <7vy5hvq1ey.fsf@alter.siamese.dyndns.org>
 <7vobirq0q2.fsf_-_@alter.siamese.dyndns.org>
 <CAMP44s30cbH5+HUxRBByk5sZGq=j_MdqLSnNzREozEk40_zbOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 03:59:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdXsJ-0000nx-6k
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 03:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978Ab2K1C7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 21:59:32 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58904 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640Ab2K1C7b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 21:59:31 -0500
Received: (qmail 1317 invoked by uid 107); 28 Nov 2012 03:00:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Nov 2012 22:00:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Nov 2012 21:59:28 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s30cbH5+HUxRBByk5sZGq=j_MdqLSnNzREozEk40_zbOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210679>

On Wed, Nov 21, 2012 at 04:31:11AM +0100, Felipe Contreras wrote:

> On Wed, Nov 21, 2012 at 1:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > Here is a list of stalled topics I am having trouble deciding what
> > to do (the default is to dismiss them around feature freeze).
> >
> > * fc/fast-export-fixes (2012-11-08) 14 commits
> >
> >  Renaming of remote-testgit feels to be a mistake.  It probably
> >  should keep its source in remote-testgit.bash and generate it,
> 
> Why generate it? There's nothing to generate. python's source code
> needs regeneration, bash's code doesn't.

We fix up the #!-lines on all of the existing shell scripts (as well as
python and perl). Wouldn't we want to do the same for people who have
bash in an alternate location?

As the series is now, people with bash in their PATH, but not in
/bin/bash, will fail t5801 (the prereq to skip the test uses "type", but
git-remote-testgit hardcodes /bin/bash).

-Peff
