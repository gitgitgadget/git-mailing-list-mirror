From: Jeff King <peff@peff.net>
Subject: Re: bare vs non-bare <1.7 then >=1.7 ?
Date: Thu, 8 Nov 2012 09:59:52 -0500
Message-ID: <20121108145951.GA15560@sigill.intra.peff.net>
References: <509B8552.4080303@rktmb.org>
 <87zk2sz0mn.fsf@flaca.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mihamina Rakotomandimby <mihamina@rktmb.org>,
	Git Issues <git@vger.kernel.org>
To: Carlos Martin Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 16:00:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWTaY-0002Ng-S2
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 16:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388Ab2KHPAA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2012 10:00:00 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36315 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751941Ab2KHPAA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 10:00:00 -0500
Received: (qmail 29991 invoked by uid 107); 8 Nov 2012 15:00:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Nov 2012 10:00:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2012 09:59:52 -0500
Content-Disposition: inline
In-Reply-To: <87zk2sz0mn.fsf@flaca.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209163>

On Thu, Nov 08, 2012 at 02:26:40PM +0100, Carlos Mart=C3=ADn Nieto wrot=
e:

> > When experimenting in order to train some colleagues, I saw that If=
 I
> > clone a repository, I couldn't push to it because it was a non-bare
> > one.
> > Searchin for some explanations, I found this ressource:
> > http://www.bitflop.com/document/111
> >
> > It's told to be reliable information for Git < v1.7.
> >
> > What would be different for Git > 1.7 so that I could be up to date
> > with the facts?
>=20
> Bare vs. non-bare hasn't changed. The reasoning behind the two types
> hasn't changed and is pretty fundamental. There is no reason for it t=
o
> change.

Right. The key thing that changed in git v1.7 is that we started warnin=
g
about and denying an operation that had always been dangerous, and that
is why the referenced document mentions that version.

-Peff
