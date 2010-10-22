From: Jeff King <peff@peff.net>
Subject: Re: git as an sfc member project
Date: Fri, 22 Oct 2010 19:18:20 -0400
Message-ID: <20101022231820.GB25520@sigill.intra.peff.net>
References: <20101022183027.GA12124@sigill.intra.peff.net>
 <AANLkTi=6tvmTAfdyL-sKBsq+4OpFaQpZWT66ANESNapj@mail.gmail.com>
 <7vocalkf53.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 23 01:17:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Qrn-0008Nj-Jc
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 01:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653Ab0JVXRi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 19:17:38 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:34585 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753417Ab0JVXRh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 19:17:37 -0400
Received: (qmail 27541 invoked by uid 111); 22 Oct 2010 23:17:35 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 22 Oct 2010 23:17:35 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Oct 2010 19:18:20 -0400
Content-Disposition: inline
In-Reply-To: <7vocalkf53.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159762>

On Fri, Oct 22, 2010 at 03:59:36PM -0700, Junio C Hamano wrote:

> Shawn Pearce <spearce@spearce.org> writes:
>=20
> > I think a committee of at least 3 people and at most 5, any of whom
> > can be a benevolent SFC liasion, is fine.  As far as selection goes=
,
> > the committee can elect or remove a member through a majority vote,
> > and should base its decisions based on surviving contributions to t=
he
> > code base, but shouldn't be tied to that (just in case someone
> > contributes a lot of good code and then becomes a jerk).
>=20
> Just a datapoint from quick "blame -C -C -w" run as of 1.7.3.2, count=
ing
> surviving lines, 7 top from each area, excluding Documentation/RelNot=
es.
>=20
>=20
> ** Everything else **
>=20
> 77212        Junio C Hamano
> 41388        Shawn O. Pearce
> 32676        Linus Torvalds
> 28618        Johannes Schindelin
> 22120        =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> 20190        Paul Mackerras
> 15518        Marius Storm-Olsen

How did you calculate this? I don't see how it could be right. For
example, =C3=86var's contribution, while being impressively large latel=
y, is
only 12877 lines total over all commits, let alone surviving lines:

  $ git log --pretty=3Dformat: --numstat --author=3DBjarmason |
    perl -ne '/^\d+/ and $total +=3D $&; END { print "$total\n"; }'
  12877

-Peff
