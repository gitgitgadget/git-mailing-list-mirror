From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: bug? in checkout with ambiguous refnames
Date: Wed, 12 Jan 2011 10:11:30 +0100
Message-ID: <20110112091130.GC24920@pengutronix.de>
References: <20110107104650.GA5399@pengutronix.de>
 <20110107194909.GB6175@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 12 10:11:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pcwjz-0003qP-Kh
	for gcvg-git-2@lo.gmane.org; Wed, 12 Jan 2011 10:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069Ab1ALJLd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jan 2011 04:11:33 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36412 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab1ALJLc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 04:11:32 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1Pcwjr-0005YO-BH; Wed, 12 Jan 2011 10:11:31 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1Pcwjq-0001cO-Qn; Wed, 12 Jan 2011 10:11:30 +0100
Content-Disposition: inline
In-Reply-To: <20110107194909.GB6175@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165010>

Hi Peff,

On Fri, Jan 07, 2011 at 02:49:09PM -0500, Jeff King wrote:
> On Fri, Jan 07, 2011 at 11:46:50AM +0100, Uwe Kleine-K=F6nig wrote:
>=20
> > 	ukl@octopus:~/gsrc/linux-2.6$ git diff; git diff --cached
> >=20
> > 	ukl@octopus:~/gsrc/linux-2.6$ git checkout sgu/mxs-amba-uart
> > 	warning: refname 'sgu/mxs-amba-uart' is ambiguous.
> > 	Previous HEAD position was c13fb17... Merge commit '65e29a85a419f9=
a161ab0f09f9d69924e36d940e' into HEAD
> > 	Switched to branch 'sgu/mxs-amba-uart'
> >=20
> > OK, it might be a bad idea to have this ambiguity, still ...
> > [...]
> > So working copy and cache are at refs/tags/sgu/mxs-amba-uart, HEAD
> > points to refs/heads/sgu/mxs-amba-uart
>=20
> Yeah, we generally resolve ambiguities in favor of the tag (and that
> warning comes from deep within get_sha1_basic). So the real bug here =
is
> that it still said "Switched to branch", which is totally wrong.
I wonder how I can resolve the ambiguity when calling checkout.  (Well
apart from changing either branch name or tag name)

git checkout refs/heads/sgu/mxs-amba-uart results in a detached HEAD.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
