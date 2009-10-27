From: Jeff King <peff@peff.net>
Subject: Re: git update --prune issue
Date: Tue, 27 Oct 2009 12:50:55 -0400
Message-ID: <20091027165054.GA8554@sigill.intra.peff.net>
References: <4389ce950910261508p7eca354el77bad07305a80952@mail.gmail.com>
 <4AE6B28F.9010407@drmicha.warpmail.net>
 <4389ce950910270807o69d51155xb083f34bb31e1dae@mail.gmail.com>
 <20091027162936.GA8130@sigill.intra.peff.net>
 <20091027164040.GB12464@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeffrey Middleton <jefromi@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Oct 27 17:51:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2pGD-0000Wc-HV
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 17:51:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756051AbZJ0Quy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Oct 2009 12:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755891AbZJ0Quy
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 12:50:54 -0400
Received: from peff.net ([208.65.91.99]:42223 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755915AbZJ0Qux (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 12:50:53 -0400
Received: (qmail 2104 invoked by uid 107); 27 Oct 2009 16:54:35 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.19)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 27 Oct 2009 12:54:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Oct 2009 12:50:55 -0400
Content-Disposition: inline
In-Reply-To: <20091027164040.GB12464@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131358>

On Tue, Oct 27, 2009 at 05:40:40PM +0100, Clemens Buchacher wrote:

> On Tue, Oct 27, 2009 at 12:29:36PM -0400, Jeff King wrote:
>=20
> > > Pruning steph
> > > URL: /users/sdewet/CxTF_DEV/CxTF_DB/
> > > =C2=A0* [pruned] steph/beta_gc_dev_old
> > > Updating kevin
> > > error: refs/remotes/steph/beta_gc_dev does not point to a valid o=
bject!
> > > error: refs/remotes/steph/beta_veh_dev does not point to a valid =
object!
> >=20
> > The "pruned" line basically means that we are deleting that ref, an=
d
> > then we complain immediately about that very ref (which is probably
> > pointing to the null sha1 or something at this point).
>=20
> Actually, it's beta_gc_dev_old and beta_gc_dev, not the same refs.

OK, I'm a bit blind. Thanks for pointing it out. I'll still see if I ca=
n
replicate it.

-Peff
