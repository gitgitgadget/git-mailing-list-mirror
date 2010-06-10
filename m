From: Jeff King <peff@peff.net>
Subject: Re: [RFC/ PATCH 4/5] t3030: update porcelain expected message
Date: Wed, 9 Jun 2010 21:59:19 -0400
Message-ID: <20100610015919.GA32671@coredump.intra.peff.net>
References: <1276087446-25112-1-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-2-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-3-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-4-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-5-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-6-git-send-email-diane.gasselin@ensimag.imag.fr>
 <vpq1vcgym6j.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	git@vger.kernel.org, Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 10 03:59:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMX3M-0000es-98
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 03:59:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758537Ab0FJB70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 21:59:26 -0400
Received: from peff.net ([208.65.91.99]:35733 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756780Ab0FJB70 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 21:59:26 -0400
Received: (qmail 29227 invoked by uid 107); 10 Jun 2010 01:59:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 09 Jun 2010 21:59:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Jun 2010 21:59:19 -0400
Content-Disposition: inline
In-Reply-To: <vpq1vcgym6j.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148828>

On Wed, Jun 09, 2010 at 10:40:20PM +0200, Matthieu Moy wrote:

> Diane Gasselin <diane.gasselin@ensimag.imag.fr> writes:
> 
> > From: Diane <diane.gasselin@ensimag.imag.fr>
> 
> You did something strange with git format-patch or send-email. This
> From header should appear in the header of your email, but not in the
> body.

The commit author is missing the last name, so send-email correctly
includes the extra "From" header. Probably the user.name config variable
needs updated (and the commit can be rebased and amended with
--reset-author to take the new author).

> > +cat> expected2 <<EOF
> > +error: Your local changes to the files:
> > +	a
> > +would be overwritten by merge.
> > +EOF
> 
> I'd have phrased it like this:
> 
> error: Your local changes to these files would be overwritten by merge:
> 	a
> 
> to avoid splitting the message in two parts. It's more consistant with
> the rest of Git (git status or git reset for example). Also, your
> version would become hard to read if the file list is long.

Yes, I think your version is much more readable.

-Peff
