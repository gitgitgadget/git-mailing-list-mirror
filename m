From: Jeff King <peff@peff.net>
Subject: Re: Show all branches and ahead/behind states
Date: Fri, 15 May 2015 12:59:13 -0400
Message-ID: <20150515165912.GA26853@peff.net>
References: <CAHd499AyEDNM7mDstFugD0Ah46=gAS=BRocDmpmOK-1k+qMCmw@mail.gmail.com>
 <1431618938.31573.3.camel@kaarsemaker.net>
 <CAHd499CQTW0J6ms+XYUBbyfT6gGKuiFFCiP57i8-eTwng+UzNQ@mail.gmail.com>
 <1431624587.31573.5.camel@kaarsemaker.net>
 <CAHd499BoApGJSM_qEKG8cHNOV_pOCyPRqEAXHo8iqYVg1LpGdw@mail.gmail.com>
 <20150514223827.GB21149@peff.net>
 <CAHd499Am4PFo-YRJEbQfPqtk571f4eNr_gkdy-3ATzyvBcc-jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 15 18:59:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtIxF-0003N3-Ex
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 18:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642AbbEOQ7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 12:59:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:59297 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752912AbbEOQ7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 12:59:16 -0400
Received: (qmail 22776 invoked by uid 102); 15 May 2015 16:59:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 May 2015 11:59:15 -0500
Received: (qmail 3870 invoked by uid 107); 15 May 2015 16:59:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 May 2015 12:59:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 May 2015 12:59:13 -0400
Content-Disposition: inline
In-Reply-To: <CAHd499Am4PFo-YRJEbQfPqtk571f4eNr_gkdy-3ATzyvBcc-jw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269156>

On Fri, May 15, 2015 at 09:25:22AM -0500, Robert Dailey wrote:

> > It's spelled "%C(bold blue)" in the --pretty formats, but in
> > for-each-ref, it's "%(color:bold blue)". Unifying these is one of those
> > things that has been on the radar for a long time, but nobody has quite
> > gotten around to it.
> >
> Thanks Jeff! That definitely fixed it. I was not able to find a
> reference for this in the git docs, maybe I just overlooked it
> somewhere.

It's in "git help for-each-ref" (see the section on "FIELD NAMES").

> As a second query, is there a way to do column alignment? For example,
> I would like the ahead/behind status in one column, and the branch
> names left aligned in a 2nd column. I can't simply use tabs here since
> the length of column 1 may differ more greatly than a single tab
> character.

The "--pretty" format does have "%<" for doing printf-style alignment
(see the "PRETTY FORMATS" section of "git help log"). But "for-each-ref"
doesn't have any similar facility, as far as I know.

Again, this is something that it would be nice to fix.

-Peff
