From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
Subject: Re: [PATCH] Revert "Stop starting pager recursively"
Date: Mon, 28 Apr 2014 14:32:44 -0400
Message-ID: <20140428183244.GA6358@logfs.org>
References: <20140421204622.GA9532@logfs.org>
 <20140425182928.GA29904@logfs.org>
 <vpqoazpdz1r.fsf@anie.imag.fr>
 <20140425201048.GB29904@logfs.org>
 <20140426071358.GA7558@sigill.intra.peff.net>
 <CACsJy8ANE+2n6fd-mF5pp+p2sXy_uRzJ2c+O=AiySyre+6KLtg@mail.gmail.com>
 <20140427075640.GB19976@sigill.intra.peff.net>
 <985432164.425366.1398611186431.JavaMail.zimbra@imag.fr>
 <xmqqk3a9s7fm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:25:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WerAs-00079r-A6
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756753AbaD1TY4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 15:24:56 -0400
Received: from longford.logfs.org ([213.229.74.203]:43240 "EHLO
	longford.logfs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756697AbaD1TYz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:24:55 -0400
Received: from joern by longford.logfs.org with local (Exim 4.72)
	(envelope-from <joern@logfs.org>)
	id 1WeqM8-0001lR-Bu; Mon, 28 Apr 2014 14:32:44 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk3a9s7fm.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247402>

On Mon, 28 April 2014 10:14:05 -0700, Junio C Hamano wrote:
> Matthieu Moy <matthieu.moy@grenoble-inp.fr> writes:
>=20
> > ----- Original Message -----
> >> On Sun, Apr 27, 2014 at 09:12:39AM +0700, Duy Nguyen wrote:
> >>=20
> >> > The intent of the commit was "that is a stupid thing to do, but =
it's
> >> > not so obvious from the first glance, do not freeze my system fo=
r my
> >> > mistake". But if it stops an actual use case, then I agree it sh=
ould
> >> > be reverted.
> >>=20
> >> Thanks for the explanation. I think we should just go with J=C3=B6=
rn's patch
> >> as-is, then.
> >
> > Agreed. At best, the commit message could be improved to explain th=
e
> > situation, but the patch itself is OK.
>=20
> True and I agree.
>=20
> The patch needs sign-off, though (I am looking at $gmane/246644).

Signed-off-by: Joern Engel <joern@logfs.org>

Or do you want me to resend with sob?

J=C3=B6rn

--
Tough times don't last, but tough people do.
-- Nigerian proverb
