From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 5 Dec 2007 23:43:00 -0500
Message-ID: <20071206044300.GD5499@coredump.intra.peff.net>
References: <7vwsso3poo.fsf@gitster.siamese.dyndns.org> <7vfxz89x9q.fsf@gitster.siamese.dyndns.org> <7vabpctx3b.fsf@gitster.siamese.dyndns.org> <7vsl30eyuk.fsf@gitster.siamese.dyndns.org> <7vve7tuz3a.fsf@gitster.siamese.dyndns.org> <7v4pfakr4j.fsf@gitster.siamese.dyndns.org> <7vzlwv6sxr.fsf@gitster.siamese.dyndns.org> <7vy7ca6ea9.fsf@gitster.siamese.dyndns.org> <7vzlwps8zf.fsf@gitster.siamese.dyndns.org> <fj60uc$er$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 05:43:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J08a9-0007TY-Qh
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 05:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077AbXLFEnF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Dec 2007 23:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754068AbXLFEnE
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 23:43:04 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3403 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754000AbXLFEnD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 23:43:03 -0500
Received: (qmail 27516 invoked by uid 111); 6 Dec 2007 04:43:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 05 Dec 2007 23:43:01 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Dec 2007 23:43:00 -0500
Content-Disposition: inline
In-Reply-To: <fj60uc$er$2@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67233>

On Wed, Dec 05, 2007 at 12:10:04PM +0100, Jakub Narebski wrote:

> Junio C Hamano wrote:
>=20
> > * jk/builtin-alias (Fri Nov 30 11:22:58 2007 -0500) 1 commit
> > =A0+ Support builtin aliases
> >=20
> > Cute hack. =A0I'd like to have "git less" here.
>=20
> I guess that "git whatchanged" can be implemented also as builtin ali=
as.

If you are thinking of

  [alias]
    whatchanged =3D log --raw --full-history

it does not quite work. git-log unconditionally sets --always, and ther=
e
is no command line option to turn it off. In most cases you could get a=
n
approximation by using --no-merges, but it would still show commits tha=
t
actually have no tree change (there are 2 in git.git).

-Peff
