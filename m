From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Document git-svn fetch --log-window-size parameter
Date: Thu, 25 Oct 2012 05:52:02 -0400
Message-ID: <20121025095202.GK8390@sigill.intra.peff.net>
References: <1350988406-97624-1-git-send-email-gunnlaugur@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Gunnlaugur =?utf-8?B?w57Ds3I=?= Briem <gunnlaugur@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 11:52:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRK6t-0000BO-RH
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 11:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935291Ab2JYJwH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Oct 2012 05:52:07 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56046 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935017Ab2JYJwG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 05:52:06 -0400
Received: (qmail 7170 invoked by uid 107); 25 Oct 2012 09:52:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Oct 2012 05:52:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2012 05:52:02 -0400
Content-Disposition: inline
In-Reply-To: <1350988406-97624-1-git-send-email-gunnlaugur@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208378>

On Tue, Oct 23, 2012 at 10:33:26AM +0000, Gunnlaugur =C3=9E=C3=B3r Brie=
m wrote:

> The --log-window-size parameter to git-svn fetch is undocumented.
>=20
> Minimally describe what it does and why the user might change it.

Thanks. Your description makes sense to me, but I do not have enough
git-svn knowledge to know if it covers all intended uses of the flag.
Eric?

> +--log-window-size=3D<n>;;
> +    Fetch <n> log entries per request when scanning Subversion histo=
ry.
> +    The default is 100. For very large Subversion repositories, larg=
er
> +    values may be needed for 'clone'/'fetch' to complete in reasonab=
le
> +    time. But overly large values may lead to request timeouts.

-Peff
