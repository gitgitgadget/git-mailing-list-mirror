From: Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v2 1/1] Makefile: make curl-config path configurable
Date: Mon, 5 Oct 2015 22:25:08 +0200
Message-ID: <20151005202508.GB386@cruxbox>
References: <1444072858-24399-1-git-send-email-repk@triplefau.lt>
 <20151005193127.GC11993@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 22:25:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjCJq-0003XL-2S
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 22:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbbJEUZD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Oct 2015 16:25:03 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:42211 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbbJEUZB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2015 16:25:01 -0400
Received: from mfilter49-d.gandi.net (mfilter49-d.gandi.net [217.70.178.180])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id 81261A80AF;
	Mon,  5 Oct 2015 22:25:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter49-d.gandi.net
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
	by mfilter49-d.gandi.net (mfilter49-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id YE1L5GTR__Au; Mon,  5 Oct 2015 22:24:59 +0200 (CEST)
X-Originating-IP: 81.57.43.44
Received: from localhost (mon75-1-81-57-43-44.fbx.proxad.net [81.57.43.44])
	(Authenticated sender: repk@triplefau.lt)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 910C8A80AD;
	Mon,  5 Oct 2015 22:24:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20151005193127.GC11993@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279078>

On Mon, Oct 05, 2015 at 12:31:27PM -0700, Jonathan Nieder wrote:
> Remi Pommarel wrote:
>=20
> > There are situations, ie during cross compilation, where curl-confi=
g program
> > is not present in the PATH.
>=20
> s/ie/e.g.,/

Oups sorry about that.

>=20
> [...]
> > @@ -374,6 +378,7 @@ LDFLAGS =3D
> >  ALL_CFLAGS =3D $(CPPFLAGS) $(CFLAGS)
> >  ALL_LDFLAGS =3D $(LDFLAGS)
> >  STRIP ?=3D strip
> > +CURL_CONFIG =3D curl-config
>=20
> Could this go down with the other programs (CC, AR, FIND, et al)?

Yes sure that makes sense. I'll resend a modified patch, thanks

--=20
R=C3=A9mi
