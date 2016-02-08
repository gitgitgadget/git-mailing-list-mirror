From: Jeff King <peff@peff.net>
Subject: Re: update_linked_gitdir writes relative path to
 .git/worktrees/<id>/gitdir
Date: Mon, 8 Feb 2016 08:56:07 -0500
Message-ID: <20160208135607.GB27054@sigill.intra.peff.net>
References: <1454789548.23898.223.camel@mattmccutchen.net>
 <xmqqlh6w9isp.fsf@gitster.mtv.corp.google.com>
 <1454893478.2511.5.camel@mattmccutchen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	git <git@vger.kernel.org>
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Mon Feb 08 14:56:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSmIb-000473-Np
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 14:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855AbcBHN4M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2016 08:56:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:39174 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750922AbcBHN4J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 08:56:09 -0500
Received: (qmail 30005 invoked by uid 102); 8 Feb 2016 13:56:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 08:56:09 -0500
Received: (qmail 5013 invoked by uid 107); 8 Feb 2016 13:56:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 08:56:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Feb 2016 08:56:07 -0500
Content-Disposition: inline
In-Reply-To: <1454893478.2511.5.camel@mattmccutchen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285765>

On Sun, Feb 07, 2016 at 08:04:38PM -0500, Matt McCutchen wrote:

> > it is very much
> > appreciated when reporting bugs people check if a presumed fix is
> > already cooking in 'next', try it to verify if it really fixes thei=
r
> > problem, and send in a "OK fix is good" / "No that does not fix my
> > case"?
>=20
> Sorry to waste your time. =C2=A0This wasn't documented where I looked=
,
> namely the "Bug Reporting" section on=C2=A0http://git-scm.com/communi=
ty=C2=A0.
> =C2=A0Here's a straw-man proposed update to that page:
>=20
> https://github.com/mattmccutchen/git-scm.com/compare/master...bug-rep=
orting-next
>=20
> If you like it, I will submit it as a pull request. =C2=A0I can propo=
se a
> similar update to the "REPORTING BUGS" section of the git(1) man page
> if you like.

=46WIW, as the person who wrote that section, I think that is a good
addition.  We do have a link to Simon Tatham's bug-reporting guide, but
this is a good place to put project-specific advice.

In addition to "try it on next" you may want to also mention "try it on
the latest version of git". That is another frequently given pointer to
bug reporters.  Trying "next" is obviously a superset, but I suspect
trying a released version may be an easier first step for some people.

-Peff
