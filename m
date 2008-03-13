From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 11/16] config: add --literal-match option
Date: Thu, 13 Mar 2008 09:24:19 -0400
Message-ID: <20080313132419.GA28564@coredump.intra.peff.net>
References: <cover.1205356737.git.peff@peff.net> <20080312214019.GL26286@coredump.intra.peff.net> <fr9ivq$eh0$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 14:25:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZnQb-0001tg-5K
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 14:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752409AbYCMNYW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Mar 2008 09:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752216AbYCMNYW
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 09:24:22 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2933 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751044AbYCMNYV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 09:24:21 -0400
Received: (qmail 31850 invoked by uid 111); 13 Mar 2008 13:24:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 13 Mar 2008 09:24:20 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Mar 2008 09:24:19 -0400
Content-Disposition: inline
In-Reply-To: <fr9ivq$eh0$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77079>

On Wed, Mar 12, 2008 at 10:46:43PM +0100, Jakub Narebski wrote:

> > +--literal-match::
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Some invocations of git-=
config will limit their actions based on
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0matching a config value =
to a regular expression. If this option
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0is used, then any such m=
atches are done as a string comparison
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rather than as a regular=
 expression match.
> > +
>=20
> Why this option is not named --fixed-strings, as everywhere else, the=
n?

Because I never use --fixed-strings anywhere else and didn't think of
it? :)

I think, though, that there is a key difference, and using that name
would lead to confusion. In grep, --fixed-strings means "find this fixe=
d
_substring_ within the input" whereas this option means "find the value
that is byte-for-byte equal to this."

-Peff
