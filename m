From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/6] Git.pm: teach "ident" to query explicitness
Date: Wed, 14 Nov 2012 11:54:24 -0800
Message-ID: <20121114195423.GE3860@sigill.intra.peff.net>
References: <20121113164845.GD20361@sigill.intra.peff.net>
 <20121113165320.GE12626@sigill.intra.peff.net>
 <20121114171213.GD6858@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 20:54:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYj2n-0007u3-6P
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 20:54:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261Ab2KNTy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 14:54:27 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48609 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753363Ab2KNTy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 14:54:27 -0500
Received: (qmail 6206 invoked by uid 107); 14 Nov 2012 19:55:15 -0000
Received: from 204-16-157-26-static.ipnetworksinc.net (HELO sigill.intra.peff.net) (204.16.157.26)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Nov 2012 14:55:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Nov 2012 11:54:24 -0800
Content-Disposition: inline
In-Reply-To: <20121114171213.GD6858@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209746>

On Wed, Nov 14, 2012 at 09:12:13AM -0800, Jonathan Nieder wrote:

> > --- a/perl/Git.pm
> > +++ b/perl/Git.pm
> > @@ -737,7 +737,7 @@ sub remote_refs {
> >  }
> >  
> >  
> > -=item ident ( TYPE | IDENTSTR )
> > +=item ident ( TYPE | IDENTSTR [, options] )
> >  
> >  =item ident_person ( TYPE | IDENTSTR | IDENTARRAY )
> >  
> > @@ -750,6 +750,10 @@ and either returns it as a scalar string or as an array with the fields parsed.
> >  Alternatively, it can take a prepared ident string (e.g. from the commit
> >  object) and just parse it.
> >  
> > +If the C<explicit> option is set to 1, the returned array will contain an
> > +additional boolean specifying whether the ident was configure explicitly by the
> > +user.
> 
> s/configure/configured/
> 
> I'd suggest adding "See GIT_COMMITTER_EXPLICIT in git-var(1) for
> details" to make the semantics crystal clear.  What do you think?

Good suggestion. Thanks.

-Peff
