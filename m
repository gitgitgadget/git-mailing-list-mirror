From: Jeff King <peff@peff.net>
Subject: Re: implement a stable 'Last updated' in Documentation
Date: Tue, 10 Feb 2015 13:43:18 -0500
Message-ID: <20150210184318.GA20090@peff.net>
References: <20150126172409.GA15204@aepfle.de>
 <xmqqd25zkeg7.fsf@gitster.dls.corp.google.com>
 <20150128080214.GA18851@aepfle.de>
 <xmqqbnlif6t9.fsf@gitster.dls.corp.google.com>
 <54CB5770.8030503@drmicha.warpmail.net>
 <20150130150758.GA3683@peff.net>
 <20150210151747.GA8965@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
X-From: git-owner@vger.kernel.org Tue Feb 10 19:43:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLFmQ-0006qk-Q0
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 19:43:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753755AbbBJSnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 13:43:22 -0500
Received: from cloud.peff.net ([50.56.180.127]:47341 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753423AbbBJSnV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 13:43:21 -0500
Received: (qmail 30167 invoked by uid 102); 10 Feb 2015 18:43:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 Feb 2015 12:43:21 -0600
Received: (qmail 8736 invoked by uid 107); 10 Feb 2015 18:43:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 Feb 2015 13:43:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Feb 2015 13:43:18 -0500
Content-Disposition: inline
In-Reply-To: <20150210151747.GA8965@aepfle.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263639>

On Tue, Feb 10, 2015 at 04:17:47PM +0100, Olaf Hering wrote:

> On Fri, Jan 30, Jeff King wrote:
> 
> > I have 8.6.9-3 installed (it is part of Debian testing/unstable now),
> > and confirmed that:
> > 
> > diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
> > index 2c16c53..10c777e 100644
> > --- a/Documentation/asciidoc.conf
> > +++ b/Documentation/asciidoc.conf
> > @@ -21,6 +21,7 @@ tilde=&#126;
> >  apostrophe=&#39;
> >  backtick=&#96;
> >  litdd=&#45;&#45;
> > +footer-style=none
> >  
> >  ifdef::backend-docbook[]
> >  [linkgit-inlinemacro]
> > 
> > drops the "last-updated" footer.
> 
> This does not remove "Last updated" from files like
> using-merge-subtree.html for me, using asciidoc-8.6.8.

Yes, the feature is part of 8.6.9-3.

-Peff
